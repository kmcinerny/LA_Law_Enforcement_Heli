library(plyr)
library(tidyverse)
library(ggplot2)
library(mosaic)
library(car)
library(gmodels)
library(readxl)
library(lubridate) #to separate date/time
library(plotly) #interactive graphics
library(ggmap)


flights6.20_filt <- subset(combined6.20_df, select= -c(aircraftModeS, callsign, depAirportIata, arrAirportIata, updated, source_flight, source_pos, squawkCode_flight, squawkCode_pos, scheduledDeparture, aircraftTypeDescription, estimatedArrival))
write.csv(flights6.20_filt, file = "flights6.20_filt.csv")


combo5.20_filt <- subset(combined5.20_df, select= -c(aircraftModeS, callsign, depAirportIata, arrAirportIata, updated, source_flight, source_pos, squawkCode_flight, squawkCode_pos, scheduledDeparture, aircraftTypeDescription, estimatedArrival))

write.csv(combo5.20_filt, file = "/Users/katemcinerny/Documents/UCLA/Carceral_ecologies/heli_data/data/CSV/combo5.20_filt.csv")

#pos5.20_filt <- subset(pos5.20_df, select= -c(aircraftModeS, callsign, depAirportIata, arrAirportIata, updated, source_flight, source_pos, squawkCode_flight, squawkCode_pos, scheduledDeparture, aircraftTypeDescription, estimatedArrival))

#write.csv(pos5.20_filt, file = "pos5.20_filt.csv")

