#' valueBox UI Function
#'
#' @description Ui function to create the value boxes showing performance at the bottom of the Summary tab.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#'
#' @importFrom shiny NS tagList 
#' 
mod_valueBox_ui <- function(id){
  ns <- NS(id)
  tagList(
    valueBoxOutput(outputId = ns("value_box"), width = 3),
  )
}
    
#' valueBox Server Function
#' 
#' @description Server function to populate value boxes created by mod_valueBox_ui().
#'
#' 
#' @param id,input,output,session Internal parameters for {shiny}
#' @param subtitle Title to be used in the info box
#' @param icon Icon to be used in the box
#' @param data Reactive data frame to be used to populate the content inside the box 
#' @param target Which information about the top performer to collect
#' 
mod_valueBox_server <- function(input, output, session,
                                subtitle, icon, data, target){
  ns <- session$ns
 
  output$value_box = renderValueBox({
    
    value <- median(data()[, target], na.rm = T)
    
    valueBox(
      value = if(icon == "dollar"){
        value <- dollar(value)
      } else{
        value
      },
      subtitle = subtitle,
      icon = icon(icon),
      color = if(value > median(movies[,target], na.rm = T)){
        "green"
      } else {
        "red"
      }
    )
  })
}
 
