library(shiny)

# Set up user interface
ui <- fluidPage(
  textInput("name", "Enter a name:"),
  textOutput("q")
)

# Set up server
server <- function(input,
                   output,
                   session){
  output$q <- renderText({
    paste0("Do you prefer dogs or cats, ",
          input$name,"?")
  })
}

# Run Shiny App
shinyApp(ui = ui, server = server)