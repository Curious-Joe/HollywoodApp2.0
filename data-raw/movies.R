## code to prepare `movies` dataset goes here
movies <- movies %>%
  mutate(profit = gross - budget)
usethis::use_data(
  movies, overwrite = TRUE)
