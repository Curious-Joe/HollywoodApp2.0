## code to prepare `movies` dataset goes here
library(tidyverse)
movies <- read.csv("C:/Users/ahfah/Desktop/Data Science Projects/Shiny app with Golem/Hollywood Movie/Shiny Dashboard_Most profitable hollywood movies_v02/movie_datacamp.csv")
movies$title <- stringi::stri_trans_general(movies$title, "latin-ascii")
movies <- movies %>%
  mutate(profit = gross - budget)
usethis::use_data(
  movies, overwrite = TRUE)
