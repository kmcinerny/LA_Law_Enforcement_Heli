library(tidyverse)
library(lubridate)
library(tictoc)
library(stringr)

## Oct 2019

pos10.19_outliers <- read_csv("Documents/UCLA/Carceral_ecologies/heli_data/data/CSV/10.19/pos10.19_outliers.csv")

mean(pos10.19_outliers$is_outlier=="TRUE")
# [1] 0.002043545

pos10.19 <- pos10.19_outliers %>% filter(!is_outlier=="TRUE")

write.csv(pos10.19, file= "Documents/UCLA/Carceral_ecologies/heli_data/data/CSV/10.19/pos10.19.csv")



## May 2020

pos5.20_outliers <- read_csv("Documents/UCLA/Carceral_ecologies/heli_data/data/CSV/pos5.20_outliers.csv")

mean(pos5.20_outliers$is_outlier=="TRUE")

# [1] 0.008151447 -> .8% are outliers

pos5.20 <- pos5.20_outliers %>% filter(!is_outlier=="TRUE")

write.csv(pos5.20, file= "Documents/UCLA/Carceral_ecologies/heli_data/data/CSV/pos5.20.csv")


