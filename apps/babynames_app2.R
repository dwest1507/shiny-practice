# Creating an interactive data table app for baby names

library(shiny)
library(shinythemes)
library(babynames)
library(tidyverse)
library(DT)

ui <-
  fluidPage(
    titlePanel("Top 10 Popular Baby Names"),
    theme = shinytheme("darkly"),
    
    sidebarLayout(
      sidebarPanel(
        selectInput("sex", "Select sex", choices = c("M","F")),
        sliderInput("year", "Select year", 
                    min = min(babynames$year), 
                    max = max(babynames$year),
                    value = min(babynames$year))
      ),
      mainPanel(
        tabsetPanel(
          tabPanel(
            "Plot",
            plotOutput("plot")
          ),
          tabPanel(
            "Table",
            DTOutput("table")
          )
        )
      )
    )
  )

server <- function(input, output){
  top_10_table <- function(){
    data <- babynames %>% 
      filter(sex==input$sex,
             year==input$year) %>% 
      top_n(10)
  }
  
  output$plot <- renderPlot({
    ggplot(top_10_table()) +
      aes(x=name,y=prop)+
      geom_col()
  })
  
  output$table <- renderDT(top_10_table())
  
}

shinyApp(ui=ui, server=server)