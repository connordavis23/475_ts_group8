
sub2 <- stocks[stocks$trading_day == 1757:1762, c('date', 'trading_day', 'symbol', 'close'  )]
max(stocks$trading_day)

length(unique(stocks$symbol))
autoplot(sub2, close)

stocks[stocks$trading_day == max(stocks$trading_day) : stocks[stocks$trading_day == max(stocks$trading_day) - 7,]   ,  ]

sub <- stocks[stocks$trading_day[100: 1762]  , ]

stocks[stocks$trad ]
sub$symbol


ui <- fluidPage(
  selectInput(
    inputId =  'selected_stock',
    label = "Select Stock",
    choices = unique(stocks$symbol) 
  ),
  selectInput(
    inputId = 'selected_metric2',
    label = 'Select Metric',
    choices = names(metrics)
  ),
  radioButtons(
    inputId = 'selected_period',
    label = 'Select a Time Period',
    choices = c('one_day')
  ),
  
  plotOutput('plot')
)

server <- function(input, output) {
  output$plot <- renderPlot(
    
    one_day <- stocks[stocks$trading_day == 1757:1762, c('date', 'trading_day', 'symbol', 'close'  )]
    
    autoplot(one_day, close)
  )
  
}

shinyApp(ui, server)

one_day <- stocks[stocks$trading_day == 1761:1762, c('date', 'trading_day', input$selected_stock, input$selected_metric  )]
five_days <- stocks[stocks$trading_day == 1757:1762, c('date', 'trading_day', input$selected_stock, input$selected_metric  )]
one_month <- stocks[stocks$trading_day == 1740:1762, c('date', 'trading_day', input$selected_stock, input$selected_metric  )]

one_month <- stocks[stocks$trading_day == 1740:1762, c('date', 'trading_day', 'symbol', 'close'  )]
autoplot(one_month, close)




library(shiny)
library('fpp3')


ui <- fluidPage(
  selectInput(
    inputId = 'purchased_stock',
    label = 'Which Stock Would You Like To Purchase?',
    choices = unique(stocks$symbol)
  ),
  
  sliderInput(
    inputId = 'buy_amount',
    label = 'How Many Shares?',
    min = 1,
    max = 100,
    value = 100 
  ),
  
  dateInput(
    inputId = 'date1',
    label = 'Select Buy Date',
    min = min(stocks$date),
    max = max(stocks$date)
  ),
  dateInput(
    inputId = 'date2',
    label = 'Select Other Date',
    min = min(stocks$date),
    max = max(stocks$date)
  ),
  
  verbatimTextOutput('stock_change')
  
)

server <- function(input, output) {
  
 output$stock_change <- renderPrint({
   
   purchase_date <- input$date1
   new_date <- input$date2
   
   value_purchased <- stocks[stocks$date == purchase_date & stocks$symbol == input$purchased_stock , 'close' ] * input$buy_amount
   value_new <- as.integer(value_purchased)
   
   value_new <- stocks[stocks$date == new_date & stocks$symbol == input$purchased_stock , 'close'  ] * input$buy_amount
   value_new <- as.integer(value_new)
   
   
   print(value_purchased)
   print(value_new)
   
  })
  
}

shinyApp(ui, server)


value_new <- stocks[stocks$date == '2012-10-10' & stocks$symbol == 'AAPL', 'close'  ] * 100
value_new <- as.vector(value_new)
print(value_new)
value_new <- as.integer(value_new)

stocks[stocks$date == '2010-5-5' & stocks$symbol == 'AAPL', 'close'  ] * 100

library(shiny)

ui <- fluidPage(

selectInput(
  inputId = 'purchased_stock',
  label = 'Which Stock Would You Like To Purchase?',
  choices = unique(stocks$symbol)
),

sliderInput(
  inputId = 'buy_amount',
  label = 'How Many Shares?',
  min = 1,
  max = 100,
  value = 100 
),
dateInput(
  inputId = 'date1',
  label = 'Select Buy Date',
  min = min(stocks$date),
  max = max(stocks$date)
),
dateInput(
  inputId = 'date2',
  label = 'Select Other Date',
  min = min(stocks$date),
  max = max(stocks$date)
),
dateRangeInput(
  inputId = 'purchase_date_range',
  label = 'Select Date Range',
  start = min(stocks$date),
  end = max(stocks$date),
  min = min(stocks$date),
  max = max(stocks$date)
),
plotOutput('purchase_plot')


)

