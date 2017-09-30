server <- function(input, output) {
	app_data <- read.csv("churn_data.csv")
	pie_chart_churn_counts <- table(app_data$churn.value)
	pie_label <- c("Retained customers \n 4293","Churned customers \n 707")

	# par(mar=c(7,2,2,2))
	# output$plot_pie_1 <- renderPlot({
	# 	plot(1:10,1:10,xlab="",ylab="",xaxt="n",yaxt="n",type="pie")
	# 	})

	output$hist <- renderPlot({
		hist(app_data$number.vmail.messages)
		})

	output$plot_1 <- renderPlot({
		plot(pie_chart_churn_counts,type=input$plotType)
		})

	output$summary <- renderPrint({str(app_data)})

	output$plot_pie_1 <- renderPlot({
		pie(pie_chart_churn_counts,labels = pie_label,main = "Total data composition of Churners")
	})


	counts_state_churn_1 <- table(app_data$churn.value, app_data$state)
	bar_plot_1_data <- counts_state_churn_1[,1:25]
	bar_plot_2_data <- counts_state_churn_1[,26:51]

	output$plot_bar_1 <- renderPlot(expr =  barplot(bar_plot_1_data,horiz=TRUE ,main = "Distribution of Retained Vs Churn customers Statewise",xlab = "State names",col = c('lightgreen','brown1'),ylab = "Count of Churners in Red \t Count of Retained in Green"))
	output$plot_bar_2 <- renderPlot(expr =  barplot(bar_plot_2_data,horiz=TRUE ,main = "Distribution of Retained Vs Churn customers Statewise",xlab = "State names",col = c('lightgreen','brown1'),ylab = "Count of Churners in Red \t Count of Retained in Green"))

	counts_state_churn_2 <- table(app_data$churn.value, app_data$international.plan)
	counts_state_churn_3 <- table(app_data$churn.value, app_data$voice.mail.plan)
	label_voice_mail <- c("Not registered","Registered")

	output$plot2 <- renderPlot({
	barplot(counts_state_churn_2,names.arg = label_voice_mail, main = "Distribution churn customers suscribers of International Plan  ",xlab = "International Plan Suscribers",col = c('antiquewhite3','brown1'),ylab = "Count of Churners in Red \t Count of Retained in Brown")
	})

	output$plot3 <- renderPlot({
	barplot(counts_state_churn_3,names.arg = label_voice_mail, main = "Distribution churn customer suscribers of Voicemail plan",xlab = "Voicemail plan Suscribers",col = c('burlywood','brown1'),ylab = "Count of Churners in Red \t Count of Retained in Brown")
	})
}