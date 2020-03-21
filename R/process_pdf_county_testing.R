process_county_testing <- function(page_text, timestamp) {
  if (timestamp < "2020-03-20 17:39:00 EDT") {
    process_county_testing_v1(page_text, timestamp)
  } else if (timestamp >= "2020-03-20 17:40:00 EDT") {
    process_county_testing_v2(page_text, timestamp)
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