
-- task 1

USE MASTER; 
GO 
  
IF EXISTS (SELECT 1 FROM sys.databases WHERE name = N'us_retails_sales_data')
BEGIN
	DROP DATABASE us_retails_sales_data;
END
GO 
  

-- Create a Database 
CREATE DATABASE us_retails_sales_data; 
GO 
  
USE us_retails_sales_data; 
GO 

-- import file into table monthly_sales