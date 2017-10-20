
library(shinythemes)
library(shiny)
library(ggplot2)
library(dplyr)
library(RMySQL)
library(plotly)
library(leaflet)
library(RColorBrewer)
library(scales)
library(lattice)
library(dplyr)
library(shinyWidgets)

meta_data_df <- read.csv("metadata.csv",stringsAsFactors=TRUE,header=TRUE)
churn <- read.csv("churn_data.csv",stringsAsFactors=FALSE,header = TRUE)
df_churn_names <- names(churn)
us_lat_long <- read.csv("us_state_lat_long.csv",stringsAsFactors=FALSE,header = TRUE)

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
region_state <- fetch(dbSendQuery(mydb,"select * from tab_state_abbv;"),n=-1)
dbClearResult(dbListResults(mydb)[[1]])
# selecting regions to display as table
region_state <- fetch(dbSendQuery(mydb,"select * from tab_state_abbv;"),n=-1)
dbClearResult(dbListResults(mydb)[[1]])
# should select region wise counts to display as graphs - 4 graphs
dbDisconnect(mydb)

# Choices for drop-downs
vars <- c(
  "Is SuperZIP?" = "superzip",
  "Centile score" = "centile",
  "College education" = "college",
  "Median income" = "income",
  "Population" = "adultpop"
  )

# Define server logic for random distribution app ----
server <- function(input, output) {

  output$tbl <- renderTable({ meta_data_df },  
   striped = TRUE,
   hover=TRUE,  
   spacing = 'l',  
   width = '100%'
   )
  output$table <- renderDataTable(churn,
    options = list(
      pageLength = 5,
      initComplete = I("function(settings, json) {alert('Done.');}")
      )
    )
  output$summary <- renderPrint({
    summary(churn)
    })
}

# shinyApp(ui = htmlTemplate("www/index.html"), server)
shinyApp(ui = htmlTemplate("template.html"), server = server)
