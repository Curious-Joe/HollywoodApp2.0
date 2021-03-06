
<!-- README.md is generated from README.Rmd. Please edit that file -->

# HollywoodMovies2.0

<!-- badges: start -->

[![Lifecycle:
stable](https://img.shields.io/badge/lifecycle-stable-brightgreen.svg)](https://www.tidyverse.org/lifecycle/#stable)
<!-- badges: end -->

HollywoodMovies2.0 is a Shiny app that has been re-built using `golem`
framework. Among many other benefits, `golem` builds a Shiny app as an R
package thus it’s quite easy to ensure the robustness of the
application. Learn more here about `golem`.

The primary goal of this HollywoodMovies2.0 is to use Shiny to achieve
two things:

  - Interactively explore the data, and
  - Enabling user to interact with an algorithm: K-Nearest Neighbors
    (KNN) to have a better understanding of the data and the KNN model.

## Description of the App

This application has three tabs. The main contents are presented in the
tabs. Other than the tabs, the sidebar serves two purposes:

  - Works as a tab navigation panel,
  - Provides users a way to select movie genre(s) that they would like
    to explore.

Here’s a brief summary about what tasks can be performed in each of the
tabs:

**Summary:**

  - Top 4 boxes gives a summary of *Highest Grossing* and *Highest
    Profit* generating movie title and director name,
  - The first bar plot shows yearly total movie production numbers.
    Users can zoom in on this plot and see the zoomed-in plot on right,
  - The second plot bar is the zoomed-in plot,
  - The boxes at the bottom provide median value of *Gross Earning*,
    *Gross Budget*, *Gross Profit*, and *User Rating* of the movies
    selected by the users. The color of the boxes represents a
    comparison between the overall performance of all movies across all
    genres vs the performance of the movies from the genre selected by
    the user.

**Bivariate Relations:**

  - The plot shows a scatter plot for the two variables selected by the
    users using the selectors on the right pane. Users can select any
    number of points on this plot by using a mouse. Detail data of the
    selected points are shown in the table below,
  - Right below the selector panes users get a summary statistics of the
    variables chosen,
  - A data table showing detail about the points selected by the user on
    the scatter plot.

**Clustering Model:**

  - The left pane provides users with selectors to select a subset of
    movies. The maximum is set fixed at 200 movies to make sure faster
    performance,
  - Users can select two variables of their choice to run clustering.
    The total number of variables are set fixed at 2 to make sure a 2D
    plot can be drawn to show the clusters,
  - Users can select optimum numbers of clusters to create based on
    looking at the `Elbow Plot`,
  - Right pane shows the clusters with the ID of the clusters and row
    number of the movies,
  - The data table at the bottom shows the movie details along with
    their cluster numbers. Filter the movies based on cluster and see
    the actual data of the movies.

## Installation

If you are interested you can install this application as an R library.

``` r
# install.packages("remotes")
remotes::install_github("Curious-Joe/HollywoodApp2.0")
# run the shiny app
HollywoodMovies2.0::run_app()
```

## App Demo

A live demo of this application is available
[here](https://curiousjoe.shinyapps.io/HollywoodMovies2/) on the
[shinyapp.io](https://www.shinyapps.io) platform.
