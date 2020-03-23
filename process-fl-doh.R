#! /usr/bin/env Rscript
options(error = NULL)
message("Check start - ", strftime(Sys.time(), "%F %T", tz = "America/New_York"))

callr::rscript("get-pdf-daily-report.R")

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

append_csv <- function(data, path, unique = "timestamp") {
  existing_data <- if (file.exists(path)) {
    read_csv(path, col_types = cols(.default = col_character()))
  }
  data <- mutate_all(data, as.character)
  full <- if (!is.null(existing_data)) {
    only_in_existing <- anti_join(existing_data, data, by = unique)
    bind_rows(
      only_in_existing,
      anti_join(data, only_in_existing, by = unique)
    )
  } else data
  write_csv(full, path)
}

html_sha <- function(xml_doc) {
  tmpfile <- tempfile()
  write_html(xml_doc, tmpfile)
  digest::sha1_digest(readLines(tmpfile))
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
fl_doh_digest <- html_sha(fl_doh)
ts_now <- now()
ts_current <- strftime(ts_now, '%FT%H%M%S', tz = "America/New_York")

# Check hash of latest with hash of last update ----
doh_has_changed <- TRUE
if (file.exists(".last-update")) {
  last_update <- readLines(".last-update", warn = FALSE)
  if (last_update[1] == fl_doh_digest) {
    doh_has_changed <- FALSE
    cat("\n", glue("Checked: {ts_current}"), file = ".last-update", append = TRUE, sep = "")
    message("No updates - ", strftime(Sys.time(), "%F %T", tz = "America/New_York"))
  }
}

write_html(fl_doh, path("snapshots", strftime(ts_now, 'fl_doh_main_%FT%H%M%S', tz = "America/New_York"), ext = "html"))

# FL DOH Table Timestamp ----
timestamp_page <- fl_doh %>% xml_node("h2 + .sml") %>% timestamp_from_node()

# Reset last run log
writeLines(
  c(
    fl_doh_digest, 
    glue("DOH Page: {timestamp_page}"),
    glue("Read: {ts_current}")
  ), 
  con = ".last-update"
)

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
dom2text <- function(chrome, root_id, selector, node = NULL) {
  if (is.null(node)) {
    node <- str_extract(selector, "\\w+$")
  }
  ids <- chrm$DOM$querySelectorAll(root_id, selector)
  html <- map(unlist(ids), ~ chrm$DOM$getOuterHTML(.x))
  
  html %>% 
    map("outerHTML") %>% 
    map(read_html) %>% 
    map(xml_nodes, node) %>% 
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

boxes_p <- map(1:25, ~ dom2text(chrm, dom$root$nodeId, glue("full-container div:nth-child({.x}) > margin-container p")))
boxes_text <- map(1:25, ~ dom2text(chrm, dom$root$nodeId, glue("full-container div:nth-child({.x}) > margin-container text")))

timestamp_dash <-
  ts_current %>% 
  ymd_hms(tz = "America/New_York") %>% 
  strftime("%F %T %Z", tz = "America/New_York")

boxes_text %>% 
  keep(~ length(.x) > 0) %>% 
  map(~ str_replace(.x, ":$", "")) %>% 
  map_if(~ length(.x) == 1, ~ str_split(.x, ": ")[[1]]) %>% 
  map_dfr(~ tibble(description = .x[1], count = .x[2])) %>% 
  mutate_at(vars(description), tolower) %>% 
  filter(!is.na(count)) %>% 
  filter(!str_detect(description, "global|usa")) %>% 
  mutate_all(str_remove_all, pattern = ",") %>% 
  filter(!str_detect(count, "[^\\d]")) %>% 
  mutate(
    variable = case_when(
      str_detect(description, "positive non-florida") ~ "non_florida_residents",
      str_detect(description, "florida deaths") ~ "florida_deaths",
      str_detect(description, "positive florida residents") ~ "florida_residents",
      str_detect(description, "people tested") ~ "total",
      str_detect(description, "negative") ~ "negative",
      str_detect(description, "total cases") ~ "positive",
      str_detect(description, "positive") ~ "positive",
      str_detect(description, "pending") ~ "pending",
      str_detect(description, "under surveillance") ~ "total",
      str_detect(description, "total tests") ~ "total",
      str_detect(description, "(currently )?monitor") ~ "monitoring",
      TRUE ~ gsub("[ -]", "_", description)
    )
  ) %>% 
  select(-description) %>% 
  pivot_wider(names_from = variable, values_from = count, values_fn = list(count = max)) %>% 
  mutate_all(as.numeric) %>% 
  select(-matches("^florida_cases$")) %>% 
  mutate(timestamp = timestamp_dash) %>% 
  select(timestamp, everything()) %>% 
  append_csv("data/covid-19-florida_dash_summary.csv")

chrm$close()



# Push changes to repo ----
if (git2r::in_repository()) {
  modified <- unlist(git2r::status(untracked = FALSE)$unstaged) %>% 
    str_subset("last-update|screenshots|plots", negate = TRUE)
  is_dirty <- rlang::has_length(modified)
  if (is_dirty || doh_has_changed) {
    # Create plot -------------------------------------------------------------
    tryCatch({
      message("generating testing summary plot")
      callr::rscript("plot-testing.R", fail_on_status = FALSE)
    },
    error = function(e) message(e$message)
    )
    
    git2r::add(".", ".")
    git2r::commit(message = glue("[auto update] {ts_current}"))
    git2r::push(credentials = git2r::cred_ssh_key())
  } else {
    fs::file_delete(unlist(git2r::status()$untracked))
  }
}

message("Check end - ", strftime(Sys.time(), "%F %T", tz = "America/New_York"))
