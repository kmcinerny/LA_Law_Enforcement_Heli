rm(list = ls())
library(lubridate)
library(tidyverse)

# changes : edit minute_range and orbit_threshold within orbit_results instead of function


set.seed(0)
# Change this to read in the specific data file of interest
monthly_data <- read_csv("/Users/katemcinerny/Documents/UCLA/Carceral_ecologies/heli_data/data/CSV/5.20/pos5.20grouphood.csv")

# Inputs
## monthly_data (data.frame, tbl)
### A data frame of flight position data with information on heading, flight_id
## minute_range (numeric, default = 15)
### The range of timestamps to consider for orbiting, centered around the timestamp of interest
### default: 15 minutes (total range of 30 minutes for +/- 15 minutes from timestamp)
## orbit_threshold (numeric, default = 720)
### The minimum rotation required (for a range of +/- minute_range) to classify a point as orbiting
### default: 720˚ (two full cycles)

# Output
##   data frame (data.frame, tbl)
###     A data frame for the original data with five additional variables:
####      next_heading (numeric): The heading of the next timestamp (˚)
####      direction (numeric): The difference in heading between the next and current timestamps (˚)
####      total_rotate (numeric): The total rotation of the helicopter (cumulative sum of all prior timestamps in the flight, ˚)
####      ever_orbiting (boolean/logical): Did the total rotation of the helicopter ever reach orbit_threshold?
####      is_orbiting (boolean/logical): Is the helicopter as orbiting or not at the given timestamp for the given flight?

