library(shiny)
library(png)
library(shinyBS)

shinyServer(function(input, output,session) {
  var1 <- reactiveValues(x = NULL, y = NULL)
  var2 <- reactiveValues(x = NULL, y = NULL)
  var3 <- reactiveValues(x = NULL, y = NULL)
  var4 <- reactiveValues(x = NULL, y = NULL)
  

 

  
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
    plot(x = -3:3,xlim = c(-6,6), type = "n", xlab = "", ylab = "", main = "Bias")
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
    if (is.null(input$Click1)){
      return()
    }
    #Save the coordinates of clicked points as two vectors
    isolate({
      var1$x <- c(var1$x, input$Click1$x)
      var1$y <- c(var1$y, input$Click1$y)
    })
  })
  
  #Reset the button to FALSE so that all the conditionalPanel will disappear
  observeEvent(input$submit1,{{
    updateButton(session,"submit1",label = "Try",style = "danger")
  }})
  #Reset(clear) the clicked points
  observe({
    if (input$submit1 == FALSE){
      var1$x <- NULL
      var1$y <- NULL
    }
  })
  
  output$target1 <- renderPlot({
    plotTarget(var1$x,var1$y)
  },height = 380, width = 380)
  
  output$plot1a <- renderPlot({
    plotA(var1$x,var1$y)
  },height = 380, width = 380)
  
  output$plot1b <- renderPlot({
    plotB(var1$x,var1$y)
  },height = 380, width = 380)
  
  #Distance between the center of target(population) and the center of the cloud of dots(ave. of samples)
  output$bias1 <- renderText({
    print(sqrt(mean(var1$x)^2 + mean(var1$y)^2))
  })
  
  #Average distance between each dots
  output$reliability1 <- renderText({
    print(mean(dist(cbind(var1$x,var1$y))))
  })
  
  output$answer1 <- renderText({
    #When the measurement of bias > 2 and of variance >2.5, it is considered as correct
    if ((sqrt(mean(var1$x)^2 + mean(var1$y)^2) > 2) & 
        (mean(dist(cbind(var1$x,var1$y))) > 2.5)){
      print("Correct!")
    }else{print("Wrong! Please try again.")}
  })
  

