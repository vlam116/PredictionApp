library(shiny);library(shinyWidgets);library(shinydashboard)

# shinyUI(fluidPage(
#   
#   setBackgroundColor(
#     color = c("#716B6B", "#999494"),
#     gradient = "linear",
#     direction = "bottom"
#   ),  
#   
#     navbarPage("Navigation Menu",
#                tabPanel("PredNextWord",
#                       sidebarPanel(
#                         tags$style(".well {background-color:#D1CACA;}"),
#                         div("Welcome to my R Shiny Word Prediction App!", style = "color:blue",
#                             align = "center"),
#                         br(),
#                         br(),
#                         textInput("userInput", "To get started, type something here, 
#                                           then a next word prediction along with a table of 
#                                           next word candidates will appear below.
#                                           You are free to type as many words as you want."),
#                         br(),
#                         htmlOutput("Prediction"),
#                         br(),
#                         tableOutput("p")
#                       ),
#                     mainPanel(
#                       h1("Next Word Prediction Application", align = "center", style = "color:white"),
#                       h3("Created by Vin Lam", align = "center", style = "color:white"),
#                       h5("As a project for the JHU Data Science Specialization", align = "center",
#                          style = "color:white"),
#                       br(),
#                       br(),
#                       br(),
#                       img(src = "cat.png", height = 144, width = 144)
#                     )
#                ),
#                tabPanel("About",
#                             textOutput("About")),
#                tabPanel("Katz Back-off Algorithm",
#                             textOutput("KBO")),
#                tabPanel("Data Mining Process",
#                             textOutput("DMP")),
#                tabPanel("Further Reading",
#                             textOutput("FR"))
#     )
# ))

dashboardPage(
  skin = "purple",
  dashboardHeader(title = "Next Word Prediction App"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Main", tabName = "main", icon = icon("dashboard")),
      menuItem("About", tabName = "About", icon = icon("book")),
      menuItem("How Predictions are Generated", tabName = "how", icon = icon("calculator")),
      menuItem("Creating predNextWord", tabName = "PNW", icon = icon("laptop-code")),
      menuItem("Further Reading", tabName = "FR", icon = icon("book-reader"))
    )
  ),
  dashboardBody(
    # tags$head(tags$style(HTML(
    #   "/* body */
    #     .content-wrapper, .right-side {
    #       background-color: #737373;
    #     }"
    # ))),
    tabItems(
      tabItem(tabName = "main",
        fluidRow(
          box(
            width = 12,
            h1("Next Word Prediction Application", align = "center"),
            h3("Created by Vin Lam", align = "center"),
            h4("12/15/20", align = "center"),
            h5("As a project for the JHU Data Science Specialization", align = "center"),
            ),
          fluidRow(
            box(
            width = 12,
            title = "Real-time Word Predictor",
            textInput("userInput", "To get started, type something here, 
                      then a next word prediction along with a table of next word candidates will appear below.
                      The associated probabilities are listed along side the predicted words, which were
                      calculated using Katz's back-off model with Good Turing smoothing. Up to five potential
                      words will be generated. You are free to type as many words as you want."),
            br(),
            htmlOutput("Prediction"),
            br(),
            tableOutput("p")
            )
          )
        )
      ),

      tabItem(tabName = "About",
            fluidRow(
              box(
                width = 12,
                uiOutput("aboutrmd")
              )
            ),
            fluidRow(
              box(
                title = "Google's powerful autocomplete search engine let's you find relevant 
                information quickly.",
                width = 4,
                height = 300,
                img(src = "g.jpg", height = 200, width = 400)
              ),
              box(
                title = "YouTube's predictive search bar allows you to find past content and discover
                new content, thereby providing data used to suggest more content you might like.",
                width = 4,
                height = 300,
                img(src = "y.png", height = 200, width = 400)
              ),
              box(
                title = "Messenger apps provide word, phrase, and sentence completion with a good degree
                of accuracy and speed.",
                width = 4,
                height = 300,
                img(src = "m.png", height = 200, width = 400)
              )
            )
          ),
      tabItem(tabName = "how",
              fluidRow(
                box(
                  width = 12,
                  uiOutput("kbormd")
                )
              )
            ),
      tabItem(tabName = "PNW",
              fluidRow(
                box(
                  width = 12,
                  uiOutput("pnwrmd")
                )
              )
              ),
      tabItem(tabName = "FR",
              fluidRow(
                box(
                  width = 12,
                  uiOutput("frrmd")
                )
              )
              )
      
    )
  )
)