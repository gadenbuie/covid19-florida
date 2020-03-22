
description_cases <- paste(
  "Tables below include cases in non-Florida residents and Florida who were", 
  "residents diagnosed and isolated outside Florida."
)

process_cases_page_2 <- function(page_text, timestamp) {
  if (timestamp < "2020-03-21 17:31:00 EDT") {
    process_cases_page_2_v1(page_text, timestamp)
  } else if (timestamp >= "2020-03-21 17:31:00 EDT") {
    process_cases_page_2_v2(page_text, timestamp)
  }
}

process_cases_page_2_v1 <- function(page_text, timestamp) {
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
  
  out <- list()
  
  out$cases_county <- try_safely(function() {
    page_2 %>% 
      select(-contains("percent"), contains("other")) %>% 
      select(county:total) %>%
      filter(county != "Total") %>% 
      add_timestamp(timestamp)
  })
  
  page_2_right <- try_safely(function() {
    page_2 %>%
      select(starts_with("other")) %>% 
      filter(!duplicated(other_1)) %>% 
      mutate(group = cumsum(is.na(other_1) | is.na(lag(other_1))))
  })
  
  if (!is.null(page_2_right)) {
    out$cases_sex <- try_safely(function() {
      page_2_right %>% 
        filter(group == 1) %>% 
        select(-group) %>% 
        set_names(c("Gender", "Count", "Percent")) %>% 
        drop_empty() %>% 
        select(-Percent) %>% 
        pivot_wider(names_from = Gender, values_from = Count) %>% 
        janitor::clean_names() %>%
        mutate_all(as.numeric) %>% 
        add_timestamp(timestamp)
    })
    
    out$cases_age <- try_safely(function() {
      page_2_right %>% 
        filter(group == 3, str_detect(other_1, "years")) %>% 
        select(age_group = other_1, count = other_2, percent = other_3) %>% 
        select(age_group, count) %>% 
        pivot_wider(names_from = age_group, values_from = count) %>% 
        mutate_all(as.numeric) %>% 
        add_timestamp(timestamp)
    })
  }
  
  out
}


process_cases_page_2_v2 <- process_cases_page_2_v1