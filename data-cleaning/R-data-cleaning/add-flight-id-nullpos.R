rm(list = ls())
library(tidyverse)
library(jsonlite)

# Read in the JSON file
flight10.19_json <- read_json("/Users/katemcinerny/Documents/UCLA/Carceral_ecologies/heli_data/data/json/pretty-202005.json", simplifyVector = TRUE)

# Extract the flight data frame (one observation per flight)
flight5.20_df <- flight5.20_json$flights %>% as_tibble() # making a data frame with just flights & nested positions

# list tail numbers alphabetically
sort(unique(flight5.20_df$aircraftRegistration))

# filter to law enforcement

flight5.20_df <- flight5.20_df %>% 
  filter(aircraftRegistration %in% c("N108DJ", "N108PP","N130SK","N171WC","N213PF", "N21844", "N221LA", "N223LA", 
                                    "N224KB", "N225LA", "N226LA", "N228LA","N228LA", "N229LA","N239PS","N267LA", "N28LB",
                                    "N29LB", "N3202Q","N472LA", "N501RM", "N520PD", "N521PD", "N661PD",
                                    "N662PD", "N664PD", "N665PD", "N668PD", "N80NT", "N8NF", "N854RJ", "N913WB",
                                    "N930DK", "N950LA", "N950SG", "N951LA", "N951LB", "N952JH", "N953LA", "N954LA",
                                    "N955LA", "N956LA", "N957LA", "N958LA", "N959LA", "N960LA", "N961LA",
                                    "N961SD", "N962LA", "N963SD", "N966SD"))

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

# create new df of flights with ID and tail #
flight5.20_num <- flight5.20_df %>%
  select(flight_id, aircraftRegistration)

# join tail number to position data with key column flight ID
pos5.20_df <- full_join(flight5.20_num, pos5.20_df, by = "flight_id")

#combined5.20_df <- full_join(flight5.20_df, pos5.20_df, by = "flight_id")
#names(combined5.20_df) <- str_replace_all(names(combined5.20_df),
#                                           c("\\.x" = "_flight",
#                                             "\\.y" = "_pos"))



write.csv(pos5.20_df, file = "/Users/katemcinerny/Documents/UCLA/Carceral_ecologies/heli_data/data/csv/5.20/pos5.20_df.csv")


