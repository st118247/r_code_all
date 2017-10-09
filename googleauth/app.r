library(shiny)
library(shinyjs)
library(googleAuthR)
library(googleID)


options(googleAuthR.scopes.selected = c("https://www.googleapis.com/auth/userinfo.email",
                                        "https://www.googleapis.com/auth/userinfo.profile"))
options("googleAuthR.webapp.client_id" = "637236591306-o449v1pv5eek4fjkk32l89m9mpfnhgjh.apps.googleusercontent.com")
options("googleAuthR.webapp.client_secret" = "13U-K4Tbeg9zE4T_kye0Enkn")

ui <- navbarPage(
    title = "App Name",
    windowTitle = "Browser window title",
    tabPanel("Tab 1",
        useShinyjs(),
        sidebarLayout(
            sidebarPanel(
                p("Welcome!"),
                googleAuthUI("gauth_login")
            ),
            mainPanel(
                textOutput("display_username")
            )
        )
    ),
    tabPanel("Tab 2",
        p("Layout for tab 2")
    )
)
 
server <- function(input, output, session) {
    ## Global variables needed throughout the app
    rv <- reactiveValues(
        login = FALSE
    )
 
    ## Authentication
    accessToken <- callModule(googleAuth, "gauth_login",
        login_class = "btn btn-primary",
        logout_class = "btn btn-primary")
    userDetails <- reactive({
        validate(
            need(accessToken(), "not logged in")
        )
        rv$login <- TRUE
        with_shiny(get_user_info, shiny_access_token = accessToken())
    })
 
    ## Display user's Google display name after successful login
    output$display_username <- renderText({
        validate(
            need(userDetails(), "getting user details")
        )
        userDetails()$displayName
    })
 
    ## Workaround to avoid shinyaps.io URL problems
    observe({
        if (rv$login) {
            shinyjs::onclick("gauth_login-googleAuthUi",
                shinyjs::runjs("window.location.href = 'http://127.0.0.1:6573';"))
        }
    })
}
 
shinyApp(ui = ui, server = server)