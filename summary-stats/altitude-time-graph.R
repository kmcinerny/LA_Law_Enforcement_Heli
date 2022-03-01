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

# Altitude over time
p <- ggplot(data=pos5.20, aes(x=PSTtimestamp, y=altitude, label=flight_id)) + geom_line() 
ggplotly(p)





# Subset of aircrafts
#Change to May and figure out which dates are of interest
#Still looks a little weird
p <- ggplot(subset(pos5.20, flight_id %in% c("2020-Oct-FlightNo-1", "2020-Oct-FlightNo-2", "2020-Oct-FlightNo-3")), aes(x=PSTtimestamp, y=altitude, color=flight_id)) + geom_line() 
ggplotly(p)
