library(tidyverse)
library(shiny)
library(leaflet)

mass_shootings <- read_csv("data/raw/Mother Jones - Mass Shootings Database, 1982 - 2020 - Sheet1.csv")

mass_shootings <- mass_shootings %>% 
  mutate(date = lubridate::mdy(str_remove(date, "\\d{2}(?=\\d{2}$)")))

ui <- bootstrapPage(
  theme = shinythemes::shinytheme('simplex'),
  leaflet::leafletOutput('map', width = '100%', height = '100%'),
  absolutePanel(top=10, right = 10, id = 'controls',
    sliderInput('nb_fatalities', 'Minimum Fatalaties', 1, 40, 10),
    dateRangeInput('date_range', 'Select Date', "2010-01-01", "2019-12-01")
  )
)

server <- function(input, output, session){
  rval_mass_shootings <- reactive({
    mass_shootings %>% 
      filter(
        date >= input$date_range[1],
        date <= input$date_range[2],
        fatalities >= input$nb_fatalities
      )
  })
  
  
  output$map <- leaflet::renderLeaflet({
    rval_mass_shootings() %>% 
      leaflet() %>% 
        addTiles() %>% 
        setView(-98.5, 39.82, zoom = 5) %>% 
        addCircleMarkers(
          popup = ~ summary,
          radius = ~ fatalities,
          fillColor = 'red', color = 'red', weight = 1
        )
      
  })
}

shinyApp(ui=ui, server=server)