library(tidyverse)
library(jsonlite)

# Read in the JSON file
flight_file <- read_json("pretty-202002.json", simplifyVector = TRUE)
# Extract the flight data frame (one observation per flight)
flight_df <- flight_file$flights %>% as_tibble()
# Extract the position information (one observation/row per position)
pos_df <- flight_df$positions %>% bind_rows()

# Find the number of rows (positions) in each flight
num_pos <- map(flight_df$positions, nrow)
# See which have no position data (save elsewhere)
missing_pos <- map_int(num_pos, length) == 0
# present_pos helps determine how many times to repeat flight IDs
present_pos <- unlist(num_pos)
# flight_id_no for position-level data
flight_id_no <- rep(seq_along(num_pos)[!missing_pos], present_pos) %>%
  paste0("2020-Feb-FlightNo-", .)
# unique_flight_id for flight-level data
unique_flight_id <- paste0("2020-Feb-FlightNo-", seq_along(num_pos))


flight_df <- flight_df %>%
  # Remove the position column from the flight data frame
  select(-positions) %>%
  mutate(flight_id = unique_flight_id)
pos_df <- pos_df %>%
  mutate(flight_id = flight_id_no)

combined_df <- full_join(flight_df, pos_df, by = "flight_id")
names(combined_df) <- str_replace_all(names(combined_df),
                                      c("\\.x" = "_flight",
                                        "\\.y" = "_pos"))
