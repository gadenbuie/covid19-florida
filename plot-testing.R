library(dplyr, warn.conflicts = FALSE)
library(tidyr, warn.conflicts = FALSE)
library(readr, warn.conflicts = FALSE)
library(lubridate, warn.conflicts = FALSE)
library(ggplot2, warn.conflicts = FALSE)
library(purrr, warn.conflicts = FALSE)

line_list <- readr::read_csv("data/covid-19-florida_arcgis_line-list.csv")

# Test summary import -----------------------------------------------------

testing_summary_dash <- read_csv("data/covid-19-florida_dash_summary.csv")
testing_summary_pdf <- read_csv("data/covid-19-florida_pdf_overall_counts.csv")

test_summary_dash <-
  testing_summary_dash %>%
  select(timestamp, negative, positive, pending, deaths = one_of("deaths", "county_deaths", "florida_deaths"), -total) %>% 
  mutate(deaths = coalesce(!!!rlang::syms(stringr::str_subset(colnames(.), "deaths")))) %>% 
  select(-matches("deaths\\d+")) %>% 
  fill(deaths)

test_summary <- 
  list(
    dash = test_summary_dash,
    pdf = testing_summary_pdf
  ) %>% 
  imap(function(data, name) {
    data %>% 
      mutate_at("timestamp", ymd_hms, tz = "America/New_York") %>%
      mutate(day = floor_date(timestamp, "day")) %>% 
      group_by(day) %>% 
      arrange(desc(timestamp)) %>% 
      slice(1) %>% 
      ungroup() %>% 
      select(day, everything())
  }) %>% 
  reduce(full_join, by = "day", suffix = paste0(".", names(.))) %>% 
  mutate(
    negative = coalesce(negative.pdf, negative.dash),
    positive = coalesce(positive.dash, positive.pdf),
    pending = coalesce(pending.dash, pending.pdf),
    timestamp = coalesce(timestamp.dash, timestamp.pdf)
  ) %>% 
  select(day, timestamp, negative, positive, pending, deaths) %>% 
  mutate_at("day", as_date)

test_summary_long <- test_summary %>%
  pivot_longer(names_to = "status", values_to = "count", -c(day, timestamp)) %>%
  mutate(status = factor(status, c("negative", "pending", "deaths", "positive")))

# Test Summary (Plot) -----------------------------------------------------

g <-
  test_summary_long %>% 
  filter(status != "negative") %>%
  ggplot() +
  aes(x = day, y = count, fill = status) +
  geom_col() +
  ggrepel::geom_text_repel(
    data = test_summary_long %>% 
      filter(day == max(day), status != "negative") %>% 
      arrange(desc(status)) %>% 
      mutate(
        placement = cumsum(count) - count / 2,
        count_label = paste(count, status)
      ),
    aes(label = count_label, y = placement, x = day + 0.40, segment.color = status), 
    xlim = test_summary %>% pull(day) %>% max() + 0.6,
    segment.size = 0.75
  ) +
  labs(
    x = NULL, y = NULL,
    caption = glue::glue(
      "Last update: {max(test_summary_long$timestamp)}",
      "Source: Florida DOH and covidtracking.com", 
      "github.com/gadenbuie/covid19-florida",
      .sep = "\n"
    )
  ) +
  ggtitle(
    label = "Florida COVID-19 Testing"
  ) +
  theme_minimal(base_size = 14) +
  scale_x_date(expand = expand_scale(add = 0)) +
  scale_y_continuous(expand = expand_scale(add = 0)) +
  scale_color_manual(
    aesthetics = "segment.color",
    values = c(negative = "#acc2d1", pending = "#aee2c9", positive = "#440154", deaths = "#fde725"),
    guide = FALSE
  ) +
  scale_fill_manual(
    values = c(negative = "#acc2d1", pending = "#aee2c9", positive = "#440154", deaths = "#fde725"),
    guide = FALSE
  ) +
  coord_cartesian(clip = "off") +
  theme(
    plot.margin = margin(0.5, 8, 0.5, 0.5, unit = "lines"),
    plot.subtitle = element_text(margin = margin(b = 1.25, unit = "lines")),
    plot.caption = element_text(color = "#444444"),
    panel.grid.major.x = element_blank(),
    panel.grid.minor.x = element_blank(),
    panel.grid.minor.y = element_blank()
  )

