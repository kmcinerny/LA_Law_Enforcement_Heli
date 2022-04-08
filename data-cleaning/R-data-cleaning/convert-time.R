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



## Oct 2019

# load data 
#pos10.19_df <- read_csv("/Users/katemcinerny/Documents/UCLA/Carceral_ecologies/heli_data/data/csv/10.19/pos10.19_df.csv")

# convert timestamp to PST
pos10.19_df$timestamp <- with_tz(ymd_hms(pos10.19_df$timestamp))

write.csv(pos10.19_df, file= "/Users/katemcinerny/Documents/UCLA/Carceral_ecologies/heli_data/data/CSV/10.19/pos10.19_df.csv")




## May 2020

# load data 
#pos5.20_df <- read_csv("/Users/katemcinerny/Documents/UCLA/Carceral_ecologies/heli_data/data/csv/pos5.20_df.csv")

# convert timestamp to PST
pos5.20_df$timestamp <- with_tz(ymd_hms(pos5.20_df$timestamp))

write.csv(pos5.20_df, file= "/Users/katemcinerny/Documents/UCLA/Carceral_ecologies/heli_data/data/csv/pos5.20_df.csv")













# load data
combo5.20_filt <- read_csv("/Users/katemcinerny/Documents/UCLA/Carceral_ecologies/heli_data/data/csv/combo5.20_filt.csv")
#View(flights11.20_hood)


# convert timestamp to PST
combo5.20_filt$timestamp <- with_tz(ymd_hms(combo5.20_filt$timestamp))
# convert created to PST
x <- ymd_hms(combo5.20_filt$created)
combo5.20_filt$created <- with_tz(x)
# convert takeoff to PST
x <- ymd_hms(combo5.20_filt$calculatedTakeoff)
combo5.20_filt$takeoff <- with_tz(x)
# convert landing to PST
x <- ymd_hms(combo5.20_filt$calculatedLanding)
combo5.20_filt$landing <- with_tz(x)


write.csv(combo5.20_filt, file = "/Users/katemcinerny/Documents/UCLA/Carceral_ecologies/heli_data/data/CSV/combo5.20_PST.csv")



# convert timestamp to PST Oct 2020
#pos10.20_df$PSTtimestamp <- with_tz(ymd_hms(pos10.20_df$timestamp))

#write.csv(pos10.20_df, file = "/Users/katemcinerny/Documents/UCLA/Carceral_ecologies/heli_data/data/CSV/pos10.20_df.csv")

positions10.20 <- read_csv("/Users/katemcinerny/Documents/UCLA/Carceral_ecologies/heli_data/data/csv/positions10.20.csv")
positions10.20$PSTtimestamp <- with_tz(ymd_hms(positions10.20$timestamp))

write.csv(positions10.20, file= "/Users/katemcinerny/Documents/UCLA/Carceral_ecologies/heli_data/data/csv/positions10.20.csv")


# separate date-time-hr
#d <- as.POSIXct(flights11.19_hood$PSTtimestamp, format="%Y-%m-%d %H:%M:%S")
#flights11.19_hood$date_pos <- format(d, format="%Y-%m-%d")
#flights11.19_hood$time_pos <- format(d, format="%H:%M:%S")
#flights11.19_hood$hr_pos <- format(d, format="%H")


# convert from string to numeric
#flights11.19_hood$hr_pos_num <- as.numeric(flights11.19_hood$hr_pos)
