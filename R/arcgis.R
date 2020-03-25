get_arcgis_line_list <- function() {
  
  x <- jsonlite::read_json("https://services1.arcgis.com/CY1LXxl9zlJeBuRZ/ArcGIS/rest/services/Florida_COVID19_Case_Line_Data/FeatureServer/0/query?where=County+is+not+NULL&objectIds=&time=&resultType=none&outFields=*&returnIdsOnly=false&returnUniqueIdsOnly=false&returnCountOnly=false&returnDistinctValues=false&cacheHint=false&orderByFields=&groupByFieldsForStatistics=&outStatistics=&having=&resultOffset=&resultRecordCount=&sqlFormat=none&f=pjson&token=")
  
  x %>% 
    pluck("features") %>% 
    map("attributes") %>% 
    map(flatten) %>% 
    map_dfr(~ .) %>% 
    rename(ed_visit = EDvisit) %>% 
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
    mutate_at(vars(matches("case|event_date")), ~ lubridate::as_datetime(.x/1000)) %>% 
    mutate_at(vars(matches("case|event_date")), lubridate::as_date)
}

get_arcgis_summary <- function() {
  x <- jsonlite::read_json(
    "https://services1.arcgis.com/CY1LXxl9zlJeBuRZ/ArcGIS/rest/services/Florida_COVID19_Cases/FeatureServer/0/query?where=OBJECTID+IS+NOT+NULL&objectIds=&time=&geometry=&geometryType=esriGeometryEnvelope&inSR=&spatialRel=esriSpatialRelIntersects&resultType=none&distance=0.0&units=esriSRUnit_StatuteMile&returnGeodetic=false&outFields=*&returnGeometry=false&returnCentroid=false&featureEncoding=esriDefault&multipatchOption=xyFootprint&maxAllowableOffset=&geometryPrecision=&outSR=&datumTransformation=&applyVCSProjection=false&returnIdsOnly=false&returnUniqueIdsOnly=false&returnCountOnly=false&returnExtentOnly=false&returnQueryGeometry=false&returnDistinctValues=false&cacheHint=false&orderByFields=&groupByFieldsForStatistics=&outStatistics=&having=&resultOffset=&resultRecordCount=&returnZ=false&returnM=false&returnExceededLimitFeatures=true&quantizationParameters=&sqlFormat=none&f=pjson&token="
  )
  
  x %>% 
    pluck("features") %>% 
    map("attributes") %>% 
    map(flatten) %>% 
    map_dfr(~ .) %>% 
    janitor::clean_names()
}
