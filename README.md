
<!-- README.md is generated from README.Rmd. Please edit that file -->

# HollywoodMovies2.0

<!-- badges: start -->

[![Lifecycle:
maturing](https://img.shields.io/badge/lifecycle-maturing-blue.svg)](https://www.tidyverse.org/lifecycle/#maturing)
<!-- badges: end -->

The goal of HollywoodMovies2.0 is a Shiny app using `golem` framework.
The primary goal of this application is to:

  - Explore a dataset about hollywood movies,
  - Demonstrate how to apply K Nearest Neighbor to cluster the movies,
    and explore the outcome.

## Installation

If you are interested you can install this application as a R library.

  - You can install the development version from GitHub with:

<!-- end list -->

``` r
# install.packages("remotes")
remotes::install_github("Curious-Joe/HollywoodApp2.0")
# run the shiny app
HollywoodMovies2.0::run_app(dataset = movies)
```
