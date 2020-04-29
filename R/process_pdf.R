library(readr)
library(dplyr)
library(tidyr)
library(purrr)
library(stringr)
library(lubridate)
library(glue)
library(fs)

fl_counties_w_spaces <- c("St. Johns", "Palm Beach", "Santa Rosa", "Indian River", "St. Lucie")

walk(
  dir_ls(here::here("R"), regexp = "process_pdf_.+R$"),
  sys.source, 
  env = globalenv()
)

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

replace_with_nbsp <- function(x, strings) {
  for (string in strings) {
    replacement <- str_replace_all(string, " ", "\u00a0")
    x <- gsub(string, replacement, x, fixed = TRUE)
  }
  x
}

remove_nbsp <- function(x) {
  gsub("\u00a0", " ", x, fixed = TRUE)
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
    quietly(readr::read_tsv, col_names = col_names)
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

try_safely <- function(.f, ...) {
  .g <- purrr::safely(.f)
  res <- .g(...)
  if (is.null(res$error)) {
    return(res$result)
  } else {
    rlang::warn(res$error$message)
    return(NULL)
  }
}

quietly <- function(.x, .f, ...) {
  if (isTRUE(getOption("process_pdf_quietly", TRUE))) {
    suppressWarnings(.f(.x, ...))
  } else {
    .f(.x, ...)
  }
}

str_detect_pct <- function(x, pattern, exclude_empty = TRUE) {
  n_out_of <- if (exclude_empty) {
    sum(str_detect(x, "^\\s*$", negate = TRUE))
  } else {
    length(x)
  }
  sum(str_detect(x, pattern)) / n_out_of
}

process_pdf <- function(pdf_file) {
  out <- list(message = c())
  add_message <- function(...) {
    out$message <<- c(out$message, paste0(..., collapse = ""))
  }
  
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
    str_extract_all("(Total (identified|tested)|Tested positive|Tested negative|Currently awaiting testing|Positive|Negative|Inconclusive|Awaiting BPHL.+?testing)\\s*[\\d,]+") %>%
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
  out_page_2 <- try_safely(process_cases_page_2, page_text, timestamp_pdf)
  if (is.null(out_page_2)) {
    add_message("Extraction failed for case summary tables from page 2")
  }
  
  out$cases_county <- out_page_2$cases_county
  out$cases_sex    <- out_page_2$cases_sex
  out$cases_age    <- out_page_2$cases_age
  
  # Testing by County --------------------------------------------------------
  out$county_testing <- try_safely(process_county_testing, page_text, timestamp_pdf)
  if (is.null(out$county_testing)) {
    add_message("County testing extraction failed for ", pdf_file)
  }
  
  # Community Spread ---------------------------------------------------------
  community_spread <- try_safely(process_community_spread, page_text, timestamp_pdf)
  if (!is.null(community_spread)) {
    add_message("This report includes community spread tables")
    out$community_spread_city <- community_spread$city
    out$community_spread_county <- community_spread$county
  }
  
  # Testing by Lab ----------------------------------------------------------
  pages_lab_testing <- page_text %>% 
    map_lgl(str_detect, pattern = "testing by lab") %>% 
    which()
  
  out$lab_testing <- try_safely(function() {
    page_text[pages_lab_testing] %>% 
      read_table_pages(col_names = c("reporting_lab", "negative", "positive", "percent_positive", "total")) %>% 
      select(-contains("percent")) %>%
      filter(reporting_lab != "Total") %>% 
      add_total(from = c("negative", "positive")) %>% 
      add_this_timestamp()
  })
  
  if (is.null(out$lab_testing)) {
    add_message("Lab test counts were not extracted")
  }
  
  # Line List ----------------------------------------------------------------
  out$line_list <- try_safely(process_line_list, page_text, timestamp_pdf)
  
  if (is.null(out$line_list)) {
    add_message("Line list tables were not parsed correctly and are not included")
  }
  
  if (length(out$message)) {
    for (msg in out$message) message(msg)
  }
  
  qc_pdf_read(out)
}

process_and_output_pdf <- function(pdf_files) {
  for (pdf_file in pdf_files) {
    message("Processing ", pdf_file, "...")
    if (!file_exists(pdf_file)) next
    tables <- process_pdf(pdf_file)
    outdir <- path("pdfs", str_replace_all(tables$timestamp_pdf, " ", "_"))
    outdir <- str_replace_all(outdir, ":", "")
    dir_create(outdir)
    if ("timestamp_pdf" %in% names(tables)) {
      write_lines(tables[["timestamp_pdf"]], path(outdir, "README.md"), append = FALSE)
    }
    if ("message" %in% names(tables) && length(tables[["message"]])) {
      cat(
        "\n", paste("-", tables[["message"]]), 
        file = path(outdir, "README.md"), 
        append = TRUE,
        sep = "\n"
      )
    }
    for (name in setdiff(names(tables), c("timestamp_pdf", "message"))) {
      if (is.character(tables[[name]])) {
        cat(
          "\n", tables[[name]], 
          file = path(outdir, "README.md"), 
          append = TRUE,
          sep = "\n"
        )
      } else if (inherits(tables[[name]], "data.frame")) {
        write_csv(tables[[name]], path(outdir, name, ext = "csv"))
      }
    }
  }
}

harmonize_pdf_data <- function() {
  dirs <- dir_ls(here::here("pdfs"), type = "directory", regexp = "2020")
  csvs <- dir_ls(dirs, regexp = "csv$")
  outdir <- here::here("data")
  dir_create(outdir)
  data <- map(csvs, read_csv, col_types = cols(.default = col_character()))
  out <- list()
  for (df_name in names(data)) {
    name <- path_ext_remove(path_file(df_name))
    out[[name]] <- bind_rows(out[[name]], data[[df_name]])
  }
  iwalk(out, ~ write_csv(
    .x, 
    path(outdir, paste0("covid-19-florida_pdf_", gsub("-", "_", .y)), ext = "csv")))
}

process_all_pdfs <- function() {
  pdf_files <- fs::dir_ls(here::here("pdfs"), regexp = "pdf$")
  process_and_output_pdf(pdf_files)
  harmonize_pdf_data()
}