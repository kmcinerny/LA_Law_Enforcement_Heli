library(tidyverse)

## Oct 2019

# Read in the data file
pos10.19hood <- read_csv("Documents/UCLA/Carceral_ecologies/heli_data/data/CSV/10.19/pos10.19hood.csv")

pos10.19hood <- pos10.19hood %>%
  # Fix the issue with naming--from Oct to May
  #mutate_at("flight_id",
  #str_replace,
  #pattern = "Oct",
  #replacement = "May") %>%
  # Arrange the rows first by flight_id, then by time stamp (earliest to latest)
  ## Time stamp arranged within each flight_id
  arrange(flight_id, timestamp)

pos10.19hoodtime <- pos10.19hood %>%
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
         time_spent = half_to - half_from) %>%
  # Summarise on a by flight, by neighborhood level
  #group_by(flight_id, neighborhoodname) %>%
  # Summarize by neighborhood
  group_by(neighborhoodname) %>%
  # Sum all times in the same neighborhood
  summarise(tot_time = sum(time_spent)) #%>%
#arrange by same flight
  #arrange(flight_id, desc(tot_time))


pos10.19hoodtime








## May 2020

# Read in the data file
pos5.20hood <- read_csv("Documents/UCLA/Carceral_ecologies/heli_data/data/CSV/pos5.20hood.csv")

pos5.20hood <- pos5.20hood %>%
  # Fix the issue with naming--from Oct to May
  #mutate_at("flight_id",
            #str_replace,
            #pattern = "Oct",
            #replacement = "May") %>%
  # Arrange the rows first by flight_id, then by time stamp (earliest to latest)
  ## Time stamp arranged within each flight_id
  arrange(flight_id, timestamp)

pos5.20hoodtime <- pos5.20hood %>%
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
         time_spent = half_to - half_from) %>%
  # Summarise on a by flight, by neighborhood level
  #group_by(flight_id, neighborho) %>%
  # Summarize by neighborhood
  group_by(neighborho) %>%
  # Sum all times in the same neighborhood
  summarise(tot_time = sum(time_spent)) #%>%
  #arrange by same flight
  #arrange(flight_id, desc(tot_time))


pos5.20hoodtime



## May 2020

# Read in the data file
pos5.20grouphood <- read_csv("Documents/UCLA/Carceral_ecologies/heli_data/data/CSV/5.20/pos5.20grouphood.csv")

pos5.20grouphood <- pos5.20grouphood %>%
  # Fix the issue with naming--from Oct to May
  #mutate_at("flight_id",
  #str_replace,
  #pattern = "Oct",
  #replacement = "May") %>%
  # Arrange the rows first by flight_id, then by time stamp (earliest to latest)
  ## Time stamp arranged within each flight_id
  arrange(flight_id, timestamp)

pos5.20grouphoodtime <- pos5.20grouphood %>%
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
         time_spent = half_to - half_from) %>%
  # Summarise on a by flight, by neighborhood level
  #group_by(flight_id, neighborho) %>%
  # Summarize by neighborhood
  group_by(hoodgroupname) %>%
  # Sum all times in the same neighborhood
  summarise(tot_time = sum(time_spent)) #%>%
  #arrange by same flight
  #arrange(flight_id, desc(tot_time))


pos5.20grouphoodtime

#graph top 10 neighborhoods with the highest time counts (in seconds)
top_n(pos5.20grouphoodtime, n=10, tot_time) %>%
  filter(!is.na(hoodgroupname)) %>%
  arrange(desc(tot_time))%>%
  ggplot(., aes(x=hoodgroupname, y=tot_time))+
  geom_bar(stat='identity', fill='#ea4524') 
