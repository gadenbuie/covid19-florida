library(dplyr, warn.conflicts = FALSE)
library(tidyr, warn.conflicts = FALSE)
library(readr, warn.conflicts = FALSE)
library(lubridate, warn.conflicts = FALSE)
library(ggplot2, warn.conflicts = FALSE)
library(purrr, warn.conflicts = FALSE)
source(here::here("R/combine-sources.R"))

fix_late_reporting <- function(x, start, end, adjusted) {
  return(x)
  dplyr::mutate(
    x,
    timestamp = dplyr::if_else(
      timestamp >= lubridate::ymd_hm(start, truncated = 2) &
        timestamp <= lubridate::ymd_hm(end, truncated = 2),
      lubridate::ymd_hm(adjusted, truncated = 2),
      timestamp
    )
  )
}

line_list <- readr::read_csv("data/covid-19-florida_arcgis_line-list.csv", guess_max = 1e5)
dash <- readr::read_csv("data/covid-19-florida_arcgis_summary.csv", guess_max = 1e5) %>% 
  fix_late_reporting("2020-05-07 13", "2020-05-07 23", "2020-05-07 12:59")

# Test summary import -----------------------------------------------------

testing_summary_dash <- read_csv("data/covid-19-florida_dash_summary.csv") %>%
  mutate_at("timestamp", lubridate::ymd_hms) %>% 
  fix_late_reporting("2020-05-07 13", "2020-05-07 23", "2020-05-07 12:59")

test_summary <-
  combine_scraped_and_api_data(testing_summary_dash, dash)

# Test Summary (Plot) -----------------------------------------------------

test_summary_long <- 
  test_summary %>%
  mutate(positive = positive - deaths) %>% 
  pivot_longer(names_to = "status", values_to = "count", -c(day, timestamp)) %>%
  filter(!status %in% c("negative", "total")) %>%
  mutate(status = factor(status, c("negative", "pending", "inconclusive", "deaths", "positive")))

set.seed(4242)
g <-
  test_summary_long %>% 
  ggplot() +
  aes(x = day, y = count, fill = status) +
  geom_col() +
  ggrepel::geom_text_repel(
    data = test_summary_long %>% 
      filter(day == max(day), status != "negative") %>% 
      arrange(desc(status)) %>% 
      mutate(
        placement = cumsum(count) - count / 2,
        count_label = paste(format(count, big.mark = ','), status)
      ),
    aes(label = count_label, y = placement, x = day, segment.color = status), 
    xlim = c((test_summary %>% pull(day) %>% max()) + 2, NA),
    hjust = 0,
    direction = "y", 
    box.padding = 0.33,
    segment.size = 0.75
  ) +
  labs(
    x = NULL, y = NULL,
    caption = glue::glue(
      "Last update: {max(test_summary$timestamp)}",
      "Source: Florida DOH and covidtracking.com", 
      "github.com/gadenbuie/covid19-florida",
      .sep = "\n"
    )
  ) +
  ggtitle(
    label = "Florida COVID-19 Known Cases"
  ) +
  annotate(
    "label",
    label = glue::glue(
      "{format(test_summary %>% pull(positive) %>% tail(1), big.mark = ',')} confirmed cases",
      "{format(test_summary %>% pull(total) %>% tail(1), big.mark = ',')} total tests",
      "{format(test_summary %>% pull(negative) %>% tail(1), big.mark = ',')} negative tests",
      .sep = "\n"
    ),
    x = min(test_summary$day) - 0.25, 
    y = test_summary %>% tail(1) %>% pull(positive) + test_summary %>% tail(1) %>% pull(pending) + 1000,
    hjust = 0, vjust = 1,
    label.size = NA,
    color = "#444444",
    fill = "#FFFFFF"
  ) +
  theme_minimal(base_size = 14) +
  scale_x_date(expand = expand_scale(add = c(0, 20))) +
  scale_y_continuous(expand = expand_scale(add = c(0, 1000))) +
  scale_color_manual(
    aesthetics = "segment.color",
    values = c(negative = "#acc2d1", pending = "#aee2c9", positive = "#440154", deaths = "#fde725", inconclusive = "grey80"),
    guide = FALSE
  ) +
  scale_fill_manual(
    values = c(negative = "#acc2d1", pending = "#aee2c9", positive = "#440154", deaths = "#fde725", inconclusive = "grey80"),
    guide = FALSE
  ) +
  coord_cartesian(clip = "off") +
  theme(
    plot.margin = margin(0.5, 0.5, 0.5, 0.5, unit = "lines"),
    plot.subtitle = element_text(margin = margin(b = 1, unit = "lines"), color = "#444444"),
    plot.caption = element_text(color = "#444444", size = 10),
    panel.grid.major.x = element_blank(),
    panel.grid.minor.x = element_blank(),
    panel.grid.minor.y = element_blank()
  )

fs::dir_create("plots")
ggsave(fs::path("plots", "covid-19-florida-testing.png"), g, width = 6.66, height = 3.33, dpi = 150, scale = 1.5)


# positive count ----------------------------------------------------------

