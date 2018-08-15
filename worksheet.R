library(dplyr)

# read in data
animals <- read.csv('data/animals.csv', stringsAsFactors = FALSE)
species <- read.csv('data/species.csv', stringsAsFactors = FALSE)

# group animals captured in one year by species_id and summarize with total
# abundance and average weight ignoring non-rodents
rodents <- animals %>%
  filter(year == 1990) %>%
  inner_join(species, c('species_id' = 'id')) %>%
  filter(taxa == 'Rodent') %>%
  group_by(species_id) %>%
  summarize(count = n(), weight = mean(weight))

# pretend this takes a really long time!
Sys.sleep(10)
