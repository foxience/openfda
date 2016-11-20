library(openfda)
df <- fda_query('/drug/event.json') %>%
  fda_filter('occurcountry', 'vn') %>%
  fda_search() %>% fda_limit(20) %>%
  # fda_count('occurcountry') %>%
  fda_exec()