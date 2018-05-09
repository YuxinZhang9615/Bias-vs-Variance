library(shiny)
library(shinydashboard)
library(png)
library(shinyBS)

ui <- dashboardPage(skin = "black",
  dashboardHeader(title = "Bias & Reliability",
                  titleWidth = 200),
  dashboardSidebar(
    width = 200,
    sidebarMenu(
      menuItem("Instruction",tabName = "instruction", icon = icon("dashboard")),
      menuItem("Game",tabName = "game", icon = icon("th"))
    )
  ),
  dashboardBody(
    tags$head(
      tags$link(rel = "stylesheet", type = "text/css", href = "navcolor.css") #customised style sheet
    ),
    tabItems(
      tabItem(tabName = "instruction",
              fluidRow(
                column(11,offset = 1, uiOutput("about1"))
                ),
              fluidRow(
                column(1,img(src = "right.png", width = 30)),
                column(11,uiOutput("about2"))
              ),br(),
              fluidRow(
                column(11,offset = 1, uiOutput("background1"))
              ),
              fluidRow(
                column(1,img(src = "right.png", width = 30)),
                column(11,uiOutput("background2"))
                ),
              fluidRow(
                column(1,img(src = "right.png", width = 30)),
                column(11,uiOutput("background3"))
              ),
              br(),
              fluidRow(
                column(11,offset = 1, uiOutput("instruction1"))
              ),
              fluidRow(
                column(1,img(src = "right.png", width = 30)),
                column(11,uiOutput("instruction2"))
              ),
              fluidRow(
                column(1,img(src = "right.png", width = 30)),
                column(11,uiOutput("instruction3"))
              ),
              fluidRow(
                column(1,img(src = "right.png", width = 30)),
                column(11,uiOutput("instruction4"))
              ),br(),
              fluidRow(
                column(11,offset = 1, uiOutput("ack1"))
              ),
              fluidRow(
                column(1,img(src = "right.png", width = 30)),
                column(11, uiOutput("ack2"))
              )
              
              ),
      tabItem(tabName = "game",
              wellPanel(
                fluidRow(uiOutput("question"))
                ),hr(),
              fluidRow(
                column(4,plotOutput("target", click = 'Click'), style = "height: 320px;"),
                column(8, 
                       conditionalPanel(
                         condition = 'input.submit != 0',
                         fluidRow(
                           column(6,plotOutput("plota"), style = "height: 320px;",
                                  bsPopover("plota", "Bias", "Smaller values indicate less bias.",placement = "top")),
                           column(6,plotOutput("plotb"), style = "height: 320px;",
                                  bsPopover("plotb", "Reliability", "Smaller values indicate better reliability.",placement = "top")))
                         ))),
              fluidRow(
                column(4, offset = 4, 
                       bsButton("submit",label = "Submit",type = "toggle", size = "large", value = FALSE, disabled = TRUE),
                       bsButton("new",label = "Next>>", style = "danger", size = "large"),
                       bsButton('clear', label = "Clear", style = 'danger', size = 'large')
                       ),
                column(3, offset = 1,
                       conditionalPanel("input.submit != 0", 
                                        wellPanel(
                                          div(style = "position: relative; top:0",print("Feedback")),
                                          img(src = "arrow.gif", width = 40), class = "arrow")))
              ),
              fluidRow(
                hr(),
                conditionalPanel("input.submit != 0",
                                 h1(uiOutput("answer")),
                                 wellPanel(uiOutput("feedback1"),
                                           uiOutput("feedback2"),
                                           uiOutput("feedback3"), class = "wellfeedback")
                ))
               
              )
    )
  )
  
)









