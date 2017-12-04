/*
	Scenario 2:
	New orders came into the staging area for (2008-05-01). 
	Merge these orders with the existing orders for the same date.
*/
USE Kata;
GO

-- merge statment upsert with where clause...
Select top 1 * from [Sales].[SalesOrderDetailStaging]
Select top 1 * from [Sales].[SalesOrderDetail]

Select count(*) from [Sales].[SalesOrderDetailStaging] where ModifiedDate = '2008-05-01' -- 6130
Select count(*) from [Sales].[SalesOrderDetail] where ModifiedDate = '2008-05-01' -- 2477


MERGE [Sales].[SalesOrderDetail] AS T  
USING [Sales].[SalesOrderDetailStaging] AS S 
ON  T.salesOrderDetailID = S.SalesOrderDetailID and T.ModifiedDate = '2008-05-01'
   
WHEN MATCHED THEN  
  UPDATE SET 
           T.CarrierTrackingNumber = S.CarrierTrackingNumber
		  ,T.OrderQty = S. OrderQty
		  ,T.UnitPrice = S.UnitPrice
		  ,T.UnitPriceDiscount = S.UnitPriceDiscount
		  ,T.LineTotal = S.LineTotal		  

WHEN NOT MATCHED THEN  
  INSERT (SalesOrderID,CarrierTrackingNumber,OrderQty,ProductID,SpecialOfferID
                                         ,UnitPrice,UnitPriceDiscount,LineTotal,rowguid,ModifiedDate)
   VALUES (S.SalesOrderID,S.CarrierTrackingNumber,S.OrderQty,S.ProductID,S.SpecialOfferID
                                         ,S.UnitPrice,S.UnitPriceDiscount,S.LineTotal,S.rowguid,S.ModifiedDate);


