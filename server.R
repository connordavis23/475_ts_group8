

server <- function(input, output) {
  
  output$ts_plot <- renderPlot({
    
    min.date <- input$selected_date_range[1]
    max.date <- input$selected_date_range[2]
    
    plot_df <- stocks[stocks$symbol == input$selected_stock & stocks$date >= min.date & stocks$date <= max.date , ]
    
    plot_df <- plot_df[ ,c('date', 'symbol', input$selected_metric) ]
    autoplot(plot_df)
  })
  
  output$ts_plot2 <- renderPlot({
    
    min.date <- input$selected_date_range[1]
    max.date <- input$selected_date_range[2]
    
    plot_df <- stocks[stocks$symbol == c(input$selected_stock1, input$selected_stock2) & stocks$date >= min.date & stocks$date <= max.date , ]
    
    plot_df <- plot_df[ ,c('date', 'symbol', input$selected_metric2) ]
    autoplot(plot_df)
  })
  
  output$table_f2 <- renderTable({
    min.date <- input$selected_date_range[1]
    max.date <- input$selected_date_range[2]
    
    plot_df <- stocks[stocks$symbol == c(input$selected_stock1, input$selected_stock2) & stocks$date >= min.date & stocks$date <= max.date , ]
    
    plot_df <- plot_df[ max(input$selected_metric2) ,c('date', 'symbol', input$selected_metric2) ]
  })
  
  output$stock_change <- renderPrint({
    
    purchase_date <- input$date1
    new_date <- input$date2
    
    value_purchased <- stocks[stocks$date == purchase_date & stocks$symbol == input$purchased_stock , 'close' ] * input$buy_amount
    value_purchased <- round(as.numeric(value_purchased),2)
    
    value_new <- stocks[stocks$date == new_date & stocks$symbol == input$purchased_stock , 'close'  ] * input$buy_amount
    value_new <- round(as.numeric(value_new),2)
    
    print(value_purchased)
    print(value_new)

    print('If output values are NA, either the chosen stock is not available, or the day selected is not a trading day. ')
    paste('At the time of purchase, your stock was worth', value_purchased)
    paste('At the new date, your stock is now worth', value_new)
    if(value_new > value_purchased ){paste('This is an increase of', value_new - value_purchased ) }
    if(value_new < value_purchased ){paste('This is a decrease of', value_new - value_purchased ) }
    
    
  })
  
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



