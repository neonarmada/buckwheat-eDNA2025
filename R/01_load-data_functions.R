# Library Call =====
p_load(tidyverse, tools)

# Function List =====
## Landscape Analysis =======
tibbl_area <- function(file_dir) { # turns all csv files in the QGIS landscape directory and outputs it as a nested tibble
  # looks for csv files in the directory
  files <- list.files(file_dir, pattern = "\\.csv$", full.names = TRUE) #  \\ : to escape the period (.) as a special character; $ : end of the string

  # applies read csv function to all files in directory
  results <- lapply(files, read_csv)
  
  # adds Site Name to data
  names(results) <- str_to_upper(
    str_remove(
      file_path_sans_ext(basename(files)),
      pattern = "^area_"
    )
  )

  # creates a nested tibble for analysis
  tibble(
    Site = names(results),
    data = results
  )
}
