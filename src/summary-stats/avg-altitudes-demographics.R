# stuff I might need
library(tidyverse)
library(lubridate)
library(plyr)
library(ggplot2)
library(mosaic)
library(car)
library(gmodels)
library(readxl)

monthly_data <- read_csv("/Users/katemcinerny/Documents/UCLA/Carceral_ecologies/heli_data/data/CSV/5.20/pos5.20.csv")

demographicsgrp <- read_csv("/Users/katemcinerny/Documents/UCLA/Carceral_ecologies/heli_data/data/Mapping/neighborhood_demographics_grp.csv")

# what I want to do is find the average altitudes in May 2020 of neighborhoods of color compared with more affluent whiter neighborhoods
# I have several variables to categorize race/income of neighborhoods in LA (though I need to be clear about the cutoff- is it >50% or a bigger threshold? look at distribution of very low income, etc. to determine threshold or buckets)
# let's say I took neighborhoods that are majority Black & Latinx (>50%) & Low Income (>25% of residents?) vs. majority white (>50%) & rich (less than 5% of residents are very low income or below pov)
# then would I make a dummy variable and attach it to each neighborhood (true POC/ false POC, for example), then attach that to each position? then summarize averages for true vs. averages for false
# orrr should I just find average altitudes for each neighborhood & then group by neighborhood demographics?

library(mosaic)



# load neighborhood demographic data

demographics <- read_csv("/Users/katemcinerny/Documents/UCLA/Carceral_ecologies/heli_data/data/Mapping/neighborhood_demographics.csv")


# find favstats of pct black/brown/indigenous

favstats(demographics$blk_brwn_ind)


avgalt <- monthly_data%>%
  group_by(neighborhood) %>%
  summarise(avgaltitude= mean(altitude))

# join to neighborhood demographics

avgalt_dem <- merge(x=avgalt, y=demographics, by="neighborhood", all=TRUE)

# pct black/brown/ind on x axis and avg altitude y axis, one row for each neighborhood

qplot(x=avgalt_dem$blk_brwn_ind, y=avgalt_dem$avgaltitude)
  
  
ggplot(avgalt_dem, aes(x=blk_brwn_ind, y=avgaltitude))+
  geom_point() +
  geom_smooth(method=lm, se=FALSE) +
  ylab("Average altitude")+ xlab("Percent Black/Indigenous/Latinx")


qplot(x=avgalt_dem$pctblack, y=avgalt_dem$avgaltitude)


# create bins for pct black brown indigenous - one that is between 0-25, 25-50, 50-75, and 75 to 100



df%>%
  group_by(pctpoc, anothervar) %>%
  summarise(avgaltitude= mean(altitude))