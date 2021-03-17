#' biv_analysis UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_biv_analysis_ui <- function(id){
  ns <- NS(id)
  tagList(
 
  )
}
    
#' biv_analysis Server Function
#'
#' @noRd 
mod_biv_analysis_server <- function(input, output, session){
  ns <- session$ns
 
}
    
## To be copied in the UI
# mod_biv_analysis_ui("biv_analysis_ui_1")
    
## To be copied in the server
# callModule(mod_biv_analysis_server, "biv_analysis_ui_1")
 
