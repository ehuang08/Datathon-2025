library(tidyverse)
t <- read_csv("transaction_fact_20250325.csv")
class(t)
sum(is.na(t))
colSums(is.na(t))
t <- t %>%
  select(-c(payment_type, invoice_nbr, fcr_flag, fcr_rate_of_exchange, adj_orgn_tran_dt, product_amt, product_qty, fcr_amount))

class(t)
t %>%
  ggplot(aes(x = transaction_date, y = transaction_amt)) +
    geom_line() +
    labs(x = "transaction_date", y = "transaction_amt") +
    theme_minimal()

library(dplyr)
t_filtered_date <- t %>%
  filter(transaction_date >= as.Date("2024-07-01"))

t_filtered_date %>% ggplot(aes(x = transaction_amt)) + geom_histogram() #very right skewed
t_filtered_date %>% ggplot(aes(x = log(transaction_amt))) + geom_histogram() 

t <- t %>%
  filter(!is.na(transaction_amt) & transaction_amt > 0) %>%
  mutate(log_transaction_amt = log(transaction_amt),
         Q1 = quantile(log_transaction_amt, 0.25, na.rm = TRUE),
         Q3 = quantile(log_transaction_amt, 0.75, na.rm = TRUE),
         IQR = Q3 - Q1,
         lower_threshold = Q1 - 2.5 * IQR,
         upper_threshold = Q3 + 2.5 * IQR) %>%
  filter(log_transaction_amt < upper_threshold & log_transaction_amt > lower_threshold) %>%
  select(-c(log_transaction_amt, Q1, Q3, IQR, lower_threshold, upper_threshold))

t_filtered_date %>%
  ggplot(aes(x = transaction_date, y = transaction_amt)) +
  geom_line() +
  labs(x = "transaction_date",
       y = "transaction_amount") +
  theme_minimal()