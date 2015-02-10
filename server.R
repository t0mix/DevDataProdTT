library(shiny)
library(ggplot2)

shinyServer(
        function(input, output) {
                output$powerPlot <- renderPlot({
                        
                        x <- seq(27, 36, by = 0.01)

                        y <- dt((x-input$mu0)/(input$sigma/sqrt(input$n)),input$n-1)
                        
                        df <- data.frame(x)
                        df <- cbind(df, y)
                        df$sampleMean <- "distribution under null hypothesis"
                        
                        y <- dt((x-input$mua)/(input$sigma/sqrt(input$n)),input$n-1)
                        
                        dfa <- data.frame(x)
                        dfa <- cbind(dfa, y)
                        dfa$sampleMean <- "distribution under alternative hypothesis"
                        
                        df <- rbind(df, dfa)

                        xitc <- input$mu0 + qt(1 - input$alpha,df = input$n) * input$sigma/sqrt(input$n)
                        power <- power.t.test(input$n,input$mua-input$mu0,sd=input$sigma,type="one.sample",alt="one.sided",sig.level = input$alpha)$power
                        
                        output$xitc <- renderPrint({xitc})
                        output$power <- renderPrint({power})
                        
                        ggplot(df, aes(x=x, y=y, colour=sampleMean), xlab="mean", ylab="probability") + 
                                geom_line() + 
                                geom_vline(xintercept = xitc, size = 1) + 
                                scale_colour_manual(name="",values=c("blue", "red")) + 
                                theme(legend.position="top", legend.direction="horizontal") +
                                ggtitle("Sample Mean Distribution") +
                                xlab("mean") +
                                ylab("probability") 
                        
                })
        }
)