g_tests <-
  line_list %>%
  count(day = case, name = "positive", .drop = FALSE) %>% 
  complete(day = seq(min(day), max(day), by = "day"), fill = list(positive = 0)) %>% 
  mutate(positive = cumsum(positive)) %>% 
  filter(day > ymd("2020-02-01")) %>%
  arrange(day) %>% 
  ggplot() +
  aes(day, positive) +
  geom_line(color = "#ec4e20") +
  geom_point(color = "#ec4e20", size = 0.5) +
  geom_text(
    data = function(d) d %>% filter(day == max(day)),
    aes(label = format(positive, big.mark = ",")),
    hjust = 0.9,
    vjust = -1,
    color = "#ec4e20"
  ) +
  labs(
    x = NULL, y = NULL,
    caption = glue::glue(
      "Last update: {max(line_list$timestamp)}",
      "Source: Florida DOH and covidtracking.com", 
      "github.com/gadenbuie/covid19-florida",
      .sep = "\n"
    )
  ) +
  ggtitle(
    label = "Cumulative Confirmed Positive Cases",
    subtitle = "Florida COVID-19"
  ) +
  theme_minimal(base_size = 14) +
  scale_x_date(date_breaks = "7 days", expand = expand_scale(add = 0), date_labels = "%b\n%d") +
  scale_y_continuous(limits = c(0, NA), expand = expand_scale(add = 0)) +
  coord_cartesian(clip = "off") +
  theme(
    plot.margin = margin(0.5, 0.5, 0.5, 0.5, unit = "lines"),
    plot.subtitle = element_text(margin = margin(b = 1.25, unit = "lines")),
    plot.caption = element_text(color = "#444444", size = 10),
    axis.title.y = element_text(angle = 0, hjust = 1),
    # panel.grid.major.x = element_blank(),
    panel.grid.minor.x = element_blank(),
    panel.grid.minor.y = element_blank()
  )

ggsave(fs::path("plots", "covid-19-florida-total-positive.png"), g_tests, width = 6.66, height = 3.33, dpi = 150, scale = 1.5)


# New Cases Added ---------------------------------------------------------

g_new_cases <-
  test_summary %>%
  select(day, positive) %>%
  filter(!is.na(positive)) %>%
  filter(positive != lag(positive)) %>%
  select(day, positive) %>%
  mutate(
    increase = positive - lag(positive),
    complete = if_else(day == today("America/New_York"), "today", "past")
  ) %>%
  mutate() %>% 
  filter(!is.na(increase), day >= today() - 35) %>% 
  ggplot() +
  aes(day, increase) +
  geom_col(aes(alpha = complete), fill = "#ec4e20") +
  labs(
    x = NULL, y = NULL,
    caption = glue::glue(
      "Last update: {max(test_summary$timestamp)}",
      "Source: Florida DOH and covidtracking.com", 
      "github.com/gadenbuie/covid19-florida",
      .sep = "\n"
    )
  ) +
  ggtitle(
    label = "New Positive Cases Added",
    subtitle = "Florida COVID-19"
  ) +
  scale_alpha_manual(
    values = c(past = 1, today = 0.33),
    guide = FALSE
  ) +
  theme_minimal(base_size = 14) +
  scale_x_date(date_breaks = "2 days", expand = expand_scale(add = 0), date_labels = "%b\n%d") +
  scale_y_continuous(limits = c(0, NA), expand = expand_scale(add = 0)) +
  coord_cartesian(clip = "off") +
  theme(
    plot.margin = margin(0.5, 0.5, 0.5, 0.5, unit = "lines"),
    plot.subtitle = element_text(margin = margin(b = 1.25, unit = "lines")),
    plot.caption = element_text(color = "#444444", size = 12),
    axis.title.y = element_text(angle = 0, hjust = 1),
    panel.grid.major.x = element_blank(),
    panel.grid.minor.x = element_blank(),
    panel.grid.minor.y = element_blank()
  )


ggsave(fs::path("plots", "covid-19-florida-change-new-cases.png"), g_new_cases, width = 6.66, height = 2.5, dpi = 150, scale = 1.5)


# Daily Changes -----------------------------------------------------------

g_test_changes <-
  test_summary %>% 
  select(day, positive, deaths, pending) %>% 
  filter(!is.na(positive)) %>% 
  arrange(day) %>% 
  mutate(
    positive = positive - lag(positive),
    deaths = deaths - lag(deaths),
    complete = if_else(day == today(), "today", "past")
  ) %>% 
  filter(!is.na(positive)) %>% 
  select(day, complete, positive, deaths) %>% 
  pivot_longer(cols = c(positive, deaths), names_to = "status") %>% 
  mutate_at(vars(status), tools::toTitleCase) %>% 
  mutate_at(vars(status), factor, levels = c("Positive", "Deaths")) %>% 
  ggplot() +
  aes(day, value) +
  geom_col(aes(alpha = complete, fill = status), width = 1) +
  geom_line(
    data = . %>% 
      group_by(status) %>% 
      mutate_at(vars(value), ~ slider::slide_dbl(.x, mean, .before = 7)),
    aes(color = status),
    size = 1
  ) +
  facet_wrap(~ status, scales = "free_y") +
  labs(
    x = NULL, y = NULL,
    caption = glue::glue(
      "Last update: {max(test_summary$timestamp)}",
      "Source: Florida DOH", 
      "github.com/gadenbuie/covid19-florida",
      .sep = "\n"
    )
  ) +
  ggtitle(
    label = "Daily Change in Testing",
    subtitle = "Florida COVID-19"
  ) +
  scale_alpha_manual(
    values = c(past = 1, today = 0.33),
    guide = FALSE
  ) +
  scale_color_manual(
    values = c(Pending = "#63768d", Positive = "#ec4e20", Deaths = "#440154"),
    guide = FALSE
  ) +
  scale_fill_manual(
    # values = c(Pending = "#63768d", Positive = "#ec4e20", Deaths = "#440154"), 
    values = c(Pending = "#63768d", Positive = "#f7b8a5", Deaths = "#b499ba"),
    guide = FALSE
  ) +
  theme_minimal(base_size = 14) +
  scale_x_date(date_breaks = "1 month", expand = expand_scale(add = 0.5), date_labels = "%B") +
  scale_y_continuous(expand = expansion()) +
  coord_cartesian(clip = "off") +
  theme(
    plot.margin = margin(0.5, 0.5, 0.5, 0.5, unit = "lines"),
    plot.subtitle = element_text(margin = margin(b = 1.25, unit = "lines")),
    plot.caption = element_text(color = "#444444"),
    panel.border = element_rect(color = "#dddddd", fill = NA),
    strip.text = element_text(face = "bold"),
    axis.title.y = element_text(angle = 0, hjust = 1),
    # panel.grid.major.x = element_blank(),
    panel.grid.minor.x = element_blank(),
    panel.grid.minor.y = element_blank()
  )

