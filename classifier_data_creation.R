library(tidyverse)
f <- read_csv("fraud_claim_case_20250325.csv")

sum(is.na(f))
colSums(is.na(f))
f <- f %>%
  select(-c(close_date, reopen_date))

f %>% ggplot(aes(x = net_fraud_amt)) + geom_histogram() ##right skewed
f %>% ggplot(aes(x = log(net_fraud_amt))) + geom_histogram()


a <- read_csv("account_dim_20250325.csv")

sum(is.na(a))
colSums(is.na(a))
a <- a %>%
  select(-c(card_activation_date, date_in_collection, special_finance_charge_ind, employee_code, ext_status_reason_cd_desc))

## classifier data
str(a$current_account_nbr)
str(f$current_account_nbr)
classifier_data <- merge(f, a, by = "current_account_nbr", all = FALSE)
print(classifier_data)

write.csv(classifier_data, "classifier_data.csv")

## data visualization: Bubble chart
library(ggplot2)

classifier_data <- classifier_data %>%
  mutate(payment_hist_1_12_mths = strsplit(payment_hist_1_12_mths, "")) %>%
  unnest(payment_hist_1_12_mths)
write.csv(classifier_data, "payment_seperated_classifier_data.csv")

p <- read_csv("payment_seperated_classifier_data.csv")
ggplot(p, aes(x = open_date.y, y = payment_hist_1_12_mths, size = gross_fraud_amt)) +
  geom_point(alpha = 0.6, color = "pink") +
  labs(title = "Fraud Amount by Payment History",
       x = "Account Open Date", y = "Payment History", size = "Fraud Amount") +
  theme_minimal()
