library(shiny)
library(shinydashboard)

# Define UI for app that draws a histogram ----
ui <- fluidPage(
  
  # App title ----
  titlePanel("Dashboard Churn Prediciton System!"),
  
  # Sidebar layout with input and output definitions ----
  sidebarLayout(
    
    # Sidebar panel for inputs ----
    sidebarPanel(
      
      h3("Select Bins"),
      # Input: Slider for the number of bins ----
      sliderInput(inputId = "bins",
                  label = "Number of bins:",
                  min = 1,
                  max = 50,
                  value = 30),
      h3("Text Input")
      
    ),
    
    # Main panel for displaying outputs ----
    mainPanel(
      tags$div(
      h1("Main header h1"),
      p("Paragraph p1"),
            # Output: Histogram ----
      plotOutput(outputId = "distPlot")
      ),
      
      h2("Main header h2")

      

    )
  )
)