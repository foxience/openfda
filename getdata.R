library(tidyr)
library(dplyr)
library(ggplot2)
library(openfda)

df <- fda_query('/drug/event.json') %>%
  fda_filter('patient.patientsex', 0) %>%
  fda_filter('patient.patientonsetage', '[25+TO+40]') %>%
  fda_filter('patient.drug.medicinalproduct', 'amitriptylin') %>%
  # fda_filter('patient.drug.drugindication', 'PYELONEPHRITIS') %>%
  # fda_filter('occurcountry', 'vn') %>%
  # fda_search() %>% fda_limit(20) %>%
  fda_count('patient.reaction.reactionmeddrapt.exact') %>%
  # fda_count('patient.patientonsetage') %>%
  fda_exec()