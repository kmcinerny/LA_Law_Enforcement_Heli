library(tidyverse)
library(lubridate)
library(plyr)
library(ggplot2)
library(mosaic)
library(car)
library(gmodels)
library(readxl)

hoodtime <- read_csv("/Users/katemcinerny/Documents/UCLA/Carceral_ecologies/heli_data/data/CSV/5.20/hoodtime5.20.csv")

demographics <- read_csv("/Users/katemcinerny/Documents/UCLA/Carceral_ecologies/heli_data/data/Mapping/neighborhood_demographics.csv")

# adding total demographic pops 

demographics$latinxpop <- demographics$pctlatinx * demographics$totalpop

demographics$whitepop <- demographics$pctwhite * demographics$totalpop

demographics$asianpop <- demographics$pctasian * demographics$totalpop

demographics$popinpov <- demographics$below100pov * demographics$totalpop

demographics$vlowincpop <- demographics$vlow_inc * demographics$totalpop

demographics$nativepop <- demographics$pctindigenous * demographics$totalpop


write.csv(demographics, "/Users/katemcinerny/Documents/UCLA/Carceral_ecologies/heli_data/data/Mapping/neighborhood_demographics.csv")

#  sum populations in south central (maybe I should just do this in excel??)
# aggregated eastside south central in excel because didn't know how to do here. now reloading data

demographicsgrp <- read_csv("/Users/katemcinerny/Documents/UCLA/Carceral_ecologies/heli_data/data/Mapping/neighborhood_demographics_grp.csv")
# neighborhoods to replace for westside south central

neighborhoods2replace <- c('Westmont','Athens','Harvard Heights',
'Mid-City', 'Arlington Heights',
'Jefferson Park',
'Adams-Normandie',
'University Park',
'Exposition Park',
'Leimert Park',
'Baldwin Hills/ Crenshaw',
'View Park- Windsor Hills',
'Hyde Park',
'Chesterfield Square',
'Vermont Square',
'Harvard Park',
'Vermont-Slauson',
'Manchester Square',
'Vermont Knolls',
'Gramercy Park',
'Westmont',
'Vermont Vista',
'Broadway-Manchester',
'Athens')


# neighborhoods to replace for eastside south central

#neighborhoods3replace <- c('Historic South Central', 'Central Alameda', 'South Park', 
#                           'Florence', 'Florence-Firestone', 'Green Meadows', 'Watts', 'Willowbrook')


# recode neighborhood into neighborhood2 (not sure how to include neighborhoods3 so manually made that in excel)
# then insert values as sum of all observations for each neighborhood (1 for most, multiple for Westside South Central)

demographicsgrp <- demographicsgrp %>%
  mutate(neighborhood2= sub(paste0(neighborhoods2replace, collapse='|'), 
                            'Westside South Central',
                            neighborhood)) %>%
  group_by(neighborhood2) %>%
    summarise(totalpop=sum(totalpop), blackpop=sum(blackpop), latinxpop=sum(latinxpop), 
              nativepop=sum(nativepop), bilpop=sum(bilpop), asianpop=sum(asianpop), 
              whitepop=sum(whitepop), popinpov=sum(popinpov), vlowincpop=sum(vlowincpop)
              )

# pipe in percent black = blackpop/total pop for each demographic

demographicsgrp$pctblack <- demographicsgrp$blackpop/ demographicsgrp$totalpop

demographicsgrp$pctlatinx <- demographicsgrp$latinxpop/ demographicsgrp$totalpop

demographicsgrp$pctnative <- demographicsgrp$nativepop/ demographicsgrp$totalpop

demographicsgrp$pctbil <- demographicsgrp$bilpop/ demographicsgrp$totalpop

demographicsgrp$pctasian <- demographicsgrp$asianpop/ demographicsgrp$totalpop

demographicsgrp$pctwhite <- demographicsgrp$whitepop/ demographicsgrp$totalpop

demographicsgrp$pctinpov <- demographicsgrp$popinpov/ demographicsgrp$totalpop

demographicsgrp$pctvlowinc <- demographicsgrp$vlowincpop/ demographicsgrp$totalpop

# *later, fix decimal places

# exporting that new neighborhood demographics set

write.csv(demographicsgrp, "/Users/katemcinerny/Documents/UCLA/Carceral_ecologies/heli_data/data/Mapping/neighborhood_demographics_grp.csv")
  
# joining neighborhood flight hours to neighborhood demographics

neighborhood_data = merge(x=hoodtime, y=demographicsgrp, by.x="neighborhood", by.y="neighborhood2")



# intercept


