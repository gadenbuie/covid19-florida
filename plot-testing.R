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
  mutate(positive = positive - deaths) %>%
  mutate_at("timestamp", ymd_hms) %>%
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
    caption = "Source: Florida DOH and covidtracking.com\ngithub.com/gadenbuie/covid19-florida"
  ) +
  ggtitle(
    label = "Florida COVID-19 Testing",
    subtitle = glue::glue("Last update: {max(x$timestamp)}")
  ) +
  theme_minimal() +
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
