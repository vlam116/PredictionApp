library(shiny);library(shinyWidgets);library(shinydashboard)

dashboardPage(
  skin = "purple",
  dashboardHeader(title = "Next Word Prediction App"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Main", tabName = "main", icon = icon("dashboard")),
      menuItem("Phrase Completer", tabName = "phrase", icon = icon("keyboard")),
      menuItem("About", tabName = "About", icon = icon("book")),
      menuItem("How Predictions are Generated", tabName = "how", icon = icon("calculator")),
      menuItem("Creating predNextWord", tabName = "PNW", icon = icon("laptop-code")),
      menuItem("Further Reading", tabName = "FR", icon = icon("book-reader"))
    )
  ),
  dashboardBody(
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
      tabItem(tabName = "phrase",
        fluidRow(
          box(
            width = 12,
            h1("Random Phrase Completer", align = "center"),
          ),
          fluidRow(
            box(
              width = 12,
              p(strong("Click the button to draw 5 random phrases from a collection of 8672 possible 
                       phrases taken from random blogs. Predictions will be generated for each of the 
                      5 phrases.")),
              br(),
              actionBttn(inputId = "go", label = "Run!", color = "success", style = "material-flat"),
              br(),
              br(),
              br(),
              tableOutput("pp"),
              p(strong("Sometimes you will get a phrase with typos and words that aren't even in English.
                       These were purposefully left in to demonstrate that you will always get a prediction."))
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