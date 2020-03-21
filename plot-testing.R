library(dplyr, warn.conflicts = FALSE)
library(tidyr, warn.conflicts = FALSE)
library(readr, warn.conflicts = FALSE)
library(lubridate, warn.conflicts = FALSE)
library(ggplot2, warn.conflicts = FALSE)

x <- read_csv("covid-19-florida-tests.csv")

test_summary <- 
  x %>%
  select(timestamp, negative, positive, pending, contains("deaths"), -total) %>%
  rename(deaths = florida_deaths) %>%
  replace_na(list(deaths = 0)) %>% 
  mutate(positive = positive - deaths) %>%
  mutate_at("timestamp", ymd_hms, tz = "America/New_York") %>%
  mutate(day = floor_date(timestamp, "day")) %>% 
  group_by(day) %>% 
  arrange(desc(timestamp)) %>% 
  slice(1) %>% 
  ungroup() %>% 
  select(-day) %>% 
  mutate_at("timestamp", as_date) %>%
  pivot_longer(names_to = "status", values_to = "count", -timestamp) %>%
  mutate(status = factor(status, c("negative", "pending", "deaths", "positive")))
  
g <- 
  test_summary %>% 
  # filter(status != "negative") %>% 
  ggplot() +
  aes(x = timestamp, y = count, fill = status) +
  geom_col() +
  ggrepel::geom_text_repel(
    data = test_summary %>% 
      filter(timestamp == max(timestamp)) %>% 
      arrange(desc(status)) %>% 
      mutate(
        placement = cumsum(count) - count / 2,
        count_label = paste(count, status)
      ),
    aes(label = count_label, y = placement, x = timestamp + 0.40, segment.color = status), 
    xlim = test_summary %>% pull(timestamp) %>% max() + 0.6,
    segment.size = 0.75
  ) +
  labs(
    x = NULL, y = NULL,
    caption = glue::glue(
      "Last update: {max(x$timestamp)}",
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

tests <- bind_rows(x, read_csv("pdfs/data/overall_counts.csv"))

g_tests <-
  tests %>% 
  select(timestamp, positive) %>% 
  filter(!is.na(positive)) %>% 
  mutate_at(vars(timestamp), ymd_hms, tz = "America/New_York") %>% 
  arrange(timestamp) %>% 
  filter(positive != lag(positive)) %>% 
  ggplot() +
  aes(timestamp, positive) +
  geom_line(color = "#ec4e20") +
  geom_point(color = "#ec4e20") +
  geom_text(
    data = function(d) d %>% filter(timestamp == max(timestamp)),
    aes(label = positive),
    hjust = 1.5,
    vjust = 0.5,
    color = "#ec4e20"
  ) +
  labs(
    x = NULL, y = NULL,
    caption = glue::glue(
      "Last update: {max(tests$timestamp)}",
      "Source: Florida DOH and covidtracking.com", 
      "github.com/gadenbuie/covid19-florida",
      .sep = "\n"
    )
  ) +
  ggtitle(
    label = "Florida COVID-19 Total Positive Cases"
  ) +
  theme_minimal(base_size = 14) +
  scale_x_datetime(date_breaks = "2 days", expand = expand_scale(add = 0), date_labels = "%b\n%d") +
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


g_new_cases <- 
  tests %>% 
  select(timestamp, positive) %>% 
  filter(!is.na(positive)) %>% 
  mutate_at(vars(timestamp), ymd_hms, tz = "America/New_York") %>% 
  arrange(timestamp) %>% 
  filter(positive != lag(positive)) %>% 
  mutate(day = floor_date(timestamp, "day")) %>% 
  group_by(day) %>% 
  filter(timestamp == max(timestamp)) %>% 
  ungroup() %>% 
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
      "Last update: {max(tests$timestamp)}",
      "Source: Florida DOH and covidtracking.com", 
      "github.com/gadenbuie/covid19-florida",
      .sep = "\n"
    )
  ) +
  ggtitle(
    label = "Daily Change in New Cases - Florida COVID-19"
  ) +
  scale_alpha_manual(
    values = c(past = 1, today = 0.33),
    guide = FALSE
  ) +
  theme_minimal(base_size = 14) +
  scale_x_datetime(date_breaks = "2 days", expand = expand_scale(add = 0), date_labels = "%b\n%d") +
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

g_test_changes <- 
  tests %>% 
  select(timestamp, positive, negative, pending) %>% 
  mutate(resolved = positive + negative) %>% 
  filter(!is.na(positive)) %>% 
  mutate_at(vars(timestamp), ymd_hms, tz = "America/New_York") %>% 
  arrange(timestamp) %>% 
  filter(positive != lag(positive)) %>% 
  mutate(day = floor_date(timestamp, "day")) %>% 
  group_by(day) %>% 
  filter(timestamp == max(timestamp)) %>% 
  ungroup() %>% 
  mutate(
    positive = positive - lag(positive),
    pending = pending - lag(pending),
    resolved = resolved - lag(resolved),
    complete = if_else(day == today(), "today", "past")
  ) %>% 
  filter(!is.na(positive)) %>% 
  select(day, complete, positive, pending, resolved) %>% 
  pivot_longer(cols = c(positive, pending, resolved), names_to = "status") %>% 
  mutate_at(vars(status), tools::toTitleCase) %>% 
  ggplot() +
  aes(day, value) +
  geom_col(aes(alpha = complete, fill = status)) +
  facet_wrap(~ status) +
  labs(
    x = NULL, y = NULL,
    caption = glue::glue(
      "Last update: {max(tests$timestamp)}",
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
    values = c(Pending = "#63768d", Positive = "#ec4e20", Resolved = "#440154"), 
    guide = FALSE
  ) +
  theme_minimal(base_size = 14) +
  scale_x_datetime(date_breaks = "4 days", expand = expand_scale(add = 3600 * 6), date_labels = "%b\n%d") +
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



county_pre <- read_csv("covid-19-florida-cases-county.csv")
county_pdf <- read_csv("pdfs/data/cases_county.csv")

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
  read_csv("pdfs/data/cases_age.csv") %>% 
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

cases_age <- read_csv("pdfs/data/cases_age.csv") 

g_age <- 
  cases_age %>% 
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
  filter(day == max(day)) %>% 
  ggplot(.) +
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
