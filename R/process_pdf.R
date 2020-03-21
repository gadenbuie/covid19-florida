library(readr)
library(dplyr)
library(tidyr)
library(purrr)
library(stringr)
library(lubridate)
library(glue)
library(fs)
source(here::here("R/process_pdf_county_testing.R"))
source(here::here("R/process_pdf_line_list.R"))
source(here::here("R/process_pdf_community_spread.R"))

find_cell <- function(table, pattern) {
  table %>% 
    set_names(seq_along(colnames(.))) %>% 
    mutate(row = row_number()) %>% 
    pivot_longer(cols = -row, names_to = "col", values_to = "cell") %>% 
    mutate_at(1:2, as.numeric) %>% 
    filter(str_detect(cell, pattern))
}

names_from_row <- function(table, row = 1) {
  colnames(table) <- unlist(table[row, ])
  table %>% slice(-row)
}

drop_empty <- function(table) {
  table %>% 
    mutate_if(is.character, ~ if_else(.x == "", NA_character_, .x)) %>% 
    janitor::remove_empty("rows") %>% 
    janitor::remove_empty("cols")
}

collapse_header_rows <- function(table, rows) {
  header <- slice(table, rows) %>% map_chr(paste, collapse = " ")
  table %>% 
    slice(-!!rows) %>% 
    bind_rows(header, .) %>% 
    names_from_row(1)
}
extract_table <- function(
  table,
  top_left,
  top_right,
  bottom_left,
  numeric_cols = NULL,
  names_row = 1
) {
  col_starts <- find_cell(table, top_left)
  col_ends <- find_cell(table, top_right) %>% 
    filter(row == col_starts$row, col > col_starts$col)
  row_ends <- find_cell(table, bottom_left) %>% 
    filter(col == col_starts$col)
  
  x <- table %>%
    slice(col_starts$row:row_ends$row) %>% 
    select(col_starts$col:col_ends$col) %>% 
    names_from_row() %>% 
    drop_empty() %>% 
    janitor::clean_names()
  
  if (is.null(numeric_cols)) {
    x %>% 
      mutate_at(numeric_cols, as.numeric)
  } else x
}

read_table_pages <- function(
  pages,
  col_names, 
  pattern_filter = "\\d\\s{4,}\\d", 
  pattern_tab = "\\s{4,}", 
  replace_tab = "\t"
) {
  pages %>%
    str_split("\n") %>%
    map(str_subset, pattern = pattern_filter) %>%
    keep(~ length(.x) > 0) %>%
    map(str_replace_all, pattern = pattern_tab, replace_tab) %>%
    map_chr(paste, collapse = "\n") %>%
    readr::read_tsv(col_names = col_names)
}

add_total <- function(df, from) {
  if ("total" %in% names(df)) {
    if (!all(is.na(df[["total"]]))) {
      return(df)
    }
  }
  df$total <- 0
  for (col in from) {
    df$total <- df$total + df[[col]]
  }
  df
}

fix_missing_percent <- function(df, col = "percent") {
  idx_pct <- which(colnames(df) == col)
  idx_after <- seq_along(colnames(df))[-1:-idx_pct]
  df[!str_detect(df[[col]], "%"), idx_after] <- 
    df[!str_detect(df[[col]], "%"), idx_after - 1]
  df[!str_detect(df[[col]], "%"), idx_pct] <- NA_character_
  df
}

add_timestamp <- function(data, timestamp) {
  data %>% 
    mutate(timestamp = !!timestamp) %>% 
    select(timestamp, everything())
}

