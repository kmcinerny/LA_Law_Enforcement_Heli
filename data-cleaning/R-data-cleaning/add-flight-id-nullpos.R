library(tidyverse)
library(jsonlite)

# Read in the JSON file
flight10.19_json <- read_json("/Users/katemcinerny/Documents/UCLA/Carceral_ecologies/heli_data/data/json/pretty-201910.json", simplifyVector = TRUE)
# Extract the flight data frame (one observation per flight)
flight10.19_df <- flight10.19_json$flights %>% as_tibble() # making a data frame with just flights & nested positions
# Extract the position information (one observation/row per position)
pos10.19_df <- flight10.19_df$positions %>% bind_rows() # making a data frame with just positions

# Find the number of rows (positions) in each flight
num_pos10.19 <- map(flight10.19_df$positions, nrow) 
# See which have no position data (save elsewhere)
missing_pos10.19 <- map_int(num_pos10.19, length) == 0
# present_pos helps determine how many times to repeat flight IDs
present_pos10.19 <- unlist(num_pos10.19)
# flight_id_no for position-level data
flight10.19_id_no <- rep(seq_along(num_pos10.19)[!missing_pos10.19], present_pos10.19) %>%
  paste0("2019-Oct-FlightNo-", .)
# unique_flight_id for flight-level data
unique_flight10.19_id <- paste0("2019-Oct-FlightNo-", seq_along(num_pos10.19))

flight10.19_df <- flight10.19_df %>%
  # Remove the position column from the flight data frame
  select(-positions) %>%
  mutate(flight_id = unique_flight10.19_id)
pos10.19_df <- pos10.19_df %>%
  mutate(flight_id = flight10.19_id_no)

#combined10.19_df <- full_join(flight10.19_df, pos10.19_df, by = "flight_id")
#names(combined10.19_df) <- str_replace_all(names(combined10.19_df),
#                                          c("\\.x" = "_flight",
#                                            "\\.y" = "_pos"))

write.csv(pos10.19_df, file = "/Users/katemcinerny/Documents/UCLA/Carceral_ecologies/heli_data/data/csv/10.19/pos10.19_df.csv")








# Read in the JSON file
flight5.20_json <- read_json("/Users/katemcinerny/Documents/UCLA/Carceral_ecologies/heli_data/data/json/pretty-202005.json", simplifyVector = TRUE)
# Extract the flight data frame (one observation per flight)
flight5.20_df <- flight5.20_json$flights %>% as_tibble() # making a data frame with just flights & nested positions
# Extract the position information (one observation/row per position)
pos5.20_df <- flight5.20_df$positions %>% bind_rows() # making a data frame with just positions

# Find the number of rows (positions) in each flight
num_pos5.20 <- map(flight5.20_df$positions, nrow) 
# See which have no position data (save elsewhere)
missing_pos5.20 <- map_int(num_pos5.20, length) == 0
# present_pos helps determine how many times to repeat flight IDs
present_pos5.20 <- unlist(num_pos5.20)
# flight_id_no for position-level data
flight5.20_id_no <- rep(seq_along(num_pos5.20)[!missing_pos5.20], present_pos5.20) %>%
  paste0("2020-May-FlightNo-", .)
# unique_flight_id for flight-level data
unique_flight5.20_id <- paste0("2020-May-FlightNo-", seq_along(num_pos5.20))

flight5.20_df <- flight5.20_df %>%
  # Remove the position column from the flight data frame
  select(-positions) %>%
  mutate(flight_id = unique_flight5.20_id)
pos5.20_df <- pos5.20_df %>%
  mutate(flight_id = flight5.20_id_no)

combined5.20_df <- full_join(flight5.20_df, pos5.20_df, by = "flight_id")
names(combined5.20_df) <- str_replace_all(names(combined5.20_df),
                                           c("\\.x" = "_flight",
                                             "\\.y" = "_pos"))

