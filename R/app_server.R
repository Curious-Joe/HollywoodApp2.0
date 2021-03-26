#' The application server-side
#' 
#' @param input,output,session Internal parameters for {shiny}. 
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_server <- function( input, output, session ) {

  
  movies_selected <- reactive({
    req(input$selected_genre, cancelOutput = FALSE) # ensure availablity of value before proceeding
    dplyr::filter(movies, genre %in% input$selected_genre)
  })
  
  # Header notication
  output$notification = renderText({
    input$selected_genre
  })
  
  # List the first level callModules here
  callModule(mod_summary_server, "summary_ui_tab1",  data = movies_selected)
  callModule(mod_summary_server, "summary_ui_tab2",  data = movies_selected)
  callModule(mod_biv_analysis_server, "biv_analysis_ui_1", 
             data = movies_selected, genre = reactive(input$selected_genre))
}
