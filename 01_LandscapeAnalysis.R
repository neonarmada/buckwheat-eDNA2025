# Library Call =====
library(sf)
library(ggplot2)
library(tidyverse)
library(lme4)
library(MuMIn)
library(ggsignif)
library(vegan)
library(phyloseq)
library(ggsci)
library(RColorBrewer)
library(fuzzyjoin)

# Land-use lookup table (code -> category)
landuse_key <- tribble(
  ~from, ~to,
  "100", "Farmland",
  "200" , "OtherFarmland",
  "500" , "Forest",
  "600" , "Wasteland",
  "700" , "Building",
  "901" , "Road",
  "902" , "Railway",
  "1000" , "OtherLand",
  "1100" , "Freshwater",
  "1400" , "Beach",
  "1500" , "Seawater",
  "1600" , "GolfCourse",
  "0000" , "OutsideAnalysis"
)

#Teihaku
rawdat_th <- read.csv("data/landusearea_data/area_th.csv")
dat_th <- rawdat_th %>%
  mutate(LandUseCode = as.character(L03b_002)) %>%
  group_by(LandUseCode) %>%
  summarise(area_sums = sum(area)) %>%
  mutate(LandUseType = replace_values(LandUseCode, from = landuse_key$from,
                                     to = landuse_key$to)) %>%
  select(LandUseType, area_sums)
  

