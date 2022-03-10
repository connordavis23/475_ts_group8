

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
    value_new <- as.integer(value_purchased)
    
    value_new <- stocks[stocks$date == new_date & stocks$symbol == input$purchased_stock , 'close'  ] * input$buy_amount
    value_new <- as.integer(value_new)
  
    print('If output values are NA, either the chosen stock is not available, or the day selected is not a trading day. ')
    print(value_purchased)
    print(value_new)
    
    if(value_new > value_purchased) {paste('The value of your stock increased by', value_new - value_purchased )  }
    if(value_new < value_purchased) {paste('The value of your stock decreased by', value_new - value_purchased )  }
    
  })
  
  
}









