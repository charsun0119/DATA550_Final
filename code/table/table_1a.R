library(dplyr)
library(gtsummary)
library(labelled)
library(gt)
library(tidyr)
library(ggplot2)
library(here)


here::i_am("code/table/table_1a.R")

df <- read.csv(
  file = here::here("data", "Indicators_of_Anxiety_or_Depression_Based_on_Reported_Frequency_of_Symptoms_During_Last_7_Days.csv")
)


df$Year <- ifelse(grepl("2020", df$`Time.Period.Label`), "2020",
           ifelse(grepl("2021", df$`Time.Period.Label`), "2021",
           ifelse(grepl("2022", df$`Time.Period.Label`), "2022",
           ifelse(grepl("2023", df$`Time.Period.Label`), "2023",
           ifelse(grepl("2024", df$`Time.Period.Label`), "2024", "Other")))))

table_1a <- df %>%
  group_by(Year, Indicator) %>%
  summarise(mean_score = mean(Value, na.rm = TRUE)) %>%
  pivot_wider(names_from = Year, values_from = mean_score)


table_1a %>%
  gt(rowname_col = "Indicator") %>%
  tab_spanner(
    label = "U.S. National Mean severity score, 2020-2024",
    columns = -Indicator
  ) %>%
  fmt_number(columns = -Indicator, decimals = 2)


saveRDS(
  table_1a,
  file = here::here("outputs", "table_1a.rds")
)
