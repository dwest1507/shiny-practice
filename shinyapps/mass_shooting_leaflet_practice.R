library(tidyverse)
library(shiny)
library(leaflet)

mass_shootings <- read_csv("data/raw/Mother Jones - Mass Shootings Database, 1982 - 2020 - Sheet1.csv")

mass_shootings <- mass_shootings %>% 
  mutate(date = lubridate::mdy(str_remove(date, "\\d{2}(?=\\d{2}$)")))

mass_shootings %>% 
  leaflet() %>% 
  addTiles() %>% 
  setView(-98.5, 39.82, zoom = 5) %>% 
  addCircleMarkers(
    popup = ~ summary,
    radius = ~ fatalities,
    fillColor = 'red', color = 'red', weight = 1
  )