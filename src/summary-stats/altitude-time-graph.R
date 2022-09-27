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
r <- ggplot(data=pos3.20, aes(x=timestamp, y=altitude, color=flight_id)) + geom_line() 
ggplotly(r)





# Subset of aircrafts
#Change to May and figure out which dates are of interest
#Still looks a little weird
p <- ggplot(subset(pos5.20, flight_id %in% c("2020-May-FlightNo-2700")), aes(x=timestamp, y=altitude)) + geom_line() 
ggplotly(p)


# Flight 2358, May 27,2020
q <- ggplot(subset(pos5.20_outliers, flight_id %in% c("2020-May-FlightNo-2358")), aes(x=timestamp, y=altitude)) + geom_line() + ggtitle("Altitude vs. Time Outliers: May 27, 2020: Flight #2358")
ggplotly(q)

z <- ggplot(subset(pos5.20, flight_id %in% c("2020-May-FlightNo-2358")), aes(x=timestamp, y=altitude)) + geom_line() + ggtitle("Altitude vs. Time: May 27, 2020: Flight #2358")
ggplotly(z)
