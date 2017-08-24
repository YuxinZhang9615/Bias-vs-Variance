library(shiny)
library(png)
library(shinyBS)

shinyServer(function(input, output,session) {
  
  #Text on the instruction page
  output$about1 <- renderUI(
    print("About")
  )
  output$about2 <- renderUI(
    print("Understand concepts bias and reliability in sampling.")
  )
  output$background1 <- renderUI(
    print("Background: Bias and Reliability")
  )
  output$background2 <- renderUI(
    print("The bias of a measurement describes to what degree it is systematically off target from the true value.")
  )
  output$background3 <- renderUI(
    print("The reliability of a measurement describes how consistent the measurement is when you repeat it 
          (alternatively, an unreliable measurement is one that shows a lot of variability from value to value 
          when the measurement is repeated independently). ")
  )
  output$instruction1 <- renderUI(
    print("Instruction")
  )
  output$instruction2 <- renderUI(
    print("Step 1: Click the plot to put down at least 10 points.")   
  )
  output$instruction3 <- renderUI(
    print("Step 2: Check the feedback and keep trying until you get it correct and go to the next question.")
  )
  output$instruction4 <- renderUI(
    print('Note: There are only four different questions.')
  )
  
  output$ack1 <- renderUI(
    print("Acknowledgement and Credit")
  )
  output$ack2 <- renderUI(
    print("This app was developed and coded by Yuxin Zhang.")
  )
  
  var <- reactiveValues(x = NULL, y = NULL, bias = NULL, reliability = NULL)
  
  index <- reactiveValues(index = 4)
  observeEvent(input$new,{
    index$index <- sample(1:4,1)
  })
  
  output$question <- renderUI({
    if (index$index == 1){
      h3("Can you create a model for large bias and low reliability?  Please put on at least 10 dots.")
    }else if (index$index == 2){
      h3("Can you create a model for large bias and high reliability?  Please put on at least 10 dots.")
    }else if (index$index == 3){
      h3("Can you create a model for no bias and low reliability?  Please put on at least 10 dots.")
    }else if (index$index == 4){
      h3("Can you create a model for no bias and high reliability? (Please put down at least 10 dots.)")
    }
  })

#Create function for ploting the target  
  plotTarget = function(x,y){
    #Get image
    isolate(ima <- readPNG("t6.png"))
    
    #Set up the plot area
    isolate(plot(x=-5:5,ylim=c(-5,5),xlim=c(-5,5),type='p',xlab = '',ylab = ''))
    
    #Get the plot information so the image will fill the plot box, and draw it
    isolate(lim <- par())
    isolate(rasterImage(ima, lim$usr[1], lim$usr[3], lim$usr[2], lim$usr[4]))
    isolate(grid())
    lines(x,y, xlim = c(-5,5), ylim = c(-5,5),type = 'p', pch = 20)
  }
  
#Create function for ploting the bias plot  
  plotA = function(x,y){
    plot(x = -3:3,xlim = c(-6,6), type = "n", xlab = "", ylab = "", main = "Bias",yaxt = 'n')
    box(col = "red")
    abline(v=0,col = "red")
    abline(v = sqrt(mean(x)^2 + mean(y)^2))
  }

#Create function for ploting the reliability plot  
  plotB = function(x,y){
    #Density plot of the distance between each dots
    plot(density(dist(cbind(x,y))),xlim = c(-2,12),xlab = "", main = "Reliability")
    abline(v = mean(dist(cbind(x,y))))
    box(col = "red")
  }
  
##Use above three functions to code the output for tab1     
  observe({
    # Initially will be empty
    if (is.null(input$Click)){
      return()
    }
    #Save the coordinates of clicked points as two vectors
    isolate({
      var$x <- c(var$x, input$Click$x)
      var$y <- c(var$y, input$Click$y)
    })
  })
  
  observe({
    if (length(var$x) >= 10){
      updateButton(session,"submit",label = "Submit",style = "danger", size = "large", disabled = FALSE)
    }
  })
  
  #Reset the button to FALSE so that all the conditionalPanel will disappear
  observeEvent(input$submit,{{
    updateButton(session,"submit",label = "Try again",style = "danger",size = "large")
  }})
  #Reset(clear) the clicked points
  observe({
    if (input$submit == FALSE){
      var$x <- NULL
      var$y <- NULL
    }
  })
  
  observe({
    if (length(var$x) == 1){
      updateButton(session,"submit", label = "Submit", disabled = TRUE)
    }
  })


  observeEvent(input$new,{
    updateButton(session, "submit", label = "Submit",value = FALSE, disabled = TRUE)
  })

  
  output$target <- renderPlot({
    plotTarget(var$x,var$y)
  },height = 320, width = 320)
  
  output$plota <- renderPlot({
    plotA(var$x,var$y)
  },height = 320, width = 320)
  
  output$plotb <- renderPlot({
    plotB(var$x,var$y)
  },height = 320, width = 320)
  

  observe({
    if (input$submit == TRUE){
      #Distance between the center of target(population) and the center of the cloud of dots(ave. of samples)
      var$bias <- sqrt(mean(var$x)^2 + mean(var$y)^2)
      #Average distance between each dots
      var$reliability <- mean(dist(cbind(var$x,var$y)))
    }
  })
  

  output$bias <- renderText({
    print(round(var$bias, digits = 2))
  })
  
  output$reliability <- renderText({
    print(round(var$reliability, digits = 2))
  })

  output$answer <- renderUI({
    if (index$index == 1){
      if ((var$bias > 4) & (var$reliability > 3)){
        print("Great! Nicely done!")
      }else if ((var$bias > 3) & (var$reliability > 2.5)){
        print("Good job!")
      }else if ((var$bias > 2.5) & (var$reliability > 2)){
        print("Not bad! Try again.")
      }else{
        print("You can do better. Try again.")
      }
    }else if (index$index == 2){
      if ((var$bias > 4) & (var$reliability < 1.5)){
        print("Great! Nicely done!")
      }else if ((var$bias > 3) & (var$reliability < 2)){
        print("Good job!")
      }else if ((var$bias > 2) & (var$reliability < 2)){
        print("Not bad! Try again.")
      }else{
        print("You can do better. Try again.")
      }
    }else if (index$index == 3){
      if ((var$bias < 0.25) & (var$reliability > 3)){
        print("Great! Nicely done!")
      }else if ((var$bias < 0.3) & (var$reliability > 2.5)){
        print("Good job!")
      }else if ((var$bias < 0.5) & (var$reliability > 2)){
        print("Not bad! Try again.")
      }else{
        print("You can do better. Try again.")
      }
    }else if (index$index == 4){
      if ((var$bias < 0.25) & (var$reliability < 1.5)){
        print("Great! Nicely done!")
      }else if ((var$bias < 0.3) & (var$reliability < 2)){
        print("Good job!")
      }else if ((var$bias < 0.5) & (var$reliability < 2)){
        print("Not bad! Try again.")
      }else{
        print("You can do better. Try again.")
      }
    }
  })
  
  observe({
    if (input$submit == TRUE){
      if ((index$index == 1) & (var$bias > 3) & (var$reliability > 2.5)){
        updateButton(session, "new", disabled = FALSE)
      }else if ((index$index == 2) & (var$bias > 3) & (var$reliability < 2)){
        updateButton(session, "new", disabled = FALSE)
      }else if ((index$index == 3) & (var$bias < 0.3) & (var$reliability > 2.5)){
        updateButton(session, "new", disabled = FALSE)
      }else if ((index$index == 4) & (var$bias < 0.3) & (var$reliability < 2)){
        updateButton(session, "new", disabled = FALSE)
      }else{
        updateButton(session, "new", disabled = TRUE)
      }
    }else{
      updateButton(session, "new", disabled = TRUE)
    }
  })

  output$feedback1 <- renderUI({
    paste("Average bias = ",round(var$bias,digits = 2),"(smaller values indicate less bias)")
  }) 
  output$feedback2 <- renderUI({
    paste("Average reliability = ", round(var$reliability,digits = 2), "(smaller values indicate better reliability)")
  })
  output$feedback3 <- renderUI({
    
    if ((mean(var$x) > 0 ) & (mean(var$y) > 0)){
      quad = "upper right"
    }else if ((mean(var$x) < 0) & (mean(var$y) > 0 )){
      quad = "upper left"
    }else if ((mean(var$x) < 0) & (mean(var$y) < 0)){
      quad = "bottom left"
    }else if ((mean(var$x) > 0) & (mean(var$y) < 0)){
      quad = "bottom right"
    }
    
    if (var$bias > 3){
      biasFeedback = "large"
    }else{
      biasFeedback = "small"
    }
    
    if (var$reliability > 2.5){
      reliaFeedback = "low"
    }else{
      reliaFeedback = "high"
    }
    
    paste("The dots you put down are centered at the",quad,"quadrant, with a relatively",biasFeedback,
          "bias and",reliaFeedback,"reliability.")
    

  })
  
  
})