server <- function(input, output) {
  output$purchase_plot <- renderPlot({
    min.date1 <- input$purchase_date_range[1]
    max.date1 <- input$purchase_date_range[2]
    
    value_purchased <- stocks[stocks$date == min.date1 & stocks$symbol == input$purchased_stock , 'close' ] * input$buy_amount
    value_purchased <- as.numeric(value_purchased)
    
    value_new <- stocks[stocks$date == max.date1 & stocks$symbol == input$purchased_stock , 'close'  ] * input$buy_amount
    value_new <- as.numeric(value_new)
    
    
    ppplot <- c(value_purchased , value_new)
    ddplot <- stocks[     ]
    ddplot <- as.Date(ddplot)
    UUUplot <- data.frame(ppplot, ddplot)
    UUUplot <- tsibble(UUUplot)
    
    autoplot(UUUplot)
    
  })
  
  
}

shinyApp(ui, server)
value_purchased <- stocks[stocks$date == '2012-10-10' & stocks$symbol == 'AAPL' , 'close' ] * 100
value_purchased <- as.numeric(value_purchased)

value_new <- stocks[stocks$date == '2013-10-10' & stocks$symbol == 'AAPL' ,  'close'  ] * 100
value_new <- as.numeric(value_new)

value_new


ppplot <- c(value_purchased , value_new)
ddplot <- c(min.date1, max.date1)
ddplot <- as.Date(ddplot)
UUUplot <- data.frame(c('2012-10-10', '2013-10-10'), c(value_purchased , value_new))
UUUplot <- data.frame(ppplot, ddplot)
UUUplot <- tsibble(UUUplot)


autoplot(UUUplot)

min.date1 <- '2012-10-10'
max.date1 <- '2013-10-10'

value_purchased <- stocks[stocks$date >= min.date1 & stocks$date <= max.date1 & stocks$symbol == 'AAPL' , 'close' ] * 100
value_purchased <- as.vector(value_purchased)
value_purchased
p_dates <- stocks[stocks$date >= min.date1 & stocks$date <= max.date1, 'date'  ]
purch_date <- data.frame(value_purchased, p_dates )

p_dates <- as.vector(p_dates)
p_dates <- as.Date(p_dates)
length(p_dates)
value_purchased


stock2 <- fill_gaps(stocks)
stock2 <- tsibble(stock2, index = date, key = symbol)

stock2 %>%
  model(NAIVE(close)) %>%
  autoplot()

-------------------
output$ts_plot4<- renderPlot({
  
  min.date <- input$selected_date_range[1]
  max.date <- input$selected_date_range[2]
  
  plot_df <- stocks[stocks$gics_sector %in% c(input$selected_sector1, input$selected_sector2) & stocks$date >= min.date & stocks$date <= max.date , ]
  
  plot_df <- plot_df[ ,c('date', 'gics_sector', input$selected_metric4) ]
  
  agg_formula <- formula(paste(input$selected_metric4, '~ date + gics_sector'))
  sector <- aggregate(agg_formula, plot_df, mean)
  tsibble(sector, index=date, key=gics_sector) %>%
    autoplot()
  
})

tabPanel(
  title = 'Compare Sectors',
  
  selectInput(
    inputId =  'selected_sector1',
    label = "Select Sector",
    choices = unique(stocks$gics_sector),
    selected = "Health Care"
  ),
  
  selectInput(
    inputId =  'selected_sector2',
    label = "Select Sector",
    choices = unique(stocks$gics_sector),
    selected = "Industrials"
  ),  
  
  selectInput(
    inputId = 'selected_metric4',
    label = 'Select Metric',
    choices = names(metrics)
  ),
  
  dateRangeInput(
    inputId = 'selected_date_range',
    label = 'Select Date Range',
    start = min(stocks$date),
    end = max(stocks$date),
    min = min(stocks$date),
    max = max(stocks$date)
  ),
  
  plotOutput('ts_plot4')
)