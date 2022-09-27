rm(list = ls())
library(lubridate)
library(tidyverse)

set.seed(0)
# Change this to read in the specific data file of interest
monthly_data <- read_csv("/Users/katemcinerny/Documents/UCLA/Carceral_ecologies/heli_data/data/CSV/5.20/pos5.20grouphood.csv")

flights_of_interest <- monthly_data %>%
  # Find the hour of the timestamp
  mutate(hr = timestamp %>%
           str_extract(pattern = '(?<= )[[:digit:]]+') %>%
           as.numeric()) %>%
  # Subset to between 9:00 PM and 7:00 AM, only for Westside South Central
  filter(hr >= 21 | hr <= 7,
         hoodgroupname == 'Westside South Central') %>%
  # Extract the flight_ids for all flights that meet these criteria at least once
  pull(flight_id) %>%
  # Find the unique set of flight_ids
  unique()

flight_bearing <- monthly_data %>%
  filter(flight_id %in% flights_of_interest)
