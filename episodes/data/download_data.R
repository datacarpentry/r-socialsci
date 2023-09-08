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
