rm(list = ls())
library(tidyverse)
library(jsonlite)


# Read in multiple json files
fileNames <- Sys.glob ("Documents/UCLA/Carceral_ecologies/heli-analysis/heli-data/raw/*.json")
flight_df <- data.frame()
for (fileName in fileNames) {
  flight_json <- read_json(fileName, simplifyVector = TRUE)
  # Extract the flight data frame (one observation per flight)
  flight_temp <- flight_json$flights %>% as_tibble() # making a data frame with just flights & nested positions
  flight_df <- dplyr::bind_rows(flight_df, flight_temp)
}

# list tail numbers alphabetically
sort(unique(flight_df$aircraftRegistration))

# filter to law enforcement

flight_df <- flight_df %>% 
  filter(aircraftRegistration %in% c("N108DJ", "N108PP","N130SK","N171WC","N213PF", "N21844", "N221LA", "N223LA", 
                                    "N224KB", "N225LA", "N226LA", "N228LA", "N229LA", "N232LA", "N233LA", "N239PS","N267LA", "N28LB",
                                    "N29LB", "N3202Q","N472LA", "N501RM", "N520PD", "N521PD", "N661PD",
                                    "N662PD", "N664PD", "N665PD", "N668PD", "N80NT", "N8NF", "N854RJ",  "N913WB",
                                    "N930DK", "N950LA", "N950SG", "N951LA", "N951LB", "N952JH", "N953LA", "N954LA",
                                    "N955LA", "N956LA", "N957LA", "N958LA", "N959LA", "N960LA", "N961LA",
                                    "N961SD", "N962LA", "N963SD", "N966SD"))

# Extract the position information (one observation/row per position)
positions_df <- flight_df$positions %>% bind_rows() # making a data frame with just positions


# Find the number of rows (positions) in each flight
num_positions <- map(flight_df$positions, nrow) 
# See which have no position data (save elsewhere)
missing_positions <- map_int(num_positions, length) == 0
# present_pos helps determine how many times to repeat flight IDs
present_positions <- unlist(num_positions)
# flight_id_no for position-level data
flight_id_no <- rep(seq_along(num_positions)[!missing_positions], present_positions) %>%
  paste0("FlightNo-", .)
# unique_flight_id for flight-level data
unique_flight_id <- paste0("FlightNo-", seq_along(num_positions))


flight_df <- flight_df %>%
  # Remove the position column from the flight data frame
  select(-positions) %>%
  mutate(flight_id = unique_flight_id)
positions_df <- positions_df %>%
  mutate(flight_id = flight_id_no)

# create new df of flights with ID and tail #
flight_num <- flight_df %>%
  select(flight_id, aircraftRegistration)

# join tail number to position data with key column flight ID
positions_df <- full_join(flight_num, positions_df, by = "flight_id")

#combined_df <- full_join(flight_df, positions_df, by = "flight_id")
#names(combined_df) <- str_replace_all(names(combined_df),
#                                           c("\\.x" = "_flight",
#                                             "\\.y" = "_pos"))


write.csv(positions_df, file = "/Users/katemcinerny/Documents/UCLA/Carceral_ecologies/heli-analysis/heli-data/positions/positions_df.csv")

write.csv(flight_df, file = "/Users/katemcinerny/Documents/UCLA/Carceral_ecologies/heli-analysis/heli-data/flights/flights_df.csv")
