library(tidyverse)
library(jsonlite)
library(lubridate)

pos_df <- read_csv("data/processed/201910-position-data.csv") %>%
  # Do not need to change timestamp if you already have mutated the time column
  ## Just run the read_csv() above then proceed to the later lines of code
  mutate(timestamp = ymd_hms(timestamp) %>% with_tz())
# Do not need to run the mutate() if you already have an hour column
# Skip to line 18/19, replace hr in group_by(hr) with the name of hour column
pos_df <- pos_df %>%
  # Hour column has the format 00:00, 01:00, etc.
  mutate(hr = paste(str_extract(timestamp,
                                pattern = "(?<= )[[:digit:]]+"),
                    "00",
                    sep = ":"))
# Group the data by hour
flight_hrs <- pos_df %>%
  group_by(hr) %>%
  # Count the unique flight ids with a given hour value
  summarise(n_flights = n_distinct(flight_id))

# Plot histogram of the number of flights in each hours
ggplot(data = flight_hrs, aes(x = hr, y = n_flights)) +
  # Identity uses the values of y (n_flights) as the height for the bars
  geom_bar(stat = "identity", fill = "#003B5C") +
  labs(title = "Number of Flights in a Given Hour",
       x = "Time by Hour (PT)",
       y = "Number of Flights",
       # Caption says the total number of flights for the given month
       caption = paste0("Total Number of Flights: ",
                        n_distinct(pos_df$flight_id),
                        "\nData for flights from October 2019")) +
  # Remove tick marks (optional)
  theme(axis.ticks = element_blank())
