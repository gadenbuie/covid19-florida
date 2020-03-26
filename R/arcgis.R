get_arcgis_line_list <- function() {
  out <- list()
  keep_going <- TRUE
  low <- 0
  i <- 1
  while(keep_going) {
    out[[i]] <- query_line_list(low) %>% line_list_to_df()
    if (is.null(out[[i]]) || max(out[[i]]$object_id) < low + 2000) {
      keep_going <- FALSE
    } else {
      i <- i + 1
      low <- low + 2000
    }
  }
  
  out %>% 
    bind_rows() %>% 
    dplyr::arrange(county, event_date, age, gender, jurisdiction)
}

query_line_list <- function(low, high = low + 2000, format = "json") {
  glue::glue(
    "https://services1.arcgis.com/CY1LXxl9zlJeBuRZ/ArcGIS/rest/services/",
    "Florida_COVID19_Case_Line_Data/FeatureServer/0/",
    "query?where=ObjectId+%3E+{low}+and+ObjectId+%3C%3D+{high}&objectIds=",
    "&time=&resultType=none&outFields=*&returnIdsOnly=false",
    "&returnUniqueIdsOnly=false&returnCountOnly=false&returnDistinctValues=false",
    "&cacheHint=false&orderByFields=ObjectId&groupByFieldsForStatistics=",
    "&outStatistics=&having=&resultOffset=&resultRecordCount=&sqlFormat=none",
    "&f=p{format}&token="
  ) %>% 
    jsonlite::read_json()
}

line_list_to_df <- function(x) {
  if (!length(x$features)) return(NULL)
  x %>% 
    purrr::pluck("features") %>% 
    purrr::map("attributes") %>% 
    purrr::map(flatten) %>% 
    purrr::map_dfr(~ .) %>% 
    dplyr::rename(ed_visit = EDvisit) %>% 
    janitor::clean_names() %>% 
    readr::type_convert(
      col_types = readr::cols(
        county = readr::col_character(),
        age = readr::col_double(),
        gender = readr::col_character(),
        jurisdiction = readr::col_character(),
        travel_related = readr::col_character(),
        origin = readr::col_character(),
        ed_visit = readr::col_character(),
        hospitalized = readr::col_character(),
        died = readr::col_character(),
        contact = readr::col_character()
      )
    ) %>% 
    dplyr::mutate_at(dplyr::vars(dplyr::matches("case|event_date")), ~ lubridate::as_datetime(.x/1000)) %>% 
    dplyr::mutate_at(dplyr::vars(dplyr::matches("case|event_date")), lubridate::as_date)
}

get_arcgis_summary <- function() {
  x <- jsonlite::read_json(
    "https://services1.arcgis.com/CY1LXxl9zlJeBuRZ/ArcGIS/rest/services/Florida_COVID19_Cases/FeatureServer/0/query?where=OBJECTID+IS+NOT+NULL&objectIds=&time=&geometry=&geometryType=esriGeometryEnvelope&inSR=&spatialRel=esriSpatialRelIntersects&resultType=none&distance=0.0&units=esriSRUnit_StatuteMile&returnGeodetic=false&outFields=*&returnGeometry=false&returnCentroid=false&featureEncoding=esriDefault&multipatchOption=xyFootprint&maxAllowableOffset=&geometryPrecision=&outSR=&datumTransformation=&applyVCSProjection=false&returnIdsOnly=false&returnUniqueIdsOnly=false&returnCountOnly=false&returnExtentOnly=false&returnQueryGeometry=false&returnDistinctValues=false&cacheHint=false&orderByFields=&groupByFieldsForStatistics=&outStatistics=&having=&resultOffset=&resultRecordCount=&returnZ=false&returnM=false&returnExceededLimitFeatures=true&quantizationParameters=&sqlFormat=none&f=pjson&token="
  )
  
  x %>% 
    purrr::pluck("features") %>% 
    purrr::map("attributes") %>% 
    purrr::map(flatten) %>% 
    purrr::map_dfr(~ .) %>% 
    janitor::clean_names()
}