ggsave(fs::path("plots", "covid-19-florida-daily-test-changes.png"), g_test_changes, width = 6.66, height = 3.33, dpi = 150, scale = 1.5)


# County Positive Cases ---------------------------------------------------

county_pre <- read_csv("data/old/covid-19-florida_dash_county.csv")
county_pdf <- read_csv("data/covid-19-florida_pdf_cases_county.csv")

county_counts <- 
  bind_rows(
    county_pre,
    county_pdf %>% select(timestamp, county, count = total)
  )

g_county_counts <- 
  county_counts %>% 
  filter(timestamp == max(timestamp)) %>% 
  top_n(10, count) %>% 
  ungroup() %>% 
  count(county) %>% 
  semi_join(county_counts, ., by = "county") %>% 
  mutate_at(vars(county), ~ forcats::fct_reorder(.x, count, max, .desc = TRUE)) %>% 
  mutate_at(vars(timestamp), ymd_hms) %>% 
  ggplot() +
  aes(timestamp, count) +
  geom_line() +
  facet_wrap(~ county, ncol = 1, scales = "free_y", strip.position = "left") +
  scale_y_continuous(
    position = "right", 
    limits = c(0, NA), 
    breaks = function(x) c(0, floor(max(x))),
    labels = function(x) ifelse(x != 0, x, ""),
    expand = expand_scale()
  ) +
  scale_x_datetime(expand = c(0, 0)) +
  coord_cartesian(clip = "off") +
  theme_minimal() +
  theme(
    strip.text.y = element_text(angle = 180, vjust = 0, hjust = 1),
    strip.placement = "outside",
    panel.grid.major.y = element_blank(),
    panel.grid.minor.y = element_blank()
  )


g_county_heatmap <- 
  county_counts %>% 
  mutate(
    county = recode(county, "Miami-Dade" = "Dade"),
    timestamp = ymd_hms(timestamp, tz = "America/New_York"),
    day = floor_date(timestamp, "day"),
    day = as_date(day)
  ) %>% 
  arrange(desc(count)) %>% 
  group_by(day, county) %>% 
  slice(1) %>% 
  ungroup() %>% 
  mutate(county = forcats::fct_reorder(county, count, max, .desc = FALSE)) %>% 
  complete(day, county, fill = list(count = 0)) %>% 
  ggplot() +
  aes(day, county, fill = count) +
  geom_tile(color = "black", size = 1) +
  labs(x = NULL, y = NULL, fill = NULL) +
  scale_fill_viridis_c(trans = scales::log1p_trans(), breaks = c(0, 10, 100, 250, 1000)) +
  scale_x_date(date_breaks = "2 days", date_labels = "%b\n%d", expand = c(0, 0)) +
  coord_equal(0.5) +
  ggdark::dark_theme_minimal() +
  theme(
    legend.position = "bottom",
    axis.ticks = element_blank(),
    plot.margin = margin(t = 1, l = 1, r = 2, unit = "lines")
  )

g_case_heatmap <- 
  read_csv("data/covid-19-florida_pdf_cases_age.csv") %>% 
  pivot_longer(-timestamp, names_to = "age", values_to = "count") %>% 
  mutate(age = forcats::fct_inorder(age)) %>% 
  mutate(
    timestamp = ymd_hms(timestamp, tz = "America/New_York"),
    day = floor_date(timestamp, "day"),
    day = as_date(day)
  ) %>% 
  arrange(desc(timestamp)) %>%
  group_by(day, age) %>% 
  slice(1) %>%
  ungroup() %>% 
  complete(day, age, fill = list(count = 0)) %>% 
  ggplot() +
  aes(day, age, fill = count) +
  geom_tile(color = "black", size = 1) +
  labs(x = NULL, y = NULL, fill = NULL) +
  scale_fill_viridis_c(trans = scales::log1p_trans(), breaks = c(0, 10, 100, 250, 1000)) +
  scale_x_date(date_breaks = "2 days", date_labels = "%b\n%d", expand = c(0, 0)) +
  coord_equal(0.5) +
  ggdark::dark_theme_minimal() +
  theme(
    legend.position = "bottom",
    axis.ticks = element_blank(),
    plot.margin = margin(t = 1, l = 1, r = 2, unit = "lines")
  )


