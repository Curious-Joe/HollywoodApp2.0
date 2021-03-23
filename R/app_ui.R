#' The application User-Interface
#' 
#' @param request Internal parameter for `{shiny}`. 
#'     DO NOT REMOVE.
#' @import shiny shinydashboard plotly
#' @noRd
app_ui <- function(request) {
  tagList(
    # Leave this function for adding external resources
    golem_add_external_resources(),
    
    # List the first level UI elements here 
    shinydashboard::dashboardPage(
    
    # 1.0 SIDEBAR ----
    # +++++++++++++++++++++++++++++++++++++++++-----
    sidebar = shinydashboard::dashboardSidebar(
      
      # 1.1 Sidebar tab names ----
      # creating sidebar tabs
      shinydashboard::sidebarMenu(
        menuItem('Summary', tabName = 'dashboard', icon = icon("table")),
        hr(),
        menuItem('Bivariate Relations', tabName = 'plots', icon = icon('binoculars')),
        hr(),
        menuItem('Clustering Model', tabName = 'model', icon = icon('bar-chart-o')),
        hr(),
        menuItem('Data', tabName = 'data', icon = icon('clipboard')),
        hr(),
        
        # 1.2 Sidebar genre search ----
        # subsetting inputs in sidebar - data tab
        h3("Subsetting"),    
        selectInput(inputId = "selected_genre",
                    label = "Select movie type(s):",
                    choices = unique(movies$genre),
                    selected = "Comedy", multiple = TRUE),
        
        hr(),
        
        # 1.3 Sidebar credit ----
        # contact info:
        h4("Get connected: ", 
           tags$a(icon('linkedin'), href="https://www.linkedin.com/in/arafath-hossain/")),
        # shiny and r credit
        h5("Built with",
           img(src = "https://www.rstudio.com/wp-content/uploads/2014/04/shiny.png", height = "30px"),
           "by",
           img(src = "https://www.rstudio.com/wp-content/uploads/2014/07/RStudio-Logo-Blue-Gray.png", height = "30px"),
           ".")
      )
    ),

    # 2.0 BODY ----
    # ++++++++++++++++++++++++++++++++++++++----
    body= shinydashboard::dashboardBody(
      
      # 2.1 Body: Info boxes ----
      tabItems(
        tabItem(tabName = 'dashboard', mod_summary_ui("summary_ui_tab1")),
        tabItem(tabName = 'plots', mod_biv_analysis_ui("biv_analysis_ui_1")),
        tabItem(tabName = "model"),
        tabItem(tabName = 'data')
      )
    ),
    
    # 3.0 HEADER ----
    # +++++++++++++++++++++++++++++++++++++++++++++++++++++++++----
    header = shinydashboard::dashboardHeader(
      title = 'Hollywood Movies',
      dropdownMenu(type = "notification", badgeStatus = "warning",
                   notificationItem(text = textOutput("notification"),
                                    icon = icon("warning")
                                    )
                   )
      ),
    
    )
    
  )
}

#' Add external Resources to the Application
#' 
#' This function is internally used to add external 
#' resources inside the Shiny application. 
#' 
#' @import shiny
#' @importFrom golem add_resource_path activate_js favicon bundle_resources
#' @noRd
golem_add_external_resources <- function(){
  
  add_resource_path(
    'www', app_sys('app/www')
  )
 
  tags$head(
    favicon(),
    bundle_resources(
      path = app_sys('app/www'),
      app_title = 'HollywoodMovies2.0'
    )
    # Add here other external resources
    # for example, you can add shinyalert::useShinyalert() 
  )
}

