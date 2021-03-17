#' cluster UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_cluster_ui <- function(id){
  ns <- NS(id)
  tagList(
 
  )
}
    
#' cluster Server Function
#'
#' @noRd 
mod_cluster_server <- function(input, output, session){
  ns <- session$ns
 
}
    
## To be copied in the UI
# mod_cluster_ui("cluster_ui_1")
    
## To be copied in the server
# callModule(mod_cluster_server, "cluster_ui_1")
 
