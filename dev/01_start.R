# Building a Prod-Ready, Robust Shiny Application.
# 
# README: each step of the dev files is optional, and you don't have to 
# fill every dev scripts before getting started. 
# 01_start.R should be filled at start. 
# 02_dev.R should be used to keep track of your development during the project.
# 03_deploy.R should be used once you need to deploy your app.
# 
# 
########################################
#### CURRENT FILE: ON START SCRIPT #####
########################################

## Fill the DESCRIPTION ----
## Add meta data about your application
golem::fill_desc(
  pkg_name = "HollywoodMovies2.0", # The Name of the package containing the App 
  pkg_title = "Explore Knn with Hollywood Movies", # The Title of the package containing the App 
  pkg_description = "This Shiny app demonstrte how K nearest neighbor can be used to group 
  observations based on their features. For demonstration purpose, a dataset of Hollywood movies 
  have been used. Using the app, a user can explore profitability of the movies historically, and 
  decide which movies are closest in nature based on their chosen criteria.", # The Description of the package containing the App 
  author_first_name = "Arafath", # Your First Name
  author_last_name = "Hossain", # Your Last Name
  author_email = "a.h.fahad90@gmail.com", # Your Email
  repo_url = NULL # The URL of the GitHub Repo (optional) 
)     

## Set {golem} options ----
golem::set_golem_options()

## Create Common Files ----
## See ?usethis for more information
usethis::use_mit_license( copyright_holder = "Arafath Hossain" )  # You can set another license here
usethis::use_readme_rmd( open = FALSE )
usethis::use_code_of_conduct()
usethis::use_lifecycle_badge( "Stable" )
# usethis::use_news_md( open = FALSE )

## Use git ----
usethis::use_git()

## Init Testing Infrastructure ----
## Create a template for tests
golem::use_recommended_tests()

## Use Recommended Packages ----
golem::use_recommended_deps()

## Favicon ----
# If you want to change the favicon (default is golem's one)
golem::remove_favicon()
golem::use_favicon("inst/app/www/curious-joe.ico") # path = "path/to/ico". Can be an online file.

## Add helper functions ----
golem::use_utils_ui()
golem::use_utils_server()

# You're now set! ----

# go to dev/02_dev.R
rstudioapi::navigateToFile( "dev/02_dev.R" )

