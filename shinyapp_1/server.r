library(shiny)
library(shinydashboard)
library(plotly)

# Define server logic required to draw a histogram ----
server <- function(input, output) {
  app_data <- read.csv("churn_data.csv")
  pie_chart_churn_counts <- table(app_data$churn.value)
  #pie_chart_labels <- paste(table(app_data$churn.value))
  counts_state_churn_1 <- table(app_data$churn.value, app_data$state)
  counts_state_churn_2 <- table(app_data$churn.value, app_data$international.plan)
  counts_state_churn_3 <- table(app_data$churn.value, app_data$voice.mail.plan)
  
  bar_plot_1_data <- counts_state_churn_1[,1:25]
  bar_plot_2_data <- counts_state_churn_1[,26:51]
  
  #set.seed(122)
  #histdata <- rnorm(500)
  
  # plot4 needs to be modified to use plot_ly for pie chart
  pie_label <- c("Retained customers \n 4293","Churned customers \n 707")
  
  output$plot4 <- renderPlot({
    pie(pie_chart_churn_counts,labels = pie_label,main = "Total data composition of Churners")
  })
  
  output$plot_bar_1 <- renderPlot(expr =  barplot(bar_plot_1_data,horiz=TRUE ,main = "Distribution of Retained Vs Churn customers Statewise",xlab = "State names",col = c('lightgreen','brown1'),ylab = "Count of Churners in Red \t Count of Retained in Green"))
  
  output$plot_bar_2 <- renderPlot(expr =  barplot(bar_plot_2_data,horiz=TRUE ,main = "Distribution of Retained Vs Churn customers Statewise",xlab = "State names",col = c('lightgreen','brown1'),ylab = "Count of Churners in Red \t Count of Retained in Green"))
  
  label_voice_mail <- c("Not registered","Registered")
  output$plot2 <- renderPlot({
    barplot(counts_state_churn_2,names.arg = label_voice_mail, main = "Distribution churn customers suscribers of International Plan  ",xlab = "International Plan Suscribers",col = c('antiquewhite3','brown1'),ylab = "Count of Churners in Red \t Count of Retained in Brown")
  })
  output$plot3 <- renderPlot({
    barplot(counts_state_churn_3,names.arg = label_voice_mail, main = "Distribution churn customer suscribers of Voicemail plan",xlab = "Voicemail plan Suscribers",col = c('burlywood','brown1'),ylab = "Count of Churners in Red \t Count of Retained in Brown")
  })
  
  
  
}