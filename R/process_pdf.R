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
  
  add_timestamp <- function(data) {
    data %>% 
      mutate(timestamp = timestamp_pdf) %>% 
      select(timestamp, everything())
  }
  
  out$overall_counts <-
    page_one_text %>%
    str_extract_all("(Total identified|Tested positive|Tested negative|Currently awaiting testing)\\s*[\\d,]+") %>%
    `[[`(1) %>% 
    tibble(raw = .) %>% 
    separate(raw, c("group", "count"), sep = "\\s{3,}") %>% 
    mutate_at(vars(group), tolower) %>% 
    mutate_at(vars(count), str_remove_all, pattern = "\\s*,\\s*") %>% 
    mutate_at(vars(count), as.numeric) %>% 
    mutate(
      group = case_when(
        str_detect(group, "total identified") ~ "total",
        str_detect(group, "positive") ~ "positive",
        str_detect(group, "negative") ~ "negative",
        str_detect(group, "awaiting|pending") ~ "pending",
        TRUE ~ str_replace_all(group, " ", "_")
      )
    ) %>% 
    pivot_wider(names_from = group, values_from = count) %>% 
    add_timestamp()
  
  
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
    )
  
  out$cases_county <-
    page_2 %>% 
    select(-contains("percent"), contains("other")) %>% 
    select(county:total) %>%
    filter(county != "Total") %>% 
    add_timestamp()
  
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
    add_timestamp()
  
  out$cases_age <-
    page_2_right %>% 
    filter(group == 3, !str_detect(other_1, "Age group")) %>% 
    select(age_group = other_1, count = other_2, percent = other_3) %>% 
    select(age_group, count) %>% 
    pivot_wider(names_from = age_group, values_from = count) %>% 
    mutate_all(as.numeric) %>% 
    add_timestamp()
  
  # Testing by County --------------------------------------------------------
  pages_testing <- page_text %>% 
    map_lgl(str_detect, pattern = "PUI testing by county") %>% 
    which()
  
  out$county_testing <-
    page_text[pages_testing] %>%
    read_table_pages(col_names = c("county", "pending", "negative", "positive", "percent", "total")) %>% 
    drop_empty() %>% 
    select(-contains("percent")) %>% 
    add_total(from = c("pending", "negative", "positive")) %>%  
    filter(county != "Total") %>% 
    add_timestamp()
  
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
    add_timestamp()
  
  # Line List ----------------------------------------------------------------
  pages_line_list <- page_text %>% 
    map_lgl(str_detect, pattern = "line list of cases") %>% 
    which()
  
  line_list_text <- 
    page_text[pages_line_list] %>% 
    str_split("\n") %>% 
    map(str_subset, pattern = "^\\d+\\s{2,}[A-Z]")
  
  line_list <-
    line_list_text %>% 
    map(str_extract, pattern = ".+(FL resident|isolated in FL)") %>% 
    keep(~ length(.) > 0) %>% 
    map_dfr(readr::read_table, col_names = c("case", "county", "age", "sex", "travel_related", paste0("jurisdiction", 1:3))) %>% 
    mutate_at(vars(contains("jurisdiction")), ~ if_else(is.na(.x), "", .x)) %>% 
    mutate(jurisdiction = paste(jurisdiction1, jurisdiction2, jurisdiction3)) %>% 
    mutate_at(vars(jurisdiction), str_trim) %>% 
    select(-matches("\\d$"))
  
  line_list$travel_detail <- 
    line_list_text %>% 
    map(str_extract, pattern = "(FL resident|isolated in FL).+") %>% 
    map(str_remove, pattern = "^(FL resident|isolated in FL)") %>% 
    map(str_extract, pattern = "^.+?(Yes|No|Unknown|\\d)") %>% 
    map(str_remove, pattern = "(Yes|No|Unknown|\\d)$") %>% 
    unlist() %>% 
    str_trim()
  
  line_list$date_counted <-
    line_list_text %>% 
    map(str_extract, pattern = "[\\d/]{5,8}$") %>% 
    unlist() %>% 
    mdy() %>% 
    strftime("%F")
  
  out$line_list <-
    line_list %>% 
    add_timestamp()
  
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