if ("age" %in% names(line_list)) {
  # Age Distribution --------------------------------------------------------
  g_age <-
    line_list %>%
    rename(sex = gender) %>% 
    filter(!is.na(age)) %>% 
    mutate(
      age = if_else(age > 80, 81, age),
      age = santoku::chop_width(age, 10, 0, labels = santoku::lbl_dash(), drop = FALSE),
      age = forcats::fct_recode(age, "85+" = "80 - 90")
    ) %>% 
    group_by(age) %>% 
    count(name = "count") %>% 
    ggplot() +
    aes(age, count) %>% 
    geom_col(fill = "#ec4e20") +
    geom_text(aes(label = count, x = age, y = count), color = "#ec4e20", size = 4, vjust = -0.5) +
    scale_y_continuous(expand = c(0, 0, 0, 20)) +
    labs(
      x = NULL, y = NULL,
      caption = glue::glue(
        "Source: Florida DOH", 
        "Last update: {max(line_list$timestamp)}",
        "github.com/gadenbuie/covid19-florida",
        .sep = "\n"
      )
    ) +
    ggtitle(
      label = "Positive Cases by Age",
      subtitle = glue::glue(
        "Florida COVID-19\n{line_list %>% nrow() %>% format(big.mark = ',')} known positive cases"
      )
    ) +
    guides(fill = FALSE) +
    coord_cartesian(clip = "off") +
    theme_minimal(base_size = 14) +
    theme(
      panel.grid.major.x = element_blank(),
      panel.grid.minor.x = element_blank(),
      panel.grid.major.y = element_blank(),
      panel.grid.minor.y = element_blank(),
      plot.caption = element_text(color = "#444444", margin = margin(t = 1.5, unit = "lines")),
      plot.subtitle = element_text(color = "#444444"),
      axis.text.y = element_blank()
    )
  
  ggsave(fs::path("plots", "covid-19-florida-age.png"), g_age, width = 6.66, height = 2, dpi = 150, scale = 1.5)
  
  # Deaths by Age -----------------------------------------------------------
  
  g_age_deaths <-
    line_list %>%
    filter(!is.na(age), died == "Yes") %>% 
    mutate(
      age = if_else(age > 85, 86, age),
      age = santoku::chop_width(age, 5, floor(min(age) / 5) * 5, labels = santoku::lbl_format("%s"), drop = FALSE),
      age = forcats::fct_recode(age, "85+" = "85")
    ) %>% 
    group_by(age) %>% 
    count(name = "count") %>% 
    ungroup() %>% 
    complete(age, fill = list(count = 0)) %>%
    ggplot() +
    aes(age, count) +
    geom_col(fill = "#893168") +
    geom_text(
      data = . %>% filter(count > 0),
      aes(label = count), 
      color = "#893168",
      size = 4, 
      vjust = -0.5
    )+
    scale_y_continuous(expand = c(0, 0.1, 0, 0)) +
    labs(
      x = NULL, y = NULL,
      caption = glue::glue(
        "Source: Florida DOH", 
        "Last update: {max(line_list$timestamp)}",
        "github.com/gadenbuie/covid19-florida",
        .sep = "\n"
      )
    ) +
    ggtitle(
      label = "Deaths by Age",
      subtitle = glue::glue(
        "Florida COVID-19\n{line_list %>% pull(died) %>% `==`('Yes') %>% sum(na.rm = TRUE) %>% format(big.mark = ',')} deaths"
      )
    ) +
    guides(fill = FALSE) +
    coord_cartesian(clip = "off") +
    theme_minimal(base_size = 14) +
    theme(
      panel.grid.major.x = element_blank(),
      panel.grid.minor.x = element_blank(),
      panel.grid.major.y = element_blank(),
      panel.grid.minor.y = element_blank(),
      plot.caption = element_text(color = "#444444", margin = margin(t = 1.5, unit = "lines")),
      plot.subtitle = element_text(color = "#444444"),
      axis.text.y = element_blank()
    )
  
  ggsave(fs::path("plots", "covid-19-florida-age-deaths.png"), g_age_deaths, width = 6.66, height = 2, dpi = 150, scale = 1.5)
  
  
  # Age & Sex Distribution ---------------------------------------------------
  
  g_age_sex <-
    line_list %>%
    rename(sex = gender) %>% 
    filter(!is.na(age), sex %in% c("Male", "Female")) %>% 
    mutate(
      age = santoku::chop(age, seq(5, 80, 5), labels = santoku::lbl_format("%s")),
      age = forcats::fct_recode(age, `80+` = "80")
    ) %>% 
    group_by(age, sex) %>% 
    count(name = "count") %>% 
    group_by(sex) %>% 
    mutate(total_sex = sum(count)) %>% 
    ungroup() %>% 
    mutate(
      total = sum(count),
      sex = glue::glue("{sex} ({scales::percent(total_sex / total, accuracy = 1)})")
    ) %>%
    ggplot(.) +
    aes(age, count, fill = sex) +
    geom_col(color = "white", size = 1) +
    facet_wrap(~ sex, ncol = 2) +
    labs(
      x = NULL, y = NULL,
      caption = glue::glue(
        "Source: Florida DOH", 
        "Last update: {max(line_list$timestamp)}",
        "github.com/gadenbuie/covid19-florida",
        .sep = "\n"
      )
    ) +
    ggtitle(
      label = "Age Distribution by Sex", 
      subtitle = "Florida COVID-19 Positive Cases"
    ) +
    guides(fill = FALSE) +
    scale_fill_manual(values = c("#440154", "#6baa75")) +
    scale_y_continuous(expand = expand_scale(add = c(0, 5))) +
    scale_x_discrete(breaks = c(seq(0, 70, 10), "80+")) +
    coord_cartesian(clip = "off") +
    theme_minimal(base_size = 14) +
    theme(
      panel.grid.major.x = element_blank(),
      panel.grid.minor.x = element_blank(),
      strip.text = element_text(size = 12),
      panel.grid.minor.y = element_blank(),
      plot.caption = element_text(color = "#444444", margin = margin(t = 1.5, unit = "lines"))
    )
  
  ggsave(fs::path("plots", "covid-19-florida-age-sex.png"), g_age_sex, width = 6.66, height = 3, dpi = 150, scale = 1.5)
  
  

  # Events by Age Group -----------------------------------------------------
  max_age <- max(line_list$age, na.rm = TRUE)
  
  wrap <- function(..., width = 80) {
    paste(
      stringr::str_wrap(paste(...), width = width),
      collapse = "\n"
    )
  }
  
  g_weekly_events_by_age <-
    line_list %>%
    mutate(week = floor_date(case, "week", week_start = 2)) %>%
    filter(
      !is.na(age),
      week < floor_date(today(), "week", 2) 
    ) %>% 
    select(week, age, ed_visit, hospitalized, died) %>%
    mutate_at(vars(ed_visit, hospitalized, died), ~ toupper(.x) == "YES") %>%
    replace_na(list(died = FALSE, ed_visit = FALSE, hospitalized = FALSE)) %>%
    mutate(
      case = TRUE,
      age_group = santoku::chop(age, seq(20, 80, 20), labels = santoku::lbl_dash()),
      age_group = forcats::fct_recode(age_group, `80+` = paste("80 -", max_age)),
      age_group = forcats::fct_explicit_na(age_group, "(Unknown)"),
    ) %>%
    pivot_longer(c(ed_visit, hospitalized, died, case)) %>% 
    mutate(
      name = recode(
        name,
        "died" = "Died",
        "ed_visit" = "Visited ER",
        "hospitalized" = "Hospitalized",
        "case" = "New Cases"
      ),
      name = factor(name, c("New Cases", "Visited ER", "Hospitalized", "Died"))
    ) %>% 
    group_by(week, age_group, name) %>% 
    summarize(n = sum(value)) %>% 
    ungroup() %>% 
    complete(week, age_group, name) %>% 
    replace_na(list(n = 0)) %>% 
    ggplot() +
    aes(week, n) +
    geom_line(aes(color = age_group)) +
    facet_wrap(vars(name), scales = "free") +
    scale_y_continuous(expand = expansion(c(0, 0.05))) +
    scale_color_manual(values = c("#69747c", "#440154", "#3e78b2", "#6baa75", "#ec4e20", "#ffc61e")) +
    theme_minimal(base_size = 14) +
    labs(
      x = NULL, y = NULL,
      color = "Age Group",
      title = "Coronavirus Severity by Age Group",
      subtitle = paste(
        "Shows the weekly count of people in each age group who were diagnosed,", 
        "visited the Emergency Room, were hospitalized, or died.\nThe dates", 
        "shown are when the case was reported by Florida DOH, not when the", 
        "ER visit, hospitalization, or death occurred."
      ),
      caption = glue::glue(
        "Source: Florida DOH", 
        "Last update: {max(line_list$timestamp)}",
        "github.com/gadenbuie/covid19-florida",
        .sep = "\n"
      )
    ) +
    theme(
      legend.position = c(0, -0.25),
      legend.justification = c(0, 0),
      legend.direction = "horizontal",
      legend.text = element_text(color = "#444444"),
      panel.grid.major.x = element_line("#f8f8f8"),
      panel.grid.minor.x = element_blank(),
      panel.background = element_rect(color = "#f0f0f0", fill = NA),
      strip.text = element_text(size = 12, hjust = 0),
      panel.grid.minor.y = element_blank(),
      plot.subtitle = element_text(color = "#999999", size = 9),
      plot.caption = element_text(
        color = "#444444", 
        margin = margin(t = 1.5, unit = "lines")
      )
    )
    
    ggsave(fs::path("plots", "covid-19-florida-weekly-events-by-age.png"), g_weekly_events_by_age, width = 6.66, height = 4, dpi = 150, scale = 1.5)

}

