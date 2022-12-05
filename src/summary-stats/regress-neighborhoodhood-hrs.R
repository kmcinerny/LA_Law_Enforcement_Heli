library(tidyverse)
library(lubridate)
library(plyr)
library(ggplot2)
library(mosaic)
library(car)
library(gmodels)
library(readxl)


hoodtime <- read_csv("Documents/UCLA/Carceral_ecologies/heli-analysis/results/csv/5.20/hoodtime5.20.csv")

demographicsgrp <- read_csv("/Users/katemcinerny/Documents/UCLA/Carceral_ecologies/heli-analysis/neighborhood-data/neighborhood-demogr-grp-2019.csv")
# neighborhoods to replace for westside south central

favstats(~sqmi, data=hoodtime)

# join demographics with flight hours data
neighborhood_data = merge(x=hoodtime, y=demographicsgrp, by.x="neighborhood", by.y="neighborhood2")

# regress flight hours on racial demographics (Black, Latinx, Indigenous, Asian)

flighthrsonrace <- lm(tot_time~pctblack+pctlatinx+pctasian+sqmi, data=neighborhood_data)

summary(flighthrsonrace)
plot(flighthrsonrace)

# do a separate one for poverty variables

# to see which variables are correlated - those that are don't both need to be in -- anything less than .5 is not bad
cor(neighborhood_data[c("pctblack", "pctinpov", "pctlatinx", "pctasian")])

# gives a number for each variable - if a number is bigger than 2 it's not a good var for the regression
vif(flighthrsonrace)

# regress
lm_timearea <- lm(time_area~I(pctblack/sqmi)+I(pctlatinx/sqmi)+I(pctasian/sqmi), data=neighborhood_data)
summary(lm_timearea)
plot(lm_timearea)

# what's the difference between dividing it in the regression vs creating divided variables

lm_timepoparea <- lm(time_area~I(blackpop/sqmi)+I(latinxpop/sqmi)+I(asianpop/sqmi)+I(whitepop/sqmi), data=neighborhood_data)
summary(lm_timepoparea)
plot(lm_timepoparea)


# adding a log
lm_timepoparea <- lm(log(time_area)~I(blackpop/sqmi)+I(latinxpop/sqmi)+I(asianpop/sqmi)+I(whitepop/sqmi), data=neighborhood_data)
summary(lm_timepoparea)
plot(lm_timepoparea)
# finding the huge outlier
filter(neighborhood_data, fitted(lm_timepoparea) >4)

# try log with percentages

# could try census tracts to see if the heliport is its own tract... but then you could have some tracts with no data whatsoever

# might want to filter it down just to the orbiting instead of transit



# using log on all of the variables and populations
lm_timepop <- lm(log(tot_time)~log1p(blackpop)+log1p(latinxpop)+log1p(whitepop)+log1p(asianpop)+log(totalpop)+log(sqmi), data=neighborhood_data)
summary(lm_timepop)
plot(lm_timepop)

# converting the variables back
install.packages("marginaleffects")
# can look at average marginal effect for average change
library(marginaleffects)
plot_cme(lm_timepop, effect="blackpop", condition="sqmi")

# glm with a log link (different than a log transformation) - to get the plots working
glm_timepop <- glm(tot_time~log1p(blackpop)+log1p(latinxpop)+log1p(whitepop)+log1p(asianpop)+log(totalpop)+log(sqmi), data=neighborhood_data, family = gaussian(link=log))
summary(glm_timepop)
plot(glm_timepop)
#exponential curve
plot_cap(glm_timepop, "blackpop") 
#log 10 x axis
plot_cap(glm_timepop, "blackpop") +scale_x_log10()
# as we triple the Black population we get about double the total time


# contrast
lh <- linearHypothesis(lm_timepoparea,"I(blackpop/sqmi)=I(whitepop/sqmi)")
attr(lh, "value")


# regress flight hours on one Black-Indigenous-Latinx percentage)
flighthrsonbil <- lm(tot_time~pctbil+pctasian, data=neighborhood_data)
summary(flighthrsonbil)


# Plot it out & interpret
 