library(shiny)
library(ggplot2)  # For the diamonds data set and plot functions

# Get a list of the numeric variables from the diamonds data set
l <- sapply(diamonds, function(x)  is.numeric(x))
num_vars <- names(l[l == TRUE])
fac_vars <- names(l[l == FALSE])

shinyUI(
  fluidPage(

    # Application title
    titlePanel('Diamonds Variables Explorer')

    , sidebarLayout(
        sidebarPanel(
          helpText(
            'This Shiny App allows you to visualize the variables from the Diamonds data set.'
            , 'You should select a numeric variable and a categorical variable.'
            , 'Then the app will plot the former grouped by the latter.'
          )
          , selectInput('vnum', 'Select a numeric variable to plot:'
                        , choices = num_vars)
          , selectInput('vcat', 'Select a categorical variable:'
                    , choices = fac_vars)
        )
    
    # Show a plot of the generated distribution
    , mainPanel(
       tabsetPanel(
          type = 'tabs'  
          , tabPanel('Density Plot', plotOutput('densityPlot'))
          ,  tabPanel('Box Plot', plotOutput('boxPlot'))
          , tabPanel('Help',
            helpText
              (
              h3('Prices of 50,000 round cut diamonds')
              , h4('Description')
              , p('The diamonds dataset contains the prices and other attributes of almost 54,000 diamonds.')
              , h4('Format')
              , p('A data frame with 53,940 rows and 10 variables.')
              , h4('Details')
              , tags$ul
                (
                  tags$li('price - price in US dollars')
                  , tags$li('carat - weight of the diamond')
                  , tags$li('cut - quality of the cut (Fair, Good, Very Good, Premium, Ideal)')
                  , tags$li('colour - diamond colour, from J (worst) to D (best)')
                  , tags$li('clarity - a measurement of how clear the diamond is (I1 (worst), SI1, SI2, VS1, VS2, VVS1, VVS2, IF (best))')
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
