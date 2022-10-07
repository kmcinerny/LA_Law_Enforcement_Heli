rm(list = ls())
library(tidyverse)
library(lubridate)

# this shows that fileName does include all of those files read in
fileNames <- Sys.glob("Documents/UCLA/Carceral_ecologies/heli-analysis/heli-data/positions-3/*.csv")
for (fileName in fileNames) {
    print(fileName)
    month_df <- read.csv(fileName)
    print(head(month_df))
}

# Input: Monthly dataframe
# Output: Summary results: Total flight time per tail number, with a month column
get_tail_time <- function(month_df) {
 tail_time <- month_df %>%
    # Group by flight_id
    group_by(flight_id) %>%
    # Calculate the flight time for each flight in seconds and minutes
    summarise(time_sec = as.numeric(as.duration(diff(range(timestamp))))) %>%
    mutate(time_hrs = time_sec / 3600) %>%
    ungroup() %>%
    # Join summary table with tail number
    left_join(month_df %>% select(flight_id, aircraftRegistration)%>%
                distinct(),
              on = 'flight_id') %>%
    # Group by tail number
    group_by(aircraftRegistration) %>%
    # Calculate the total time (minutes) by flight number
    # Can change time_min to time_sec if you want seconds
    summarise(total_time = sum(time_hrs)) %>%
    # Add the year-month as an ID column
    mutate(month = month_df %>%
             slice(1) %>%
             pull(flight_id) %>%
             str_extract('\\d{4}-[A-Za-z]+(?=-)')) %>%
    ungroup()
}
 
# this is where I run into an issue.. maybe with the function
all_months_df = data.frame()
for (fileName in fileNames) {
    month_df <- read.csv(fileName) %>%
    ## Arrange the rows first by flight_id, then by time stamp (earliest to latest)
    ## Time stamp arranged within each flight_id
    arrange(flight_id, timestamp) 
    temp_df<- get_tail_time(month_df)
    # all_months_df <- rbind(all_months_df, temp_df)
    # Apply the tail time function for each month's dataframe
    #month_data_list <- list(month_df)
    #all_months_df <- map_dfr(month_data_list, get_tail_time)
}


# Create a list with each element being a month's flight data frame
month_data_list <- list(pos10.19_df, pos11.19_df, pos12.19_df, pos1.20_df, pos2.20, pos3.20_df, pos4.20_df, 
                        pos5.20_df, pos6.20_df, pos8.20_df, pos9.20_df, pos10.20_df)

# Apply the tail time function for each month's dataframe
all_months_tailtime <- map_dfr(month_data_list, get_tail_time)

write_csv(all_months_tailtime,"Documents/UCLA/Carceral_ecologies/heli_data/data/CSV/tailtime_notjuly.csv")

