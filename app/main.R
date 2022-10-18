box::use(
  shiny[fluidPage, sidebarLayout, tags, renderText, sidebarPanel, mainPanel, textInput, textOutput, moduleServer, NS, ],
  shinyBS[createAlert,closeAlert, bsAlert]
)
# Run the `.onAttach` hook (shinyBS uses it to add a Shiny resource path).
suppressWarnings(library(shinyBS))

#' @export
ui <- function(id) {
  ns <- NS(id)
  fluidPage(
    sidebarLayout(
      sidebarPanel(textInput(ns("num1"), NULL, value = 100),
                   "divided by",
                   textInput(ns("num2"), NULL, value = 20),
                   "equals",
                   textOutput(ns("exampleOutput"))
                   ),
      mainPanel(
        bsAlert(ns("alert"))
      )
    )
  )
}

#' @export
server <- function(id) {
  moduleServer(id, function(input, output, session) {
    output$exampleOutput <- renderText({

      num1 <- as.numeric(input$num1)
      num2 <- as.numeric(input$num2)

      if(is.na(num1) | is.na(num2)) {
        createAlert(session,
                    session$ns("alert"),
                    "exampleAlert",
                    title = "Oops",
                    content = "Both inputs should be numeric.",
                    append = FALSE
                    )
      } else if(num2 == 0) {
        createAlert(session,
                    session$ns("alert"),
                    "exampleAlert",
                    title = "Oops",
                    content = "You cannot divide by 0.",
                    append = FALSE
                    )
      } else {
        closeAlert(session, "exampleAlert")
        return(num1/num2)
      }

    })
  })
}
