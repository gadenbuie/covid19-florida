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
  ts <- glue("{date} {time}")
  ts <- str_replace_all(ts, "[.]", "")
  mdy_hm(ts, tz = "America/New_York")
}

append_csv <- function(data, path) {
  existing_data <- if (file.exists(path)) {
    read_csv(path, col_types = cols(.default = col_character()))
  }
  data <- mutate_all(data, as.character)
  write_csv(bind_rows(existing_data, data), path)
}

# Add random wait time to offset regularity of cronlog
if (!interactive()) {
  wait_time <- runif(1, 0, 120)
  message("Waiting ", round(wait_time, 2), "s")
  Sys.sleep(wait_time)
}

# Get FL DOH Main Page ----
fl_doh_url <- "http://www.floridahealth.gov/diseases-and-conditions/COVID-19/"

fl_doh <- read_html(fl_doh_url)
fl_doh_digest <- digest::sha1_digest(xml_text(fl_doh))
ts_now <- now()
ts_current <- strftime(ts_now, '%FT%H%M%S', tz = "America/New_York")

# Check hash of latest with hash of last update ----
if (file.exists(".last-update")) {
  last_update <- readLines(".last-update", warn = FALSE)
  if (last_update[1] == fl_doh_digest) {
    cat("\n", glue("Checked: {ts_current}"), file = ".last-update", append = TRUE, sep = "")
    message("No updates - ", strftime(Sys.time(), "%F %T", tz = "America/New_York"))
    stop("No updates at this time")
    quit("n", 1)
  }
}

write_html(fl_doh, path("snapshots", strftime(ts_now, 'fl_doh_main_%FT%H%M%S', tz = "America/New_York"), ext = "html"))

# FL DOH Table Timestamp ----
timestamp_page <- fl_doh %>% xml_node("block p sup") %>% timestamp_from_node()

# Reset last run log
writeLines(
  c(
    fl_doh_digest, 
    glue("DOH Page: {timestamp_page}"),
    glue("Read: {ts_current}")
  ), 
  con = ".last-update"
)

table_rows <- c(
  "Confirmed Cases in Florida Residents",
  "Cases in Non-Florida Residents",
  "Total Cases Overview"
)

fl_doh %>% 
  html_table() %>% 
  bind_rows() %>% 
  as_tibble() %>% 
  set_names(c("variable", "count")) %>% 
  mutate(timestamp = strftime(timestamp_page, "%F %T %Z", tz = tz(timestamp_page))) %>% 
  select(timestamp, everything()) %>% 
  append_csv("covid-19-florida-doh.csv")

# Screenshot FL DOH page --------------------------------------------------
chrm <- chromote::ChromoteSession$new()

{
  chrm$Page$navigate(fl_doh_url)
  chrm$Page$loadEventFired()
  Sys.sleep(5)
}
chrm$Emulation$setVisibleSize(width = 900, height = 1800, wait_ = TRUE)
chrm$screenshot(
  filename = path("screenshots", "floridahealth_gov__diseases-and-conditions__COVID-19.png")
)

# Florida County Cases from arcgis Dashboard ------------------------------
dom2text <- function(chrome, root_id, selector) {
  ids <- chrm$DOM$querySelectorAll(root_id, selector)
  html <- map(unlist(ids), ~ chrm$DOM$getOuterHTML(.x))
  
  html %>% 
    map("outerHTML") %>% 
    map(read_html) %>% 
    map(xml_nodes, "p") %>% 
    map_chr(xml_text) %>% 
    str_trim()
}

fl_dash_url <- "https://fdoh.maps.arcgis.com/apps/opsdashboard/index.html#/8d0de33f260d444c852a615dc7837c86"

{
  chrm$Page$navigate(fl_dash_url)
  chrm$Page$loadEventFired()
  Sys.sleep(5)
}
chrm$Emulation$setVisibleSize(width = 900, height = 900, wait_ = TRUE)
chrm$screenshot(
  filename = path("screenshots", "fodh_maps_arcgis_com__apps__opsdashboard.png")
)

dom <- chrm$DOM$getDocument()
writeLines(
  chrm$DOM$getOuterHTML(dom$root$nodeId)$outerHTML, 
  path("snapshots", strftime(ts_now, 'fl_doh_dash_%FT%H%M%S', tz = "America/New_York"), ext = "html")
)

timestamp_dash <- mdy_hm(
  dom2text(chrm, dom$root$nodeId, "full-container div:nth-child(2) > margin-container p")[2],
  tz = "America/New_York"
) %>% 
  strftime("%F %T %Z", tz = "America/New_York")

dom2text(chrm, dom$root$nodeId, "full-container div:nth-child(1) > margin-container p") %>% 
  str_subset("^$", negate = TRUE) %>% 
  str_subset("Number of Cases", negate = TRUE) %>% 
  tibble(raw = .) %>% 
  separate(raw, c("county", "count"), ":\\s*") %>%
  mutate_at(vars(county), str_remove, pattern = "\\s*County") %>% 
  filter(!str_detect(county, "^\\s*$")) %>% 
  mutate_at(vars(count), as.numeric) %>% 
  mutate(timestamp = timestamp_dash) %>% 
  select(timestamp, everything()) %>%
  append_csv("covid-19-florida-cases-county.csv")

dom2text(chrm, dom$root$nodeId, "full-container div:nth-child(5) > margin-container p") %>% 
  tibble(raw = .) %>% 
  separate(raw, c("description", "count"), sep = ":\\s*") %>% 
  mutate_at(vars(description), tolower) %>% 
  mutate(
    variable = case_when(
      str_detect(description, "people tested") ~ "total",
      str_detect(description, "negative") ~ "negative",
      str_detect(description, "positive") ~ "positive",
      str_detect(description, "pending") ~ "pending",
      TRUE ~ gsub(" ", "_", description)
    )
  ) %>% 
  select(-description) %>% 
  pivot_wider(names_from = variable, values_from = count) %>% 
  mutate_all(as.numeric) %>% 
  mutate(timestamp = timestamp_dash) %>% 
  select(timestamp, everything()) %>% 
  append_csv("covid-19-florida-tests.csv")

chrm$close()

# Push changes to repo ----
if (git2r::in_repository()) {
  is_dirty <- rlang::has_length(git2r::status(untracked = FALSE)$unstaged)
  if (is_dirty) {
    git2r::add(".", ".")
    git2r::commit(message = glue("[auto update] {ts_current}"))
    git2r::push(credentials = git2r::cred_ssh_key())
  }
}

message("Check end - ", strftime(Sys.time(), "%F %T", tz = "America/New_York"))
