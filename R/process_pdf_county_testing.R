process_county_testing <- function(page_text, timestamp) {
  if (timestamp < "2020-03-20 17:39:00 EDT") {
    process_county_testing_v1(page_text, timestamp)
  } else if (timestamp >= "2020-03-20 17:40:00 EDT" && timestamp < "2020-03-21 17:31:00 EDT") {
    process_county_testing_v2(page_text, timestamp)
  } else if (timestamp >= "2020-03-21 17:31:00 EDT" && timestamp < "2020-03-25 10:07:00 EDT") {
    process_county_testing_v3(page_text, timestamp)
  } else if (timestamp >= "2020-03-25 10:07:00 EDT") {
    process_county_testing_v4(page_text, timestamp)
  }
}

process_county_testing_v1 <- function(page_text, timestamp) {
  pages_testing <- page_text %>% 
    map_lgl(str_detect, pattern = "PUI testing by county") %>% 
    which()
  
  page_text[pages_testing] %>%
    read_table_pages(col_names = c("county", "pending", "negative", "positive", "percent", "total")) %>% 
    drop_empty() %>% 
    select(-contains("percent")) %>% 
    add_total(from = c("pending", "negative", "positive")) %>%  
    filter(county != "Total") %>% 
    add_timestamp(timestamp)
}

process_county_testing_v2 <- function(page_text, timestamp) {
  pages_testing <- page_text %>% 
    map_lgl(str_detect, pattern = "All persons tested") %>% 
    which()
  
  page_text[pages_testing] %>%
    read_table_pages(col_names = c("county", "pending", "negative", "positive", "total", "percent")) %>% 
    drop_empty() %>% 
    select(-contains("percent")) %>% 
    add_total(from = c("pending", "negative", "positive")) %>%  
    filter(county != "Total") %>% 
    add_timestamp(timestamp)
}

process_county_testing_v3 <- function(page_text, timestamp) {
  pages_testing <- page_text %>% 
    map_lgl(str_detect, pattern = "All persons tested") %>% 
    which()
  
  page_text[pages_testing] %>%
    # remove last two columns (total and percent)
    str_replace_all("[\\d,]+\\s+\\d+%\n", "\n") %>% 
    read_table_pages(
      col_names = c("county", "pending", "negative", "positive", "inconclusive"),
      pattern_tab = "\\s{3,}"
    ) %>% 
    drop_empty() %>%
    select(-contains("percent")) %>% 
    replace_na(list(inconclusive = 0)) %>% 
    add_total(from = c("negative", "positive", "inconclusive")) %>%  
    filter(county != "Total") %>% 
    add_timestamp(timestamp)
}

process_county_testing_v4 <- function(page_text, timestamp) {
  pages_testing <- page_text %>% 
    map_lgl(str_detect, pattern = "All persons with test") %>% 
    which()
  
  page_text[pages_testing] %>%
    # remove last two columns (total and percent)
    str_replace_all("[\\d,]+\\s+\\d+%\n", "\n") %>% 
    read_table_pages(
      col_names = c("county", "pending", "inconclusive", "negative", "positive"),
      pattern_tab = "\\s{3,}"
    ) %>% 
    filter(county != "Total") %>% 
    drop_empty() %>%
    select(-contains("percent")) %>% 
    mutate_at(vars(pending, inconclusive, negative, positive), as.numeric) %>% 
    replace_na(list(inconclusive = 0)) %>% 
    add_total(from = c("negative", "positive", "inconclusive")) %>%  
    filter(county != "Total") %>% 
    add_timestamp(timestamp)
}