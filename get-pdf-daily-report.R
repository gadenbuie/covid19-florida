#! /usr/bin/env Rscript
options(error = NULL)

library(readr)
library(dplyr)
library(tidyr)
library(purrr)
library(stringr)
library(lubridate)
library(glue)
library(fs)
library(xml2)
library(rvest)

fl_doh_url <- "http://www.floridahealth.gov/diseases-and-conditions/COVID-19/"
fl_disaster_url <- "https://floridadisaster.org/covid19/"

fl_doh <- read_html(fl_doh_url)
fl_disaster <- read_html(fl_disaster_url)

pdf_files <-
  c(
    fl_doh %>% xml_nodes("a") %>% xml_attr("href") %>% str_replace("^/", "http://www.floridahealth.gov/"),
    fl_disaster %>% xml_nodes("a") %>% xml_attr("href") %>% str_replace("^/", "https://floridadisaster.org/")
  ) %>% 
  str_subset("pdf$") %>% 
  str_subset("daily-report") %>% 
  unique() %>% 
  .[!duplicated(path_file(.))]

dir_create("pdfs")

pdf_files <- pdf_files[!file_exists(path("pdfs", path_file(pdf_files)))]

safe_download <- safely(download.file)

if (length(pdf_files)) {
  walk(pdf_files, ~ safe_download(url = .x, destfile = path("pdfs", path_file(.x))))
}
