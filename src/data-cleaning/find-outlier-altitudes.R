
library(tidyverse)
library(lubridate)
library(tictoc)

# Read in the position CSV file 
pos2.20_df <- read_csv("/Users/katemcinerny/Documents/UCLA/Carceral_ecologies/heli_data/data/CSV/2.20/pos2.20_df.csv")


findOutliers <- function(flight, df, ascent_rate = 1600) {
  # Only care about altitude and timestamp
  flight_alt <- df %>%
    filter(flight_id == flight) %>%
    select(altitude, timestamp) #%>%
    #mutate(timestamp = ymd_hms(timestamp) %>% with_tz()) # change to PST within flight (don't need if I already changed flight times)
  valid <- 1
  outlier <- logical(nrow(flight_alt))
  if (length(outlier) > 1) {
    for (i in seq(from = 2, to = nrow(flight_alt))) {
      # Get the two important altitude values
      rel_alts <- flight_alt %>%
        slice(valid, i) %>%
        pull(altitude)
      # Get the two important timestamps
      rel_times <- flight_alt %>%
        slice(valid, i) %>%
        pull(timestamp)
      # We need none of them to be NA values
      ## If NA, we mark it as not an outlier
      if (all(!is.na(rel_alts)) & all(!is.na(rel_times))) {
        # Find the second difference, then divide by 60 for minute difference
        minute_diff <- interval(start = rel_times[1], end = rel_times[2]) %>%
          as.duration() %>%
          as.numeric() %>%
          `/`(60)
        # Range of altitude change is the rate (ft/min) multiplied by minutes
        possible_range <- ascent_rate * minute_diff
        # Altitude difference is current - prior valid altitude
        alt_diff <- diff(rel_alts)
        # If the difference in altitude is larger than the range,
        ## The ith value is an outlier and we don't change the valid point
        if (abs(alt_diff) > abs(possible_range)) {
          outlier[i] <- TRUE
        } else {
          # If the point isn't an outlier, then outlier remains FALSE
          ## We make this point the new valid point to compare the next point
          valid <- i
        }
      }
    }
  }
  outlier
}

# Apply findOutliers to all unique flight IDs
tic()
all_outliers <- map(unique(pos2.20_df$flight_id),
                    findOutliers,
                    df = pos2.20_df,
                    ascent_rate = 2500)
toc()
positions202002 <- pos2.20_df %>% mutate(is_outlier = unlist(all_outliers))

write.csv(pos2.20_df, file= "Documents/UCLA/Carceral_ecologies/heli_data/data/CSV/pos2.20_outliers.csv") 


# find how many are outliers
mean(pos2.20_df$is_outlier=="TRUE")


# exclude outlier altitudes
pos2.20 <- pos2.20_outliers %>% filter(!is_outlier=="TRUE")


write.csv(pos2.20, file= "Documents/UCLA/Carceral_ecologies/heli_data/data/CSV/2.20/pos2.20_df.csv")
