#nstall.packages('ggplot')
#install.packages('ggplot2')
#library('ggplot')
library('ggplot2')
library('shiny')
library('dplyr')
library('fpp3')
library('readr')

stocks <- as.data.frame(stocks)
stocks <- read_csv('nyse_stocks.csv.zip')

stocks$date <- as.Date(stocks$date)
stocks <- tsibble(stocks, index = date, key = symbol )


ui <- fluidPage(
  
  selectInput("Symbol", 
              label = "Select a Symbol:",
              choices = unique(stocks$symbol)),
              dateInput ("Date",
                         label = paste('Please Input your Date'),
                         value = as.character(Sys.Date()),
                         min = "2005-1-1", max = Sys.Date(),
                         format = "dd/mm/yy",
                         startview = 'year', language = 'eng', weekstart = 1
              ),
              
              verbatimTextOutput("return"),
              actionButton("goButton", "Go!"),
              plotOutput("stockapp")
  )


server <- function(input, output, session){
  
  symbol <- eventReactive(input$goButton, {
    input$Symbol })
  
  date <- eventReactive(input$goButton, {
    input$Date})
  
  renderPrint({stock <- ggplot(symbol(),                    
                                from = '2005-01-01',
                                to = "2022-03-08",
                                get = "stock.prices")
  
  
  first_price <- stock %>% 
    filter(date == date()) %>% 
    dplyr::select(close)
  
  second_price <-  stock %>% 
    filter(date == "2022-03-07") %>% 
    dplyr::select(close)
  
  ((second_price-first_price)/first_price*100)})
  
  output$stockapp <- renderPlot({
    stock2 <- ggplot(symbol(),                    
                      from = '2005-01-01',
                      to = "2022-03-08",
                      get = "stock.prices")
    
    chart <- stock2 %>% 
      filter(date >= date() & date <= "2022-03-08") %>% 
      select(date, close)
    
    chart %>% ggplot(aes(x = date, y = close)) + 
      geom_line()
  })
}

shinyApp(ui, server)



