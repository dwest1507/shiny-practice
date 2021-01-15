# Creating an app that explores the baby names data set

library(shiny)
library(babynames)
library(tidyverse)

ui <- fluidPage(
  sidebarLayout(
    sidebarPanel(
      textInput("name","Enter name here:", "David"),
    ),
    mainPanel(
      plotOutput("trend")
    )
  )
)

server <- function(input, output, session){

  output$trend <- renderPlot({
    data <- babynames %>% 
      filter(name == input$name)
    
    ggplot(data) +
      aes(x=year, y=prop, color=sex) +
      geom_line()
  })
}

shinyApp(ui=ui, server=server)