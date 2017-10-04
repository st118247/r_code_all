library(shiny)
library(shinydashboard)
library(plotly)
library(ggplot2)
library(grDevices)
library(RMySQL)

# Define server logic for random distribution app ----
server <- function(input, output) {

  # Reactive expression to generate the requested distribution ----
  # This is called whenever the inputs change. The output functions
  # defined below then use the value computed from this expression
  d <- reactive({
    dist <- switch(input$dist,
                   norm = rnorm,
                   unif = runif,
                   lnorm = rlnorm,
                   exp = rexp,
                   rnorm)

    dist(input$n)
  })

  # Generate a plot of the data ----
  # Also uses the inputs to build the plot label. Note that the
  # dependencies on the inputs and the data reactive expression are
  # both tracked, and all expressions are called in the sequence
  # implied by the dependency graph.
  output$plot <- renderPlot({
    dist <- input$dist
    n <- input$n

    hist(d(),
         main = paste("r", dist, "(", n, ")", sep = ""),
         col = "#75AADB", border = "white")
  })

  # Generate a summary of the data ----
  output$summary <- renderPrint({
    summary(d())
  })

  # Generate an HTML table view of the head of the data ----
  output$table <- renderTable({
    head(data.frame(x = d()))
  })

  app_data_1 <- read.csv("churn_data.csv")
  pie_chart_churn_counts <- table(app_data_1$churn.value)
  pie_label <- c("Retained customers \n 4293","Churned customers \n 707")

  output$plotpie1 <- renderPlot({
    pie(pie_chart_churn_counts,labels = pie_label,main = "Total data composition of Churners")
  })
  

  mydb = dbConnect(MySQL(),user = 'root', password="zadmin1",dbname="db_churn",host='127.0.0.1')
  churn_data_region <- fetch(dbSendQuery(mydb,"select region,count(*) from tab_churn, tab_state_abbv where tab_state_abbv.abbrev = tab_churn.state group by region"),n=-1)
  dbClearResult(dbListResults(mydb)[[1]])
  
  output$summary1 <- renderPrint({
    summary(churn_data_region)
  })
  output$plotbar <- renderPlot({
    plot_ly(churn_data, x=churn_data$region, y=churn_data$`count(*)`,type = 'bar')
  })

}

shinyApp(ui = htmlTemplate("www/index.html"), server)