write.csv(pos5.20_df, file = "/Users/katemcinerny/Documents/UCLA/Carceral_ecologies/heli_data/data/csv/pos5.20_df.csv")










# Read in the JSON file
flight10.20_json <- read_json("/Users/katemcinerny/Documents/UCLA/Carceral_ecologies/heli_data/data/json/pretty-202010.json", simplifyVector = TRUE)
# Extract the flight data frame (one observation per flight)
flight10.20_df <- flight10.20_json$flights %>% as_tibble() # making a data frame with just flights & nested positions
# Extract the position information (one observation/row per position)
pos10.20_df <- flight10.20_df$positions %>% bind_rows() # making a data frame with just positions

# Find the number of rows (positions) in each flight
num_pos10.20 <- map(flight10.20_df$positions, nrow) 
# See which have no position data (save elsewhere)
missing_pos10.20 <- map_int(num_pos10.20, length) == 0
# present_pos helps determine how many times to repeat flight IDs
present_pos10.20 <- unlist(num_pos10.20)
# flight_id_no for position-level data
flight10.20_id_no <- rep(seq_along(num_pos10.20)[!missing_pos10.20], present_pos10.20) %>%
  paste0("2020-Oct-FlightNo-", .)
# unique_flight_id for flight-level data
unique_flight10.20_id <- paste0("2020-Oct-FlightNo-", seq_along(num_pos10.20))

flight10.20_df <- flight10.20_df %>%
  # Remove the position column from the flight data frame
  select(-positions) %>%
  mutate(flight_id = unique_flight10.20_id)
pos10.20_df <- pos10.20_df %>%
  mutate(flight_id = flight10.20_id_no)

combined10.20_df <- full_join(flight10.20_df, pos10.20_df, by = "flight_id")
names(combined10.20_df) <- str_replace_all(names(combined10.20_df),
                                      c("\\.x" = "_flight",
                                        "\\.y" = "_pos"))

write.csv(pos10.20_df, file = "/Users/katemcinerny/Documents/UCLA/Carceral_ecologies/heli_data/data/csv/pos10.20_df.csv")









# Read in the JSON file
flight9.20_json <- read_json("/Users/katemcinerny/Documents/UCLA/Carceral_ecologies/heli_data/data/json/pretty-202009.json", simplifyVector = TRUE)
# Extract the flight data frame (one observation per flight)
flight9.20_df <- flight9.20_json$flights %>% as_tibble() # making a data frame with just flights & nested positions
# Extract the position information (one observation/row per position)
pos9.20_df <- flight9.20_df$positions %>% bind_rows() # making a data frame with just positions

# Find the number of rows (positions) in each flight
num_pos9.20 <- map(flight9.20_df$positions, nrow) 
# See which have no position data (save elsewhere)
missing_pos9.20 <- map_int(num_pos9.20, length) == 0
# present_pos helps determine how many times to repeat flight IDs
present_pos9.20 <- unlist(num_pos9.20)
# flight_id_no for position-level data
flight9.20_id_no <- rep(seq_along(num_pos9.20)[!missing_pos9.20], present_pos9.20) %>%
  paste0("2020-Sept-FlightNo-", .)
# unique_flight_id for flight-level data
unique_flight9.20_id <- paste0("2020-Sept-FlightNo-", seq_along(num_pos9.20))

flight9.20_df <- flight9.20_df %>%
  # Remove the position column from the flight data frame
  select(-positions) %>%
  mutate(flight_id = unique_flight9.20_id)
pos9.20_df <- pos9.20_df %>%
  mutate(flight_id = flight9.20_id_no)

combined9.20_df <- full_join(flight9.20_df, pos9.20_df, by = "flight_id")
names(combined9.20_df) <- str_replace_all(names(combined9.20_df),
                                           c("\\.x" = "_flight",
                                             "\\.y" = "_pos"))

write.csv(pos9.20_df, file = "/Users/katemcinerny/Documents/UCLA/Carceral_ecologies/heli_data/data/CSV/positions9.20.csv")


