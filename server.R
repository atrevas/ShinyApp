library(shiny)
library(ggplot2)
library(scales)

# Define the server logic for the shiny app
shinyServer(function(input, output) {

  # Reactive function to update variable name
  vnum <- reactive({
    input$vnum
  })
  
  vcat <- reactive({
    input$vcat
  })
  
  output$densityPlot <- renderPlot({
    x_label <- paste0(toupper(substring(vnum(), 1, 1)), substring(vnum(), 2))
    title <- paste0('Kernel Density Plot - ', x_label, '\n')
    y_label <- 'Density'
    
    # It is necessary to use aes_string to manage variable names in the call
    # to ggplot
    ggplot(diamonds, aes_string(x = vnum(),  fill = vcat())) +
      geom_density(alpha = 0.7) +
      #geom_line(stat = 'density',  aes_string(colour = color())) +
      #scale_y_continuous(labels = percent) +
      ggtitle(title) +
      theme(plot.title = element_text(size = rel(2))) +
      xlab(x_label) +
      ylab(y_label)

  })
  
  output$boxPlot <- renderPlot({
    x_label <- paste0(toupper(substring(vcat(), 1, 1)), substring(vcat(), 2))
    y_label <- paste0(toupper(substring(vnum(), 1, 1)), substring(vnum(), 2))
    title <- paste0('Box Plot - ', x_label, ' x ', y_label, '\n')
    
    ggplot(diamonds, aes_string(x = vcat(), y = vnum(), fill = vcat())) +
      geom_boxplot() +
      guides(fill=FALSE) +
      ggtitle(title) +
      theme(plot.title = element_text(size = rel(2))) +
      xlab(x_label)  +
      ylab(y_label)
  })
  
  output$summaryText <- renderPrint({
    summary(diamonds[, vnum()])  
  })
  
  output$summary2Text <- renderPrint({
    table(diamonds[, vcat()])  
  })
  
 
})
