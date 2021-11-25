library(shiny)
library(ggplot2)

shinyServer(function(input, output, session) {
    observe({
        mu0 <- input$mu0
        updateSliderInput(session, "mua", value = mu0+2,
                          min = mu0, max = mu0+6, step = 1)
        
        
    })
    power<-reactive({
        mu0 <- input$mu0
        mua <- input$mua
        sigma <- input$sigma
        n <- input$n
        alpha <- input$alpha
        pnorm(mu0 + qnorm(1-alpha)* sigma/sqrt(n), mean= mua, sd = sigma/sqrt(n), lower.tail = FALSE)
        
    })
    output$power <- renderText({power()})
    
    output$plot <- renderPlot({
        mu0 <- input$mu0
        mua <- input$mua
        sigma <- input$sigma
        n <- input$n
        alpha <- input$alpha
        myplot <- function(sigma, mua, n, alpha){
            g = ggplot(data.frame(mu = c(mu0-3, mu0+6)), aes(x = mu))
            g = g + stat_function(fun=dnorm, geom = "line", 
                                  args = list(mean = mu0, sd = sigma / sqrt(n)), 
                                  size = 2, col = "red")
            g = g + stat_function(fun=dnorm, geom = "line", 
                                  args = list(mean = mua, sd = sigma / sqrt(n)), 
                                  size = 2, col = "blue")
            xitc = mu0 + qnorm(1 - alpha) * sigma / sqrt(n)
            g = g + geom_vline(xintercept=xitc, size = 3)
            g
        }
        myplot(sigma, mua, n, alpha)
    })
    
})