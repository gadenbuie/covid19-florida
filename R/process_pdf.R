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
  page_2_counties <- tabulizer::extract_tables(
    file = pdf_file,
    pages = 2,
    area = list(c(
      top = 193.1202018721, left = 73.276492623426, 
      bottom = 893.14255524011, right = 552.37461410041
    )),
    guess = FALSE
  )
  
  page_2_col2 <- tabulizer::extract_tables(
    file = pdf_file,
    pages = 2,
    area = list(c(top = 182.0541642969, left = 568.23365661678, bottom = 889.73570960937, right = 809.94355227247)),
    guess = FALSE
  )[[1]] %>% 
    as_tibble(.name_repair = "unique")

  out$cases_county <-
    page_2_counties[[1]] %>% 
    as_tibble(.name_repair = "unique") %>% 
    collapse_header_rows(1:5) %>% 
    janitor::clean_names() %>% 
    drop_empty() %>% 
    select(-contains("percent")) %>% 
    select(county:total) %>%
    filter(county != "Total") %>% 
    add_timestamp()
  
  out$cases_sex <-
    page_2_col2 %>% 
    slice(1:4) %>% 
    names_from_row(1) %>% 
    drop_empty() %>% 
    select(-Percent) %>% 
    pivot_wider(names_from = Gender, values_from = Count) %>% 
    janitor::clean_names() %>%
    mutate_all(as.numeric) %>% 
    add_timestamp()
  
  out$cases_age <-
    page_2_col2 %>%
    slice(-1:-4) %>% 
    names_from_row(1) %>% 
    drop_empty() %>% 
    janitor::clean_names() %>% 
    select(age_group, count) %>% 
    pivot_wider(names_from = age_group, values_from = count) %>% 
    mutate_all(as.numeric) %>% 
    add_timestamp()
  
  # Testing by County --------------------------------------------------------
  pages_testing <- page_text %>% 
    map_lgl(str_detect, pattern = "PUI testing by county") %>% 
    which()
  
  page_county_testing <- 
    tabulizer::extract_tables(pdf_file, pages = pages_testing) %>% 
    map(as_tibble, .name_repair = "unique")
  
  out$county_testing <-
    page_county_testing %>% 
    map_dfr(collapse_header_rows, row = 1:2) %>% 
    janitor::clean_names() %>% 
    select(-contains("percent")) %>%
    rename(pending = no_result) %>% 
    filter(county != "Total") %>% 
    mutate_at(-1, as.numeric) %>% 
    add_timestamp()

  # Testing by Lab ----------------------------------------------------------
  pages_lab_testing <- page_text %>% 
    map_lgl(str_detect, pattern = "testing by lab") %>% 
    which()
  
  page_lab_testing <- 
    tabulizer::extract_tables(pdf_file, pages = pages_lab_testing) %>% 
    map(as_tibble, .name_repair = "unique")
  
  out$lab_testing <-
    page_lab_testing %>%
    map_dfr(collapse_header_rows, row = 1:3) %>% 
    janitor::clean_names() %>% 
    select(-contains("percent")) %>%
    filter(reporting_lab != "Total") %>% 
    mutate_at(-1, as.numeric) %>% 
    add_timestamp()
  
  
  # Line List ----------------------------------------------------------------
  pages_line_list <- page_text %>% 
    map_lgl(str_detect, pattern = "line list of cases") %>% 
    which()
  
  page_line_list <- 
    tabulizer::extract_tables(pdf_file, pages = pages_line_list) %>% 
    map(as_tibble, .name_repair = "unique")
  
  out$line_list <-
    page_line_list %>% 
    map_dfr(collapse_header_rows, row = 1:3) %>% 
    janitor::clean_names() %>% 
    mutate_at(vars(date_case_counted), mdy) %>% 
    mutate_at(vars(date_case_counted), strftime, "%F")
  
  out
}