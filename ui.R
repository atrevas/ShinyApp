library(shiny)
library(ggplot2)  # For the diamonds data set and plot functions

# Get a list of the numeric variables from the diamonds data set
l <- sapply(diamonds, function(x)  is.numeric(x))
var_names <- names(l[l == TRUE])

shinyUI(
  fluidPage(

    # Application title
    titlePanel('Diamonds Variables')

    , sidebarLayout(
       sidebarPanel(
       helpText('The diamonds dataset contains the prices and other attributes of almost 54,000 diamonds.')
       , helpText('This Shiny App displays a kernel density plot for one of the numeric variables of the diamonds data set.')
       , selectInput('var', 'Select the variable to plot:', var_names)
       , selectInput('color', 'Select the color:'
                    , choices = c('blue', 'green', 'darkgreen'))
       )
    
    # Show a plot of the generated distribution
    , mainPanel(
       tabsetPanel(
         type = 'tabs'  
         , tabPanel('Plot', plotOutput("distPlot"))
         , tabPanel('Summary', verbatimTextOutput('summaryText'))
       ) 
     )
   )
  )
)
