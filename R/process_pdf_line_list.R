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
    map(str_replace_all, pattern = "((Male|Female|Unknown)\\s+)(Yes|No|Unknown)", "\\1 \\3") %>% 
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
  
  cases <- page_text[pages_cases] %>% process_line_list_v2_table()
  deaths <- page_text[pages_deaths] %>% process_line_list_v2_table()
  
  case_list <- 
    bind_rows(
      cases %>% 
        anti_join(deaths, by = c("county", "age", "sex", "date_counted")) %>% 
        mutate(died = FALSE),
      deaths %>% 
        mutate(died = TRUE)
    )
  
  
  case_list %>% 
    add_timestamp(timestamp)
}

words_with_spaces <- c(
  "United Kingdom",
  "UNITED KINGDOM",
  "FL resident",
  "Non-FL resident",
  "Not diagnosed/isolated in FL",
  "Dominican Republic",
  "DOMINICAN REPUBLIC",
  "Trinidad and Tobago",
  "TRINIDAD AND TOBAGO",
  "United Arab Emirates",
  "UNITED ARAB EMIRATES",
  "Cayman Islands",
  "CAYMAN ISLANDS",
  "El Salvador",
  "EL SALVADOR",
  "South Korea",
  "SOUTH KOREA",
  "Saudi Arabia",
  "SAUDI ARABIA",
  "; "
)

process_line_list_v2_table <- function(pages_text) {
  line_list_text <-
    pages_text %>%
    replace_with_nbsp(fl_counties_w_spaces) %>%
    replace_with_nbsp(words_with_spaces) %>% 
    str_split("\n") %>% 
    map(str_subset, pattern = "^\\d[\\d\\s,]{3,}[A-Z]")
  
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
    
    requires_county_age_split <- !is.numeric(tables[[i]][[3]]) && any(str_detect(tables[[i]][[2]], "\\d"))
    if (requires_county_age_split) {
      tables[[i]] <- tables[[i]] %>% 
        extract(2, paste0("x", 1:2), regex = "([a-zA-Z .\\s]+) (\\d+)") %>% 
        mutate_at(3, as.numeric) %>% 
        reindex_cols()
    }
    
    # if 25%+ of the non-empty travel_detail column values end with Yes|No|Unknown,
    # then assume that the column needs to be split into travel_detail and contact
    requires_travel_contact_split <- str_detect_pct(tables[[i]][[6]], "(Yes|No|Unknown)$") > 0.25
    
    if (requires_travel_contact_split) {
      tables[[i]] <- tables[[i]] %>% 
        extract(6, c("a", "b"), regex = "(.+?) (Yes|No|Unknown)$", remove = FALSE) %>%
        mutate_at(6:8, str_trim) %>% 
        mutate(
          a = if_else(is.na(a) & !str_detect(X6, "^Yes|No|Unknown$"), X6, a),
          b = if_else(is.na(b) & str_detect(X6, "^Yes|No|Unknown$"), X6, b),
        ) %>% 
        replace_na(list(a = "", b = "")) %>% 
        select(-6) %>% 
        reindex_cols()
    }
    
    idx_binary <- index_has_pattern(tables[[i]], "^(Yes|No|Unknown|)$", all)
    if (length(idx_binary) == 1 && str_detect_pct(tables[[i]][[idx_binary[1] + 2]], "(?<!; )FL") > 0.25) {
      # contact column is likely completely empty
      tables[[i]]$a <- ""
      tables[[i]] <- tables[[i]] %>% 
        select(1:(idx_binary[1] + 1), a, everything())
      idx_binary <- c(idx_binary, idx_binary[1] + 2)
    } else if (length(idx_binary) == 2 && idx_binary[2] != idx_binary[1] + 2) {
      tables[[i]] <- tables[[i]] %>% 
        unite(col = "a", (idx_binary[1] + 1):(idx_binary[2] - 1), sep = " ")
      idx_binary <- index_has_pattern(tables[[i]], "^(Yes|No|Unknown|)$", all)
    }
    tables[[i]] <- reindex_cols(tables[[i]])
    
    # make sure date is in it's own column
    idx_date <- index_has_pattern(tables[[i]], "\\d+/\\d+/\\d+")
    if (idx_date != idx_binary[2] + 2) {
      if (idx_date > idx_binary[2] + 2) {
        # there are extra columns between binary `contact` and `date_counted`
        # that need to be collapsed into `jurisdiction`
        tables[[i]] <- tables[[i]] %>% 
          unite("a", (idx_binary[2] + 1):(idx_date - 1), sep = " ")
      } else if (idx_date == idx_binary[2] + 1) {
        tables[[i]] <- tables[[i]] %>% 
          extract(idx_date, c("a", "b"), "(.+?) (\\d+/\\d+/\\d+)")
      }
    }
    
    colnames(tables[[i]]) <- c(
      "case", "county", "age", "sex",
      "travel_related", "travel_detail", "contact",
      "jurisdiction", "date_counted"
    )
  }
  
  map_dfr(tables, ~ .) %>%
    mutate_at(vars(case), str_remove_all, ",") %>% 
    mutate_at(vars(case), as.numeric) %>%
    mutate_if(is.character, str_trim) %>%
    mutate_if(is.character, remove_nbsp) %>% 
    mutate(date_counted = mdy(date_counted) %>% strftime("%F"))
}