###Repeat three times for the other three tabs
  observe({
    if (is.null(input$Click2)){
      return()
    }
    
    isolate({
      var2$x <- c(var2$x, input$Click2$x)
      var2$y <- c(var2$y, input$Click2$y)
    })
  })
  
  #Reset the button to FALSE so that all the conditionalPanel will disappear
  observeEvent(input$submit2,{{
    updateButton(session,"submit2",label = "Try",style = "danger")
  }})
  #Reset(clear) the clicked points
  observe({
    if (input$submit2 == FALSE){
      var2$x <- NULL
      var2$y <- NULL
    }
  })
  output$target2 <- renderPlot({
    plotTarget(var2$x,var2$y)
  },height = 380, width = 380)
  
  output$plot2a <- renderPlot({
    plotA(var2$x,var2$y)
  },height = 380, width = 380)
  
  output$plot2b <- renderPlot({
    plotB(var2$x,var2$y)
  },height = 380, width = 380)
  
  output$bias2 <- renderText({
    print(sqrt(mean(var2$x)^2 + mean(var2$y)^2))
  })
  
  output$reliability2 <- renderText({
    print(mean(dist(cbind(var2$x,var2$y))))
  })
  
  output$answer2 <- renderText({
    #When the measurement of bias > 2 and of variance < 2, it is considered as correct
    if ((sqrt(mean(var2$x)^2 + mean(var2$y)^2) > 4) & 
        (mean(dist(cbind(var2$x,var2$y))) < 1.5)){
      print("Great! Nicely done!")
    }else if ((sqrt(mean(var2$x)^2 + mean(var2$y)^2) > 3) & (mean(dist(cbind(var2$x,var2$y))) < 2))
      {print("Good job!")
      }else if ((sqrt(mean(var2$x)^2 + mean(var2$y)^2) > 2) & (mean(dist(cbind(var2$x,var2$y))) < 2))
      {print("Not bad! Try again.")
        }else{print("You can do better. Try again.")}
  })
  output$instruction2 <- renderText({
    if ((sqrt(mean(var2$x)^2 + mean(var2$y)^2) > 4) & (mean(dist(cbind(var2$x,var2$y))) < 1.5)){
      print("The center of dots is far from the center of the target, which gives a large bias.
             Dots are close to each other, which shows a high reliability.")
    }else if ((sqrt(mean(var2$x)^2 + mean(var2$y)^2) > 3) & (mean(dist(cbind(var2$x,var2$y))) < 2)){
      print("The center of dots can be further from the center of the target to show a large bias.
             Dots can be closer to each other to show a high reliability.")
    }else{
      print("The center of dots should be further from the center of the target to show a large bias.
             Dots should be closer to each other to show a high reliability.")
    }
  })
  
  
  observe({
    if (is.null(input$Click3)){
      return()
    }
    
    isolate({
      var3$x <- c(var3$x, input$Click3$x)
      var3$y <- c(var3$y, input$Click3$y)
    })
  })
  #Reset the button to FALSE so that all the conditionalPanel will disappear
  observeEvent(input$submit3,{{
    updateButton(session,"submit3",label = "Try",style = "danger")
  }})
  #Reset(clear) the clicked points
  observe({
    if (input$submit1 == FALSE){
      var3$x <- NULL
      var3$y <- NULL
    }
  })
  output$target3 <- renderPlot({
    plotTarget(var3$x,var3$y)
  },height = 380, width = 380)
  
  output$plot3a <- renderPlot({
    plotA(var3$x,var3$y)
  },height = 380, width = 380)
  
  output$plot3b <- renderPlot({
    plotB(var3$x,var3$y)
  },height = 380, width = 380)
  
  output$bias3 <- renderText({
    print(sqrt(mean(var3$x)^2 + mean(var3$y)^2))
  })
  
  output$reliability3 <- renderText({
    print(mean(dist(cbind(var3$x,var3$y))))
  })
  
  output$answer3 <- renderText({
    #When the measurement of bias < 1 and of variance > 2.5, it is considered as correct
    if ((sqrt(mean(var3$x)^2 + mean(var3$y)^2) < 1) & 
        (mean(dist(cbind(var3$x,var3$y))) > 2.5)){
      print("Correct!")
    }else{print("Wrong! Please try again.")}
  })
  
  
  observe({
    if (is.null(input$Click4)){
      return()
    }
    
    isolate({
      var4$x <- c(var4$x, input$Click4$x)
      var4$y <- c(var4$y, input$Click4$y)
    })
  })
  #Reset the button to FALSE so that all the conditionalPanel will disappear
  observeEvent(input$submit4,{{
    updateButton(session,"submit4",label = "Try",style = "danger")
  }})
  #Reset(clear) the clicked points
  observe({
    if (input$submit4 == FALSE){
      var4$x <- NULL
      var4$y <- NULL
    }
  })
  output$target4 <- renderPlot({
    plotTarget(var4$x,var4$y)
  },height = 380, width = 380)
  
  output$plot4a <- renderPlot({
    plotA(var4$x,var4$y)
  },height = 380, width = 380)
  
  output$plot4b <- renderPlot({
    plotB(var4$x,var4$y)
  },height = 380, width = 380)
  
  output$bias4 <- renderText({
    print(sqrt(mean(var4$x)^2 + mean(var4$y)^2))
  })
  
  output$reliability4 <- renderText({
    print(mean(dist(cbind(var4$x,var4$y))))
  })
  
  output$answer4 <- renderText({
    #When the measurement of bias < 1 and of variance < 2, it is considered as correct
    if ((sqrt(mean(var4$x)^2 + mean(var4$y)^2) < 1) & 
        (mean(dist(cbind(var4$x,var4$y))) < 2)){
      print("Correct!")
    }else{print("Wrong! Please try again.")}
  })
  
 

    
   
})