# County Cases Log Scale --------------------------------------------------
county_daily <-
  line_list %>% 
  mutate(
    county = case_when(
      county %in% c("Miami-Dade", "Broward", "Palm Beach") ~ "Miami",
      county %in% c("Hillsborough", "Pinellas", "Pasco", "Hernando") ~ "Tampa Bay",
      county %in% c("Orange", "Seminole", "Osceola", "Lake") ~ "Orlando",
      county %in% c("Duval", "St. Johns", "Clay", "Nassau", "Baker") ~ "Jacksonville",
      county %in% c("Alachua", "Gilchrist") ~ "Gainesville",
      county %in% c("Gadsden", "Jefferson", "Leon", "Wakulla") ~ "Tallahassee"
    )
  ) %>% 
  filter(!is.na(county)) %>% 
  count(county, day = case, name = "count") %>% 
  mutate(county = recode(county, "Dade" = "Miami-Dade")) %>% 
  complete(county, day, fill = list(count = 0)) %>% 
  group_by(county) %>%
  arrange(day) %>% 
  mutate(count = cumsum(count)) %>% 
  mutate(count_last = max(count)) %>% 
  ungroup() %>% 
  mutate(
    county = glue::glue("{county} ({format(count_last, big.mark = ',', trim = TRUE)})"),
    county = forcats::fct_reorder(county, count, max, .desc = FALSE)
  )

county_top_6 <- county_daily %>% 
  group_by(county) %>% 
  filter(count == max(count), day == max(day)) %>% 
  ungroup() %>% 
  top_n(6, count)

county_start_date <- 
  county_daily %>%
  filter(count > 15) %>%
  mutate(diff = abs(count - 20)) %>%
  group_by(county) %>%
  filter(diff == min(diff)) %>% 
  filter(day == max(day)) %>% 
  select(county, start_date = day)

county_days <-
  county_start_date %>% 
  left_join(county_daily, by = "county") %>% 
  filter(day >= start_date) %>% 
  mutate(
    days = as.numeric(difftime(day, start_date, units = "days")),
    days = case_when(
      stringr::str_detect(county, "^Broward") ~ days ,
      stringr::str_detect(county, "^Miami-Dade") ~ days,
      TRUE ~ days
    ),
    highlight = county %in% county_top_6$county
  ) %>% 
  group_by(county) %>% 
  mutate(count = count - min(count) + 20) %>% 
  mutate(n = n()) %>% 
  filter(n > 2) %>% 
  ungroup() %>% 
  mutate(county = forcats::fct_reorder(county, count, max, desc = FALSE)) %>% 
  mutate_at(vars(county), forcats::fct_drop) %>% 
  select(-n)


