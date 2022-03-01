library(tidyverse)
library(lubridate)
library(tictoc)

pos5.20 <- read_csv("Documents/UCLA/Carceral_ecologies/heli_data/data/CSV/pos5.20_outliers.csv")


mean(pos5.20$is_outlier=="TRUE")

pos5.20 <- pos5.20 %>% filter(!is_outlier=="TRUE")

write.csv(pos5.20, file= "Documents/UCLA/Carceral_ecologies/heli_data/data/CSV/pos5.20.csv")


