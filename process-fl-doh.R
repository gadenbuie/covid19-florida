#! /usr/bin/env Rscript
options(error = NULL)
message("Check start - ", strftime(Sys.time(), "%F %T", tz = "America/New_York"))

# Library ----
library(tidyr, warn.conflicts = FALSE)
library(purrr, warn.conflicts = FALSE)
library(dplyr, warn.conflicts = FALSE)
library(stringr, warn.conflicts = FALSE)
library(lubridate, warn.conflicts = FALSE)
library(glue, warn.conflicts = FALSE)
library(fs, warn.conflicts = FALSE)
library(xml2, warn.conflicts = FALSE)
library(rvest, warn.conflicts = FALSE)
library(readr, warn.conflicts = FALSE)

dir_create("snapshots")

# Functions ----
timestamp_from_node <- function(node) {
  text <- xml_text(node)
  time <- str_extract(text, "\\d{1,2}:\\d{2} [APMapm.]+")
  date <- str_extract(text, "(\\d+[/.-]?){3}")
  mdy_hm(glue("{date} {time}"), tz = "America/New_York")
}

append_csv <- function(data, path) {
  existing_data <- if (file.exists(path)) {
    read_csv(path)
  }
  write_csv(bind_rows(existing_data, data), path)
}

# Add random wait time to offset regularity of cronlog
if (!interactive()) {
  wait_time <- runif(1, 0, 120)
  message("Waiting ", round(wait_time, 2), "s")
  Sys.sleep(wait_time)
}

# Get FL DOH Page ----
fl_doh_url <- "http://www.floridahealth.gov/diseases-and-conditions/COVID-19/"

fl_doh <- read_html(fl_doh_url)
fl_doh_digest <- digest::sha1_digest(fl_doh)
ts_now <- now()
ts_current <- strftime(ts_now, '%FT%H%M%S', tz = "America/New_York")

# Check hash of latest with hash of last update ----
if (file.exists(".last-update")) {
  last_update <- readLines(".last-update", warn = FALSE)
  if (last_update[1] == fl_doh_digest) {
    cat(glue("Checked: {ts_current}"), file = ".last-update", append = TRUE)
    message("No updates - ", strftime(Sys.time(), "%F %T", tz = "America/New_York"))
    stop("No updates at this time")
    quit("n", 1)
  }
}

write_html(fl_doh, path("snapshots", strftime(ts_now, '%F%T', tz = "America/New_York"), ext = "html"))

# FL DOH Table Timestamp ----
timestamp_page <- fl_doh %>% xml_node("block p sup") %>% timestamp_from_node()
timestamp_table <- fl_doh %>% xml_node("table span sub") %>% timestamp_from_node()

# Reset last run log
writeLines(
  c(
    fl_doh_digest, 
    glue("DOH Page: {timestamp_page}"),
    glue("DOH Table: {timestamp_table}"),
    glue("Read: {ts_current}")
  ), 
  con = ".last-update"
)

# Main table of Florida Residents ----
fl_doh_table <- read_xml("<table></table>")

fl_doh %>% 
  xml_nodes("table tr:not(:first-child)") %>% 
  walk(~ xml_add_child(fl_doh_table, .x))

fl_residents_table <-
  rvest:::html_table.xml_node(fl_doh_table, header = TRUE) %>% 
  as_tibble(.name_repair = "minimal") %>% 
  janitor::clean_names() %>% 
  rename(id = x) %>% 
  mutate(timestamp = timestamp_table) %>% 
  append_csv("covid-19-florida-residents.csv")

# Main Stats ----
fl_stats <-
  xml_node(fl_doh, xpath = "//h3[contains(., 'Positive Cases')]") %>% 
  xml_parent() %>% 
  as_list() %>% 
  map_if(~ "strong" %in% names(.x), ~ .x[["strong"]]) %>% 
  map_if(~ "sup" %in% names(.x), ~ .x[["sup"]]) %>% 
  map_dfr(~ tibble(text = .x[[1]]), .id = "tag") %>% 
  filter(tag != "p", tag != "h1") %>% 
  mutate(group = cumsum(tag == "h3")) %>% 
  pivot_wider(names_from = tag, values_from = text, values_fn = list(text = list)) %>% 
  unnest(c(h3, div)) %>% 
  separate(div, c("count", "description"), sep = " – ", fill = "right") %>% 
  mutate_at(vars(count), str_remove, pattern = "[^\\d]") %>% 
  mutate_at(vars(count), as.numeric) %>% 
  mutate_if(is.character, tolower) %>% 
  mutate_if(is.character, str_trim) %>% 
  replace_na(list(description = "")) %>% 
  mutate(
    variable_group = case_when(
      str_detect(h3, "positive") ~ "positive",
      str_detect(h3, "deaths") ~ "deaths",
      str_detect(h3, "negative test") ~ "tests_negative",
      str_detect(h3, "pending test") ~ "tests_pending",
      str_detect(h3, "health monitoring") ~ "monitored"
    ),
    variable_subgroup = case_when(
      description == "florida residents" ~ "resident",
      str_detect(description, "isolated") ~ "resident_outside",
      str_detect(description, "non-florida") ~ "non_resident",
      str_detect(description, "current") ~ "current",
      str_detect(description, "to date") ~ "to_date",
      TRUE ~ gsub(" ", "_", description)
    ),
    variable = paste(variable_group, variable_subgroup, sep = "_"),
    variable = sub("_$", "", variable)
  ) %>% 
  select(variable, count) %>% 
  mutate(timestamp = timestamp_page) %>% 
  pivot_wider(names_from = variable, values_from = count) %>% 
  append_csv("covid-19-florida-stats.csv")
  
# Push changes to repo ----
if (git2r::in_repository()) {
  is_dirty <- rlang::has_length(git2r::status(untracked = FALSE)$unstaged)
  if (is_dirty) {
    git2r::add(".", ".")
    git2r::commit(message = glue("[auto update] {ts_current}"))
    git2r::push()
  }
}

message("Check end - ", strftime(Sys.time(), "%F %T", tz = "America/New_York"))
