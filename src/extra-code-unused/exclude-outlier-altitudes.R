library(tidyverse)
library(lubridate)
library(tictoc)
library(stringr)



pos5.20_outliers <- read_csv("Documents/UCLA/Carceral_ecologies/heli_data/data/CSV/pos5.20_outliers.csv")

mean(pos5.20_outliers$is_outlier=="TRUE")

# [1] 0.008151447 -> .8% are outliers

pos5.20 <- pos5.20_outliers %>% filter(!is_outlier=="TRUE")

write.csv(pos5.20, file= "Documents/UCLA/Carceral_ecologies/heli_data/data/CSV/pos5.20.csv")


