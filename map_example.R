# Load required packages
library(dplyr)
library(ggplot2)
library(maps)
library(viridis)
# Load the dataset from the URL
url <- "https://raw.githubusercontent.com/melaniewalsh/Neat-Datasets/main/us-prison-jail-rates.csv"
data <- read.csv(url)

# Data processing
data_comparison <- data %>%
  filter(year == max(year, na.rm = TRUE), !is.na(female_jail_pop_rate), !is.na(male_jail_pop_rate)) %>%
  group_by(state) %>%
  summarize(female_jail_pop_rate = mean(female_jail_pop_rate, na.rm = TRUE),
            male_jail_pop_rate = mean(male_jail_pop_rate, na.rm = TRUE)) %>%
  pivot_longer(cols = c(female_jail_pop_rate, male_jail_pop_rate), 
               names_to = "Gender", 
               values_to = "IncarcerationRate")

# Create a scatter plot comparing male and female incarceration rates by state
ggplot(data_comparison, aes(x=state, y=IncarcerationRate, color=Gender)) +
  geom_point(alpha=0.7) +
  labs(title="Comparison of Male and Female Incarceration Rates by State", 
       x="State", 
       y="Incarceration Rate per 100,000 People", 
       color="Gender") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
  scale_color_manual(values=c("female_jail_pop_rate"="pink", "male_jail_pop_rate"="blue"))