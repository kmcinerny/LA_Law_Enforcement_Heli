# Reverse geocode the latitude and longitude ----
## See https://cloud.google.com/maps-platform/ to acquire an API key
library(tidyverse)
library(ggmap)

register_google(key = "insert key here")


flights202010 <- read_csv("/Users/katemcinerny/Documents/UCLA/Carceral_ecologies/heli_data/data/csv/flights202010.csv")

# Extract specific latitude and longitude columns
lat_long <- df %>%
  # Replace posLat, posLong with the latitude and longitude columns from which
  ## you want to get locations
  select(flights.positions.latitude, flights.positions.longitude) %>%
  # Transpose to get each column to be a unique latitude-longitude pair
  t() %>%
  # Column names will be X1, X2, ..., X[# of rows in data frame]
  as.data.frame(col.names = paste0("X", seq_len(nrow(df))))

# For each element in the list (each column in the data frame), reverse geocode
locales <- map(lat_long, revgeocode)

# The output of locales will be a list with each element in the list being
## an address that corresponds to the location
## The first element (locales$X1) will correspond to the latitude-longitude
## coordinate pair for the first column in lat_long (the first row in df)