g_county_trajectory <-
  ggplot(county_days) +
  aes(days, count) +
  scale_y_continuous(
    trans = scales::log1p_trans(),
    breaks = c(0, 10, 20, 50, 100, 200, 500, 1000, 5000, 10000),
  ) +
  # scale_x_continuous(breaks = seq(0, 360, 4)) +
  scale_x_continuous(breaks = scales::pretty_breaks(n = 10)) +
  scale_color_manual(
    values = c("#ec4e20", "#ffc61e", "#440154", "#3e78b2", "#6baa75", "#69747c")
  ) +
  labs(
    x = "Days since 20 Known Cases", 
    y = NULL, 
    color = NULL,
    caption = glue::glue(
      "Source: Florida DOH", 
      "Last update: {max(line_list$timestamp)}",
      "github.com/gadenbuie/covid19-florida",
      .sep = "\n"
    )
  ) +
  ggtitle(
    label = "Known Positive Cases by Metropolitan Area",
    subtitle = "Florida COVID-19"
  ) +
  guides(
    color = guide_legend(
      nrow = 2, 
      byrow = TRUE,
      label.theme = element_text(margin = margin(r = 4, l = 0)), 
      override.aes = list(size = 3), 
      reverse = TRUE
    )
  ) +
  theme_minimal(14) +
  theme(
    legend.position = c(-0.01, 1.02),
    legend.justification = c(0, 1),
    legend.background = element_rect(fill = "white", color = "transparent"),
    axis.title.y = element_text(angle = 90, vjust = 0.5, hjust = 0.5, color = "#666666"),
    plot.margin = margin(0.5, 0.5, 0.5, 0.5, unit = "lines"),
    plot.subtitle = element_text(margin = margin(b = 1.25, unit = "lines")),
    plot.caption = element_text(color = "#444444"),
    panel.grid.major.x = element_blank(),
    panel.grid.minor.x = element_blank(),
    panel.grid.minor.y = element_blank()
  )

gct <- 
  g_county_trajectory +
  geom_line(
    data = . %>% filter(!highlight),
    aes(group = county),
    color = "#aaaaaa"
  ) +
  geom_line(
    data = . %>% filter(highlight),
    aes(color = county),
    size = 1
  ) +
  geom_point(
    data = . %>% filter(highlight),
    aes(color = county),
    show.legend = FALSE
  ) +
  labs(y = "Logarithmic Scale")


gct_exp <-
  g_county_trajectory +
  geom_line(
    data = . %>% filter(highlight),
    aes(color = county),
    size = 0.5
  ) +
  scale_y_continuous() +
  scale_x_continuous() +
  labs(x = NULL, caption = NULL, title = "Linear Scale", subtitle = NULL) +
  guides(color = FALSE) +
  theme(
    plot.title = element_text(size = 12, hjust = 0.5, margin = margin(), color = "#666666"),
    panel.border = element_rect(color = "grey60", size = 1, fill = NA),
    panel.background = element_rect(fill = "white"),
    axis.text.x = element_blank(),
    axis.text.y = element_blank()
  )

library(cowplot)

gg_county_trajectory <-
  ggdraw() +
  draw_plot(gct) +
  draw_plot(gct_exp, x = 0.73, y = 0.18, width = .25, height = .22)

ggsave(fs::path("plots", "covid-19-florida-county-top-6.png"), gg_county_trajectory, width = 6.66, height = 5, dpi = 150, scale = 1.5)

# Tests per Positive Case -------------------------------------------------

library(patchwork)

test_per_case <-
  dash %>%
  select(timestamp, county_1, t_positive, t_total) %>%
  mutate(t_total = if_else(
    timestamp < ymd_hm("2020-05-16 08:00") & timestamp > ymd_hm("2020-05-15 19:00"),
    NA_real_,
    t_total
  )) %>% 
  group_by(day = floor_date(timestamp - hours(8), "day")) %>% 
  filter(timestamp == max(timestamp)) %>%
  ungroup() %>% 
  select(-timestamp, timestamp = day) %>% 
  mutate(
    metro = case_when(
      county_1 %in% c("Dade", "Broward", "Palm Beach") ~ "Miami",
      county_1 %in% c("Hillsborough", "Pinellas", "Pasco", "Hernando") ~ "Tampa Bay",
      county_1 %in% c("Orange", "Seminole", "Osceola", "Lake") ~ "Orlando",
      county_1 %in% c("Duval", "St. Johns", "Clay", "Nassau", "Baker") ~ "Jacksonville",
      county_1 %in% c("Alachua", "Gilchrist") ~ "Gainesville",
      county_1 %in% c("Gadsden", "Jefferson", "Leon", "Wakulla") ~ "Tallahassee"
    )
  ) %>% 
  filter(!is.na(metro)) %>% 
  bind_rows(mutate(., metro = "Florida")) %>% 
  select(-county_1) %>% 
  group_by(timestamp, metro) %>%
  summarize_all(sum) %>% 
  group_by(metro) %>%
  arrange(timestamp) %>% 
  filter(t_positive > lag(t_positive)) %>% 
  complete(
    timestamp = seq(min(timestamp), max(timestamp), by = "day"),
    metro
  ) %>%
  mutate_at(
    # fill in missing days with midpoint between day before and after
    vars(t_positive, t_total), 
    ~ ifelse(is.na(.x), slider::slide_dbl(.x, mean, .before = 1, .after = 1, na.rm = TRUE), .x)
  ) %>% 
  # Convert from cumulative to daily new
  mutate_at(vars(t_positive, t_total), ~ .x - lag(.x)) %>% 
  filter(timestamp != min(timestamp)) %>%
  ungroup() %>% 
  mutate(pct_positive = t_positive / t_total) %>% 
  # mutate_at(vars(pct_positive), slider::slide_dbl, mean, .before = 5) %>% 
  gather(status, count, t_positive, t_total) %>% 
  mutate(
    status = if_else(status == "t_total", "test", metro),
    metro = forcats::fct_reorder(metro, count, mean, .desc = TRUE),
    status = forcats::fct_relevel(status, "test")
  )

