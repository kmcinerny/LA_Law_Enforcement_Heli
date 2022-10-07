library(tidyverse)
library(lubridate)

pos6.20_df <- pos6.20_df %>%
  # Fix the issue with naming--from Oct to May
  mutate_at("flight_id",
  str_replace,
  pattern = "Jul",
  replacement = "Jun")