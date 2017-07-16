library(shiny)
library(png)
library(shinyBS)

shinyServer(function(input, output,session) {
  var <- reactiveValues(x = NULL, y = NULL, bias = NULL, reliability = NULL)
  
  index <- reactiveValues(index = 4)
  observeEvent(input$new,{
    index$index <- sample(1:4,1)
  })
  
  output$question <- renderUI({
    if (index$index == 1){
      h4("Can you create a model for large bias and low reliability?  Please put on at least 10 dots.")
    }else if (index$index == 2){
      h4("Can you create a model for large bias and high reliability?  Please put on at least 10 dots.")
    }else if (index$index == 3){
      h4("Can you create a model for no bias and low reliability?  Please put on at least 10 dots.")
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
      updateButton(session,"submit",label = "Try",style = "danger", size = "large", disabled = FALSE)
    }
  })
  
  #Reset the button to FALSE so that all the conditionalPanel will disappear
  observeEvent(input$submit,{{
    updateButton(session,"submit",label = "Try",style = "danger",size = "large")
  }})
  #Reset(clear) the clicked points
  observe({
    if (input$submit == FALSE){
      var$x <- NULL
      var$y <- NULL
    }
  })
  # observeEvent(input$submit1,{
  #   updateButton(session, "new", disabled = TRUE)
  # })
  
  # observeEvent(input$submit1,{
  #   if ((index$index == 1) & (var$bias > 3) & (var$reliability > 2.5)){
  #     updateButton(session, "new", disabled = FALSE)
  #   }else if ((index$index == 2) & (var$bias > 3) & (var$reliability < 2)){
  #     updateButton(session, "new", disabled = FALSE)
  #   }else if ((index$index == 3) & (var$bias < 0.3) & (var$reliability > 2.5)){
  #     updateButton(session, "new", disabled = FALSE)
  #   }else if ((index$index == 4) & (var$bias < 0.3) & (var$reliability < 2)){
  #     updateButton(session, "new", disabled = FALSE)
  #   }else{
  #     updateButton(session, "new", disabled = TRUE)
  #   }
  # })
  


  observeEvent(input$new,{
    updateButton(session, "submit", value = FALSE)
  })

  
  output$target <- renderPlot({
    plotTarget(var$x,var$y)
  },height = 340, width = 340)
  
  output$plota <- renderPlot({
    plotA(var$x,var$y)
  },height = 340, width = 340)
  
  output$plotb <- renderPlot({
    plotB(var$x,var$y)
  },height = 340, width = 340)
  

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

  output$answer <- renderText({
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

   
})



