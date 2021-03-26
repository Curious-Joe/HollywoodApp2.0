
<!-- README.md is generated from README.Rmd. Please edit that file -->

# HollywoodMovies2.0

<!-- badges: start -->

[![Lifecycle:
stable](https://img.shields.io/badge/lifecycle-stable-brightgreen.svg)](https://www.tidyverse.org/lifecycle/#stable)
<!-- badges: end -->

The goal of HollywoodMovies2.0 is a Shiny app built using `golem`
framework. The primary goal of this application is to demonstrate:

  - How to use Shiny for data exploration, and
  - How to enable user to interact with an algorithm.

Using this application a user can explore a data set, named `movies`
that comes along with this Shiny app/package. And using the `Cluster`
tab, a user can also explore a popular clustering algorithm, K Nearest
Neighbor to do perform following tasks:

  - Group movies, from a sample, based on two features of their choice,
  - Determine what is likely the optimum number of cluster for their
    selected data.
  - Explore the clustered data further by interacting directly with the
    data.

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

## App Demo

A live demo of this application is available
[here](https://curiousjoe.shinyapps.io/HollywoodMovies2/) on the
[shinyapp.io](https://www.shinyapps.io) platform.
