
library(here)
library(dplyr)
library(gtsummary)
library(labelled)
library(gt)
library(tidyr)
library(ggplot2)


here::i_am("code/figure/figure_1.R")


df <- read.csv(
  file = here::here("data", "Indicators_of_Anxiety_or_Depression_Based_on_Reported_Frequency_of_Symptoms_During_Last_7_Days.csv")
)

df$Year <- ifelse(grepl("2020", df$`Time.Period.Label`), "2020",
           ifelse(grepl("2021", df$`Time.Period.Label`), "2021",
           ifelse(grepl("2022", df$`Time.Period.Label`), "2022",
           ifelse(grepl("2023", df$`Time.Period.Label`), "2023",
           ifelse(grepl("2024", df$`Time.Period.Label`), "2024", "Other")))))

df_figure1 <- df %>%
  filter(Group == "By Age", Year == "2020") %>%             
  group_by(Year, Indicator, Subgroup) %>%    
  summarise(mean_score = mean(Value, na.rm = TRUE)) %>%
  pivot_wider(names_from = Year, values_from = mean_score)

figure_1a <- df_figure1 %>%
  filter(Indicator == "Symptoms of Depressive Disorder") %>%
  ggplot(aes(x = Subgroup, y = `2020`)) +
  geom_col(fill = "steelblue") +
  labs(
    title = "National Mean Scores for Self-reported Symptoms\nof Depression among Age Groups(2020)",
    x = "Age Group",
    y = "Mean Score") +
  theme(plot.title = element_text(hjust = 0.5))

ggsave(
  file = here::here("outputs", "figure_1a.png"),
  plot = figure_1a,
  device = "png"
)

figure_1b <-  df_figure1 %>%
  filter(Indicator == "Symptoms of Anxiety Disorder") %>%
  ggplot(aes(x = Subgroup, y = `2020`)) +
  geom_col(fill = "steelblue") +
  labs(
    title = "National Mean Scores for Self-reported Symptoms\nof Anxiety among Age Groups(2020)",
    x = "Age Group",
    y = "Mean Score") +
  theme(plot.title = element_text(hjust = 0.5))

ggsave(
  file = here::here("outputs", "figure_1b.png"),
  plot = figure_1b,
  device = "png"
)

figure_1c <- df_figure1 %>%
  filter(Indicator == "Symptoms of Anxiety Disorder or Depressive Disorder") %>%
  ggplot(aes(x = Subgroup, y = `2020`)) +
  geom_col(fill = "steelblue") +
  labs(
    title = "National Mean Scores for Self-reported Symptoms\nof Depression or Anxity among Age Groups(2020)",
    x = "Age Group",
    y = "Mean Score") +
  theme(plot.title = element_text(hjust = 0.5))

ggsave(
  file = here::here("outputs", "figure_1c.png"),
  plot = figure_1c,
  device = "png"
)