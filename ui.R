

ui <- fluidPage(
  tabsetPanel(
    
#Feature 1  
    
  tabPanel(  
    title = 'Visualize a Stock',
    selectInput(
      inputId =  'selected_stock',
      label = "Select Stock",
      choices = unique(stocks$symbol) 
    ),
    
    selectInput(
      inputId = 'selected_metric',
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

    plotOutput('ts_plot'))
    ,
  
  
#Inputs for Feature 2  
  tabPanel(
    title = 'Compare Stocks',
      selectInput(
        inputId =  'selected_stock1',
        label = "Select Stock",
        choices = unique(stocks$symbol) 
      ),
    
    selectInput(
      inputId =  'selected_stock2',
      label = "Select Stock",
      choices = unique(stocks$symbol),
      selected = 'AAL'
      
    ),  
    
      selectInput(
        inputId = 'selected_metric2',
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

      plotOutput('ts_plot2'),
      tableOutput('table_f2')
    ),

    tabPanel(
      title = 'Purchase a Stock',
      selectInput(
        inputId = 'purchased_stock',
        label = 'Which Stock Would You Like To Purchase?',
        choices = unique(stocks$symbol)
      ),
      
      sliderInput(
        inputId = 'buy_amount',
        label = 'How Many Shares?',
        min = 1,
        max = 1000,
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
      
      verbatimTextOutput('stock_change'),
    )

  )  
)





