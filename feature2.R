ui <- fluidPage(
  
  selectInput("Symbol", 
              label = "Select a Symbol:",
              choices = unique(stocks$symbol),
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
  ),
)

server <- function(input, output, session){
  
  symbol <- eventReactive(input$goButton, {
    input$Symbol })
  
  date <- eventReactive(input$goButton, {
    input$Date})
  
  renderPrint({stock <- gg_plot(symbol(),                    
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
    stock2 <- gg_plot(symbol(),                    
                      from = '2005-01-01',
                      to = "2022-03-08",
                      get = "stock.prices")
    
    chart <- stock2 %>% 
      filter(date >= date() & date <= "2022-03-08") %>% 
      select(date, close)
    
    chart %>% gg_plot(aes(x = date, y = close)) + 
      geom_line()
  })
}

shinyApp(ui, server)
