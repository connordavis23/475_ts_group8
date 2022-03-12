#nstall.packages('ggplot')
#install.packages('ggplot2')
#library('ggplot')
library('ggplot2')
library('shiny')
library('dplyr')
library('fpp3')
library('readr')
#install.packages('shinythemes')
library('shinythemes')
library('plotly')

stocks <- as.data.frame(stocks)
stocks <- read_csv('nyse_stocks.csv.zip')

stocks$date <- as.Date(stocks$date)
stocks <- tsibble(stocks, index = date, key = symbol )


ui <- fluidPage(
  shinytheme("sandstone"),
  
  selectInput("Symbol", 
              label = "Select a Symbol:",
              choices = unique(stocks$symbol)),
 
  dateInput ("Date",
             label = paste('Input a Date'),
             value = "2010-01-01",
             min = "2010-01-01", 
             max = "2017-02-01",
             format = "dd/mm/yy",
             startview = 'year', language = 'eng', weekstart = 1
     ),
verbatimTextOutput("return"),
actionButton("goButton", "Go!"),
plotlyOutput("stockapp"),
  )




server <- function(input, output, session){
  
  symbol <- eventReactive(input$goButton, {
    input$Symbol })
  
  date <- eventReactive(input$goButton, {
    input$Date})
  

  output$stockapp <- renderPlotly({
    filtered_stocks <- stocks[stocks$symbol == input$Symbol, ]
    filtered_stocks <- filtered_stocks[filtered_stocks$date > input$Date, ]
    filtered_stocks <- filtered_stocks[filtered_stocks$date < '2022-03-10', ]
    filtered_stocks <- filtered_stocks[ , c("date","open", "close")]
    filtered_stocks$percent_change <- ((filtered_stocks$open - filtered_stocks$close)/ 
                                         filtered_stocks$open * 100)
    
    autoplot(filtered_stocks, .vars = percent_change) %>%
      ggplotly()

  })
}

shinyApp(ui, server)



