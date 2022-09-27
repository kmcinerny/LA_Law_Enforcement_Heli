library(tidyverse)
library(lubridate)
library(plyr)
library(ggplot2)
library(mosaic)
library(car)
library(gmodels)
library(readxl)


hoodtime <- read_csv("/Users/katemcinerny/Documents/UCLA/Carceral_ecologies/heli_data/data/CSV/5.20/hoodtime5.20.csv")

demographicsgrp <- read_csv("/Users/katemcinerny/Documents/UCLA/Carceral_ecologies/heli_data/data/Mapping/neighborhood_demographics_grp.csv")
# neighborhoods to replace for westside south central

favstats(~sqmi, data=hoodtime)

# join demographics with flight hours data
neighborhood_data = merge(x=hoodtime, y=demographicsgrp, by.x="neighborhood", by.y="neighborhood2")

# regress flight hours on racial demographics (Black, Latinx, Indigenous, Asian)

flighthrsonrace <- lm(tot_time~pctblack+pctlatinx+pctasian+sqmi+pctinpov, data=neighborhood_data)
 
summary(flighthrsonrace)

# to see which variables are correlated - those that are don't both need to be in -- anything less than .5 is not bad
cor(neighborhood_data[c("pctblack", "pctinpov", "pctlatinx", "pctasian")])

# gives a number for each variable - if a number is bigger than 2 it's not a good var for the regression
vif(flighthrsonrace)

# regress
lm_timearea <- lm(time_area~pctblack+pctlatinx+pctasian, data=neighborhood_data)
summary(lm_timearea)

# regress flight hours on one Black-Indigenous-Latinx percentage)
flighthrsonbil <- lm(tot_time~pctbil+pctasian, data=neighborhood_data)
summary(flighthrsonbil)


# Plot it out & interpret
 