process_pdf <- function(pdf_file) {
  out <- list()
  
  # Page 1 ------------------------------------------------------------------
  page_text <- pdftools::pdf_text(pdf_file)
  
  page_one_text <- page_text[1]
  
  timestamp_pdf <-
    pdf_file %>% 
    str_extract("\\d[\\d_-]{6,}") %>% 
    ymd_hm(tz = "America/New_York") %>% 
    strftime("%F %T %Z", tz = "America/New_York")
  
  out$timestamp_pdf <- timestamp_pdf
  
  add_this_timestamp <- partial(add_timestamp, timestamp = timestamp_pdf)
  
  out$overall_counts <-
    page_one_text %>%
    str_extract_all("(Total (identified|tested)|Tested positive|Tested negative|Currently awaiting testing|Positive|Negative|Inconclusive|Awaiting BPHL testing)\\s*[\\d,]+") %>%
    `[[`(1) %>% 
    str_trim() %>% 
    tibble(raw = .) %>% 
    separate(raw, c("group", "count"), sep = "\\s{3,}") %>% 
    mutate_at(vars(group), tolower) %>% 
    mutate_at(vars(count), str_remove_all, pattern = "\\s*,\\s*") %>% 
    mutate_at(vars(count), as.numeric) %>% 
    mutate(
      group = case_when(
        str_detect(group, "total (identified|tested)") ~ "total",
        str_detect(group, "positive") ~ "positive",
        str_detect(group, "negative") ~ "negative",
        str_detect(group, "awaiting|pending") ~ "pending",
        str_detect(group, "inconclusive") ~ "inconclusive",
        TRUE ~ str_replace_all(group, " ", "_")
      )
    ) %>% 
    pivot_wider(names_from = group, values_from = count) %>% 
    add_this_timestamp()
  
  if (!nrow(out$overall_counts)) {
    out$overall_counts <- tibble(timestamp = timestamp_pdf)
  }
  
  
  # Page 2 ------------------------------------------------------------------
  page_2 <-
    page_text[[2]] %>% 
    str_replace_all("\\s{2,}|((\\d) ([\\dA-Z]))", "\\2\t\\3") %>% 
    str_replace_all("\\s{2,}|((\\d) ([\\dA-Z]))", "\\2\t\\3") %>% 
    read_table_pages(
      col_names = c(
        "county", "florida_resident", "percent",
        "florida_resident_outside", "non_florida_resident", "total",
        "other_1", "other_2", "other_3"
      ),
      pattern_filter = "\\d\t\\d",
      pattern_tab = "\\s{2,}"
    ) %>% 
    fix_missing_percent()
  
  out$cases_county <-
    page_2 %>% 
    select(-contains("percent"), contains("other")) %>% 
    select(county:total) %>%
    filter(county != "Total") %>% 
    add_this_timestamp()
  
  page_2_right <-
    page_2 %>%
    select(starts_with("other")) %>% 
    filter(!duplicated(other_1)) %>% 
    mutate(group = cumsum(is.na(other_1) | is.na(lag(other_1))))
  
  out$cases_sex <-
    page_2_right %>% 
    filter(group == 1) %>% 
    select(-group) %>% 
    set_names(c("Gender", "Count", "Percent")) %>% 
    drop_empty() %>% 
    select(-Percent) %>% 
    pivot_wider(names_from = Gender, values_from = Count) %>% 
    janitor::clean_names() %>%
    mutate_all(as.numeric) %>% 
    add_this_timestamp()
  
  out$cases_age <-
    page_2_right %>% 
    filter(group == 3, str_detect(other_1, "years")) %>% 
    select(age_group = other_1, count = other_2, percent = other_3) %>% 
    select(age_group, count) %>% 
    pivot_wider(names_from = age_group, values_from = count) %>% 
    mutate_all(as.numeric) %>% 
    add_this_timestamp()
  
  # Testing by County --------------------------------------------------------
  out$county_testing <- process_county_testing(page_text, timestamp_pdf)
  
  # Community Spread ---------------------------------------------------------
  community_spread <- process_community_spread(page_text, timestamp_pdf)
  if (!is.null(community_spread)) {
    out$community_spread_city <- community_spread$city
    out$community_spread_county <- community_spread$county
  }
  
  # Testing by Lab ----------------------------------------------------------
  pages_lab_testing <- page_text %>% 
    map_lgl(str_detect, pattern = "testing by lab") %>% 
    which()
  
  out$lab_testing <-
    page_text[pages_lab_testing] %>% 
    read_table_pages(col_names = c("reporting_lab", "negative", "positive", "percent_positive", "total")) %>% 
    select(-contains("percent")) %>%
    filter(reporting_lab != "Total") %>% 
    add_total(from = c("negative", "positive")) %>% 
    add_this_timestamp()
  
  # Line List ----------------------------------------------------------------
  out$line_list <- process_line_list(page_text, timestamp_pdf)
  
  out
}

process_and_output_pdf <- function(pdf_files) {
  for (pdf_file in pdf_files) {
    message("Processing ", pdf_file, "...")
    if (!file_exists(pdf_file)) next
    tables <- process_pdf(pdf_file)
    outdir <- path("pdfs", str_replace_all(tables$timestamp_pdf, " ", "_"))
    dir_create(outdir)
    for (name in names(tables)) {
      if (is.character(tables[[name]])) {
        write_lines(tables[[name]], path(outdir, "README.md"))
      } else if (inherits(tables[[name]], "data.frame")) {
        write_csv(tables[[name]], path(outdir, name, ext = "csv"))
      }
    }
  }
}

harmonize_pdf_data <- function() {
  dirs <- dir_ls(here::here("pdfs"), type = "directory", regexp = "2020")
  csvs <- dir_ls(dirs, regexp = "csv$")
  outdir <- here::here("pdfs", "data")
  dir_create(outdir)
  data <- map(csvs, read_csv)
  out <- list()
  for (df_name in names(data)) {
    name <- path_ext_remove(path_file(df_name))
    out[[name]] <- bind_rows(out[[name]], data[[df_name]])
  }
  iwalk(out, ~ write_csv(.x, path(outdir, .y, ext = "csv")))
}

process_all_pdfs <- function() {
  pdf_files <- fs::dir_ls(here::here("pdfs"), regexp = "pdf$")
  process_and_output_pdf(pdf_files)
  harmonize_pdf_data()
}