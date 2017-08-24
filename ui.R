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
      tags$link(rel = "stylesheet", type = "text/css", href = "navcolor.css")
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
                         # fluidRow(
                         #   column(4,offset = 2,h4(textOutput("bias"))),
                         #   column(4,offset = 2,h4(textOutput("reliability")))
                         # )
                         ))),
              fluidRow(
                column(4, offset = 4, 
                       bsButton("submit",label = "Submit",type = "toggle", size = "large", value = FALSE, disabled = TRUE),
                       bsButton("new",label = "Next>>", style = "danger", size = "large", disabled = TRUE)
                       ),
                column(3, offset = 1,
                       conditionalPanel("input.submit != 0", 
                                        wellPanel(
                                          div(style = "position: relative; top:0",print("Scroll down to see more")),
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