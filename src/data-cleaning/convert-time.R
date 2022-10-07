rm(list = ls())
library(lubridate) #to separate date/time


# load data 
positions_df <- read_csv("Documents/UCLA/Carceral_ecologies/heli-analysis/heli-data/positions/positions_df.csv")

fileNames <- Sys.glob("Documents/UCLA/Carceral_ecologies/heli-analysis/heli-data/positions-3/*.csv")
# define empty dataset with timezone
positions3_df_tz <- data.frame()
for (fileName in fileNames) {
  positions3_df <- read.csv(fileName)
  positions3_df$timestamp <- with_tz(ymd_hms(positions3_df$timestamp))
  # then fill dataset with these conversions
  positions3_df_tz <- dplyr::bind_rows(positions3_df_tz, positions3_df)
}


# convert positions timestamp to pacific
positions_df$timestamp <- with_tz(ymd_hms(positions_df$timestamp))

write.csv(positions_df, file= "/Documents/UCLA/Carceral_ecologies/heli-analysis/heli-data/positions/positions_df")


# convert flight time to pacific
flights_df <- read_csv("/Documents/UCLA/Carceral_ecologies/heli-analysis/heli-data/flights/flights_df.csv")

# converting timezone of when flight was created
flights_df$created <- with_tz(ymd_hms(flights_df$created))

# converting timezone of when flight updated
flights_df$updated <- with_tz(ymd_hms(flights_df$updated))

