
-- task 2

--Create a SQL query that returns report of the "Men's clothing stores" and "Women's clothing stores" sales. This report must show the following columns:
	--sales_month: Month of the register (format Year/Month)
	--kind_of_business: Register source (Men and Womens clothing separately)
	--sales: The total sales for each month and kind of business
	--pct_growth: How much is the rate of increase / decrease of the sales compared to the previous month
	--pct_mens_cloth: What is the percentage of Men clothing in the total sales (consider the sum of Men and Womens clothing)
	--yearly_sales: The yearly sales (Men and Womens clothing separately)
	--pct_month_yearly_sales: How much (in percentage) is the fraction of the monthly total sales compared to the yearly sales
	--previous_sales_record: What was the historical record of sales, considering only the precedent data of the month row?



WITH aggregated_sales_data AS(
SELECT 
	 sales_per_month.kind_of_business
	,sales_per_month.sales_month
	,sales_per_month.sales_year
	,sales_per_month.total_sales_per_month
	,sales_per_year.total_sales_per_year
	,sales_per_month_for_mens_and_womens.total_sales_per_month_for_mens_and_womens
	,LAG(total_sales_per_month) OVER(PARTITION BY sales_per_month.kind_of_business ORDER BY sales_per_month.sales_year) AS last_month_total_sales
	,LAG(total_sales_per_month,12) OVER(PARTITION BY sales_per_month.kind_of_business ORDER BY sales_per_month.kind_of_business, sales_per_month.sales_year) AS last_year_total_sales_for_this_month

FROM
	(
	SELECT 
		 kind_of_business
		,YEAR(sales_month) AS sales_year
		,MONTH(sales_month) AS sales_month, 
		SUM(sales) AS total_sales_per_month
	FROM monthly_sales
	WHERE kind_of_business IN ('Men''s clothing stores', 'Women''s clothing stores')
	GROUP BY kind_of_business, YEAR(sales_month), MONTH(sales_month)
	)sales_per_month
	JOIN
	(
	SELECT 
		kind_of_business
		,YEAR(sales_month) sales_year
		,SUM(sales) AS total_sales_per_year
	FROM monthly_sales 
	WHERE kind_of_business in ('Men''s clothing stores', 'Women''s clothing stores')
	GROUP BY kind_of_business,YEAR(sales_month)
	)sales_per_year
	
	ON sales_per_year.sales_year = sales_per_month.sales_year
	AND sales_per_year.kind_of_business = sales_per_month.kind_of_business
	JOIN
	(
	  SELECT 
	     MONTH(sales_month) sales_month
		,YEAR(sales_month) sales_year
		,SUM(sales) AS total_sales_per_month_for_mens_and_womens
	FROM monthly_sales 
	WHERE kind_of_business in ('Men''s clothing stores', 'Women''s clothing stores')
	GROUP BY YEAR(sales_month), month(sales_month)
	)sales_per_month_for_mens_and_womens
	ON sales_per_month_for_mens_and_womens.sales_year = sales_per_month.sales_year
	AND sales_per_month_for_mens_and_womens.sales_month = sales_per_month.sales_month
)
SELECT 
	 dbo.fn_sales_month_formate(sales_year,sales_month) as sales_month
	,kind_of_business
	,total_sales_per_month AS sales
	,FORMAT((total_sales_per_month - last_month_total_sales) / last_month_total_sales * 100, 'N2') AS pct_growth
	,FORMAT(CASE WHEN 
				kind_of_business = 'Men''s clothing stores' 
					THEN total_sales_per_month / total_sales_per_month_for_mens_and_womens * 100 END
			,'N2')  
	AS pct_mens_cloth
	,total_sales_per_year AS yearly_sales
	,FORMAT((total_sales_per_month / total_sales_per_year) * 100,'N2') AS pct_month_yearly_sales
	,last_year_total_sales_for_this_month AS previous_sales_record
FROM 
	aggregated_sales_data
ORDER BY 2
