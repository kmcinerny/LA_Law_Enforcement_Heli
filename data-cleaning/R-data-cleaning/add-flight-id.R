library(tidyverse)
library(jsonlite)

### Issues with October & December 2019; February, March, September, October 2020


## Oct 2020

flights10.20_json <- read_json("/Users/katemcinerny/Documents/UCLA/Carceral_ecologies/heli_data/data/json/pretty-202010.json", simplifyVector = TRUE)
flights10.20_df <- flights10.20_json$flights %>% as_tibble() # making a data frame with just flights & nested positions
pos10.20_df <- flights10.20_df$positions %>% bind_rows() # making a data frame with just positions

# mapping id number to data based on number of positions per flight
num_pos <- map_int(flights10.20_df$positions, nrow) 
flights10.20_id_no <- rep(seq_along(num_pos), num_pos)
flights10.20_id_no <- paste0("2020-Oct-FlightNo-", flights10.20_id_no)
unique_flights10.20_id <- unique(flights10.20_id_no)

# I need to understand what this is better... but I think it's selecting only positions
flights10.20_df <- flights10.20_df %>%
  select(-positions) %>%
  mutate(flight_id = unique_flights10.20_id)
pos10.20_df <- pos10.20_df %>%
  mutate(flight_id = flights10.20_id_no) 

combined10.20_df <- full_join(flights10.20_df, pos10.20_df, by = "flight_id") # this is the key to join datasets
names(combined10.20_df) <- str_replace_all(names(combined_df), # they automatically assign x and y
                                      c("\\.x" = "_flight",
                                        "\\.y" = "_pos"))


## Sept 2020

flights9.20_json <- read_json("/Users/katemcinerny/Documents/UCLA/Carceral_ecologies/heli_data/data/json/pretty-202009.json", simplifyVector = TRUE)
flights9.20_df <- flights9.20_json$flights %>% as_tibble() # making a dataframe with just flights & nested positions
pos9.20_df <- flights9.20_df$positions %>% bind_rows() # making a dataframe with just positions

# mapping id number to data based on number of positions per flight... 
# this is where the errors start...
num_pos <- map_int(flights9.20_df$positions, nrow) 
flights9.20_id_no <- rep(seq_along(num_pos), num_pos)
flights9.20_id_no <- paste0("2020-Sept-FlightNo-", flights9.20_id_no)
unique_flights9.20_id <- unique(flights9.20_id_no)

# I need to understand what this is better... but I think it's selecting only positions
flights9.20_df <- flights9.20_df %>%
  select(-positions) %>%
  mutate(flight_id = unique_flights9.20_id)
pos9.20_df <- pos9.20_df %>%
  mutate(flight_id = flights9.20_id_no) 

combined9.20_df <- full_join(flights9.20_df, pos9.20_df, by = "flight_id") # this is the key to join datasets
names(combined9.20_df) <- str_replace_all(names(combined9.20_df), # they automatically assign x and y
                                           c("\\.x" = "_flight",
                                             "\\.y" = "_pos"))



## August 2020

flights8.20_json <- read_json("/Users/katemcinerny/Documents/UCLA/Carceral_ecologies/heli_data/data/json/pretty-202008.json", simplifyVector = TRUE)
flights8.20_df <- flights8.20_json$flights %>% as_tibble() # making a dataframe with just flights & nested positions
pos8.20_df <- flights8.20_df$positions %>% bind_rows() # making a dataframe with just positions

# mapping id number to data based on number of positions per flight... 
# this is where the errors start...
num_pos <- map_int(flights8.20_df$positions, nrow) 
flights8.20_id_no <- rep(seq_along(num_pos), num_pos)
flights8.20_id_no <- paste0("2020-Aug-FlightNo-", flights8.20_id_no)
unique_flights8.20_id <- unique(flights8.20_id_no)

# I need to understand what this is better... but I think it's selecting only positions
flights8.20_df <- flights8.20_df %>%
  select(-positions) %>%
  mutate(flight_id = unique_flights8.20_id)
pos8.20_df <- pos8.20_df %>%
  mutate(flight_id = flights8.20_id_no) 

combined8.20_df <- full_join(flights8.20_df, pos8.20_df, by = "flight_id") # this is the key to join datasets
names(combined8.20_df) <- str_replace_all(names(combined8.20_df), # they automatically assign x and y
                                          c("\\.x" = "_flight",
                                            "\\.y" = "_pos"))




## July 2020

