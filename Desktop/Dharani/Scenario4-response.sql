/*
	Scenario 4:
	The team has been sent an extract from the mainframe to perform price updates based on category. 
	Using Update.txt, update the product pricing.

	The file format is:

	ProductCategoryId.ProductSubcategoryId|Margin
	-------------------------------------------------
	000001.000001|1.7950

	The list price should be Standard Cost * Margin
*/
USE Kata;
GO


--Select * into [Production].[Product_bkp]  from [Production].[Product]


UPDATE  [Production].[Product] 
SET     ListPrice = pd.StandardCost*[dbo].[ExtractUpdateFile].Margin
FROM    [Production].[Product] Pd
        INNER JOIN [dbo].[ExtractUpdateFile] 
            ON  pd.ProductSubcategoryID = [dbo].[ExtractUpdateFile].ProductSubCategoryID

Select * from [Production].[Product] where ProductSubcategoryID is not null
Select * from [Production].[Product_bkp] where ProductSubcategoryID is not null