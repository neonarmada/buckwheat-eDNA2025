# Library Call
p_load(tidyverse)

# Land-use lookup table (code -> land use type)
landuse_key <- tribble(
  ~from, ~to,
  "100", "Farmland",
  "200", "OtherFarmland",
  "500", "Forest",
  "600", "Wasteland",
  "700", "Building",
  "901", "Road",
  "902", "Railway",
  "1000", "OtherLand",
  "1100", "Freshwater",
  "1400", "Beach",
  "1500", "Seawater",
  "1600", "GolfCourse",
  "0000", "OutsideAnalysis"
) %>%
  mutate(from = as.character(from)) # force codes as characters

# Function: Adding Site Name to table, Sums of Area by code, area proportion
areasum <- function(x) {
  x %>%
    mutate(LandUseCode = as.integer(L03b_002)) %>% # to strip leading zeros (uniniform data values)
    mutate(LandUseCode = as.character(LandUseCode)) %>% # format codes as characters to match look up table
    group_by(LandUseCode) %>%
    summarise(area_sums = sum(Area, na.rm = TRUE)) %>%
    mutate(LandUseType = replace_values(LandUseCode,
      from = landuse_key$from,
      to = landuse_key$to
    )) %>%
    select(LandUseType, area_sums) %>%
    mutate(AreaProp = area_sums / sum(area_sums))
}
