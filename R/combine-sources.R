combine_scraped_and_api_data <- function(data_scraped = NULL, data_api = NULL) {
  if (is.null(data_scraped)) {
    data_scraped <- readr::read_csv(here::here("data/covid-19-florida_dash_summary.csv"))
  }
  if (is.null(data_api)) {
    data_api <- readr::read_csv(here::here("data/covid-19-florida_arcgis_summary.csv"), guess_max = 1e5)
  }
  
  data_scraped_sel <-
    data_scraped %>%
    dplyr::select(timestamp, negative, positive, pending, deaths = one_of("deaths", "county_deaths", "florida_deaths"), -total) %>%
    dplyr::mutate(deaths = dplyr::coalesce(!!!rlang::syms(stringr::str_subset(colnames(.), "deaths")))) %>%
    dplyr::select(-matches("deaths\\d+")) %>%
    tidyr::fill(deaths) %>%
    dplyr::mutate(source = 1, timestamp = lubridate::ymd_hms(timestamp))
  
  data_api_sel <- 
    data_api %>%
    dplyr::group_by(timestamp) %>%
    dplyr::mutate(c_fl_res_deaths = dplyr::coalesce(c_fl_res_deaths, fl_res_deaths)) %>% 
    dplyr::summarize_at(vars(t_positive, t_negative, t_pending, t_inconc, c_non_res_deaths, c_fl_res_deaths), sum, na.rm = TRUE) %>%
    dplyr::ungroup() %>%
    dplyr::mutate(source = 0)

  dplyr::bind_rows(data_scraped_sel, data_api_sel) %>%
    dplyr::mutate(
      timestamp = dplyr::if_else(
        timestamp >= lubridate::ymd_h("2020-05-07 12", tz = "America/New_York") &
          timestamp <= lubridate::ymd_h("2020-05-07 23", tz = "America/New_York"),
        lubridate::ymd_hm("2020-05-07 12:59", tz = "America/New_York"),
        timestamp
      )
    ) %>% 
    dplyr::mutate(
      # since updates will happen daily at 11am, a "day" is now 
      # 1pm on day (x - 1) -- 1pm on day X
      # timestamp = timestamp + lubridate::hours(12),
      day = lubridate::floor_date(timestamp + lubridate::hours(11), "day")
    ) %>%
    dplyr::mutate_at(vars(day), lubridate::as_date) %>%
    dplyr::group_by(day) %>%
    dplyr::arrange(dplyr::desc(timestamp), source) %>%
    dplyr::slice(1) %>%
    dplyr::ungroup() %>%
    dplyr::mutate(
      negative = dplyr::coalesce(t_negative, negative),
      positive = dplyr::coalesce(t_positive, positive),
      pending = dplyr::coalesce(t_pending, pending),
      deaths = dplyr::coalesce(c_fl_res_deaths + c_non_res_deaths, deaths),
      inconclusive = t_inconc
    ) %>%
    tidyr::replace_na(list(inconclusive = 0)) %>%
    dplyr::mutate(total = negative + positive + inconclusive) %>%
    dplyr::arrange(day) %>%
    dplyr::select(day, timestamp, total, negative, positive, pending, deaths, inconclusive)
}