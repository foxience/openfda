library(openfda)
fda_query('/drug/event.json') %>%
  # fda_filter('occurcountry', 'usa') %>%
  # fda_search() %>% fda_limit() %>%
  fda_count('occurcountry') %>%
  fda_exec()