#install and load packages
if(!("shiny" %in% rownames(installed.packages()))) {
  install.packages("shiny")
}
library(shiny)

if(!("plotly" %in% rownames(installed.packages()))) {
  install.packages("plotly")
}
library(plotly)

#load dataset from R base package
data("esoph")

shinyUI(fluidPage(

  # Application title
  titlePanel("(O)esophageal Cancer in Ille-et-Vilaine, France"),

  # Sidebar with a slider input for number of bins
  sidebarLayout(
      sidebarPanel(
        radioButtons("chatType", "Choose your chart type:", 
                     c("Boxplot" = "box", "Scatterplot" = "scatter")),
        checkboxGroupInput("alc", "Choose the cases to display - alcohol consumption:",
                     c("0-39g/day", "40-79", "80-119", "120+"), selected = c("0-39g/day", "40-79", "80-119", "120+")),
        checkboxGroupInput("tob", "Choose the cases to display - tobacco consumption:",
                     c("0-9g/day", "10-19", "20-29", "30+"), selected = c("0-9g/day", "10-19", "20-29", "30+"))
      ),
    
    # Show a plot of the generated distribution
    mainPanel(
      plotlyOutput("casePlot"),
      h3(textOutput("tex"))
    )
  )
))
