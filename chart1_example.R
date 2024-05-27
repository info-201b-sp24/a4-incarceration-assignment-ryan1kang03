# Load required packages
library(dplyr)
library(ggplot2)
library(tidyr)
# Data processing
data_filtered <- data %>%
  filter(year >= 1990, !is.na(black_jail_pop_rate), !is.na(white_jail_pop_rate)) %>%
  group_by(year) %>%
  summarize(black_jail_pop_rate = mean(black_jail_pop_rate, na.rm = TRUE),
            white_jail_pop_rate = mean(white_jail_pop_rate, na.rm = TRUE)) %>%
  pivot_longer(cols = c(black_jail_pop_rate, white_jail_pop_rate),
               names_to = "Race",
               values_to = "IncarcerationRate")

# Create the trend chart
ggplot(data_filtered, aes(x=year, y=IncarcerationRate, color=Race)) +
  geom_line() +
  labs(title="Incarceration Rates Over Time by Race", x="Year", y="Incarceration Rate per 100,000 People") +
  theme_minimal() +
  scale_color_manual(values=c("black_jail_pop_rate"="black", "white_jail_pop_rate"="blue")) +
  theme(legend.title = element_blank())

