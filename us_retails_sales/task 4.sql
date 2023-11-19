
USE us_retails_sales_data; 
GO 

--task 4

--Considering now just the kind_of_business that are included in the classes 4 and 9 (indices of the before mentioned list_kind_of_business dataframe). Create a SQL query that can returns the following columns:
	--sales_month: Month of the register (format Year/Month)
	--top_seller_class: For each month, which class (4 or 9) had higher total sales?
	--top_seller_kind_of_business: Considering the top seller class of the month, which kind_of_business most contributed to this result?
	--top_seller_sales: And what was the total sales of top_sellter_kind_of_business?

;WITH aggregated_sales_data AS(
SELECT 
      sales_per_month.kind_of_business
	 ,sales_per_month.sales_year
	 ,sales_per_month.sales_month
	 ,sales_per_month.sales
	 ,sales_per_month.sales_rnk
	 ,aggregated_sales_per_month.kind_of_business_set
	 ,aggregated_sales_per_month.naics_code
	 ,aggregated_sales_per_month.total_sales
	 ,aggregated_sales_per_month.total_sales_rnk
FROM	
	(
	SELECT 
		 kind_of_business
		,YEAR(sales_month) AS sales_year
		,MONTH(sales_month) AS sales_month
		,sales
		,ROW_NUMBER() OVER(PARTITION BY  YEAR(sales_month), MONTH(sales_month) ORDER BY sales DESC) AS sales_rnk
	FROM monthly_sales
	WHERE naics_code IN (445,452)
	)sales_per_month
	JOIN
	(
	SELECT 
		 YEAR(sales_month) AS sales_year
		,MONTH(sales_month) AS sales_month
		,naics_code
		,kind_of_business_set
		,SUM(sales) AS total_sales
		,ROW_NUMBER() OVER(PARTITION BY  YEAR(sales_month), MONTH(sales_month) ORDER BY SUM(sales) DESC) AS total_sales_rnk
	FROM monthly_sales
	WHERE naics_code IN (445,452)
	GROUP BY naics_code, YEAR(sales_month), MONTH(sales_month), kind_of_business_set
	)aggregated_sales_per_month	
	ON sales_per_month.sales_year = aggregated_sales_per_month.sales_year
	AND sales_per_month.sales_month = aggregated_sales_per_month.sales_month
)
SELECT 
	  dbo.fn_sales_month_formate(sales_year,sales_month) AS sales_month
	 ,kind_of_business_set AS top_seller_class
	 ,kind_of_business AS top_seller_kind_of_business
	 ,sales AS top_seller_sales
FROM 
	 aggregated_sales_data
WHERE sales_rnk=1 AND total_sales_rnk=1

