#' summary UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
#' @import shinydashboard
#' 
mod_summary_ui <- function(id){
  ns <- NS(id)
  tagList(
    
    fluidRow(
      column(
        width = 12, 
        
        # 1.0 INFO BOXES ----
        mod_infoBox_ui(ns("infoBox_ui_1")),
        mod_infoBox_ui(ns("infoBox_ui_2")),
        mod_infoBox_ui(ns("infoBox_ui_3")),
        mod_infoBox_ui(ns("infoBox_ui_4")),
    )),
    
  
    fluidRow(
      # 1.2 TIME SERIES PLOT ----
      column(width = 7,
              h3("Number of movies produced over the years"),
              h6("Select any area (using mouse) on the plot to look it closely in the plot to the right side"),
              plotOutput(outputId = ns("time_series"),
                         brush = brushOpts(id = ns("brush_zoom"), 
                                           direction = "x",resetOnNew = TRUE)
                    )
             ),

      # 1.3 ZOOMED PLOT ----
      column(width = 5,
             wellPanel(
               h4("Zoomed in area of the plot"),
               h6("Hover over the bars to see the information in tooltip"),
               plotlyOutput(outputId = ns("time_series_zoom"))
             )
      )
    ),
    
    hr(),
    
    # 2.4 VALUE BOX ----
    # creating value boxes in dashboard body (bottom)
    fluidRow(
      box(width = 12,
        h4(tags$b("Performance of selected genre(s) vs overall performance")),
        h6("Green = performing better than overall,  Red = performing worse than overall"),
        mod_valueBox_ui(ns("valueBox_ui_1")),
        mod_valueBox_ui(ns("valueBox_ui_2")),
        mod_valueBox_ui(ns("valueBox_ui_3")),
        mod_valueBox_ui(ns("valueBox_ui_4"))
      )
    )
 
  )
}
    
#' summary Server Function
#'
#' @noRd 
mod_summary_server <- function(input, output, session, data
                               # , selected_genre
                               ){
  ns <- session$ns

  # x and y as reactive expressions
  # x <- reactive({ str_to_title(input$x)})
  # y <- reactive({ str_to_title(input$y)})
  
  
  # 2.0 INFO BOXES ----
  box1 <- callModule(mod_infoBox_server, "infoBox_ui_1",
                    title  = "Highest grossing movie", icon = "film",
                    data = data,
                    based_on = "gross", target = "title")
  
  box2 <- callModule(mod_infoBox_server, "infoBox_ui_2",
                     title  = "Highest grossing director", icon = "film",
                     data = data,
                     based_on = "gross", target = "director")
  
  box3 <- callModule(mod_infoBox_server, "infoBox_ui_3",
                     title  = "Highest profit movie", icon = "film",
                     data = data,
                     based_on = "gross", target = "title")
  
  box4 <- callModule(mod_infoBox_server, "infoBox_ui_4",
                     title  = "Highest profit director", icon = "film",
                     data = data,
                     based_on = "gross", target = "director")
  
  
  
  # 2.1 TIME SERIES PLOT ----
  # # creating time series plot
  output$time_series = renderPlot({
    data() %>%  dplyr::count(year, genre) %>%
      ggplot2::ggplot(ggplot2::aes(x = year, y = n, fill = genre)) +
      ggplot2::geom_bar( position = 'dodge', stat = "identity") +
      ggplot2::scale_x_continuous(breaks = seq(from = 1920, to = 2016, by = 8)) +
      ggplot2::labs(x = "Year", y = "Total", fill = "Genre") + 
      ggplot2::theme_minimal()

  })
  
  # 2.3 ZOOMED PLOT ----
  ranges2 <- reactiveValues(x = NULL, y = NULL)

  output$time_series_zoom <- renderPlotly({
    p <- data() %>%  dplyr::count(year, genre) %>%
      ggplot2::ggplot(ggplot2::aes(x = year, y = n, fill = genre,
                                   text = glue::glue(
                                     "Genre: {genre} \nYear: {year} \nTotal: {n}")
      )) +
      ggplot2::geom_bar(position = 'dodge', stat = "identity") +
      ggplot2::coord_cartesian(xlim = ranges2$x, ylim = ranges2$y, expand = FALSE) +
      ggplot2::labs(x = "Year" , y = "Total") + 
      ggplot2::theme_minimal() +
      ggplot2::theme(legend.position = "none") 
    
    p %>% plotly::ggplotly(tooltip = "text")
  })

  # # When a double-click happens, check if there's a brush on the plot.
  # # If so, zoom to the brush bounds; if not, reset the zoom.
  observe({
    brush <- input$brush_zoom
    if (!is.null(brush)) {
      ranges2$x <- c(brush$xmin, brush$xmax)
      ranges2$y <- c(brush$ymin, brush$ymax)

    } else {
      ranges2$x <- NULL
      ranges2$y <- NULL
    }
  })
  
  # 2.4 VALUE BOX ----
  valuebox1 <- callModule(mod_valueBox_server, "valueBox_ui_1",
                          subtitle = "Median Gross Earning (mln)", 
                          icon = "dollar", 
                          data = data, target = "gross")
  
  valuebox2 <- callModule(mod_valueBox_server, "valueBox_ui_2",
                          subtitle = "Median Gross Budget (mln)", 
                          icon = "dollar", 
                          data = data, target = "budget")
  
  valuebox3 <- callModule(mod_valueBox_server, "valueBox_ui_3",
                          subtitle = "Median Gross Profit (mln)", 
                          icon = "dollar", 
                          data = data, target = "profit")
  
  valuebox4 <- callModule(mod_valueBox_server, "valueBox_ui_4",
                          subtitle = "Median Viewer Rating", 
                          icon = "star", 
                          data = data, target = "rating")
  
  
  # creating value box for dashboard tab page (bottom)
  # output$med_grossing = renderValueBox({
  #   valueBox(
  #     value = round(median((movies_selected()[,"gross"]))/1000000,1),
  #     subtitle = "Median gross earnings (mln)",
  #     icon = icon("dollar"),
  #     color = if(median((movies_selected()[,"gross"])) > gross){
  #       "green"
  #     } else {
  #       "red"
  #     }
  #   )
  # })
  
  # output$med_budget = renderValueBox({
  #   valueBox(
  #     value = round(median((movies_selected()[,"budget"]))/1000000,1),
  #     subtitle = "Median gross budget (mln)",
  #     icon = icon("dollar"),
  #     color = if(median((movies_selected()[,"budget"])) > budget){
  #       "green"
  #     } else {
  #       "red"
  #     }
  #   )
  # })
  # 
  # output$med_profit = renderValueBox({
  #   valueBox(
  #     value = round(median(movies_selected()$gross-movies_selected()$budget)/1000000,1),
  #     subtitle = "Median profit (mln)",
  #     icon = icon("dollar"),
  #     color = if(median((movies_selected()[,"gross"])-(movies_selected()[,'budget'])) > profit){
  #       "green"
  #     } else {
  #       "red"
  #     }
  #   )
  # })
  # 
  # output$med_rating = renderValueBox({
  #   valueBox(
  #     value = median((movies_selected()[,"rating"])),
  #     subtitle = "Median viewer rating",
  #     icon = icon("star"),
  #     color = if(median((movies_selected()[,"rating"])) > rating){
  #       "green"
  #     } else {
  #       "red"
  #     }
  #   )
  # })
  # 
}
    
## To be copied in the UI
# mod_summary_ui("summary_ui_1")
    
## To be copied in the server
# callModule(mod_summary_server, "summary_ui_1")
 
