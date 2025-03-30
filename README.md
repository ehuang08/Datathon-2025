Data Sprouts

Video link: 

Steps to run the code:
- Make sure all datasets are in working directory
- Run code in R in order of transactions_cleaning_visualization file, Prophet Model, classifier_data_creation file, Classifier Model

transactions_cleaning_visualization file:
- got rid of columns with high number of missing values
- created a plot transaction_date vs amount for all data
- data was very right skewed, fixed using natural log, got rid of outliers using IQR rule
- filtered the date to just look at previous 8 months
- created transaction_date vs amount graph and a bar graph with previous 8 months vs total amount per month
- made a new csv: cleaned_transaction.csv with cleaned data

Prophet Model:
- https://facebook.github.io/prophet/
- using cleaned data, we first convereted months into Date format
- filtered using past 8 months (from july of 2024)
- for prophet model, it uses variables ds for independent variable and y for our dependent variable to train
- set ds = month
- set y = total amount
- trained the model
- made a future dataframe for the next 10 months to include Q4 (october to december)
- predicted the future spendings

classifier_data_creation file:
- merged columns from multiple csv files to train k-means clustering on
- merged account numbers, account open date, payment hisotry of 1-12 Âmonths, and gross fraud amount (potential risk signs)
- visualized account open date vs payment history 1-12 months as a bubble plot with gross fraud amount as third variable
- made a new data frame: classifier_data.csv and payment_seperated_classifer_data.csv (payment_seperated_classifier_data.csv takes the payment history from 1-12 months and seperates accounts that contain multiple letters)

Classifier Model:
- Used k-means cluster
- using classifier_data.csv created a new feature called months_since_oepn
- only using features that affect accounts eligible for credit line increase without risk, accounts eligible for credit line increase but has risk of potential defaults or fraud, no Credit Line increase required and non-Performing
- normalized the data
- train the data with output of 4 clusters
- ploted data to visualize clusters
