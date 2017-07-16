library(shiny)
library(shinydashboard)
library(png)
library(shinyBS)

ui <- dashboardPage(skin = "black",
  dashboardHeader(title = "Bias & Reliability"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Instruction",tabName = "instruction", icon = icon("dashboard")),
      menuItem("Game",tabName = "game", icon = icon("th"))
    )
  ),
  dashboardBody(
    tags$head(
      tags$link(rel = "stylesheet", type = "text/css", href = "navcolor.css")
    ),
    tabItems(
      tabItem(tabName = "instruction",
              h2("Reliability is the extent to which an experiment, test, or any measuring procedure
                                 yields the same result on repeated trials.","\n","Validity refers to the degree to 
                 which a study accurately reflects or assesses the specific concept that the researcher
                 is attemping to measure. Please put on at least 10 dots. The center of the target 
                 represents the population and each dot represents a sample.")
              ),
      tabItem(tabName = "game",
              wellPanel(
                fluidRow(uiOutput("question"))
                #fluidRow(h4("Please put down at least 10 points."))
              ,height = 80),hr(),
              fluidRow(
                column(4,plotOutput("target", click = 'Click')),
                column(8, 
                       conditionalPanel(
                         condition = 'input.submit != 0',
                         fluidRow(
                           column(6,plotOutput("plota")),
                           column(6,plotOutput("plotb")))
                         # fluidRow(
                         #   column(4,offset = 2,h4(textOutput("bias"))),
                         #   column(4,offset = 2,h4(textOutput("reliability")))
                         # )
                         ))),
              fluidRow(
                column(4, offset = 4, 
                       bsButton("submit",label = "Try",type = "toggle", size = "large", value = FALSE, disabled = TRUE),
                       bsButton("new",label = "Next>>", style = "danger", size = "large", disabled = TRUE))
              ),
              fluidRow(
                hr(),
                conditionalPanel("input.submit != 0",
                                 h1(textOutput("answer"))),
                wellPanel("Instructions will be written here ...")
              )
              )
    )
  )
  
)











# 
# 
# 
# 
# shinyUI(navbarPage("Bias + Reliability",
#                    
#                    tabPanel("Instruction",
#                             h2("Reliability is the extent to which an experiment, test, or any measuring procedure
#                                  yields the same result on repeated trials.","\n","Validity refers to the degree to 
#                                which a study accurately reflects or assesses the specific concept that the researcher
#                                is attemping to measure. Please put on at least 10 dots. The center of the target 
#                                represents the population and each dot represents a sample.")
#                             ),
#                    tabPanel("Large Bias + Low Reliability",
#                             
#                             wellPanel(
#                               uiOutput("question")
#                             ),hr(),
#                             fluidRow(
#                               column(4,plotOutput("target1", click = 'Click1')),
#                               column(8, 
#                                      conditionalPanel(
#                                        condition = 'input.submit1 != 0',
#                                        fluidRow(
#                                          column(4,plotOutput("plot1a")),
#                                          column(4,offset = 1,plotOutput("plot1b"))),
#                                        fluidRow(
#                                          column(4,offset = 2,h4(textOutput("bias1"))),
#                                          column(4,offset = 2,h4(textOutput("reliability1")))
#                                          )))),
#                             fluidRow(
#                               column(4, offset = 4, bsButton("submit1",label = "Try",type = "toggle",value = FALSE),
#                                      bsButton("new",label = "Next>>", disabled = TRUE))
#                             ),
#                             fluidRow(
#                               br(),
#                               hr(),
#                               conditionalPanel("input.submit1 != 0",
#                                                h1(textOutput("answer1"))),
#                               wellPanel("Instructions will be written here ...")
#                             )
#                    ),
#                    
#                    #####################################################################################################
#                    tabPanel("Large Bias + High Reliability",
#                            
#                             fluidRow(
#                               column(4,plotOutput("target2", click = 'Click2')),
#                               column(8,
#                                      conditionalPanel(
#                                        condition = 'input.submit2 != 0',
#                                        fluidRow(
#                                          column(4,plotOutput("plot2a")),
#                                          column(4,offset = 1,plotOutput("plot2b"))),
#                                        fluidRow(
#                                          column(4,offset = 2,h4(textOutput("bias2"))),
#                                          column(4,offset = 2,h4(textOutput("reliability2")))
#                                        )))),
#                             fluidRow(
#                               column(4, offset = 4, bsButton("submit2",label = "Try",type = "toggle")
#                                      )
#                             ),
#                             fluidRow(
#                               br(),
#                               hr(),
#                               conditionalPanel("input.submit2 != 0",
#                                                wellPanel(h1(textOutput("answer2")),
#                                                          h2(textOutput("instruction2"))))
#                             )
#                    ),
#                    
#                    tabPanel("No Bias + Low Reliability",
#                             wellPanel(h2("Instructions will be written here...")),hr(),
#                             fluidRow(
#                               column(4,plotOutput("target3", click = 'Click3')),
#                               column(8,
#                                      conditionalPanel(
#                                        condition = 'input.submit3 != 0',
#                                        fluidRow(
#                                          column(4,plotOutput("plot3a")),
#                                          column(4,offset = 1,plotOutput("plot3b"))),
#                                        fluidRow(
#                                          column(4,offset = 2,h4(textOutput("bias3"))),
#                                          column(4,offset = 2,h4(textOutput("reliability3")))
#                                        )))),
#                             fluidRow(
#                               column(4, offset = 4, bsButton("submit3",label = "Try",type = "toggle"))
#                             ),
#                             fluidRow(
#                               br(),
#                               hr(),
#                               conditionalPanel("input.submit3 != 0",
#                                                h1(textOutput("answer3"))),
#                               wellPanel("Instructions will be written here ...")
#                             )
#                    ),
#                    
#                    tabPanel("No Bias + High Reliability",
#                             wellPanel(h2("Instructions will be written here...")),hr(),
#                             fluidRow(
#                               column(4,plotOutput("target4", click = 'Click4')),
#                               column(8,
#                                      conditionalPanel(
#                                        condition = 'input.submit4 != 0',
#                                        fluidRow(
#                                          column(4,plotOutput("plot4a")),
#                                          column(4,offset = 1,plotOutput("plot4b"))),
#                                        fluidRow(
#                                          column(4,offset = 2,h4(textOutput("bias4"))),
#                                          column(4,offset = 2,h4(textOutput("reliability4")))
#                                        )))),
#                             fluidRow(
#                               column(4, offset = 4, bsButton("submit4",label = "Try",type = "toggle"))
#                             ),
#                             fluidRow(
#                               br(),
#                               hr(),
#                               conditionalPanel("input.submit4 != 0",
#                                                h1(textOutput("answer4"))),
#                               wellPanel("Instructions will be written here ...")
#                             )
#                    )
#                             
#                             
#                    
# ))