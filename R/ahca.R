ahca_sources <- c("covid-hospitalizations", "icu-beds-county", "hospital-beds-county")

ahca_data_url <- function(which = "covid-hospitalizations") {
  switch(
    match.arg(which, ahca_sources),
    "covid-hospitalizations" = "https://bi.ahca.myflorida.com/t/ABICC/views/Public/COVIDHospitalizationsCounty.csv",
    "hospital-beds-county" = "https://bi.ahca.myflorida.com/t/ABICC/views/Public/HospitalBedsCounty.csv",
    "icu-beds-county" = "https://bi.ahca.myflorida.com/t/ABICC/views/Public/ICUBedsCounty.csv",
    stop("Not available")
  )
}

ahca_get_data <- function(which) {
  x <- readr::read_csv(ahca_data_url(which), col_types = readr::cols(.default = "c"))
  janitor::clean_names(x)
}
