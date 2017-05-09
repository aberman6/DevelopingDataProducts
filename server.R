if(!("shiny" %in% rownames(installed.packages()))) {
  install.packages("shiny")
}
library(shiny)

if(!("ggplot2" %in% rownames(installed.packages()))) {
  install.packages("ggplot2")
}
library(ggplot2)

if(!("plotly" %in% rownames(installed.packages()))) {
  install.packages("plotly")
}
library(plotly)

shinyServer(function(input, output, session) {
  
  #initialize data frame
  df <- esoph[1,]
  df <- df[-1,]
  
  output$casePlot <- renderPlotly({

    #segment esoph by alcgp
    count <- 0
    for(i in 1:88){
      if((esoph[i, "alcgp"] %in% input$alc) & (esoph[i, "tobgp"] %in% input$tob)){ 
        count <- count + 1
        df[count,] <- esoph[i,]
      }  
    }
    
    #create the plot
    plot_ly(data = df, x = ~agegp, y = ~ncases, type = input$chatType, marker = list(size = 10)) %>%
      layout(xaxis = list(title = "Age (years)"), yaxis = list(title = "Number of cases"))
  })
  
  output$tex <- renderText({
    count <- 0
    for(i in 1:88){
      if((esoph[i, "alcgp"] %in% input$alc) & (esoph[i, "tobgp"] %in% input$tob)){
        count <- count + 1
      }  
    }
    t <- c("Sample size: ", count)
    t
  })
})
