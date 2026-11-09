source("R/01_load-data_functions.R")
source("R/02_clean-data_functions.R")

rawcsv_nested <- tibbl_area("data/raw/landusearea_data/")
luadat_nested <- rawcsv_nested %>%
  mutate(processed = map(data, areasum))
