library('fpp3')
library('shiny')
library('readr')
library('plotly')


stocks <- read_csv('nyse_stocks.csv.zip')

stocks$date <- as.Date(stocks$date)
stocks <- tsibble(stocks, index = date, key = symbol )


metrics <- subset(stocks,
                  select = c('open', 'close', 'low', 'high', 'volume' ))