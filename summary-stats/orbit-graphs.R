library(lubridate)
library(tidyverse)
library(ggplot2)
library(plotly)

orbit_coord <- read_csv("/Users/katemcinerny/Documents/UCLA/Carceral_ecologies/heli_data/data/CSV/5.20/May2020-niteorbitcoords-30min2turns.csv")

# limit to flight no. 13
flight_orbit <- orbit_coord %>%
  filter(flight_id== "2020-May-FlightNo-13") %>%
  filter(is_orbiting=="TRUE")



# graph lat vs. lon
ggplot(data=flight_orbit, aes(latitude, longitude)) + geom_point()

ggplot(data=flight_orbit, aes(timestamp, latitude))+ geom_line()

ggplot(data=flight_orbit, aes(timestamp, longitude))+ geom_line()

ggplot(data=flight_orbit, aes(timestamp, bearing_geosphere))+ geom_line()


# having issues with cumsum of turn angle
cumdeg <- flight_orbit %>% cumsum(turn_angle)

ggplot(data=flight_orbit, aes(timestamp, turn_angle)+ geom_line()
       
       