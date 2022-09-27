
library(lubridate) #to separate date/time



## May 2020

# load data 
pos5.20_df <- read_csv("/Users/katemcinerny/Documents/UCLA/Carceral_ecologies/heli_data/data/CSV/5.20/pos5.20_df.csv")

# convert timestamp to PST
pos5.20_df$timestamp <- with_tz(ymd_hms(pos5.20_df$timestamp))

write.csv(pos5.20_df, file= "/Users/katemcinerny/Documents/UCLA/Carceral_ecologies/heli_data/data/csv/5.20/pos5.20_df.csv")

# convert flight time to PST

flight5.20_df <- read_csv("/Users/katemcinerny/Documents/UCLA/Carceral_ecologies/heli_data/data/CSV/5.20/mayflights.csv")

# converting timezone of when flight was created
flight5.20_df$created <- with_tz(ymd_hms(flight5.20_df$created))

# converting timezone of when flight updated
flight5.20_df$updated <- with_tz(ymd_hms(flight5.20_df$updated))

# separate date-time-hr
#d <- as.POSIXct(flights11.19_hood$PSTtimestamp, format="%Y-%m-%d %H:%M:%S")
#flights11.19_hood$date_pos <- format(d, format="%Y-%m-%d")
#flights11.19_hood$time_pos <- format(d, format="%H:%M:%S")
#flights11.19_hood$hr_pos <- format(d, format="%H")


# convert from string to numeric
#flights11.19_hood$hr_pos_num <- as.numeric(flights11.19_hood$hr_pos)
