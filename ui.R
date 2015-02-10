library(shiny)
shinyUI(pageWithSidebar(
        headerPanel("Graphical Representation of Power"),
        sidebarPanel(
                p("Change the parameters below to see how power for the test is changing."),
                sliderInput('mu0', 'mean under the null hypothesis',value = 30, min = 28, max = 32, step = 1,),
                sliderInput('sigma', 'population standard deviation',value = 4, min = 1, max = 10, step = 1,),
                sliderInput('mua', 'mean under the alternative',value = 32, min = 30, max = 35, step = 1,),
                sliderInput('n', 'sample size',value = 16, min = 2, max = 50, step = 1,),
                sliderInput('alpha', 'type 1 error rate',value = 0.05, min = 0.01, max = 0.1, step = 0.01,)
        ),
        mainPanel(
                h3("Sample Mean Test ( H0:mua=mu0 | Ha:mua>mu0 )"),
                p("Power is the probability to reject the null hypothesis if alternative is true, calibrated for a given alpha (e.g. type 1 error rate). This is the area under the blue curve on the right hand side of the vertical black line. Power is:"),
                verbatimTextOutput("power"),
                p("Black vertical line shows critical value beyond which null hypothesis is rejected, e.g. if sample mean is greater than that threshold value. Critical value is:"),
                verbatimTextOutput("xitc"),
                p("The distribution curves below are properly following a t-student distribution (of n-1 degrees of freedom) unlike the curves in the Statistical Inference course example which follow a normal distribution."),
                plotOutput('powerPlot')
        )
))