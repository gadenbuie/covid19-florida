ahca_data_url <- function(which = c("covid-hospitalizations", "icu-beds-county", "icu-beds-hospital")) {
  switch(
    match.arg(which),
    "covid-hospitalizations" = "https://bi.ahca.myflorida.com/vizql/t/ABICC/w/Public/v/COVIDHospitalizationsCounty/vud/sessions/A3457D37E8BA45BEB99CC560A5B08B55-1:0/views/7247426513482188062_11259638418207441572?csv=true&summary=true",
    "icu-beds-county" =,
    "icu-beds-hospital" =,
    stop("Not available")
  )
}

ahca_get_data <- function(which) {
  read.delim(
    ahca_data_url(which),
    stringsAsFactors = FALSE,
    fileEncoding = "UTF-16"
  )
}
