library(shiny)
library(ggplot2)  # For the diamonds data set and plot functions

# Get a list of the numeric variables from the diamonds data set
l <- sapply(diamonds, function(x)  is.numeric(x))
var_names <- names(l[l == TRUE])

shinyUI(
  fluidPage(

    # Application title
    titlePanel('Diamonds Variables Explorer')

    , sidebarLayout(
        sidebarPanel(
          helpText('This Shiny App displays a kernel density plot for one of the numeric variables of the diamonds data set.')
          , selectInput('var', 'Select a numeric variable to plot:', var_names)
          , selectInput('color', 'Select the color:'
                    , choices = c('blue', 'green', 'darkgreen'))
        )
    
    # Show a plot of the generated distribution
    , mainPanel(
       tabsetPanel(
          type = 'tabs'  
          , tabPanel('Plot', plotOutput("distPlot"))
          , tabPanel('Summary', verbatimTextOutput('summaryText'))
          , tabPanel('Help',
            helpText
              (
              h3('Prices of 50,000 round cut diamonds')
              , h4('Description')
              , p('The diamonds dataset contains the prices and other attributes of almost 54,000 diamonds.')
              , h4('Format')
              , p('A data frame with 53940 rows and 10 variables.')
              , h4('Details')
              , tags$ul
                (
                  tags$li('price - price in US dollars')
                  , tags$li('carat - weight of the diamond')
                  , tags$li('cut - quality of the cut (Fair, Good, Very Good, Premium, Ideal)')
                  , tags$li('x - length in mm')
                  , tags$li('y - width in mm') 
                  , tags$li('z - depth in mm')
                  , tags$li('depth - total depth percentage = z / mean(x, y) = 2 * z / (x + y)')
                  , tags$li('table - width of top of diamond relative to widest point')
                )
            )
         )
       ) 
     )
   )
  )
)
