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

# load data
flights11.19_hood <- read_csv("/Users/katemcinerny/Documents/UCLA/Carceral_ecologies/heli_data/data/csv/flights11.19_hood.csv")
#View(flights11.20_hood)


# convert timestamp to PST
y <- ymd_hms(flights11.19_hood$timestamp)
flights11.19_hood$PSTtimestamp <- with_tz(y)
# convert created to PST
x <- ymd_hms(flights11.19_hood$created)
flights11.19_hood$PSTcreated <- with_tz(x)
# convert takeoff to PST
x <- ymd_hms(flights11.19_hood$calculatedTakeoff)
flights11.19_hood$PSTtakeoff <- with_tz(x)
# convert landing to PST
x <- ymd_hms(flights11.19_hood$calculatedLanding)
flights11.19_hood$PSTlanding <- with_tz(x)


# separate date-time-hr
d <- as.POSIXct(flights11.19_hood$PSTtimestamp, format="%Y-%m-%d %H:%M:%S")
flights11.19_hood$date_pos <- format(d, format="%Y-%m-%d")
flights11.19_hood$time_pos <- format(d, format="%H:%M:%S")
flights11.19_hood$hr_pos <- format(d, format="%H")


# convert from string to numeric
#flights11.19_hood$hr_pos_num <- as.numeric(flights11.19_hood$hr_pos)
