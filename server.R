library(shiny)
library(ggplot2)
library(scales)

# Define the server logic for the shiny app
shinyServer(function(input, output) {

  # Reactive function to update variable name
  var <- reactive({
    input$var
  })
  
  color <- reactive({
    input$color
  })
  
  output$distPlot <- renderPlot({
    x_label <- paste0(toupper(substring(var(), 1, 1)), substring(var(), 2))
    title <- paste0('Density Curve - ', x_label, '\n')
    y_label <- 'Density'
    
    # It is necessary to use aes_string to manage variable names in the call
    # to ggplot
    ggplot(diamonds, aes_string(x = var())) +
      geom_density(fill = color(), colour = NA, alpha = .2) +
      geom_line(stat = 'density',  colour = color()) +
      scale_y_continuous(labels = percent) +
      ggtitle(title) +
      theme(plot.title = element_text(size = rel(2))) +
      xlab(x_label) +
      ylab(y_label)

  })
  
  output$summaryText <- renderPrint({
    summary(diamonds[, var()])
  })
})
