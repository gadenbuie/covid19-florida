library(dplyr)
library(jsonlite)
library(lubridate)
library(glue)

dash <- read_csv("data/covid-florida_dash_summary.csv")

covid_tracker_api <- "https://covidtracking.com/api/states/daily?state=FL&date={date}"

started <- ymd("2020-03-04")
dates <- strftime(seq(started, today() - 1, by = "day"), "%Y%m%d")

data <- 
  map(dates, ~ glue(covid_tracker_api, date = .x)) %>% 
  map(fromJSON)

data %>%
  map(~ discard(.x, is.null)) %>% 
  map_dfr(~ .) %>% 
  replace_na(list(death = 0)) %>% 
  rename(florida_deaths = death) %>% 
  mutate(
    timestamp = ymd_hm(glue("{date} 12:00"), tz = "America/New_York"),
    timestamp = strftime(timestamp, "%F %T %Z", tz = "America/New_York")
  ) %>% 
  bind_rows(dash) %>% 
  select(names(dash)) %>% 
  select(timestamp:pending, florida_deaths, everything()) %>% 
  write_csv("data/covid-florida_dash_summary.csv")
