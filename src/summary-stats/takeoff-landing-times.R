rm(list = ls())
library(lubridate)
library(tidyverse)

monthly_data <- read_csv("/Users/katemcinerny/Documents/UCLA/Carceral_ecologies/heli_data/data/CSV/5.20/pos5.20.csv")


# need to do a histogram of the most common takeoff/ landing times
# so going to call the first timestamp of every flight - create a new dataframe with that?

library(dplyr)
first_timestamps <- monthly_data %>%
  arrange(flight_id, timestamp) %>%
  # grouping by flight id
  group_by(flight_id) %>% 
  # filter to call only first timestamp for each unique flight id
  filter(row_number(timestamp)==1) %>%
  # isolate hour from timestamp
  mutate(hr = paste(str_extract(timestamp,
                                pattern = "(?<= )[[:digit:]]+"),
                    "00",
                    sep = ":"))

library(mosaic)
# then run a histogram to see most popular takeoff times
gf_histogram(~hr, stat="count",data=first_timestamps)

# export so I can map it to see most common heliport areas
write.csv(first_timestamps, "/Users/katemcinerny/Documents/UCLA/Carceral_ecologies/heli_data/data/CSV/5.20/first_timestamps_may.csv")


# most common landing
last_timestamps <- monthly_data %>%
  arrange(flight_id, timestamp) %>%
  # grouping by flight id
  group_by(flight_id) %>% 
  # filter to call only last timestamp for each unique flight id
  slice(tail(row_number(timestamp),1)) %>%
  # isolate hour from timestamp
  mutate(hr = paste(str_extract(timestamp,
                                pattern = "(?<= )[[:digit:]]+"),
                    "00",
                    sep = ":"))
# then run a histogram to see most popular takeoff times
gf_histogram(~hr, stat="count",data=last_timestamps)

