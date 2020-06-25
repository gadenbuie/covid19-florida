get_arcgis_line_list <- function() {
  x <- query_paged("line_list", process_fn = line_list_to_df)
  sort_columns <- intersect(c("county", "case", "age", "gender", "jurisdiction"), names(x))
  dplyr::arrange(x, !!!rlang::syms(sort_columns))
}

url_arcgis <- function(which) {
  switch(
    which,
    # line_list = "https://services1.arcgis.com/CY1LXxl9zlJeBuRZ/ArcGIS/rest/services/Florida_COVID19_Case_Line_Data/FeatureServer/0/query?where=OBJECTID+IS+NOT+NULL&objectIds=&time=&resultType=none&outFields=*&returnIdsOnly=false&returnUniqueIdsOnly=false&returnCountOnly=false&returnDistinctValues=false&cacheHint=false&orderByFields=&groupByFieldsForStatistics=&outStatistics=&having=&resultOffset={low}&resultRecordCount=2000&sqlFormat=none&f=p{format}&token=",
    line_list = "https://services1.arcgis.com/CY1LXxl9zlJeBuRZ/arcgis/rest/services/Florida_COVID19_Case_Line_Data_NEW/FeatureServer/0/query?where=OBJECTID+IS+NOT+NULL&objectIds=&time=&resultType=none&outFields=*&returnIdsOnly=false&returnUniqueIdsOnly=false&returnCountOnly=false&returnDistinctValues=false&cacheHint=false&orderByFields=&groupByFieldsForStatistics=&outStatistics=&having=&resultOffset={low}&resultRecordCount=2000&sqlFormat=none&f=p{format}&token=",
    cases_by_day = "https://services1.arcgis.com/CY1LXxl9zlJeBuRZ/ArcGIS/rest/services/Florida_COVID_19_Cases_by_Day_For_Time_Series/FeatureServer/0/query?where=OBJECTID+IS+NOT+NULL&objectIds=&time=&resultType=none&outFields=*&returnIdsOnly=false&returnUniqueIdsOnly=false&returnCountOnly=false&returnDistinctValues=false&cacheHint=false&orderByFields=&groupByFieldsForStatistics=&outStatistics=&having=&resultOffset={low}&resultRecordCount=2000&sqlFormat=none&f=p{format}&token=",
    summary = "https://services1.arcgis.com/CY1LXxl9zlJeBuRZ/ArcGIS/rest/services/Florida_COVID19_Cases/FeatureServer/0/query?where=OBJECTID+IS+NOT+NULL&objectIds=&time=&geometry=&geometryType=esriGeometryEnvelope&inSR=&spatialRel=esriSpatialRelIntersects&resultType=none&distance=0.0&units=esriSRUnit_StatuteMile&returnGeodetic=false&outFields=*&returnGeometry=false&returnCentroid=false&featureEncoding=esriDefault&multipatchOption=xyFootprint&maxAllowableOffset=&geometryPrecision=&outSR=&datumTransformation=&applyVCSProjection=false&returnIdsOnly=false&returnUniqueIdsOnly=false&returnCountOnly=false&returnExtentOnly=false&returnQueryGeometry=false&returnDistinctValues=false&cacheHint=false&orderByFields=&groupByFieldsForStatistics=&outStatistics=&having=&resultOffset=&resultRecordCount=&returnZ=false&returnM=false&returnExceededLimitFeatures=true&quantizationParameters=&sqlFormat=none&f=pjson&token=",
    cases_by_zip = "https://services1.arcgis.com/CY1LXxl9zlJeBuRZ/arcgis/rest/services/Florida_Cases_Zips_COVID19/FeatureServer/0/query?where=ObjectId+%3E+{low}+and+ObjectId+%3C%3D+{high}&objectIds=&time=&geometry=&geometryType=esriGeometryEnvelope&inSR=&spatialRel=esriSpatialRelIntersects&resultType=none&distance=0.0&units=esriSRUnit_Meter&returnGeodetic=false&outFields=*&returnGeometry=true&returnCentroid=false&featureEncoding=esriDefault&multipatchOption=xyFootprint&maxAllowableOffset=&geometryPrecision=&outSR=&datumTransformation=&applyVCSProjection=false&returnIdsOnly=false&returnUniqueIdsOnly=false&returnCountOnly=false&returnExtentOnly=false&returnQueryGeometry=false&returnDistinctValues=false&cacheHint=false&orderByFields=&groupByFieldsForStatistics=&outStatistics=&having=&resultOffset=&resultRecordCount=&returnZ=false&returnM=false&returnExceededLimitFeatures=true&quantizationParameters=&sqlFormat=none&f=p{format}&token=",
    health_metrics = "https://services1.arcgis.com/CY1LXxl9zlJeBuRZ/ArcGIS/rest/services/Florida_Health_Metrics/FeatureServer/0/query?where=OBJECTID+IS+NOT+NULL&objectIds=&time=&resultType=none&outFields=*&returnIdsOnly=false&returnUniqueIdsOnly=false&returnCountOnly=false&returnDistinctValues=false&cacheHint=false&orderByFields=&groupByFieldsForStatistics=&outStatistics=&having=&resultOffset={low}&resultRecordCount=2000&sqlFormat=none&f=p{format}&token="
  )
}

