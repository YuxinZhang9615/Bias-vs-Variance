library(shiny)
library(png)

shinyUI(navbarPage("Bias + Variance",
                   tabPanel("Large Bias + large variance",
                            fluidRow(
                              column(4,plotOutput("target1", click = 'Click1')),
                              column(8, 
                                     conditionalPanel(
                                       condition = 'input.submit1 != 0',
                                       fluidRow(
                                         column(5,plotOutput("plot1a")),
                                         column(5,plotOutput("plot1b")))))),
                            fluidRow(
                              column(4, offset = 4, actionButton("submit1","Submit"))
                            ),
                            fluidRow(
                              br(),
                              hr(),
                              wellPanel("Instructions will be written here ...")
                            )
                   ),
                   tabPanel("Large Bias + small varianve",
                            fluidRow(
                              column(4,plotOutput("target2", click = 'Click2')),
                              column(8,
                                     conditionalPanel(
                                       condition = 'input.submit2 != 0',
                                       fluidRow(
                                         column(5,plotOutput("plot2a")),
                                         column(5,plotOutput("plot2b")))))),
                            fluidRow(
                              column(4, offset = 4, actionButton("submit2","Submit"))
                            ),
                            fluidRow(
                              br(),
                              hr(),
                              wellPanel("Instructions will be written here ...")
                            )
                   ),
                   
                   tabPanel("No Bias + large variance",
                            fluidRow(
                              column(4,plotOutput("target3", click = 'Click3')),
                              column(8,
                                     conditionalPanel(
                                       condition = 'input.submit2 != 0',
                                       fluidRow(
                                         column(5,plotOutput("plot3a")),
                                         column(5,plotOutput("plot3b")))))),
                            fluidRow(
                              column(4, offset = 4, actionButton("submit3","Submit"))
                            ),
                            fluidRow(
                              br(),
                              hr(),
                              wellPanel("Instructions will be written here ...")
                            )
                   ),
                   
                   tabPanel("No Bias + small variance",
                            fluidRow(
                              column(4,plotOutput("target4", click = 'Click4')),
                              column(8,
                                     conditionalPanel(
                                       condition = 'input.submit2 != 0',
                                       fluidRow(
                                         column(5,plotOutput("plot4a")),
                                         column(5,plotOutput("plot4b")))))),
                            fluidRow(
                              column(4, offset = 4, actionButton("submit4","Submit"))
                            ),
                            fluidRow(
                              br(),
                              hr(),
                              wellPanel("Instructions will be written here ...")
                            )
                   )
                            
                            
                   
))