flights7.20_json <- read_json("/Users/katemcinerny/Documents/UCLA/Carceral_ecologies/heli_data/data/json/pretty-202007.json", simplifyVector = TRUE)
flights7.20_df <- flights7.20_json$flights %>% as_tibble() # making a dataframe with just flights & nested positions
pos7.20_df <- flights7.20_df$positions %>% bind_rows() # making a dataframe with just positions

# mapping id number to data based on number of positions per flight... 
# this is where the errors start...
num_pos <- map_int(flights7.20_df$positions, nrow) 
flights7.20_id_no <- rep(seq_along(num_pos), num_pos)
flights7.20_id_no <- paste0("2020-Jul-FlightNo-", flights7.20_id_no)
unique_flights7.20_id <- unique(flights7.20_id_no)

# I need to understand what this is better... but I think it's selecting only positions
flights7.20_df <- flights7.20_df %>%
  select(-positions) %>%
  mutate(flight_id = unique_flights7.20_id)
pos7.20_df <- pos7.20_df %>%
  mutate(flight_id = flights7.20_id_no) 

combined7.20_df <- full_join(flights7.20_df, pos7.20_df, by = "flight_id") # this is the key to join datasets
names(combined7.20_df) <- str_replace_all(names(combined7.20_df), # they automatically assign x and y
                                          c("\\.x" = "_flight",
                                            "\\.y" = "_pos"))


## June 2020

flights6.20_json <- read_json("/Users/katemcinerny/Documents/UCLA/Carceral_ecologies/heli_data/data/json/pretty-202006.json", simplifyVector = TRUE)
flights6.20_df <- flights6.20_json$flights %>% as_tibble() # making a dataframe with just flights & nested positions
pos6.20_df <- flights6.20_df$positions %>% bind_rows() # making a dataframe with just positions

# mapping id number to data based on number of positions per flight... 
# this is where the errors start...
num_pos <- map_int(flights6.20_df$positions, nrow) 
flights6.20_id_no <- rep(seq_along(num_pos), num_pos)
flights6.20_id_no <- paste0("2020-Jun-FlightNo-", flights6.20_id_no)
unique_flights6.20_id <- unique(flights6.20_id_no)

# I need to understand what this is better... but I think it's selecting only positions
flights6.20_df <- flights6.20_df %>%
  select(-positions) %>%
  mutate(flight_id = unique_flights6.20_id)
pos6.20_df <- pos6.20_df %>%
  mutate(flight_id = flights6.20_id_no) 

combined6.20_df <- full_join(flights6.20_df, pos6.20_df, by = "flight_id") # this is the key to join datasets
names(combined6.20_df) <- str_replace_all(names(combined6.20_df), # they automatically assign x and y
                                          c("\\.x" = "_flight",
                                            "\\.y" = "_pos"))




## May 2020

flights5.20_json <- read_json("/Users/katemcinerny/Documents/UCLA/Carceral_ecologies/heli_data/data/json/pretty-202005.json", simplifyVector = TRUE)
flights5.20_df <- flights5.20_json$flights %>% as_tibble() # making a dataframe with just flights & nested positions
pos5.20_df <- flights5.20_df$positions %>% bind_rows() # making a dataframe with just positions

# mapping id number to data based on number of positions per flight... 
# this is where the errors start...
num_pos <- map_int(flights5.20_df$positions, nrow) 
flights5.20_id_no <- rep(seq_along(num_pos), num_pos)
flights5.20_id_no <- paste0("2020-May-FlightNo-", flights5.20_id_no)
unique_flights5.20_id <- unique(flights5.20_id_no)

# I need to understand what this is better... but I think it's selecting only positions
flights5.20_df <- flights5.20_df %>%
  select(-positions) %>%
  mutate(flight_id = unique_flights5.20_id)
pos5.20_df <- pos5.20_df %>%
  mutate(flight_id = flights5.20_id_no) 

combined5.20_df <- full_join(flights5.20_df, pos5.20_df, by = "flight_id") # this is the key to join datasets
names(combined5.20_df) <- str_replace_all(names(combined5.20_df), # they automatically assign x and y
                                          c("\\.x" = "_flight",
                                            "\\.y" = "_pos"))



## April 2020

flights4.20_json <- read_json("/Users/katemcinerny/Documents/UCLA/Carceral_ecologies/heli_data/data/json/pretty-202004.json", simplifyVector = TRUE)
flights4.20_df <- flights4.20_json$flights %>% as_tibble() # making a dataframe with just flights & nested positions
pos4.20_df <- flights4.20_df$positions %>% bind_rows() # making a dataframe with just positions

