ahca_sources <- c("covid-hospitalizations", "icu-beds-county", "hospital-beds-county", "hospital-beds-hospital", "icu-beds-hospital")

ahca_data_url <- function(which = "covid-hospitalizations") {
  switch(
    match.arg(which, ahca_sources),
    "covid-hospitalizations" = "https://bi.ahca.myflorida.com/t/ABICC/views/Public/COVIDHospitalizationsCounty.csv",
    "hospital-beds-county" = "https://bi.ahca.myflorida.com/t/ABICC/views/Public/HospitalBedsCounty.csv",
    "icu-beds-county" = "https://bi.ahca.myflorida.com/t/ABICC/views/Public/ICUBedsCounty.csv",
    "hospital-beds-hospital" = "https://bi.ahca.myflorida.com/t/ABICC/views/Public/HospitalBedsHospital.csv",
    "icu-beds-hospital" = "https://bi.ahca.myflorida.com/t/ABICC/views/Public/ICUBedsHospital.csv",
    stop("Not available")
  )
}

ahca_get_data <- function(which) {
  x <- readr::read_csv(ahca_data_url(which), col_types = readr::cols(.default = "c"))
  janitor::clean_names(x)
}
