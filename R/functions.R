`%>%` <- magrittr::`%>%`

timestamp_from_node <- function(node) {
  text <- xlm2::xml_text(node)
  time <- stringr::str_extract(text, "\\d{1,2}:\\d{2} [APMapm.]+")
  date <- stringr::str_extract(text, "(\\d+[/.-]?){3}")
  ts <- glue::glue("{date} {time}")
  ts <- stringr::str_replace_all(ts, "[.]", "")
  lubridate::mdy_hm(ts, tz = "America/New_York")
}

append_csv <- function(data, path, unique = "timestamp") {
  existing_data <- if (file.exists(path)) {
    readr::read_csv(path, col_types = readr::cols(.default = readr::col_character()))
  }
  data <- dplyr::mutate_all(data, as.character)
  full <- if (!is.null(existing_data)) {
    only_in_existing <- dplyr::anti_join(existing_data, data, by = unique)
    dplyr::bind_rows(
      only_in_existing,
      dplyr::anti_join(data, only_in_existing, by = unique)
    )
  } else data
  readr::write_csv(full, path)
}

html_sha <- function(xml_doc) {
  tmpfile <- tempfile()
  xml2::write_html(xml_doc, tmpfile)
  digest::sha1_digest(readLines(tmpfile))
}