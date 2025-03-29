data sprouts

video link: 

transactions_cleaning_visualization file:
- got rid of columns with high number of missing values
- created a plot transaction_date vs amount for all data
- data was very right skewed, fixed using natural log, got rid of outliers using IQR rule
- filtered the date to just look at previous 8 months
- created transaction_date vs amount graph and a bar graph with previous 8 months vs total amount per month
- made a new csv: cleaned_transaction.csv with cleaned data

Prophet Model:
- using cleaned data, we first convereted months into Date format
- filtered using past 8 months (from july of 2024)
- for prophet model, it uses variables ds for independent variable and y for our dependent variable to train
- set ds = month
- set y = total amount
- trained the model
- made a future dataframe for the next 10 months to include Q4 (october to december)
- predicted the future spendings
