library(tidyverse)
library(jsonlite)

flights9.20_json <- read_json("/Users/katemcinerny/Documents/UCLA/Carceral_ecologies/heli_data/data/json/pretty-202009.json")
flight_specific <- flights9.20_json$flights

getNumberPositions <- function(x) {
  x$positions %>% length()
}


num_pos <- map_int(flight_specific, getNumberPositions)
flight_id_no <- rep(seq_along(num_pos), num_pos)
flight_id_no <- paste0("2020-Sept-FlightNo-", flight_id_no)

flights9.20_csv <- read_csv("/Users/katemcinerny/Documents/UCLA/Carceral_ecologies/heli_data/data/csv/flights9.20.csv")
flights9.20_id <- flights9.20_csv %>%
  mutate(flight_id = flight_id_no)

