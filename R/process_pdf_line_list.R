process_line_list <- function(page_text, timestamp) {
  if (timestamp < "2020-03-20 09:00:00 EDT") {
    process_line_list_v1(page_text, timestamp)
  } else if (timestamp >= "2020-03-20 09:00:00 EDT") {
    process_line_list_v2(page_text, timestamp)
  }
}

process_line_list_v1 <- function(page_text, timestamp) {
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
  
  line_list %>% 
    add_timestamp(timestamp)
}

process_line_list_v2 <- function(page_text, timestamp) {
  pages_cases <- page_text %>% 
    map_lgl(str_detect, pattern = "line list of cases") %>% 
    which()
  
  pages_deaths <- page_text %>% 
    map_lgl(str_detect, pattern = "line list of deaths") %>%
    which()
  
  cases_text <- page_text[pages_cases]
  deaths_text <- page_text[pages_deaths]
  
  case_list <- 
    bind_rows(
      process_line_list_v2_table(cases_text) %>% 
        mutate(died = FALSE),
      process_line_list_v2_table(deaths_text) %>% 
        mutate(died = TRUE)
    )
  
  
  case_list %>% 
    add_timestamp(timestamp)
}

process_line_list_v2_table <- function(pages_text) {
  line_list_text <- 
    pages_text %>% 
    str_split("\n") %>% 
    map(str_subset, pattern = "^\\d+\\s{2,}[A-Z]")
  
  tables <- 
    line_list_text %>% 
    map(read_table, col_names = FALSE)
  
  index_has_pattern <- function(df, pattern, .f = any) {
    df %>% 
      map(str_detect, pattern = pattern) %>% 
      map_lgl(.f) %>% 
      which()
  }
  
  reindex_cols <- function(df) {
    df %>% set_names(paste0("X", seq_along(.)))
  }
  
  for (i in seq_along(tables)) {
    requires_sex_travel_split <- index_has_pattern(tables[[i]], "(Male|Female)\\s*(Yes|No)")
    if (length(requires_sex_travel_split)) {
      tables[[i]] <- tables[[i]] %>% 
        separate(requires_sex_travel_split, into = c("a", "b"), sep = "\\s+") %>% 
        reindex_cols()
    }
    
    idx_binary <- index_has_pattern(tables[[i]], "^(Yes|No|Unknown|)$", all)
    if (idx_binary[2] != idx_binary[1] + 2) {
      tables[[i]] <- tables[[i]] %>% 
        unite(col = "a", (idx_binary[1] + 1):(idx_binary[2] - 1), sep = " ") %>% 
        reindex_cols()
      idx_binary <- index_has_pattern(tables[[i]], "^(Yes|No|Unknown|)$", all)
    }
    
    idx_date <- index_has_pattern(tables[[i]], "\\d+/\\d+/\\d+")
    if (idx_date != idx_binary[2] + 2) {
      tables[[i]] <- tables[[i]] %>% 
        unite("a", (idx_binary[2] + 1):(idx_date - 1), sep = " ")
    }
    
    colnames(tables[[i]]) <- c(
      "case", "county", "age", "sex",
      "travel_related", "travel_detail", "contact",
      "jurisdiction", "date_counted"
    )
  }
  
  map_dfr(tables, ~ .) %>% 
    mutate_if(is.character, str_trim) %>% 
    mutate(date_counted = mdy(date_counted) %>% strftime("%F"))
}