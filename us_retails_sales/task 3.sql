
USE us_retails_sales_data; 
GO 
--task 3

--Still considering only the "Women's clothing stores" kind of business, create a SQL query that returns a time-series analysis report of the data. This report must be able to show the following columns.
	
	--sales_month: Month of the register (format Year/Month)
	--avg_sales: The moving average of the sales (consider the period of one year in the window).
	--sales_high_low_avg: Show when the sales where higher or lower than the moving average of the sales.
	--diff_sales_avg: How much is the deviation (in percentage) between the reported sales and the calculated average
	--count_avg_registers: How many records were used in the average calculation


;WITH womens_sales_data AS(
SELECT 
	 kind_of_business
	,sales
	,MONTH(sales_month) AS sales_month
	,YEAR(sales_month) AS sales_year
	,AVG(sales) OVER (ORDER BY sales_month ROWS BETWEEN 11 PRECEDING AND CURRENT ROW) AS avg_sales
	,RANK() OVER(ORDER BY YEAR(sales_month), MONTH(sales_month)) AS item_counter
FROM 
	monthly_sales 
wHERE 
	kind_of_business = 'Women''s clothing stores'
)
SELECT 
	 dbo.fn_sales_month_formate(sales_year,sales_month) AS sales_month
	,FORMAT(avg_sales, 'N2') AS avg_sales
	,FORMAT((sales / avg_sales * 100),'N2') AS sales_high_low_avg
	,FORMAT((ABS(sales - avg_sales) / (sales + avg_sales) / 2) * 100,'N2') AS diff_sales_avg 
	,CASE WHEN
			 item_counter < 12 THEN item_counter ELSE 12 
		END
	AS	 count_avg_registers
FROM 
	womens_sales_data