qc_pdf_read <- function(out) {
  qc_checks <- list(
    qc_pdf_cases_county,
    qc_pdf_cases_age,
    qc_pdf_cases_sex
  )
  
  for (check in qc_checks) {
    out <- check(out)
  }
  
  out
}

qc_add_message <- function(out, ...) {
  out$message <- c(out$message, paste(..., sep = "", collapse = " "))
  out
}

qc_pdf_expect_cols <- function(out, name, expected_cols) {
  unexpected_cols <- setdiff(names(out[[name]]), expected_cols)
  if (length(unexpected_cols)) {
    unexpected_cols <- paste(unexpected_cols, collapse = ", ")
    out <- qc_add_message(
      out, glue::glue("Unexpected columns in `{name}`: {unexpected_cols}")
    )
  }
  out
}

qc_pdf_cases_county <- function(out) {
  if (is.null(out$cases_county)) return(out)
  
  out <- qc_pdf_expect_cols(
    out, 
    "cases_county",
    c("timestamp", "county", "florida_resident", "florida_resident_outside", 
      "non_florida_resident", "total")
  )
  
  total_positive <- out$overall_counts$positive
  if (is.null(total_positive)) return(out)
  total_county <- out$cases_county %>% pull(total) %>% sum()
  if (total_county != total_positive) {
    out <- qc_add_message(
      out, "Total cases in `cases_county` not equal to total positive: ",
      total_county, " != ", total_positive
    )
  }
  
  out
}

qc_pdf_cases_age <- function(out) {
  if (is.null(out$cases_age)) return(out)
  
  out <- qc_pdf_expect_cols(
    out,
    "cases_age",
    c("timestamp", "0-9 years", "10-19 years", "20-29 years", "30-39 years", 
      "40-49 years", "50-59 years", "60-69 years", "70-79 years", "80+ years")
  )
  
  total_positive <- out$overall_counts$positive
  if (is.null(total_positive)) return(out)
  total_age <- out$cases_age %>% select(-timestamp) %>% unlist() %>% sum()
  if (total_age != total_positive) {
    out <- qc_add_message(
      out, "Total cases in `cases_age` not equal to total positive: ",
      total_age, " != ", total_positive
    )
  }
  
  out
}

qc_pdf_cases_sex <- function(out) {
  if (is.null(out$cases_sex)) return(out)
  
  out <- qc_pdf_expect_cols(out, "cases_sex", c("timestamp", "male", "female", "unknown", "total"))
  
  total_positive <- out$overall_counts$positive
  if (is.null(total_positive)) return(out)
  total_sex <- out$cases_sex %>% select(-matches("timestamp|total")) %>% unlist() %>% sum()
  if (total_sex != total_positive) {
    out <- qc_add_message(
      out, "Total cases in `cases_sex` not equal to total positive: ",
      total_sex, " != ", total_positive
    )
  }
  
  out
}