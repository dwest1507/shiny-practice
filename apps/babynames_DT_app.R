# Creating an interactive data table app for baby names

library(shiny)
library(babynames)
library(tidyverse)
library(DT)

ui <-
  fluidPage(
    titlePanel("Top 10 Popular Baby Names"),
    
    sidebarLayout(
      sidebarPanel(
        selectInput("sex", "Select sex", choices = c("M","F")),
        sliderInput("year", "Select year", 
                    min = min(babynames$year), 
                    max = max(babynames$year),
                    value = min(babynames$year))
      ),
      mainPanel(
        DTOutput("table")
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
  
  output$table <- renderDT(top_10_table())
  
}

shinyApp(ui=ui, server=server)