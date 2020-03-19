process_pdf <- function(pdf_file) {
  out <- list()
  
  # Page 1 ------------------------------------------------------------------
  page_text <- pdftools::pdf_text(pdf_file)
  
  page_one_text <- page_text[1]
  
  out$timestamp_pdf <-
    pdf_file %>% 
    str_extract("\\d[\\d_-]{6,}") %>% 
    ymd_hm(tz = "America/New_York") %>% 
    strftime("%F %T %Z", tz = "America/New_York")
  
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
  
  page_2 <- tabulizer::extract_tables(pdf_file, pages = 2) %>% 
    map(as_tibble, .name_repair = "unique")
  
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
  
  out$cases_county <-
    list(
      page_2[[2]] %>% select(1:7) %>% select(-3) %>% slice(-1:-5),
      page_2[[1]] %>% select(1:6)
    ) %>% 
    map_dfr(~ set_names(.x, c("county", "florida_resident", "percent", "outside_florida", "non_florida_resident", "total"))) %>% 
    select(county, florida_resident, outside_florida, non_florida_resident, total) %>% 
    add_timestamp()
  
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
  
  out$cases_sex <- 
    page_2[[2]] %>% 
    extract_table("Gender", "Percent", "Unknown", numeric_cols = "count") %>% 
    select(-percent) %>% 
    pivot_wider(names_from = gender, values_from = count) %>% 
    janitor::clean_names() %>% 
    add_timestamp()
  
  out$cases_age <-
    page_2[[1]] %>% 
    select(7:8) %>% 
    set_names(c("age_group", "count")) %>% 
    pivot_wider(names_from = age_group, values_from = count) %>% 
    add_timestamp()
  
  # Page 5-6 ----------------------------------------------------------------
  
  pages_testing <- page_text %>% 
    map_lgl(str_detect, pattern = "PUI testing by county") %>% 
    which()
  
  page_county_testing <- 
    tabulizer::extract_tables(pdf_file, pages = pages_testing) %>% 
    map(as_tibble, .name_repair = "unique")
  
  out$county_testing <- 
    page_county_testing %>% 
    map_dfr(~ {
      header <- slice(.x, 1:2) %>% map_chr(paste, collapse = " ")
      .x %>% 
        slice(-1:-2) %>% 
        bind_rows(header, .) %>% 
        names_from_row(1)
    }) %>% 
    janitor::clean_names() %>% 
    select(-contains("percent")) %>% 
    filter(county != "Total") %>% 
    mutate_at(-1, as.numeric) %>% 
    add_timestamp()
  
  # Page 6-7 ----------------------------------------------------------------
  pages_line_list <- page_text %>% 
    map_lgl(str_detect, pattern = "line list of cases") %>% 
    which()
  
  page_line_list <- 
    tabulizer::extract_tables(pdf_file, pages = pages_line_list) %>% 
    map(as_tibble, .name_repair = "unique")
  
  out$line_list <- 
    page_line_list %>% 
    map_dfr(~ {
      header <- slice(.x, 1:3) %>% map_chr(paste, collapse = " ")
      .x %>% 
        slice(-1:-4) %>% 
        bind_rows(header, .) %>% 
        names_from_row(1)
    }) %>% 
    janitor::clean_names() %>% 
    mutate_at(vars(date_case_counted), mdy) %>% 
    mutate_at(vars(date_case_counted), strftime, "%F")
  
  out
}