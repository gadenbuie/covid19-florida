
description_cases <- paste(
  "Tables below include cases in non-Florida residents and Florida who were", 
  "residents diagnosed and isolated outside Florida."
)

process_cases_page_2 <- function(page_text, timestamp) {
  if (timestamp < "2020-03-22 09:51:00 EDT") {
    process_cases_page_2_v1(page_text, timestamp)
  } else if (timestamp >= "2020-03-22 09:51:00 EDT" && timestamp < "2020-03-27 18:19:00 EDT") {
    # the format changed with this report, but it didn't require a new version
    process_cases_page_2_v1(page_text, timestamp)
  } else if (timestamp >= "2020-03-27 18:19:00 EDT") {
    stop("Extraction of county cases has been temporarily disabled due to formatting changes.")
  }
}

process_cases_page_2_v1 <- function(page_text, timestamp) {
  page_2 <-
    page_text[2:3] %>% 
    str_subset("additional surveillance information", negate = TRUE) %>% 
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
        set_names(c("gender", "count", "percent")) %>% 
        mutate_at(vars(count), str_remove_all, pattern = ",") %>% 
        mutate_at(vars(count), as.numeric) %>% 
        drop_empty() %>% 
        select(-percent) %>% 
        filter(gender != "total") %>% 
        pivot_wider(names_from = gender, values_from = count) %>% 
        janitor::clean_names() %>%
        add_total(c("male", "female", "unknown")) %>% 
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