determine_orbit_positions <- function(monthly_data,
                                      minute_range = 15,
                                      orbit_threshold = 720) {
  # Calculate rotation statistics ----
  flight_bearing <- monthly_data %>%
    # Filter a subset for the function to run quicker.... right now I'm going limit neighborhood to Westside South Central
    # that doesn't work because flights don't just happen within one neighborhood
    # is there a way to filter where it's any flight that ever flew in Westside South Central? Like limiting to those flights that contain points in Westside?
    #filter(hoodgroupname == "Westside South Central") %>%
    # isolate hour of day for flight in order to filter
    mutate(hr = paste(str_extract(timestamp,
                                  pattern = "(?<= )[[:digit:]]+"),
                      "00",
                      sep = ":")) %>%
    # filter flights to certain times (9 pm- 7 am)
    filter(hr %in% c("21:00","22:00","23:00","00:00","01:00","02:00", "03:00","04:00","05:00","06:00","07:00")) %>%
    # Only consider when in the air, heading data present
    filter(altitude > 0, !is.na(heading)) %>%
    # Mutate on a group-by-group basis
    group_by(flight_id) %>%
    arrange(timestamp) %>%
    mutate(next_heading = lead(heading),
           direction = case_when(
             # If less than 180 degree change, assume correct
             abs(next_heading - heading) < 180 ~ next_heading - heading,
             # If going from low number to high (e.g. 40 to 320),
             ## Find portion of circle (and make negative)
             next_heading > heading ~ -(360 - (next_heading - heading)),
             # Otherwise, find other portion of circle
             TRUE ~ 360 + (next_heading - heading)
           ),
           .after = heading) %>%
    mutate(
      prior_direction = case_when(
        # Make sure same direction if there are two 180˚'s in a row
        abs(lag(direction)) != 180 ~ lag(direction),
        TRUE ~ lag(direction, n = 2)
      ),
      direction = case_when(
        # For 180, go in same direction as before
        abs(direction) == 180 ~ 180 * sign(prior_direction),
        TRUE ~ direction
      ),
      # Total rotation in the flight
      total_rotate = cumsum(direction),
      ever_orbiting = suppressWarnings(diff(range(total_rotate, na.rm = TRUE)) > orbit_threshold),
      .after = direction
    ) %>%
    select(-prior_direction)
  
  # Functions ----
  
  # Inputs
  ##   obs_no (integer)
  ###     The observation used to determine if the flight is orbiting for a given time
  ##   flight (data.frame, tbl)
  ###     A data frame of observations for a specific flight ID
  ##   time_range (numeric)
  ###     The range to consider for determining orbit (+/- this time from observation)
  ###     Default: 15 minutes (indicates thirty-minute total frame)
  ##   min_rot (numeric)
  ###     The minimum rotation difference required to classify as rotating
  ###     Default: 720 (two full cycles in time_range to classify as orbiting)
  
  # Output
  ##   TRUE/FALSE (logical/boolean)
  ###     Whether the helicopter is orbiting at a given time/observation in the flight
  
  calculate_rotation <- function(obs_no, flight, time_range = 15, min_rot = 720) {
    # Select specific flight observation
    obs <- flight %>% slice(obs_no)
    # Range of +/- time_range minutes around the time
    rotations <- flight %>%
      filter(timestamp > obs$timestamp - minutes(time_range),
             timestamp < obs$timestamp + minutes(time_range),
             !is.na(total_rotate)) %>%
      pull(total_rotate)
    # If some observations fit the criteria, find range of total rotations
    if (length(rotations) > 0) {
      rotation_amt <- rotations %>%
        range() %>%
        diff()
    } else {
      # If no observations, total rotation set to zero (done to avoid errors)
      rotation_amt <- 0
    }
    # Rotation has to be at least min_rot (default of 720˚/2 cycles)
    rotation_amt > min_rot
  }
    
  
  # Wrapper function to apply the orbiting determination to all flights
  
  # Inputs
  ##   flight_id_no (character)
  ###     The flight ID to subset a specific flight
  ##   flights (data.frame, tbl)
  ###     A data frame of observations for all flight IDs (or at least with flight_id_no)
  ##   time_range (numeric)
  ###     The range to consider for determining orbit (+/- this time from observation)
  ###     Default: 15 minutes (indicates thirty-minute total frame)
  ###     time_range passed on as an argument to calculate_rotation()
  ##   min_rot (numeric)
  ###     The minimum rotation difference required to classify as rotating
  ###     Default: 720 (two full cycles in time_range to classify as orbiting)
  ###     min_rot passed on as an argument to calculate_rotation()
  
  # Output
  ##   specific_flight (data.frame, tbl)
  ###     A data frame for the specific flight_id_no with all prior variables and the additional
  ###       is_orbiting variable. is_orbiting is a TRUE/FALSE boolean value that classifies the
  ###       helicopter as orbiting or not at the given timestamp for the given flight

  id_orbits <- function(flight_id_no, flights, time_range = 15, min_rot = 720) {
    # Select specific flight
    specific_flight <- flights %>% filter(flight_id == flight_id_no)
    if (any(specific_flight$ever_orbiting)) {
      # Add orbiting results as a new column
      specific_flight <- specific_flight %>%
        mutate(is_orbiting = map_lgl(seq_len(nrow(.)),
                                     calculate_rotation,
                                     flight = .,
                                     time_range = time_range,
                                     min_rot = min_rot),
               .after = ever_orbiting)
    } else {
      # If no observations in the flight were orbiting, don't waste time (all FALSE)
      specific_flight <- specific_flight %>%
        mutate(is_orbiting = FALSE, .after = ever_orbiting)
    }
    specific_flight
  }

  # Results ----
  map_dfr(unique(flight_bearing$flight_id),
          id_orbits,
          flights = flight_bearing,
          time_range = minute_range,
          min_rot = orbit_threshold)
}

orbit_results <- determine_orbit_positions(monthly_data, minute_range = 10, orbit_threshold = 720)
write_csv(orbit_results, "Documents/UCLA/Carceral_ecologies/heli_data/data/CSV/5.20/May2020-niteorbits-20min2turns.csv")


# then isolate the points where is_orbiting=TRUE





# isolate the first unique orbit and then if there's a break in orbiting that's longer than 5 minutes then start code over **Clarify
# do it for 30 min/ an hour instead of 15 mins - DONE
# do it during sleeping hours - DONE
# exclude flights not orbiting, count total flights orbiting - DONE
# look at range of altitude while they're orbiting ****
