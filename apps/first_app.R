library(shiny)

# Set up user interface
ui <- fluidPage(
  textInput("name", "Enter a name:"),
  textOutput("question")
)

# Set up server
server <- function(input,
                   output,
                   session){
  output$question <- renderText({
    paste0("Do you prefer dogs or cats, ",
          input$name,"?")
  })
}

# Run Shiny App
shinyApp(ui = ui, server = server)