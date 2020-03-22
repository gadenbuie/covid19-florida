
description_community_spread <- paste(
  "Cities and counties of residence for 265 cases who had no known travel and no",
  "known contact with a confirmed case."
)

process_community_spread <- function(page_text, timestamp) {
  if (timestamp != "2020-03-21 10:08:00 EDT") {
    return(NULL)
  } else if (timestamp == "2020-03-21 10:08:00 EDT") {
    # this table was added in the above pdf report, 
    # but removed in the next iteration
    process_community_spread_v1(page_text, timestamp)
  }
}

process_community_spread_v1 <- function(page_text, timestamp) {
  pages_testing <- page_text %>% 
    map_lgl(str_detect, pattern = "Cities and counties") %>% 
    which()
  
  joined_table <- 
    page_text[pages_testing] %>%
    read_table_pages(col_names = c("city", "count", "county", "count2"), pattern_filter = "[a-z]\\s{4,}\\d") %>% 
    drop_empty() %>% 
    select(-contains("percent")) %>% 
    filter(county != "Total", city != "Total") %>% 
    add_timestamp(timestamp)
  
  list(
    city = joined_table %>% select(timestamp, city, count),
    county = joined_table %>% select(timestamp, county, count = count2)
  )
}