# mapping id number to data based on number of positions per flight... 
# this is where the errors start...
num_pos <- map_int(flights4.20_df$positions, nrow) 
flights4.20_id_no <- rep(seq_along(num_pos), num_pos)
flights4.20_id_no <- paste0("2020-Apr-FlightNo-", flights4.20_id_no)
unique_flights4.20_id <- unique(flights4.20_id_no)

# I need to understand what this is better... but I think it's selecting only positions
flights4.20_df <- flights4.20_df %>%
  select(-positions) %>%
  mutate(flight_id = unique_flights4.20_id)
pos4.20_df <- pos4.20_df %>%
  mutate(flight_id = flights4.20_id_no) 

combined4.20_df <- full_join(flights4.20_df, pos4.20_df, by = "flight_id") # this is the key to join datasets
names(combined4.20_df) <- str_replace_all(names(combined4.20_df), # they automatically assign x and y
                                          c("\\.x" = "_flight",
                                            "\\.y" = "_pos"))


## March 2020

flights3.20_json <- read_json("/Users/katemcinerny/Documents/UCLA/Carceral_ecologies/heli_data/data/json/pretty-202003.json", simplifyVector = TRUE)
flights3.20_df <- flights3.20_json$flights %>% as_tibble() # making a dataframe with just flights & nested positions
pos3.20_df <- flights3.20_df$positions %>% bind_rows() # making a dataframe with just positions

# mapping id number to data based on number of positions per flight... 
# this is where the errors start...
num_pos <- map_int(flights3.20_df$positions, nrow) 
flights3.20_id_no <- rep(seq_along(num_pos), num_pos)
flights3.20_id_no <- paste0("2020-Mar-FlightNo-", flights3.20_id_no)
unique_flights3.20_id <- unique(flights3.20_id_no)

# I need to understand what this is better... but I think it's selecting only positions
flights3.20_df <- flights3.20_df %>%
  select(-positions) %>%
  mutate(flight_id = unique_flights3.20_id)
pos3.20_df <- pos3.20_df %>%
  mutate(flight_id = flights3.20_id_no) 

combined3.20_df <- full_join(flights3.20_df, pos3.20_df, by = "flight_id") # this is the key to join datasets
names(combined3.20_df) <- str_replace_all(names(combined3.20_df), # they automatically assign x and y
                                          c("\\.x" = "_flight",
                                            "\\.y" = "_pos"))


## February 2020

flights2.20_json <- read_json("/Users/katemcinerny/Documents/UCLA/Carceral_ecologies/heli_data/data/json/pretty-202002.json", simplifyVector = TRUE)
flights2.20_df <- flights2.20_json$flights %>% as_tibble() # making a dataframe with just flights & nested positions
pos2.20_df <- flights2.20_df$positions %>% bind_rows() # making a dataframe with just positions

# mapping id number to data based on number of positions per flight... 
# this is where the errors start...
num_pos <- map_int(flights2.20_df$positions, nrow) 
flights2.20_id_no <- rep(seq_along(num_pos), num_pos)
flights2.20_id_no <- paste0("2020-Feb-FlightNo-", flights2.20_id_no)
unique_flights2.20_id <- unique(flights2.20_id_no)

# I need to understand what this is better... but I think it's selecting only positions
flights2.20_df <- flights2.20_df %>%
  select(-positions) %>%
  mutate(flight_id = unique_flights2.20_id)
pos2.20_df <- pos2.20_df %>%
  mutate(flight_id = flights2.20_id_no) 

combined2.20_df <- full_join(flights2.20_df, pos2.20_df, by = "flight_id") # this is the key to join datasets
names(combined2.20_df) <- str_replace_all(names(combined2.20_df), # they automatically assign x and y
                                          c("\\.x" = "_flight",
                                            "\\.y" = "_pos"))

## January

flights1.20_json <- read_json("/Users/katemcinerny/Documents/UCLA/Carceral_ecologies/heli_data/data/json/pretty-202001.json", simplifyVector = TRUE)
flights1.20_df <- flights1.20_json$flights %>% as_tibble() # making a dataframe with just flights & nested positions
pos1.20_df <- flights1.20_df$positions %>% bind_rows() # making a dataframe with just positions

# mapping id number to data based on number of positions per flight... 
# this is where the errors start...
num_pos <- map_int(flights1.20_df$positions, nrow) 
flights1.20_id_no <- rep(seq_along(num_pos), num_pos)
flights1.20_id_no <- paste0("2020-Jan-FlightNo-", flights1.20_id_no)
unique_flights1.20_id <- unique(flights1.20_id_no)

# I need to understand what this is better... but I think it's selecting only positions
flights1.20_df <- flights1.20_df %>%
  select(-positions) %>%
  mutate(flight_id = unique_flights1.20_id)
