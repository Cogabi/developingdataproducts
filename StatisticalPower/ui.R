library(shiny)
library(ggplot2)

shinyUI(fluidPage(
    titlePanel("Power Calculator for Normal Distribution"),
    sidebarLayout(
        sidebarPanel(
            numericInput("mu0",
                         "mu0:",
                         min = 0,
                         value = 30),
            sliderInput("mua",
                        "mua:",
                        min = 30,
                        max = 36,
                        value = 32),
            sliderInput("sigma",
                        "sigma:",
                        min = 1,
                        max = 10,
                        value = 4),
            sliderInput("n",
                        "n:",
                        min = 1,
                        max = 50,
                        value = 16),
            sliderInput("alpha",
                        "alpha:",
                        min = 0.01,
                        max = 0.1,
                        value = 0.05,
                        step = 0.01)
        ),
        
        mainPanel(
            h3("Power:"),
            textOutput("power"),
            h4("Power is area under the blue curve to the right of the vertical line"),
            plotOutput("plot"),
            h3("Instructions:"),
            p("The formula for power is: pnorm(mu0 + qnorm(1-alpha)* sigma/sqrt(n), mean= mua, sd = sigma/sqrt(n), lower.tail = FALSE)"),
            p("The side panel contains an input box for mu0 and sliders for mua, sigma, n and alpha."),
            p("Changing the mu0 value will change the slider for mua so that mua = m0+2 by default."),
            p("Adjusting mua will move the blue normal distribution curve left or right so the center is at the mean."),
            p("Adjusting sigma and n will broaden or narrow both curves."),
            p("Adjusting alpha will move the vertical line left or right so that the area under the red curve to the right of the line is equal to alpha.")
        )
    )
))

