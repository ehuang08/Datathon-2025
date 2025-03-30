install.packages("devtools")
devtools::install_github("FinYang/tsdl")
install.packages("prophet")
library(tidyverse)
library(tsdl)
library(prophet)
library(dplyr)

transactions <- read_csv("cleaned_transaction.csv")

str(transactions)
transactions$month <- as.Date(paste(transactions$month, "01", sep = "-"), format = "%Y-%m-%d")
class(transactions$month)
str(transactions)
print(transactions$month)

transactions_filtered <- transactions %>%
  filter(transactions$month >= as.Date("2024-07-01"))

transactions_filtered <- mutate(
  transactions_filtered, 
  ds = transactions_filtered$month,
  y = transactions_filtered$total_transaction,
)

m <- prophet(transactions_filtered)
future <- make_future_dataframe(m, periods = 304)
forecast <- predict(m, future)
colnames(forecast)
if ("trend" %in% colnames(forecast)) {
  trend_data <- forecast[, c("ds", "trend")]
} else {
  stop("trend col is missing")
}
trend_data$ds <- as.numeric(as.Date(trend_data$ds))
lm_model <- lm(trend ~ ds, data = trend_data)
summary(lm_model)
plot(m, forecast)
prophet_plot_components(m, forecast)
