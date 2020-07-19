#! /usr/bin/env Rscript
options(error = NULL)

source(here::here("R", "functions.R"))
ts_now <- lubridate::now("America/New_York")
ts_current <- strftime(ts_now, '%FT%H%M%S', tz = "America/New_York")

msgs <- c()

# AHCA Data ----------------------------------------------------------------
source(here::here("R", "ahca.R"))

for (ahca_source in ahca_sources) {
  ahca_data <- purrr::safely(ahca_get_data)(ahca_source)
  if (is.null(ahca_data$error) && nrow(ahca_data$result)) {
    ahca_data$result %>% 
      dplyr::mutate(timestamp = ts_current) %>% 
      dplyr::select(timestamp, dplyr::everything()) %>% 
      append_csv(glue::glue("data/covid-19-florida_ahca_{ahca_source}.csv"))
  } else {
    msg <- glue::glue("Unable to get {ahca_source} from AHCA dashboard")
    msgs <- c(msgs, msg)
    message(mgs, ": ", ahca_data$error$message)
  }
}

if (git2r::in_repository()) {
  modified <- unlist(git2r::status(untracked = FALSE)$unstaged) %>% 
    stringr::str_subset("florida_ahca")
  is_dirty <- rlang::has_length(modified)
  if (is_dirty) {
    git2r::add(".", fs::dir_ls("data/", regexp = "_ahca_"))
    git2r::commit(message = glue("[ahca update] {ts_current}\n\n{paste(msgs, collapse = '\n')}"))
    git2r::push(credentials = git2r::cred_ssh_key())
  }
}