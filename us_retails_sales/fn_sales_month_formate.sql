
USE us_retails_sales_data; 
GO 

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sys.all_objects WHERE name = N'fn_sales_month_formate' AND type = 'FN')
BEGIN
	DROP FUNCTION [dbo].fn_sales_month_formate
END
GO 


CREATE  FUNCTION [dbo].[fn_sales_month_formate] (@y varchar(4), @m varchar(2))
RETURNS varchar(8) AS
BEGIN
    RETURN concat(@y ,'/' , @m)
END
GO