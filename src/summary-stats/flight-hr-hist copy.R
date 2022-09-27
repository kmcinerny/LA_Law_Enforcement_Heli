library(tidyverse)
library(jsonlite)
library(lubridate)


# Skip to line 18/19, replace hr in group_by(hr) with the name of hour column
pos10.19_df <- read_csv("/Users/katemcinerny/Documents/UCLA/Carceral_ecologies/heli_data/data/CSV/10.19/pos10.19_df.csv") %>%
  # Hour column has the format 00:00, 01:00, etc.s
  mutate(hr = paste(str_extract(timestamp,
                                pattern = "(?<= )[[:digit:]]+"),
                    "00",
                    sep = ":"))
# Group the data by hour
flight10.19_hrs <- pos10.19_df %>%
  group_by(hr) %>%
  # Count the unique flight ids with a given hour value
  summarise(n_flights = n_distinct(flight_id))

# Plot histogram of the number of flights in each hours
ggplot(data = flight10.19_hrs, aes(x = hr, y = n_flights)) +
  # Identity uses the values of y (n_flights) as the height for the bars
  geom_bar(stat = "identity", fill = "#003B5C") +
  labs(title = "Number of Flights in a Given Hour",
       x = "Time by Hour (PT)",
       y = "Number of Flights",
       # Caption says the total number of flights for the given month
       caption = paste0("Total Number of Flights: ",
                        n_distinct(pos10.19_df$flight_id),
                        "\nData for flights from Oct 2019")) +
  # Remove tick marks (optional)
  theme(axis.ticks = element_blank())



#pos5.20_df <- read_csv("Documents/UCLA/Carceral_ecologies/heli_data/data/CSV/pos5.20_df.csv") #%>%
  # Do not need to change timestamp if you already have mutated the time column
  ## Just run the read_csv() above then proceed to the later lines of code
  # mutate(timestamp = ymd_hms(timestamp) %>% with_tz())
# Do not need to run the mutate() if you already have an hour column
# Skip to line 18/19, replace hr in group_by(hr) with the name of hour column
pos5.20_df <- pos5.20_df %>%
  # Hour column has the format 00:00, 01:00, etc.s
  mutate(hr = paste(str_extract(timestamp,
                                pattern = "(?<= )[[:digit:]]+"),
                    "00",
                    sep = ":"))
# Group the data by hour
flight5.20_hrs <- pos5.20_df %>%
  group_by(hr) %>%
  # Count the unique flight ids with a given hour value
  summarise(n_flights = n_distinct(flight_id))

# Plot histogram of the number of flights in each hours
ggplot(data = flight5.20_hrs, aes(x = hr, y = n_flights)) +
  # Identity uses the values of y (n_flights) as the height for the bars
  geom_bar(stat = "identity", fill = "#ea4524") +
  labs(title = "Number of Flights in a Given Hour",
       x = "Time by Hour (PT)",
       y = "Number of Flights",
       # Caption says the total number of flights for the given month
       caption = paste0("Total Number of Flights: ",
                        n_distinct(pos5.20_df$flight_id),
                        "\nData for flights from May 2020")) +
  # Remove tick marks (optional)
  theme(axis.ticks = element_blank())
