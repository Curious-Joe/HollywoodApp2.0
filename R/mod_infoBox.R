#' infoBox UI Function
#'
#' @description Ui function to create the information boxes showing top performers at the top of the Summary tab.
#'
#' @param id Internal parameters for {shiny}.
#'
#' @importFrom shiny NS tagList
#'
mod_infoBox_ui <- function(id) {
  ns <- NS(id)
  tagList(
    shinydashboard::infoBoxOutput(
      outputId = ns("info_box"), width = 3
    )
  )
}

#' infoBox Server Function
#'
#' @description Server function to populate information boxes created by mod_infoBox_ui().
#'
#'
#' @param input,output,session Internal parameters for {shiny}
#' @param title Title to be used in the info box
#' @param icon Icon to be used in the box
#' @param data Reactive data frame to be used to populate the content inside the box
#' @param based_on Based on which factor to calculate the best performer
#' @param target Which information about the top performer to collect
#'
mod_infoBox_server <- function(input, output, session,
                               title, icon, data, based_on, target) {
  ns <- session$ns

  output$info_box <- shinydashboard::renderInfoBox({
    infoBox(
      title = title, icon = icon(icon),
      value = data() %>%
        dplyr::top_n(1, !!dplyr::sym(based_on)) %>%
        dplyr::pull(!!dplyr::sym(target))
    )
  })
}

## To be copied in the UI
# mod_infoBox_ui("infoBox_ui_1")

## To be copied in the server
# callModule(mod_infoBox_server, "infoBox_ui_1")
