#' cluster UI Function
#'
#' @description A shiny Module to populate the contents for the tab showing clustering.
#'
#' @param id Internal parameters for {shiny}.
#'
#' @importFrom shiny NS tagList
mod_cluster_ui <- function(id) {
  ns <- NS(id)

  # 1.0 Input choices ----
  choices <- c(
    "Gross earnings" = "gross",
    "Duration" = "duration",
    "Budget" = "budget",
    "Facebook likes for csts" = "cast_facebook_likes",
    "Total audience votes" = "votes",
    "No of reviews" = "reviews",
    "Rating" = "rating"
  )

  tagList(
    fluidRow(
      
      # 1.1 Tab Intro ----
      column(
        width = 12,
        h3("Find Out Similar Movies Using K-NN"),
        h4(
          HTML(
            paste0(
              a(
                href = "https://en.wikipedia.org/wiki/K-nearest_neighbors_algorithm",
                "K Nearest Neighbors (K-NN)"
              ),
              " is a commonly used algorithm to cluster observations. In this case we'll use K-NN to
                        group movies in the user decided number of groups and based on the features selected by the user."
            ))),
            h6(
              tags$b("Notes:"),
            "For ease of visualization, maximum no of movies to cluster is restricted to 200,
            and max of 2 variables can be used for clustring.")
          )
      ),
    hr(),
    fluidRow(
      # 1.2 Inputs ----
      column(
        width = 4,
        wellPanel(
          div(
            h4(tags$b("Choose Number of Movies:")),
            sliderInput(inputId = ns("sample_size"), 
                        label = NULL,
                        min = 10, max = 200, value = 40),
            h4(tags$b("Choose Variables:")),
            selectizeInput(
              inputId = ns("var1"),
              label = "Variable 01",
              choices = choices,
              selected = "gross"
            ),
            selectizeInput(
              inputId = ns("var2"),
              label = "Variable 02",
              choices = choices,
              selected = "budget"
            )
            ),
          hr(),
          div(
            h4(tags$b("Deciding Optimum Number of Clusters: ")),
            p(
              HTML(paste0(
                "We'll use a method called, ",
                a(
                  href = "https://en.wikipedia.org/wiki/Elbow_method_(clustering)",
                  "Elbow Method"
                ),
                " to choose number of cluster. Briefly, it's a heuristic to choose a cut-off
                             point beyond which return or gain is no longer high enough to justify the cost."
              )), 
              br(),
              "From the Elbow Plot choose the point from where the curve starts to flatten."
              ),
            numericInput(inputId = ns("n_center"), 
                         label = "Input number of clusters",value = 4
                         ),
            plotOutput(outputId = ns("elbow"), height = "250px"),
            h6("*WCSS = Within cluster sum of squares"))
          )
        ),

      column(
        width = 8,
        wellPanel(
          h4(tags$b("Clusters")),
          # 1.3 Cluster plot ----
          plotOutput(outputId = ns("cluster_plot")),
          
          hr(),
          
          # 1.4 Cluster data ----
          h4(tags$b("Detail Data with Cluster")),
          DT::dataTableOutput(outputId = ns("clustered_movies"))
        )
      )
    )
  )
}

#' cluster Server Function
#' 
#' @description A server module that populates the cluster tab. 
#' 
#' @param input,output,session Internal parameters for {shiny}.
#' @param data Reactive dataframe that is filtered based on user selected movie genre.
#' 

mod_cluster_server <- function(input, output, session,
                               data) {
  ns <- session$ns
  
  # 1.1 Adjusting sample size range ----
  observe({
    max = nrow(data())
    updateSliderInput(session,"sample_size",
                      max = ifelse(max >= 200, 200, max),
                      min = ifelse(max < 10, max, 10))
  })
  
  # 1.2 Subset data based on user inputs ----
  cluster_data <- reactive({
    data <- data() %>%
      dplyr::select(input$var1, input$var2) %>%
      utils::head(input$sample_size)
    
    data <- scale(data) # normalizing data (mean 0, sd = 1)
  })
  
  # 1.3 Uppercasing input vars ----
  # x and y as reactive expressions
  var_1 <- reactive({ stringr::str_to_title(input$var1)})
  var_2 <- reactive({ stringr::str_to_title(input$var2)})
  
  # 1.4 Elbow Plot ----
  output$elbow = renderPlot({
    set.seed(6)
    wcss = vector()
    for (i in 1:9) wcss[i] = sum(stats::kmeans(cluster_data(), i)$withinss)
    plot(1:9,
         wcss,
         type = 'b',
         main = paste('Elbow Chart'),
         xlab = 'Number of clusters',
         ylab = 'WCSS')
  })
  
  # 1.5 Cluster calculation ----
  cluster_vec = reactive({
    stats::kmeans(cluster_data(), input$n_center)$cluster
  })
  
  # 1.6 Cluster Plot ----
  output$cluster_plot = renderPlot({
    
    set.seed(6)
     
    cluster::clusplot(cluster_data(),
                      cluster_vec(),
                      lines = 0,
                      shade = FALSE,
                      color = TRUE,
                      labels = 2,
                      plotchar = FALSE,
                      span = TRUE,
                      main = paste("Clusters of movies (x and y values are scaled)"),
                      xlab = var_1(),
                      ylab = var_2())
  })
  
  # 1.6 Cluster data table----
  output$clustered_movies = DT::renderDataTable(server = FALSE, {
    movies = data() %>%
              utils::head(input$sample_size) %>%
      dplyr::mutate(Cluster = as.character(cluster_vec())) %>%
      dplyr::relocate(Cluster, .before = everything())
    
    DT::datatable(movies, 
                  rownames = F,
                  style = "default",
                  filter = "top",
                  selection = "none",
                  options = list(
                    pageLength = 5, 
                    dom = "Bfrtip",
                    scrollX = TRUE
                  ))
  })
  
  
}

## To be copied in the UI
# mod_cluster_ui("cluster_ui_1")

## To be copied in the server
# callModule(mod_cluster_server, "cluster_ui_1")
