#' biv_analysis UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
#' @import ggplot2
#' 
mod_biv_analysis_ui <- function(id){
  ns <- NS(id)
  
  # 1.1 VARIABLES ----
  # select input choices
  choices <- c("Gross earnings" = "gross",
    "Duration" = "duration",
    "Budget" = "budget",
    "Facebook likes for csts" = "cast_facebook_likes",
    "Total audience votes" = "votes",
    "No of reviews" = 'reviews',
    "Rating" = 'rating')
  
  
  tagList(
    
    fluidRow( 
      # 1.2 Scatterplot ----
      column(width = 9,
             wellPanel(
               h3(textOutput(ns("scatterplot_des"))),
               h6("Select points by dragging mouse pointer to see the details below the plot"),
               plotOutput(ns("scatterplot"), 
                          # click = ns('plot_click'),
                          brush = brushOpts(id = ns("brush_scatter"), 
                                            direction = "xy",resetOnNew = TRUE),
                          height =  '350px')
                  )
             ),
      
      # 1.3 Input panel ----
      column(width = 3,
             wellPanel(
               
               h3("Plotting inputs"),
               selectInput(inputId = ns("y"),
                           label = "Y-axis:",
                           choices = choices,
                           selected = "gross"),
               # Select variable for x-axis
               selectInput(inputId = ns("x"),
                           label = "X-axis:",
                           choices = choices,
                           selected = "budget"),
               h4("Summary Statistics"),
               textOutput(ns('med_x')),
               textOutput(ns('med_y')),
               textOutput(ns('cor')),
               h6("* Correlation coefficient shouldn't be interpreted 
                  in case of no linear relation")
               )
             )
      ),
    
    # 1.4 Selected movies from plot ----
    fluidRow(
      column(width = 12,
             wellPanel(
               
               h3("Selected Movies "),
               DT::dataTableOutput(outputId = ns("brush_points")) 
                )
             )
    )
 
  )
}
    
#' biv_analysis Server Function
#'
#' @noRd 
mod_biv_analysis_server <- function(input, output, session,
                                    data, genre){
  ns <- session$ns
  
  # 1.0 BRUSH POINTS ----
  
  # 1.1 Storing brushed points ----
  # reactive values to store x and y co-ordinates from brush
  brush_scatter <- reactiveValues(x = NULL, y = NULL)
  
  # # When a double-click happens, check if there's a brush on the plot.
  # If so, zoom to the brush bounds; if not, reset the zoom.
  observe({
    brush <- input$brush_scatter
    if (!is.null(brush)) {
      brush_scatter$x <- c(brush$xmin, brush$xmax)
      brush_scatter$y <- c(brush$ymin, brush$ymax)
      
    } else {
      brush_scatter$x <- NULL
      brush_scatter$y <- NULL
    }
  })
  
  # 1.2 Rendering table from brushed points ----
  output$brush_points <- DT::renderDataTable({
    tbl <- shiny::brushedPoints(data(), input$brush_scatter, 
                                input$x, input$y) 
      
    if (nrow(tbl) == 0)
      return()
    tbl
  })
  
  # 2.0 SCATTER PLOT ----
  
  # 2.1 X, Y Labels ----
  # upper case converted x and y variables
  x <- reactive({ stringr::str_to_title(input$x)})
  y <- reactive({ stringr::str_to_title(input$y)})
  
  # 2.2 Scatterplot label ----
  # Create scatterplot object the plotOutput function is expecting 
  output$scatterplot_des <- renderText({
    glue::glue("{x()} Vs {y()} of 
           {nrow(data())} {genre()} movies.")
  })
  
  # 2.3 Plot ----
  output$scatterplot <- renderPlot({
    x_max <- reactive({max(data()[, input$x], na.rm = T)})
    x_labels <- reactive({
      if(x_max() > 10000){
        label = comma
      }else {
        label = waiver()
      }
    })
    
    y_max <- reactive({max(data()[, input$y], na.rm = T)})
    y_labels <- reactive({
      if(y_max() > 10000){
        label = comma
      } else {
        label = waiver()
      }
    })
    
    ggplot2::ggplot(data = data(), 
                    ggplot2::aes_string(x = input$x, y = input$y, 
                                                color = 'genre')) +
      ggplot2::geom_point() + 
      ggplot2::scale_x_continuous(n.breaks = 10, labels = x_labels()) + 
      ggplot2::scale_y_continuous(n.breaks = 10, labels = y_labels()) + 
      ggplot2::labs(x = x(), 
                    y = y(), 
                    color = 'Genre') + 
      ggplot2::theme_minimal() +
      ggplot2::theme(legend.position = "none") 
  })
  
  # 3.0 SUMMARY ----
  # 3.1 Median values ----
  output$med_x = renderText({
    med = median(data()[,input$x], na.rm = TRUE)
    med = if(med >= 500000){
      comma(med)
    } else {
      med
    }
    
    paste("2. Median of", y(), "=", med)
  })
  
  output$med_y = renderText({
    med = median(data()[,input$y], na.rm = TRUE)
    med = if(med >= 500000){
            comma(med)
          } else {
            med
          }
    
    paste("2. Median of", y(), "=", med)
  })
  
  # 3.2 Correlation value ----
  output$cor = renderText({
    paste("3. Correlation of", x(), "and", y(), "=", 
          round(cor(data()[,input$x], data()[,input$y]),2))
  })
  
 
}
    
## To be copied in the UI
# mod_biv_analysis_ui("biv_analysis_ui_1")
    
## To be copied in the server
# callModule(mod_biv_analysis_server, "biv_analysis_ui_1")
 