pos1.20_df <- pos1.20_df %>%
  mutate(flight_id = flights1.20_id_no) 

combined1.20_df <- full_join(flights1.20_df, pos1.20_df, by = "flight_id") # this is the key to join datasets
names(combined1.20_df) <- str_replace_all(names(combined1.20_df), # they automatically assign x and y
                                          c("\\.x" = "_flight",
                                            "\\.y" = "_pos"))

## December 2019

flights12.19_json <- read_json("/Users/katemcinerny/Documents/UCLA/Carceral_ecologies/heli_data/data/json/pretty-201912.json", simplifyVector = TRUE)
flights12.19_df <- flights12.19_json$flights %>% as_tibble() # making a dataframe with just flights & nested positions
pos12.19_df <- flights12.19_df$positions %>% bind_rows() # making a dataframe with just positions

# mapping id number to data based on number of positions per flight... 
# this is where the errors start...
num_pos <- map_int(flights12.19_df$positions, nrow) 
flights12.19_id_no <- rep(seq_along(num_pos), num_pos)
flights12.19_id_no <- paste0("2019-Dec-FlightNo-", flights12.19_id_no)
unique_flights12.19_id <- unique(flights12.19_id_no)

# I need to understand what this is better... but I think it's selecting only positions
flights12.19_df <- flights12.19_df %>%
  select(-positions) %>%
  mutate(flight_id = unique_flights12.19_id)
pos12.19_df <- pos12.19_df %>%
  mutate(flight_id = flights12.19_id_no) 

combined12.19_df <- full_join(flights12.19_df, pos12.19_df, by = "flight_id") # this is the key to join datasets
names(combined12.19_df) <- str_replace_all(names(combined12.19_df), # they automatically assign x and y
                                          c("\\.x" = "_flight",
                                            "\\.y" = "_pos"))

## November 2019

flights11.19_json <- read_json("/Users/katemcinerny/Documents/UCLA/Carceral_ecologies/heli_data/data/json/pretty-201911.json", simplifyVector = TRUE)
flights11.19_df <- flights11.19_json$flights %>% as_tibble() # making a dataframe with just flights & nested positions
pos11.19_df <- flights11.19_df$positions %>% bind_rows() # making a dataframe with just positions

# mapping id number to data based on number of positions per flight... 
# this is where the errors start...
num_pos <- map_int(flights11.19_df$positions, nrow) 
flights11.19_id_no <- rep(seq_along(num_pos), num_pos)
flights11.19_id_no <- paste0("2019-Nov-FlightNo-", flights11.19_id_no)
unique_flights11.19_id <- unique(flights11.19_id_no)

# I need to understand what this is better... but I think it's selecting only positions
flights11.19_df <- flights11.19_df %>%
  select(-positions) %>%
  mutate(flight_id = unique_flights11.19_id)
pos11.19_df <- pos11.19_df %>%
  mutate(flight_id = flights11.19_id_no) 

combined11.19_df <- full_join(flights11.19_df, pos11.19_df, by = "flight_id") # this is the key to join datasets
names(combined11.19_df) <- str_replace_all(names(combined11.19_df), # they automatically assign x and y
                                           c("\\.x" = "_flight",
                                             "\\.y" = "_pos"))


## October 2019

flights10.19_json <- read_json("/Users/katemcinerny/Documents/UCLA/Carceral_ecologies/heli_data/data/json/pretty-201910.json", simplifyVector = TRUE)
flights10.19_df <- flights10.19_json$flights %>% as_tibble() # making a dataframe with just flights & nested positions
pos10.19_df <- flights10.19_df$positions %>% bind_rows() # making a dataframe with just positions

# mapping id number to data based on number of positions per flight... 
# this is where the errors start...
num_pos <- map_int(flights10.19_df$positions, nrow) 
flights10.19_id_no <- rep(seq_along(num_pos), num_pos)
flights10.19_id_no <- paste0("2019-Oct-FlightNo-", flights10.19_id_no)
unique_flights10.19_id <- unique(flights10.19_id_no)

# I need to understand what this is better... but I think it's selecting only positions
flights10.19_df <- flights10.19_df %>%
  select(-positions) %>%
  mutate(flight_id = unique_flights10.19_id)
pos10.19_df <- pos10.19_df %>%
  mutate(flight_id = flights10.19_id_no) 

combined10.19_df <- full_join(flights10.19_df, pos10.19_df, by = "flight_id") # this is the key to join datasets
names(combined10.19_df) <- str_replace_all(names(combined10.19_df), # they automatically assign x and y
                                           c("\\.x" = "_flight",
                                             "\\.y" = "_pos"))

