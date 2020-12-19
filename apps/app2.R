# Creating an app that explores the baby names data set

library(shiny)
library(babynames)
library(ggplot2)

ui <- fluidPage(
  textInput("name","Enter name here:", "David"),
  plotOutput("trend")
)

server <- function(input, output, session){
  output$trend <- renderPlot({
    ggplot()
  })
}

shinyApp(ui=ui, server=server)