library(shiny)
library(png)
library(shinyBS)

shinyUI(navbarPage("Bias + Reliability",
                   tabPanel("Large Bias + Low Reliability",
                            wellPanel(h2("Instructions will be written here...")),hr(),
                            fluidRow(
                              column(4,plotOutput("target1", click = 'Click1')),
                              column(8, 
                                     conditionalPanel(
                                       condition = 'input.submit1 != 0',
                                       fluidRow(
                                         column(4,plotOutput("plot1a")),
                                         column(4,offset = 1,plotOutput("plot1b"))),
                                       fluidRow(
                                         column(4,offset = 2,h4(textOutput("bias1"))),
                                         column(4,offset = 2,h4(textOutput("reliability1")))
                                         )))),
                            fluidRow(
                              column(4, offset = 4, bsButton("submit1",label = "Try",type = "toggle"))
                            ),
                            fluidRow(
                              br(),
                              hr(),
                              conditionalPanel("input.submit1 != 0",
                                               h1(textOutput("answer1"))),
                              wellPanel("Instructions will be written here ...")
                            )
                   ),
                   tabPanel("Large Bias + High Reliability",
                            wellPanel(h2("Instructions will be written here...")),hr(),
                            fluidRow(
                              column(4,plotOutput("target2", click = 'Click2')),
                              column(8,
                                     conditionalPanel(
                                       condition = 'input.submit2 != 0',
                                       fluidRow(
                                         column(4,plotOutput("plot2a")),
                                         column(4,offset = 1,plotOutput("plot2b"))),
                                       fluidRow(
                                         column(4,offset = 2,h4(textOutput("bias2"))),
                                         column(4,offset = 2,h4(textOutput("reliability2")))
                                       )))),
                            fluidRow(
                              column(4, offset = 4, bsButton("submit2",label = "Try",type = "toggle"))
                            ),
                            fluidRow(
                              br(),
                              hr(),
                              conditionalPanel("input.submit2 != 0",
                                               h1(textOutput("answer2"))),
                              wellPanel("Instructions will be written here ...")
                            )
                   ),
                   
                   tabPanel("No Bias + Low Reliability",
                            wellPanel(h2("Instructions will be written here...")),hr(),
                            fluidRow(
                              column(4,plotOutput("target3", click = 'Click3')),
                              column(8,
                                     conditionalPanel(
                                       condition = 'input.submit3 != 0',
                                       fluidRow(
                                         column(4,plotOutput("plot3a")),
                                         column(4,offset = 1,plotOutput("plot3b"))),
                                       fluidRow(
                                         column(4,offset = 2,h4(textOutput("bias3"))),
                                         column(4,offset = 2,h4(textOutput("reliability3")))
                                       )))),
                            fluidRow(
                              column(4, offset = 4, bsButton("submit3",label = "Try",type = "toggle"))
                            ),
                            fluidRow(
                              br(),
                              hr(),
                              conditionalPanel("input.submit3 != 0",
                                               h1(textOutput("answer3"))),
                              wellPanel("Instructions will be written here ...")
                            )
                   ),
                   
                   tabPanel("No Bias + High Reliability",
                            wellPanel(h2("Instructions will be written here...")),hr(),
                            fluidRow(
                              column(4,plotOutput("target4", click = 'Click4')),
                              column(8,
                                     conditionalPanel(
                                       condition = 'input.submit4 != 0',
                                       fluidRow(
                                         column(4,plotOutput("plot4a")),
                                         column(4,offset = 1,plotOutput("plot4b"))),
                                       fluidRow(
                                         column(4,offset = 2,h4(textOutput("bias4"))),
                                         column(4,offset = 2,h4(textOutput("reliability4")))
                                       )))),
                            fluidRow(
                              column(4, offset = 4, bsButton("submit4",label = "Try",type = "toggle"))
                            ),
                            fluidRow(
                              br(),
                              hr(),
                              conditionalPanel("input.submit4 != 0",
                                               h1(textOutput("answer4"))),
                              wellPanel("Instructions will be written here ...")
                            )
                   )
                            
                            
                   
))