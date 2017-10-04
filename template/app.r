library(shiny)
library(ggplot2)
library(dplyr)
library(RMySQL)
library(plotly)

churn <- read.csv("churn_data.csv",stringsAsFactors=FALSE,header = TRUE)

v_states <- sort(unique(churn[[2]]))

i <- 1
z <- c(1,1)

for (n in names(churn)) {if((class(churn[[n]])) != "factor") {z[i] <- n;i=i+1} }

mydb = dbConnect(MySQL(),user = 'root', password="zadmin1",dbname="db_churn",host='127.0.0.1')
churn_data_region <- fetch(dbSendQuery(mydb,"select region,count(*) from tab_churn, tab_state_abbv where tab_state_abbv.abbrev = tab_churn.state group by region"),n=-1)
dbClearResult(dbListResults(mydb)[[1]])
churn_region_true_cnt <- fetch(dbSendQuery(mydb,"select region,count(*) from tab_churn, tab_state_abbv where tab_state_abbv.abbrev = tab_churn.state and tab_churn.churn_value='True' group by region;"),n=-1)
dbClearResult(dbListResults(mydb)[[1]])
churn_region_false_cnt <- fetch(dbSendQuery(mydb,"select region,count(*) from tab_churn, tab_state_abbv where tab_state_abbv.abbrev = tab_churn.state and tab_churn.churn_value='False' group by region;"),n=-1)
dbClearResult(dbListResults(mydb)[[1]])
churn_state_counts <- fetch(dbSendQuery(mydb,"select v1.state,v1.counts as churners,v2.counts as non_churners from v_state_true_cnt as v1, v_state_false_cnt as v2 where v1.state=v2.state;"),n=-1)
dbClearResult(dbListResults(mydb)[[1]])
dbDisconnect(mydb)


ui <- fluidPage(
	titlePanel("BC Liquor Store prices"),
	sidebarLayout(
		sidebarPanel(),
		mainPanel(
			tabPanel("Plot", plotOutput("state")),
			br(), br(),
			# plotlyOutput("bar"),
			# br(), br(),
			# plotlyOutput("bar2"),
			# 			br(), br(),
			tabPanel("Plot2", plotlyOutput("bar2"),br(),br()),
			plotlyOutput("bar3")
			# plotlyOutput("bar3"),
			)
		)
	)

server <- function(input, output) {

	# output$state <- renderPlot({
	# 	hist(churn[[input$typeInput]])
	# 	})

	output$bar <- renderPlotly({
		plot_ly(churn_data_region, x=churn_data_region$region, y=churn_data_region$`count(*)`,type = 'bar')
		})
	output$bar2 <- renderPlotly({
		plot_ly(churn_data_region, x=churn_data_region$region, y=churn_data_region$`count(*)`,type = 'bar') %>%
		add_trace(y=churn_region_true_cnt$`count(*)`) %>%
		add_trace(y=churn_region_false_cnt$`count(*)`) %>%
		layout(yaxis = list(title = 'Counts'), barmode = 'group')
		})

	output$bar3 <- renderPlotly({
		plot_ly(churn_state_counts[1:10,],type='bar',x=churn_state_counts$state,y=churn_state_counts$churners,name="Churners") %>% 
		add_trace(y=churn_state_counts$non_churners,name="Non-Churners") %>% 
		layout(yaxis=list(title = "Counts"), barmode = 'group')
		})

}



shinyApp(ui = ui, server = server)