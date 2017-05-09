if(!("shiny" %in% rownames(installed.packages()))) {
  install.packages("shiny")
}
library(shiny)

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
      layout(title = "Number of (o)esophageal cancer cases", 
             xaxis = list(title = "Age (years)"), yaxis = list(title = "Number of cases"))
  })
  
  output$samp <- renderText({
    count <- 0
    for(i in 1:88){
      if((esoph[i, "alcgp"] %in% input$alc) & (esoph[i, "tobgp"] %in% input$tob)){
        count <- count + 1
      }  
    }
    t <- c("Sample size: ", count)
    t
  })

  output$source <- renderText({
    "Data from a case-control study of (o)esophageal cancer in Ille-et-Vilaine, France.  Source: Breslow, N. E. and Day, N. E. (1980) Statistical Methods in Cancer Research. Volume 1: The Analysis of Case-Control Studies. IARC Lyon / Oxford University Press."
  })
  
})
