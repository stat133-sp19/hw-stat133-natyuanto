#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)
library(reshape2)

# Define UI for application that draws a histogram
ui <- fluidPage(
   
   # Application title
   titlePanel("Saving Simulation"),
   
   # Sidebar with a slider input for number of bins 
   fluidRow(
     column(4,
            sliderInput("initial",
                        "Initial amount",
                        min = 1,
                        max = 100000,
                        value = 1000, 
                        step = 500)),
     column(4,
            sliderInput("rate", 
                        "Return Rate (in %)",
                        min = 0,
                        max = 20,
                        value = 5,
                        step = 0.1)),
     column(4,
            sliderInput("year",
                        "Years",
                        min = 0,
                        max = 50,
                        value = 20,
                        step = 1))),
   fluidRow(
     column(4,
            sliderInput("annual", "Annual Contribution",
                        min = 0, 
                        max = 50000,
                        value = 2000,
                        step = 500)),
     column(4,
            sliderInput("growth", "Growth Rate (in %)",
                        min = 0, 
                        max = 20,
                        value = 2,
                        step = 0.1)),
     column(4,
            selectInput("facet",
                        "Facet?",
                        choices = c("Yes", "No"),
                        selected = "No"))),
      
      # Show a plot of the generated distribution
      mainPanel(
        h4('Timelines'),
        plotOutput("timeline"),
        h4('Balances'),
        verbatimTextOutput("balances")
   )
)


#' @title Future Value Function
#' @description Calculate the future value of an investment
#' @param amount : initial invested amount
#' @param rate : annual rate of return 
#' @param years : number of years
#' @result amount after compound interest

future_value <- function(amount, rate, years){
  if(amount < 0 || rate < 0 || years < 0) {
    stop("Function cannot take negative values")
  }else {
  final_value <- amount * ((1 + rate)^years)
  return(final_value)
  }
}

#' @title Future Value of Annuity
#' @description Calculate the future value of annuity
#' @param contrib : contributed amount
#' @param rate : annual rate of return 
#' @param years : number of years
#' @result amount after a group of recurring payments at a specified date in the future

annuity <- function(contrib, rate, years){
  if (contrib < 0 || rate < 0 || years < 0){
    stop("Function cannot take negative values")
  }else {
  bracket <- (((1 + rate)^years) - 1)/rate
  final_value <- contrib * bracket
  return(final_value)
  }
}

#' @title Future Value of Growing Annuity
#' @description Calculate the future value of growing annuity
#' @param contrib : contributed amount
#' @param rate : annual rate of return 
#' @param growth : annual growth rate
#' @param years : number of years
#' @result amount after a series of cash flows, or payments, that grow at a proportionate rate

growing_annuity <- function(contrib, rate, growth, years){
  if(contrib < 0 || rate < 0 || growth < 0 || years < 0){
    stop("Function cannot take negative values")
  }else {
  bracket <- (((1 + rate)^years) - ((1 + growth)^years))/(rate - growth)
  final_value <- contrib * bracket
  return(final_value)
  }
}

# Define server logic required to draw a timeline plot and data table
server <- function(input, output) {
  
  output$timeline <- renderPlot({
    
    no_contrib = c()
    fixed_contrib = c()
    growing_contrib = c()
    
    for (i in 1:(input$year + 1)) {
      no_contrib[i] = future_value(amount = input$initial, rate = input$rate / 100, years = i - 1)
      fixed_contrib[i] = future_value(amount = input$initial, rate = input$rate / 100, years = i - 1) + annuity(contrib = input$annual, rate = input$rate / 100, years = i - 1)
      growing_contrib[i] = future_value(amount = input$initial, rate = input$rate / 100, years = i - 1) + growing_annuity(contrib = input$annual, rate = input$rate / 100, growth = input$growth / 100, years = i - 1)
    }
    
    simulation = data.frame(year = 0:input$year, variable = rep(c('no_contrib', 'fixed_contrib', 'growing_contrib'), each = input$year + 1), balance = c(no_contrib, fixed_contrib, growing_contrib))
    simulation$variable = factor(simulation$variable, levels = c('no_contrib', 'fixed_contrib', 'growing_contrib'))

    plot1 = ggplot(data = simulation, aes(x = year, y = balance, col = variable)) + geom_line() + theme_bw() + geom_point() + ggtitle('Three modes of investing') + xlab('year') + ylab('value') + scale_color_discrete('variable')
    
    if (input$facet == "Yes") {
      plot1 = plot1 + geom_area(aes(fill = variable), alpha = .5) + facet_wrap(~variable)
    }
    plot1
  })
  
  output$balances <- renderPrint({
    
    year = c()
    no_contrib = c()
    fixed_contrib = c()
    growing_contrib = c()
    
    for (i in 1:(input$year + 1)) {
      year[i] = i - 1
      no_contrib[i] = future_value(amount = input$initial, rate = input$rate / 100, years = i - 1)
      fixed_contrib[i] = future_value(amount = input$initial, rate = input$rate / 100, years = i - 1) + annuity(contrib = input$annual, rate = input$rate / 100, years = i - 1)
      growing_contrib[i] = future_value(amount = input$initial, rate = input$rate / 100, years = i - 1) + growing_annuity(contrib = input$annual, rate = input$rate / 100, growth = input$growth / 100, years = i - 1)
    }
    data.frame(cbind(year, no_contrib, fixed_contrib, growing_contrib))
  })
}


# Run the application 
shinyApp(ui = ui, server = server)