fs::dir_create("plots")
ggsave(fs::path("plots", "covid-19-florida-testing.png"), g, width = 6.66, height = 3.33, dpi = 150, scale = 1.5)



# positive count ----------------------------------------------------------

g_tests <-
  line_list %>% 
  count(day = event_date, name = "positive", .drop = FALSE) %>% 
  complete(day = seq(min(day), max(day), by = "day"), fill = list(positive = 0)) %>% 
  mutate(positive = cumsum(positive)) %>% 
  filter(day > today() - 30) %>%
  arrange(day) %>% 
  ggplot() +
  aes(day, positive) +
  geom_line(color = "#ec4e20") +
  geom_point(color = "#ec4e20") +
  geom_text(
    data = function(d) d %>% filter(day == max(day)),
    aes(label = positive),
    hjust = 1.5,
    vjust = 0.5,
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
    label = "Florida COVID-19 Total Positive Cases"
  ) +
  theme_minimal(base_size = 14) +
  scale_x_date(date_breaks = "2 days", expand = expand_scale(add = 0), date_labels = "%b\n%d") +
  scale_y_continuous(limits = c(0, NA), expand = expand_scale(add = 0)) +
  coord_cartesian(clip = "off") +
  theme(
    plot.margin = margin(0.5, 0.5, 0.5, 0.5, unit = "lines"),
    plot.subtitle = element_text(margin = margin(b = 1.25, unit = "lines")),
    plot.caption = element_text(color = "#444444"),
    axis.title.y = element_text(angle = 0, hjust = 1),
    panel.grid.major.x = element_blank(),
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
    complete = if_else(day == today(), "today", "past")
  ) %>% 
  filter(!is.na(increase)) %>% 
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
    label = "New Positive Cases Added - Florida COVID-19"
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
    plot.caption = element_text(color = "#444444"),
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
    pending = pending - lag(pending),
    deaths = deaths - lag(deaths),
    complete = if_else(day == today(), "today", "past")
  ) %>% 
  filter(!is.na(positive)) %>% 
  select(day, complete, positive, pending, deaths) %>% 
  pivot_longer(cols = c(positive, pending, deaths), names_to = "status") %>% 
  mutate_at(vars(status), tools::toTitleCase) %>% 
  mutate_at(vars(status), factor, levels = c("Pending", "Positive", "Deaths")) %>% 
  ggplot() +
  aes(day, value) +
  geom_col(aes(alpha = complete, fill = status)) +
  facet_wrap(~ status) +
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
    label = "Daily Change in Florida COVID-19 Testing"
  ) +
  scale_alpha_manual(
    values = c(past = 1, today = 0.33),
    guide = FALSE
  ) +
  scale_fill_manual(
    values = c(Pending = "#63768d", Positive = "#ec4e20", Deaths = "#440154"), 
    guide = FALSE
  ) +
  theme_minimal(base_size = 14) +
  scale_x_date(date_breaks = "4 days", expand = expand_scale(add = 0.5), date_labels = "%b\n%d") +
  scale_y_continuous() +
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

# Age Distribution --------------------------------------------------------

cases_age <- read_csv("data/covid-19-florida_arcgis_line-list.csv")

g_age <-
  cases_age %>%
  filter(!is.na(age)) %>% 
  mutate(
    age = santoku::chop_width(age, 10, 0, labels = santoku::lbl_dash())
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
      "Last update: {max(cases_age$timestamp)}",
      "github.com/gadenbuie/covid19-florida",
      .sep = "\n"
    )
  ) +
  ggtitle(
    label = "Florida COVID-19 Positive Cases by Age"
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
    axis.text.y = element_blank()
  )


ggsave(fs::path("plots", "covid-19-florida-age.png"), g_age, width = 6.66, height = 2, dpi = 150, scale = 1.5)

# Age & Sex Distribution ---------------------------------------------------

cases_all <- read_csv("data/covid-19-florida_pdf_line_list.csv", guess_max = 1e5)

