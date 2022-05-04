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


## May 2020

# load data 
#pos5.20_df <- read_csv("/Users/katemcinerny/Documents/UCLA/Carceral_ecologies/heli_data/data/csv/pos5.20_df.csv")

# convert timestamp to PST
pos5.20_df$timestamp <- with_tz(ymd_hms(pos5.20_df$timestamp))

write.csv(pos5.20_df, file= "/Users/katemcinerny/Documents/UCLA/Carceral_ecologies/heli_data/data/csv/pos5.20_df.csv")





# separate date-time-hr
#d <- as.POSIXct(flights11.19_hood$PSTtimestamp, format="%Y-%m-%d %H:%M:%S")
#flights11.19_hood$date_pos <- format(d, format="%Y-%m-%d")
#flights11.19_hood$time_pos <- format(d, format="%H:%M:%S")
#flights11.19_hood$hr_pos <- format(d, format="%H")


# convert from string to numeric
#flights11.19_hood$hr_pos_num <- as.numeric(flights11.19_hood$hr_pos)
