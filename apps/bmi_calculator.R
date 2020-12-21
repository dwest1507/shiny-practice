# Body Mass Index calculator

library(shiny)
library(shinythemes)

ui <- fluidPage(
  titlePanel("BMI Calculator"),
  theme = shinytheme("darkly"),
  
  sidebarLayout(
    sidebarPanel(
      textInput("name", "Enter your name"),
      numericInput("height", "Enter your height in meters", 1.5, step = 0.1),
      numericInput("weight", "Enter your weight in Kilograms", 60, step = 5),
      actionButton("calculate","Show BMI"),
      actionButton("help","Help")
    ),
    mainPanel(
      textOutput("result")  
    )
  )
)

server <- function(input, output, session){
  rval_bmi <- eventReactive(
    input$calculate,
    {input$weight/input$height^2})
  
  output$result <- renderText({
    paste0("Hi ",
           input$name,
           "! Your BMI is ",
           round(rval_bmi(),1))
  })
  
  observeEvent(input$help,{
    showModal(
      modalDialog("Body Mass Index is a simple calculation using a person's 
                  height and weight. The formula is BMI = kg/m2 where kg is 
                  a person's weight in kilograms and m2 is their height in 
                  metres squared. A BMI of 25.0 or more is overweight, while 
                  the healthy range is 18.5 to 24.9."))
  })
  
}

shinyApp(ui=ui, server=server)