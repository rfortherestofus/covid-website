
# Load Packages -----------------------------------------------------------

library(tidyverse)
library(tigris)
library(lubridate)
library(janitor)

# Geospatial Data ---------------------------------------------------------

us_states <- states(cb = TRUE, resolution = "20m") %>%
  shift_geometry() %>% 
  clean_names() %>% 
  select(geoid, name) %>% 
  rename(state = name) %>% 
  filter(state %in% state.name)

us_states %>%
  write_rds("data/us_states.rds")

# COVID Data --------------------------------------------------------------

# https://github.com/nytimes/covid-19-data/tree/master/rolling-averages

covid_data <- read_csv("https://raw.githubusercontent.com/nytimes/covid-19-data/master/rolling-averages/us-states.csv") %>% 
  mutate(geoid = parse_number(geoid))

covid_data %>% 
  write_rds("data/covid_data.rds")