g_age_sex <- 
  cases_all %>% 
  filter(
    timestamp == max(timestamp),
    sex %in% c("Male", "Female")
  ) %>% 
  ggplot(.) +
  aes(age, fill = sex) +
  geom_histogram(binwidth = 5, color = "white", size = 1) +
  facet_wrap(~ sex, ncol = 2) +
  labs(
    x = NULL, y = NULL,
    caption = glue::glue(
      "Source: Florida DOH", 
      "Last update: {max(cases_all$timestamp)}",
      "github.com/gadenbuie/covid19-florida",
      .sep = "\n"
    )
  ) +
  ggtitle(
    label = "Age Distribution by Sex", 
    subtitle = "Florida COVID-19 Positive Cases"
  ) +
  guides(fill = FALSE) +
  scale_fill_manual(values = c(
    Female = "#440154", Male = "#6baa75"
  )) +
  scale_y_continuous(expand = expand_scale(add = c(0, 5))) +
  coord_cartesian(clip = "off") +
  theme_minimal(base_size = 14) +
  theme(
    panel.grid.major.x = element_blank(),
    panel.grid.minor.x = element_blank(),
    # panel.grid.major.y = element_blank(),
    panel.grid.minor.y = element_blank(),
    plot.caption = element_text(color = "#444444", margin = margin(t = 1.5, unit = "lines"))
  )

ggsave(fs::path("plots", "covid-19-florida-age-sex.png"), g_age_sex, width = 6.66, height = 3, dpi = 150, scale = 1.5)


# County Cases Log Scale --------------------------------------------------

county_daily <-
  line_list %>% 
  count(county, day = event_date, name = "count") %>% 
  mutate(county = recode(county, "Dade" = "Miami-Dade")) %>% 
  complete(county, day, fill = list(count = 0)) %>% 
  group_by(county) %>% 
  mutate(count = cumsum(count)) %>% 
  mutate(count_last = max(count)) %>% 
  ungroup() %>% 
  mutate(
    county = glue::glue("{county} ({format(count_last, big.mark = ',', trim = TRUE)})"),
    county = forcats::fct_reorder(county, count, max, .desc = FALSE)
  )

county_top_6 <- county_daily %>% 
  group_by(county) %>% 
  filter(count == max(count)) %>% 
  ungroup() %>% 
  top_n(6, count)

county_start_date <- 
  county_daily %>%
  filter(count > 7) %>%
  mutate(diff = abs(count - 10)) %>%
  group_by(county) %>%
  filter(diff == min(diff)) %>% 
  filter(day = max(day)) %>% 
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
  mutate(n = n()) %>% 
  filter(n > 2) %>% 
  ungroup() %>% 
  mutate(county = forcats::fct_reorder(county, count, max, desc = FALSE)) %>% 
  mutate_at(vars(county), forcats::fct_drop) %>% 
  select(-n)


g_county_trajectory <-
  ggplot(county_days) +
  aes(days, count) +
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
    color = "#FFFFFF",
    size = 3
  ) +
  geom_point(
    data = . %>% filter(highlight),
    aes(color = county),
    show.legend = FALSE
  ) +
  scale_y_continuous(
    trans = scales::log1p_trans(),
    breaks = c(0, 10, 20, 50, 100, 200, 500, 1000, 5000, 10000),
  ) +
  scale_x_continuous(breaks = 0:90) +
  scale_color_manual(
    values = c("#ec4e20", "#ffc61e", "#440154", "#3e78b2", "#6baa75", "#69747c")
  ) +
  labs(
    x = "Days since ~10 Confirmed Cases", 
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
    label = "Florida COVID-19 Positive Cases by County",
    subtitle = "For the 6 counties with the highest case count"
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
    legend.position = c(-0.01, 1.025),
    legend.justification = c(0, 1),
    legend.background = element_rect(fill = "transparent", color = "transparent"),
    axis.title.y = element_text(angle = 90, vjust = 0.5, hjust = 0.5, color = "#666666"),
    plot.margin = margin(0.5, 0.5, 0.5, 0.5, unit = "lines"),
    plot.subtitle = element_text(margin = margin(b = 1.25, unit = "lines")),
    plot.caption = element_text(color = "#444444"),
    panel.grid.major.x = element_blank(),
    panel.grid.minor.x = element_blank(),
    panel.grid.minor.y = element_blank()
  )

ggsave(fs::path("plots", "covid-19-florida-county-top-6.png"), g_county_trajectory, width = 6.66, height = 5, dpi = 150, scale = 1.5)
