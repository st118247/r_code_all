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

ui <- bootstrapPage(
    tags$head(
        tags$title("ICPCR"),
        tags$link(rel = "stylesheet", type = "text/css", href = "footer.css")
        ),
    theme = shinytheme("paper"),
      # shinythemes::themeSelector(),
      navbarPage("",
        tabPanel("Home",
            fluidPage(
                tags$div(
                    tags$h1("Intelligent Churn Prediction System - ICPCR"),
                    tags$p("This system is designed to help users to predict the churning of cutomers.")
                    ),
                tags$div(
                    tags$h3("Description"),
                    tags$p("Churn is the ")
                    ),
                materialSwitch(inputId = "id", label = "ThemeSelector", status = "primary", right = TRUE)

                )
            ),
        tabPanel("Data",
            fluidPage(
                tags$h1("Intelligent Churn Prediction System"),
                tags$h4("This system is designed to show the statistics of the customers of the system.",
                    "Below is the snapshot of the exisitng cutomer call details records data."),    
                tabsetPanel(type = "tabs",
                    tabPanel("Description", 
                        fluidPage(
                            tags$h3("Meta data of the churn dataset"),
                            tableOutput('tbl')
                            )
                        ),
                    tabPanel("Data Recods", dataTableOutput("table")),
                    tabPanel("Summary of Variables", verbatimTextOutput("summary"))
                    )
                )
            ),
        tabPanel("Plots",
            fluidPage(
                tags$h2("The following plots show the churners vs non-churners"),
                tabsetPanel(type = "tabs",
                    # tabPanel("Variable - ", plotlyOutput("bar")),
                    tabPanel("Variable - Region",
                        tags$h3("The region bar plot shows the counts in the region and breakup of churners to non-churners"),
                        plotlyOutput("bar2")
                        ),
                    tabPanel("Variable - States", 
                        tags$h3("The states bar plot shows the counts in the states and breakup of churners to non-churners"),
                        selectInput(inputId = "n_breaks",
                           label = "Number of bins in histogram (approximate):",
                                 # choices = c(10, 20, 35, 50),
                                 choices = df_churn_names,
                                 selected = 20),
                        plotOutput('bar4'),
                        plotlyOutput("bar3")
                        )
                    )
                )
            ),
        tabPanel("Prediction Result",
            fluidPage(
                tags$h2("Here details of prediction model are displayed"),
                tags$h4("")
                )
            ),
        tabPanel("Predict",
            fluidPage(
                tags$h2("Upload file to Predict Churn"),
                tags$h4(""),
                sidebarLayout(
                    # Sidebar panel for inputs ----
                    sidebarPanel(
                        # Input: Select a file ----
                        fileInput("file1", "Choose CSV File",
                            multiple = TRUE,
                            accept = c("text/csv","text/comma-separated-values,text/plain",".csv")),
                        # Horizontal line ----
                        tags$hr(),
                        # Input: Checkbox if file has header ----
                        checkboxInput("header", "Header", TRUE),
                        # Input: Select separator ----
                        radioButtons("sep", "Separator",
                            choices = c(Comma = ",",Semicolon = ";",Tab = "\t"),
                            selected = ","),
                        # Input: Select quotes ----
                        radioButtons("quote", "Quote",
                            choices = c(None = "","Double Quote" = '"',"Single Quote" = "'"),
                            selected = '"'),
                        # Horizontal line ----
                        tags$hr(),
                        # Input: Select number of rows to display ----
                        radioButtons("disp", "Display",
                            choices = c(Head = "head",
                                All = "all"),
                            selected = "head")
                        ),
                    # Main panel for displaying outputs ----
                    mainPanel(
                        # Output: Data file ----
                        tableOutput("contents")
                        )
                    )
                )
            ),

        tabPanel("About",
            "About Page"
            ),

        tabPanel("Interactive map",
            div(class="outer",
                tags$head(
                    # Include our custom CSS
                    includeCSS("styles.css"),
                    includeScript("gomap.js")
                    ),

                leafletOutput("map", width="100%", height="100%"),

                # Shiny versions prior to 0.11 should use class="modal" instead.
                absolutePanel(id = "controls", class = "panel panel-default", fixed = TRUE,
                    draggable = TRUE, top = 60, left = "auto", right = 20, bottom = "auto",
                    width = 330, height = "auto",
                    h2("ZIP explorer"),
                    selectInput("color", "Color", vars),
                    selectInput("size", "Size", vars, selected = "adultpop")
                    # conditionalPanel("input.color == 'superzip' || input.size == 'superzip'",
                #         # Only prompt for threshold when coloring or sizing by superzip
                #         numericInput("threshold", "SuperZIP threshold (top n percentile)", 5)
                )
                )
            )
        ),
tags$footer(
    class="footer",
    tags$div(class="container","Designed by AIT CSIM & Parth Sarangi")
        # tags$div(class="col",
        #     tags$div(class="col"),
        # tags$div(class="col"),
        # tags$div(
        #     class="col align-self-end",
        #     "Designed by Parth"
        #     )
        # )
        )
)
     # )


     server <- function(input, output, session) {

        output$tbl <- renderTable({ meta_data_df },  
           striped = TRUE,
           hover=TRUE,  
           spacing = 'l',  
           width = '100%')

        output$map <- renderLeaflet({
            leaflet() %>%
            addTiles(
                urlTemplate = "//{s}.tiles.mapbox.com/v3/jcheng.map-5ebohr46/{z}/{x}/{y}.png",
                attribution = 'Maps by <a href="http://www.mapbox.com/">Mapbox</a>'
                ) %>%
            setView(lng = -93.85, lat = 37.45, zoom = 4)
            })

        output$table <- renderDataTable(churn,
            options = list(
              pageLength = 5,
              initComplete = I("function(settings, json) {alert('Done.');}")
              )
            )
        output$summary <- renderPrint({
            summary(churn)
            })

    # output$bar <- renderPlotly({
    #     plot_ly(churn_data_region, x=churn_data_region$region, y=churn_data_region$`count(*)`,type = 'bar') %>%
    #     layout(yaxis)
    #     })

    output$bar2 <- renderPlotly({
        plot_ly(churn_data_region, x=churn_data_region$region, y=churn_data_region$`count(*)`,type = 'bar', name="Total Count") %>%
        add_trace(y=churn_region_true_cnt$`count(*)`, name="Churners") %>%
        add_trace(y=churn_region_false_cnt$`count(*)`, name="Non-Churners") %>%
        layout(yaxis = list(title = 'Counts'), barmode = 'group')
        })

    output$bar3 <- renderPlotly({
        plot_ly(churn_state_counts[1:10,],type='bar',x=churn_state_counts$state,y=churn_state_counts$churners,name="Churners") %>% 
        add_trace(y=churn_state_counts$non_churners,name="Non-Churners") %>% 
        layout(yaxis=list(title = "Counts"), barmode = 'group')
        })

    churndim <- reactive ({input$n_breaks})

    output$bar4 <- renderPlot({
        hist(churn[,input$n_breaks],main="Histogram",xlab=input$n_breaks,col = "#75AADB", border = "white")
        })

    output$contents <- renderTable({
        # input$file1 will be NULL initially. After the user selects
        # and uploads a file, head of that data file by default,
        # or all rows if selected, will be shown.

        req(input$file1)

        df <- read.csv(input$file1$datapath,
            header = input$header,
            sep = input$sep,
            quote = input$quote)

        if(input$disp == "head") {
            return(head(df))
        }
        else {
            return(df)
        }

        })
}



shinyApp(ui = ui, server = server)