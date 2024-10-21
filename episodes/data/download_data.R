if (!dir.exists("data"))
  dir.create("data")

# Get and clean the data
# There are leading spaces in some respondent_wall_type
# key_id 1 and 21 are duplicated. The 2nd row should be 2 and the 53rd row should be 53

if (! file.exists("data/SAFI_clean.csv")) {
  download.file("https://ndownloader.figshare.com/files/11492171",
                "data/SAFI_clean.csv", mode = "wb")

  # Clean data
  df <- read.csv("data/SAFI_clean.csv",
                 stringsAsFactors = FALSE)

  # Remove white space
  df$respondent_wall_type <- trimws(df$respondent_wall_type, which = "both")
  # Replace duplicate ids
  df[[2, 1]] <- 2
  df[[53, 1]] <- 53

  write.csv(df, "data/SAFI_clean.csv", row.names = FALSE)
}

# Plotting data -----------------------------------------------------------

# Create plotting data for ggplot episode
library(tidyr)
library(dplyr)

if (! file.exists("data/interviews_plotting.csv")) {
  # Copy code from ggplot episode to create data
  interviews_plotting <- df %>%
    # Need to turn NULL to NA
    mutate(memb_assoc = na_if(memb_assoc, "NULL"),
           affect_conflicts = na_if(affect_conflicts, "NULL"),
           items_owned = na_if(items_owned, "NULL")) %>%
      ## pivot wider by items_owned
      separate_longer_delim(items_owned, delim = ";") %>%
      replace_na(list(items_owned = "no_listed_items")) %>%
      ## Use of grouped mutate to find number of rows
      group_by(key_ID) %>%
      mutate(items_owned_logical = TRUE,
             number_items = if_else(items_owned == "no_listed_items", 0, n())) %>%
      pivot_wider(names_from = items_owned,
                  values_from = items_owned_logical,
                  values_fill = list(items_owned_logical = FALSE)) %>%
      ## pivot wider by months_lack_food
      separate_longer_delim(months_lack_food, delim = ";") %>%
      mutate(months_lack_food_logical = TRUE,
             number_months_lack_food = if_else(months_lack_food == "none", 0, n())) %>%
      pivot_wider(names_from = months_lack_food,
                  values_from = months_lack_food_logical,
                  values_fill = list(months_lack_food_logical = FALSE))

  write.csv(interviews_plotting, "data/interviews_plotting.csv", row.names = FALSE)
}