pct_positive <- test_per_case %>% filter(paste(status) == paste(metro))

g_test_per_case_counties <-
  test_per_case %>% 
  filter(metro != "Florida") %>% 
  ggplot() +
  aes(timestamp, y = count, fill = status) +
  geom_col(position = "stack", show.legend = FALSE) +
  facet_wrap(vars(metro), scales = "free_y", as.table = TRUE) +
  scale_fill_manual(
    values = c(
      test = "#dddddd",
      Jacksonville = "#ec4e20", # orange
      Orlando      = "#ef7674", # yellow
      Florida      = "#440154", # purple
      "Tampa Bay"  = "#3e78b2", # blue
      Gainesville  = "#6baa75", # green
      Miami        = "#69747c", # gray
      Tallahassee  = "#f9a03f"  # dark
    )
  ) +
  scale_y_continuous(labels = grkmisc::format_pretty_num(), expand = expansion()) +
  scale_x_datetime(date_breaks = "1 month", date_labels = "%B") +
  theme_minimal(14) +
  theme(
    strip.text = element_text(face = "bold"),
    axis.text.x = element_text(size = 8)
  )

g_test_per_case_florida <-
  test_per_case %>% 
  filter(metro == "Florida") %>% 
  mutate(status = recode(status, "Florida" = "Positive", "test" = "Negative")) %>% 
  ggplot() +
  aes(timestamp, y = count, fill = status) +
  geom_col(position = "stack") +
  facet_wrap(vars(metro), scales = "free") +
  labs(fill = NULL) +
  scale_fill_manual(
    values = c(
      Negative = "#dddddd",
      Positive = "#440154"
    )
  ) +
  scale_y_continuous(labels = grkmisc::format_pretty_num()) +
  scale_x_datetime(date_breaks = "1 week", date_labels = "%b %d", expand = expansion()) +
  theme_minimal(14) +
  theme(
    strip.text = element_text(face = "bold", size = 18),
    legend.position = c(0.06, 1)
  )

g_test_per_case <-
  (g_test_per_case_florida / g_test_per_case_counties) * 
  labs(x = NULL, y = NULL) *
  theme(
    panel.grid.major.x = element_blank(),
    panel.grid.minor.x = element_blank(),
    panel.grid.minor.y = element_blank()
  ) +
  plot_annotation(
    title = "Daily New Test Results and New Positive Confirmed Cases",
    subtitle = "Florida COVID-19",
    caption = glue::glue(
      "Source: Florida DOH", 
      "Last update: {max(line_list$timestamp)}",
      "github.com/gadenbuie/covid19-florida",
      .sep = "\n"
    ),
    theme = theme(
      plot.title = element_text(hjust = 0, size = 18, face = "plain"),
      plot.margin = margin(0.5, 0.5, 0.5, 0.5, unit = "lines"),
      plot.subtitle = element_text(margin = margin(b = 1.25, unit = "lines")),
      plot.caption = element_text(color = "#444444")
    )
  )

ggsave(fs::path("plots", "covid-19-florida-tests-per-case.png"), g_test_per_case, width = 6, height = 6, dpi = 150, scale = 1.5)



# Percent Positivity ------------------------------------------------------

geom_binomial <- function(...) {
  geom_smooth(method = "glm", method.args = list(family = "binomial"), ..., color = NA)
}

max_percent_positive <- pct_positive %>% 
  filter(timestamp >= today() - 21) %>% 
  pull(pct_positive) %>% 
  max()

g_pct_positive_florida <-
  pct_positive %>% 
  filter(metro == "Florida", timestamp >= today() - 21) %>% 
  ggplot() +
  aes(timestamp, y = pct_positive) +
  geom_binomial(fill = "#440154", alpha = 0.2, se = TRUE, show.legend = FALSE, aes(weight = count)) +
  geom_line(color = "#440154") +
  geom_text(
    data = . %>% 
      summarize(
        label = glue::glue("Avg. Daily Tests: {format(mean(count / pct_positive), , big.mark = ',', digits = 2)}"),
        timestamp = mean(timestamp),
        pct_positive = max(pct_positive)
      ) %>% 
      ungroup() %>% 
      mutate(pct_positive = max(pct_positive), metro = "Florida"),
    aes(label = label),
    y = max(pct_positive$pct_positive)
  ) +
  facet_wrap(vars(metro), scales = "free") +
  scale_y_continuous(labels = scales::percent_format(0.5), limits = c(0, max_percent_positive)) +
  theme_minimal(14) +
  theme(
    strip.text = element_text(face = "bold", size = 18),
    legend.position = c(0.06, 1)
  )

