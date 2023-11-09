# Coding test - Basic Data Engineering skills

To work on this test, please create a branch with your name. You have 
all the freadom related to creating files and deciding which technology 
is going to be used to solve the tasks.

This test is divided into two main tasks: Data Analytics skills (Retail Database) and Data Engineering skills (Database Design and ETL creation). 

A few points regarding the tasks:
1. With this task we are also interested to see how you organize your code base and what best practices you follow wrt code-style, formatting, documentation, versioning etc.  
2. You are allowed to skip the tasks that you cannot do - quality is more important than quantity (also, there 
may be some tasks that are intentionally not feasible).

## Retail database

Here we are going to work with a dataset of monthly US retail sales from the [Monthly Retail Trade Report](https://www.census.gov/retail/index.html#mrts).
The data in this report is used as an economic indicator to understand trends in US consumer spending patterns. 

The dataset can be found in the folder `data/retail`.

This task is going to focus mainly on your skills to solve basic analytical problems, using however, only SQL queries. The choice of the database (MSSQL, PostgreSQL, MySQL, etc...) is up to you.

### Tasks:

1. Create a SQL database / table to persist the retail dataset. Obs.: Before uploading the data to the table,
add to it a new column with the class of the `kind_of_business` (see the notebook 01). The class is the index
of the `list_kind_of_business` dataframe (this classification will be used in the last task).

2. Create a SQL query that returns report of the "Men's clothing stores" and "Women's clothing stores" 
sales. This report must show the following columns:
- `sales_month`: Month of the register (format Year/Month)
- `kind_of_business`: Register source (Men and Womens clothing separately)
- `sales`: The total sales for each month and kind of business
- `pct_growth`: How much is the rate of increase / decrease of the sales compared to the previous month
- `pct_mens_cloth`: What is the percentage of Men clothing in the total sales (consider the sum of Men and Womens clothing)
- `yearly_sales`: The yearly sales (Men and Womens clothing separately) 
- `pct_month_yearly_sales`: How much (in percentage) is the fraction of the monthly total sales compared to the yearly sales
- `previous_sales_record`: What was the historical record of sales, considering only the precedent data of the month row?

3. Still considering only the "Women's clothing stores" kind of business, create a SQL query that returns a time-series analysis report of the data. This report must be able to show the following columns.
- `sales_month`: Month of the register (format Year/Month)
- `avg_sales`: The moving average of the sales (consider the period of one year in the window).
- `sales_high_low_avg`: Show when the sales where higher or lower than the moving average of the sales.
- `diff_sales_avg`: How much is the deviation (in percentage) between the reported sales and the calculated average
- `count_avg_registers`: How many records were used in the average calculation

4. Considering now just the `kind_of_business` that are included in the classes 4 and 9 (indices of the before 
mentioned `list_kind_of_business` dataframe). Create a SQL query that can returns the following columns:
- `sales_month`: Month of the register (format Year/Month)
- `top_seller_class`: For each month, which class (4 or 9) had higher total sales?
- `top_seller_kind_of_business`: Considering the top seller class of the month, which `kind_of_business` most contributed to this result? 
- `top_seller_sales`: And what was the total sales of `top_sellter_kind_of_business`?

**Observation:** if you judge necessary, you can split the queries to solve the task in a more appropriate manner.

## Earthquakes database 

The data used in this stup is a set of records for all earthquakes recorded by the US Geological Survey (USGS) from 2010 to 2020. 
The USGS provides the data in a number of formats, including real-time feeds, at [https://earthquake.usgs.gov/earthquakes/feed/](https://earthquake.usgs.gov/earthquakes/feed/).

The datasets of this task can be found in the `data/earthquakes` folder.

This task is going to focus mainly on your experience on creating an ETL pipeline.

### Tasks:

- Design a database to persist the dataset. We ask you to consider using the well-stabilished [Dimensional Modelling Techniques](https://www.kimballgroup.com/data-warehouse-business-intelligence-resources/kimball-techniques/dimensional-modeling-techniques/) of the Kimball Group.
- Create an ETL pipeline to upload the datasets founded in the `data/earthquakes` folder (consider the existence of 
duplicated rows).


### Extra tasks:

1. Create for the earthquake a query that returns the following columns:
- `date`: Day of the register (format Year-month-day)
- `place`: Returns only "Northern California"
- `mag_count`: Count of registries for the given day
- `mag_min`: Minimum value of magnitude
- `mag_max`: Maximum value of magnitude
- `mag_mean`: Mean value of magnitude
- `mag_std`: Standard deviation value of magnitude
- `mag_pct_X`: Xth percentile of the magnitude (where X is 25, 50,