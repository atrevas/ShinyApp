library(shiny)
library(ggplot2)  # For the diamonds data set

# Get a list of the numeric variables from the diamonds data set
l <- sapply(diamonds, function(x)  is.numeric(x))
var_names <- names(l[l == TRUE])

shinyUI(
  fluidPage(

  # Application title
  titlePanel('Diamonds Variables')

  , sidebarLayout(
    sidebarPanel(
      helpText('Diamonds is a dataset containing the prices and other attributes of almost 54,000 diamonds.')
      , selectInput('var', 'Select the variable to plot:', var_names)
      , selectInput('color', 'Select the color:'
                    , choices = c('blue', 'green', 'darkgreen'))
    ),

    # Show a plot of the generated distribution
    mainPanel(
      h3('Kernel density plot', align = 'center')
      , plotOutput("distPlot")
      , h3('Summary of the variable', align = 'center')
      , verbatimTextOutput('summaryText')
    )
  )
))