g_pct_positive_counties <-
  pct_positive %>% 
  filter(metro != "Florida", timestamp >= today() - 21) %>% 
  ggplot() +
  aes(timestamp, y = pct_positive, color = metro) +
  geom_binomial(aes(fill = metro, weight = count), alpha = 0.2, se = TRUE, show.legend = FALSE) +
  geom_line(show.legend = FALSE) +
  geom_point(aes(size = count / pct_positive), alpha = 0.66, shape = 21) +
  facet_wrap(vars(metro)) +
  geom_text(
    data = . %>% 
      group_by(metro) %>% 
      summarize(
        label = glue::glue("Avg. Daily Tests: {format(mean(count / pct_positive), , big.mark = ',', digits = 0)}"),
        timestamp = mean(timestamp),
        pct_positive = max(pct_positive)
      ) %>% 
      ungroup() %>% 
      mutate(pct_positive = max(pct_positive)),
    aes(label = label)
  ) +
  guides(color = FALSE, size = guide_legend(title = "Number of Tests", override.aes = list(shape = 21, color = "#444444"))) +
  scale_y_continuous(labels = scales::percent_format(5)) +
  scale_size_continuous(range = c(1, 10)) +
  scale_color_manual(
    values = c(
      test = "#dddddd",
      Jacksonville = "#ec4e20", # orange
      Orlando      = "#ef7674", # yellow
      Florida      = "#440154", # purple
      "Tampa Bay"  = "#3e78b2", # blue
      Gainesville  = "#6baa75", # green
      Miami        = "#69747c", # gray
      Tallahassee  = "#f9a03f"  # dark
    )
  ) +
  scale_fill_manual(
    values = c(
      test = "#dddddd",
      Jacksonville = "#ec4e20", # orange
      Orlando      = "#ef7674", # yellow
      Florida      = "#440154", # purple
      "Tampa Bay"  = "#3e78b2", # blue
      Gainesville  = "#6baa75", # green
      Miami        = "#69747c", # gray
      Tallahassee  = "#f9a03f"  # dark
    )
  ) +
  theme_minimal(14) +
  theme(
    legend.position = "top",
    strip.text = element_text(face = "bold"),
    axis.text.x = element_text(size = 8)
  )

g_pct_positive <- 
  (g_pct_positive_florida / g_pct_positive_counties) * 
  # scale_y_continuous(labels = scales::percent_format(5), limits = c(, 0.35)) * 
  labs(x = NULL, y = NULL) *
  scale_x_datetime(date_breaks = "1 week", date_labels = "%b %d", expand = expansion()) *
  theme(
    panel.grid.major.x = element_blank(),
    panel.grid.minor.x = element_blank(),
    panel.grid.minor.y = element_blank()
  ) +
  plot_layout(nrow = 2, heights = c(1, 2)) +
  plot_annotation(
    title = "Percent Positive of Daily Test Results",
    subtitle = "Florida COVID-19",
    caption = glue::glue(
      "Source: Florida DOH", 
      "Last update: {max(line_list$timestamp)}",
      "github.com/gadenbuie/covid19-florida",
      .sep = "\n"
    ),
    theme = theme(
      plot.title = element_text(hjust = 0, size = 18, face = "plain"),
      plot.margin = margin(0.5, 0.5, 0.5, 0.5, unit = "lines"),
      plot.subtitle = element_text(margin = margin(b = 1.25, unit = "lines")),
      plot.caption = element_text(color = "#444444")
    )
  )

ggsave(fs::path("plots", "covid-19-florida-tests-percent-positive.png"), g_pct_positive, width = 6, height = 5, dpi = 150, scale = 1.5)

# Test and case growth ----------------------------------------------------

growth_rate <-
  test_per_case %>% 
  filter(metro == "Florida") %>% 
  group_by(status) %>%
  arrange(timestamp) %>%
  mutate(
    growth = if_else(
      count > lag(count), 
      (count-lag(count))/count,
      -(lag(count)-count)/lag(count)
    ),
    growth = if_else(is.na(growth), 0, growth),
    growth_smooth = slider::slide_dbl(growth, mean, .before = 7, .complete = TRUE)
  ) %>%
  ungroup() %>%
  filter(!is.na(growth))

g_growth <-
  growth_rate %>% 
  ggplot(aes(x = timestamp, y = growth)) +
  geom_line(
    aes(color = status, linetype = "Daily Rate"),
    alpha = .8
  ) +
  geom_smooth(
    aes(color = status, y = growth_smooth, linetype = "7-Day Average"), 
    size = 1, se = FALSE, span = 0.33
  ) +
  scale_color_manual(
    values = c("#6baa75", "#440154"),
    labels = c("Test growth", "Case growth"),
    name = NULL
  ) + 
  scale_linetype_manual(
    values = c("Daily Rate" = 2, "7-Day Average" = 1),
    drop = FALSE,
    name = NULL
  ) +
  guides(
    linetype = guide_legend(
      override.aes = list(color = "#444444", size = 0.5)
    )
  ) +
  labs(
    x = NULL, y = NULL,
    caption = glue::glue(
      "Last update: {max(line_list$timestamp)}",
      "Source: Florida DOH and covidtracking.com", 
      "github.com/gadenbuie/covid19-florida",
      .sep = "\n"
    )
  ) +
  ggtitle(
    label = "Test and case growth",
    subtitle = "Florida COVID-19"
  ) +
  theme_minimal(base_size = 14) +
  coord_cartesian(clip = "off") +
  theme(
    legend.position = c(1, 1.25),
    legend.justification = c(1, 1),
    legend.direction = "vertical",
    legend.box = "horizontal",
    legend.margin = margin(b = 0.5, unit = "line"),
    legend.spacing.y = unit(0, "line"),
    legend.background = element_rect("#FFFFFFaa", NA),
    plot.margin = margin(0.5, 0.5, 0.5, 0.5, unit = "lines"),
    plot.subtitle = element_text(margin = margin(b = 1.25, unit = "lines")),
    plot.caption = element_text(color = "#444444", size = 10),
    axis.title.y = element_text(angle = 0, hjust = 1),
    panel.grid.minor.x = element_blank(),
    panel.grid.minor.y = element_blank()
  )


ggsave(fs::path("plots", "covid-19-florida-test-and-case-growth.png"), g_growth, width = 6, height = 3, dpi = 150, scale = 1.5)

