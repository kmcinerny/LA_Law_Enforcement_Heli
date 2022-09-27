rm(list = ls())
library(tidyverse)
library(dplyr)

# changes made on this doc: deleted repeat code/ changed variable name to "neighborhood" / turned seconds into hours for time spent per neighborhood

# Read in the data file
pos5.20 <- read_csv("Documents/UCLA/Carceral_ecologies/heli_data/data/CSV/5.20/pos5.20.csv")



# renaming neighborhood column
pos5.20 <- rename(pos5.20, neighborhood=neighborhoodname)

pos5.20 <- pos5.20 %>%
  # Fix the issue with naming--from Oct to May
  #mutate_at("flight_id",
  #str_replace,
  #pattern = "Jul",
  #replacement = "Jun") %>%
  # Arrange the rows first by flight_id, then by time stamp (earliest to latest)
  ## Time stamp arranged within each flight_id
  arrange(flight_id, timestamp)

pos10.19 <- pos10.19 %>% arrange(flight_id, timestamp)

pos10.20 <- pos10.20 %>% arrange(flight_id, timestamp)

#pos5.20 %>% count(neighborhood, sort=TRUE)



get_neighborhood_fly_time <- function(month_df){
  neighborhood_fly_time <- month_df %>%
  # Calculate neighborhood times within each flight_id
  group_by(flight_id) %>%
  # Find total time in seconds relative to first time in that flight
  mutate(seconds_in = difftime(timestamp, timestamp[1]) %>% as.numeric(),
         # Last time stamp before current
         prior_second = case_when(
           seconds_in == 0 ~ 0,
           TRUE ~ lag(seconds_in)
         ),
         # Next time stamp after current
         next_second = case_when(
           seconds_in == max(seconds_in) ~ seconds_in,
           TRUE ~ lead(seconds_in)
         ),
         # Midway point between prior and current times
         half_from = (seconds_in + prior_second) / 2,
         # Midway point between current and next times
         half_to = (seconds_in + next_second) / 2,
         # Time at a given location calculated by time as nearest time stamp
         time_spent = (half_to - half_from)/3600) %>%
  # Summarise on a by flight, by neighborhood level
  #group_by(flight_id, neighborho) %>%
  # Summarize by neighborhood
  group_by(neighborhood) %>%
  # Sum all times in the same neighborhood
  summarise(tot_time = sum(time_spent)) %>%
  #arrange by same flight
  #arrange(flight_id, desc(tot_time))
  arrange(desc(tot_time)) %>%
  mutate(month = month_df %>%
            slice(1) %>%
            pull(flight_id) %>%
            str_extract('\\d{4}-[A-Za-z]+(?=-)'))
}

  

# Create a list with each element being a month's flight data frame
month_data_list <- list(pos5.20)

# Apply the tail time function for each month's dataframe
all_months_hoodfly <- map_dfr(month_data_list, get_neighborhood_fly_time)


# read in neighborhood sq mi
neighborhood_sqmi <- read_csv("Documents/UCLA/Carceral_ecologies/heli_data/data/CSV/neighborhood_sqmi.csv")

# join sq mi to flight time
all_months_hoodfly <- left_join(all_months_hoodfly, neighborhood_sqmi, by = "neighborhood")


# create new variable to divide flight times by sq mi
all_months_hoodfly$time_area <- all_months_hoodfly$tot_time/ all_months_hoodfly$sqmi

write.csv(all_months_hoodfly, "Documents/UCLA/Carceral_ecologies/heli_data/data/CSV/5.20/hoodtime5.20.csv")



#graph top 10 neighborhoods with the highest time counts (in seconds)
top_n(hoodtime, n=10, tot_time) %>%
  filter(!is.na(neighborhood)) %>%
  arrange(desc(tot_time))%>%
  ggplot(., aes(x=neighborhood, y=tot_time))+
  geom_bar(stat='identity', fill='#c40001') +
  labs(y="Time Spent (Hours)", x="Neighborhood") +
  ggtitle("Top 10 Neighborhood Flight Times- May 2020")
