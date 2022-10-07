library(lubridate) #to separate date/time

#load data

#separate date-time-hr
d <- as.POSIXct(flights11.19_hood$PSTtimestamp, format="%Y-%m-%d %H:%M:%S")
flights11.19_hood$date_pos <- format(d, format="%Y-%m-%d")
flights11.19_hood$time_pos <- format(d, format="%H:%M:%S")
flights11.19_hood$hr_pos <- format(d, format="%H")


# convert from string to numeric
flights11.19_hood$hr_pos_num <- as.numeric(flights11.19_hood$hr_pos)
