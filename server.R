library(shiny)
library(png)
shinyServer(function(input, output,session) {
  var1 <- reactiveValues(x = NULL, y = NULL)
  var2 <- reactiveValues(x = NULL, y = NULL)
  var3 <- reactiveValues(x = NULL, y = NULL)
  var4 <- reactiveValues(x = NULL, y = NULL)

  plotTarget = function(x,y){
    #Get image
    isolate(ima <- readPNG("t6.png"))
    
    #Set up the plot area
    isolate(plot(x=-5:5,ylim=c(-5,5),xlim=c(-5,5),type='p',xlab = ''))
    
    #Get the plot information so the image will fill the plot box, and draw it
    isolate(lim <- par())
    isolate(rasterImage(ima, lim$usr[1], lim$usr[3], lim$usr[2], lim$usr[4]))
    isolate(grid())
    lines(x,y, xlim = c(-5,5), ylim = c(-5,5),type = 'p', pch = 20)
  }
  
  plotA = function(x,y){
    plot(x = -3:3,xlim = c(-6,6), type = "n", xlab = "", ylab = "", main = "Bias")
    box(col = "red")
    abline(v=0,col = "red")
    abline(v = sqrt(mean(x)^2 + mean(y)^2))
  }
  
  plotB = function(x,y){
    plot(density(sqrt(x^2 + y^2)), xlab = '', ylab = '', main = 'Reliability')
    box(col = "red")
  }
    
  observe({
    # Initially will be empty
    if (is.null(input$Click1)){
      return()
    }
    
    isolate({
      var1$x <- c(var1$x, input$Click1$x)
      var1$y <- c(var1$y, input$Click1$y)
    })
  })
  
  output$target1 <- renderPlot({
    plotTarget(var1$x,var1$y)
    
  },height = 400, width = 400)
  
  output$plot1a <- renderPlot({
    plotA(var1$x,var1$y)
  },height = 400, width = 400)
  
  output$plot1b <- renderPlot({
    plotB(var1$x,var1$y)
  },height = 400, width = 400)
  

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
  output$target2 <- renderPlot({
    plotTarget(var2$x,var2$y)
  },height = 400, width = 400)
  
  output$plot2a <- renderPlot({
    plotA(var2$x,var2$y)
  },height = 400, width = 400)
  
  output$plot2b <- renderPlot({
    plotB(var2$x,var2$y)
  },height = 400, width = 400)
  
  observe({
    if (is.null(input$Click3)){
      return()
    }
    
    isolate({
      var3$x <- c(var3$x, input$Click3$x)
      var3$y <- c(var3$y, input$Click3$y)
    })
  })
  output$target3 <- renderPlot({
    plotTarget(var3$x,var3$y)
  },height = 400, width = 400)
  output$hist3 <- renderPlot({
    curve(dnorm(x, mean = sqrt(mean(var3$x)^2 + mean(var3$y)^2), sd = sqrt((sum((var3$x-mean(var3$x))^2 + (var3$y-mean(var3$y))^2))/length(var3$x))),xlim = c(-5,5),ylab = '')
    abline(v=0)
  },height = 400, width = 400)
  
  observe({
    if (is.null(input$Click4)){
      return()
    }
    
    isolate({
      var4$x <- c(var4$x, input$Click4$x)
      var4$y <- c(var4$y, input$Click4$y)
    })
  })
  output$target4 <- renderPlot({
    plotTarget(var4$x,var4$y)
  },height = 400, width = 400)
  output$hist4 <- renderPlot({
    curve(dnorm(x, mean = sqrt(mean(var4$x)^2 + mean(var4$y)^2), sd = sqrt((sum((var4$x-mean(var4$x))^2 + (var4$y-mean(var4$y))^2))/length(var4$x))),xlim = c(-5,5),ylab = '')
    abline(v=0)
  },height = 400, width = 400)
 

    
   
})



