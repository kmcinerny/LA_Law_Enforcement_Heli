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


flights8.20_filt <- subset(combined8.20_df, select= -c(aircraftModeS, callsign, depAirportIata, arrAirportIata, updated, source_flight, source_pos, squawkCode_flight, squawkCode_pos, scheduledDeparture, aircraftTypeDescription, estimatedArrival))
write.csv(flights8.20_filt, file = "flights8.20_filt.csv")


flights7.20_filt <- subset(combined7.20_df, select= -c(aircraftModeS, callsign, depAirportIata, arrAirportIata, updated, source_flight, source_pos, squawkCode_flight, squawkCode_pos, scheduledDeparture, aircraftTypeDescription, estimatedArrival))
write.csv(flights7.20_filt, file = "flights7.20_filt.csv")


flights6.20_filt <- subset(combined6.20_df, select= -c(aircraftModeS, callsign, depAirportIata, arrAirportIata, updated, source_flight, source_pos, squawkCode_flight, squawkCode_pos, scheduledDeparture, aircraftTypeDescription, estimatedArrival))
write.csv(flights6.20_filt, file = "flights6.20_filt.csv")


flights5.20_filt <- subset(combined5.20_df, select= -c(aircraftModeS, callsign, depAirportIata, arrAirportIata, updated, source_flight, source_pos, squawkCode_flight, squawkCode_pos, scheduledDeparture, aircraftTypeDescription, estimatedArrival))

write.csv(flights5.20_filt, file = "flights5.20_filt.csv")


flights4.20_filt <- subset(combined4.20_df, select= -c(aircraftModeS, callsign, depAirportIata, arrAirportIata, updated, source_flight, source_pos, squawkCode_flight, squawkCode_pos, scheduledDeparture, aircraftTypeDescription, estimatedArrival))

write.csv(flights4.20_filt, file = "flights4.20_filt.csv")



flights11.19_filt <- subset(combined11.19_df, select= -c(aircraftModeS, callsign, depAirportIata, arrAirportIata, updated, source_flight, source_pos, squawkCode_flight, squawkCode_pos, scheduledDeparture, aircraftTypeDescription, estimatedArrival))

write.csv(flights11.19_filt, file = "flights11.19_filt.csv")