query_arcgis <- function(target, low, high = low + 2000, format = "json", return_json = TRUE) {
  x <- glue::glue(url_arcgis(target))
  if (return_json) jsonlite::read_json(x) else x
}

query_paged <- function(target, page_size = 2000, process_fn = clean_feature_attributes) {
  out <- list()
  keep_going <- TRUE
  retries <- 0
  low <- 0
  i <- 1
  while(keep_going) {
    page <- paste(i)
    
    res <- query_arcgis(
      target, 
      low = scientific_result_offset(low), 
      high = scientific_result_offset(low + page_size)
    )
    
    if (!is.null(res$error)) {
      retries <- retries + 1L
      message("Waiting 60s to try again.")
      if (retries > 25) {
        stop("Unable to complete request over 25 minutes")
      }
      Sys.sleep(60)
      next
    }
    
    out[[page]] <- process_fn(res)
    
    if (is.null(out[[page]])) {
      keep_going <- FALSE
      next
    }
    if (ifelse(is.data.frame(out[[page]]), nrow(out[[page]]), length(out[[page]])) < page_size) {
      keep_going <- FALSE
      next
    } else {
      i <- i + 1
      low <- low + page_size
    }
  }
  
  out %>% 
    dplyr::bind_rows()
}

clean_feature_attributes <- function(x) {
  x %>% 
    purrr::pluck("features") %>% 
    purrr::map("attributes") %>% 
    purrr::map(purrr::flatten) %>% 
    purrr::map_dfr(~ .)
}

scientific_result_offset <- function(x) {
  if (x < 1e5) return(x)
  exp <- 5
  keep_going <- FALSE
  while (keep_going) {
    if ((x / (10 ^ exp)) < 1) {
      keep_going <- FALSE
    } else {
      exp <- exp + 1
    }
  }
  paste0(x / (10^(exp)), "e", exp)
}

line_list_to_df <- function(x) {
  if (!length(x$features)) return(NULL)
  x <- x %>% 
    clean_feature_attributes() %>% 
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
    rename(is_case = case, case = case1) %>% 
    dplyr::mutate_at(dplyr::vars(dplyr::matches("(event|chart)_date")), ~ lubridate::as_datetime(.x/1000)) %>% 
    dplyr::mutate_at(dplyr::vars(dplyr::matches("(event|chart)_date")), lubridate::as_date)
  if (is.character(x$case)) {
    x$case <- lubridate::as_date(lubridate::floor_date(lubridate::mdy_hm(x$case), "day"))
  } else if (is.numeric(x$case)) {
    x$case <- lubridate::as_date(lubridate::as_datetime(x$case / 1000))
  }
  x
}

get_arcgis_summary <- function() {
  x <- jsonlite::read_json(url_arcgis("summary"))
  
  x %>% 
    clean_feature_attributes %>% 
    janitor::clean_names()
}

get_arcgis_cases_by_day <- function() {
  query_paged("cases_by_day", process_fn = function(x) {
    x %>% 
      clean_feature_attributes() %>% 
      janitor::clean_names() %>% 
      dplyr::mutate_at(dplyr::vars(dplyr::matches("date")), ~ lubridate::as_datetime(.x/1000)) %>% 
      dplyr::mutate_at(dplyr::vars(dplyr::matches("date")), lubridate::as_date)
  })
}

get_arcgis_cases_by_zip <- function(format = "json") {
  if (format == "json") {
    query_paged("cases_by_zip", process_fn = function(x) {
      x %>% 
        clean_feature_attributes() %>% 
        janitor::clean_names()
    })
  } else {
    url <- "https://opendata.arcgis.com/datasets/09ec2e757f91411b8e12445805cf2809_0.geojson"
    download.file(url, strftime(Sys.time(), here::here("data/geojson/covid-19-florida_cases-by-zip_%F.geojson")))
  }
}

get_arcgis_health_metrics <- function() {
  query_paged("health_metrics", process_fn = function(x) {
    clean_feature_attributes(x) %>% 
      janitor::clean_names() %>% 
      dplyr::mutate_at(dplyr::vars(dplyr::matches("date")), ~ lubridate::as_datetime(.x/1000)) %>% 
      dplyr::mutate_at(dplyr::vars(dplyr::matches("date")), lubridate::as_date)
  }) %>% 
    arrange(week_end_date, county)
}