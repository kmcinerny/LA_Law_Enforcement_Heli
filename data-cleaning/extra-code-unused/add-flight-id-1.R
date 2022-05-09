library(tidyverse)
library(jsonlite)

flights4.20_json <- read_json("/Users/katemcinerny/Documents/UCLA/Carceral_ecologies/heli_data/data/json/pretty-202004.json")
flight_specific <- flights4.20_json$flights

getNumberPositions <- function(x) {
  x$positions %>% length()
}


num_pos <- map_int(flight_specific, getNumberPositions)
flight_id_no <- rep(seq_along(num_pos), num_pos)
flight_id_no <- paste0("2020-Apr-FlightNo-", flight_id_no)

flights4.20_csv <- read_csv("/Users/katemcinerny/Documents/UCLA/Carceral_ecologies/heli_data/data/csv/flights4.20.csv")
flights4.20_id <- flights4.20_csv %>%
  mutate(flight_id = flight_id_no)

head(flights4.20_csv)

tail(flights9.20_csv)

