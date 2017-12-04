/*
	Scenario 1:
	There was an error in the order entry system that caused duplicate order lines to get entered into the database. 
	Remove the duplicate order lines.
	BONUS: Modify the database so that this error cannot happen again.
*/
USE Kata;
GO

-- For [Sales].[SalesOrderDetail]
-- Took backup of orignal table, truncate dit and then inserted back without duplicates
Select top 1 * from [Sales].[SalesOrderDetail]

Select * into [Sales].[SalesOrderDetail_bkp] -- 121729
         From [Sales].[SalesOrderDetail]

 Truncate Table [Sales].[SalesOrderDetail]

Insert into [Sales].[SalesOrderDetail] (SalesOrderID,CarrierTrackingNumber,OrderQty,ProductID,SpecialOfferID,UnitPrice,UnitPriceDiscount
                                       ,LineTotal,rowguid,ModifiedDate)
Select distinct SalesOrderID,CarrierTrackingNumber,OrderQty,ProductID,SpecialOfferID,UnitPrice,UnitPriceDiscount
                                       ,LineTotal,rowguid,ModifiedDate
      From [Sales].[SalesOrderDetail_bkp] -- 120729

	  Select count(*) from [Sales].[SalesOrderDetail_bkp] -- 121729
	  Select Count(*) from [Sales].[SalesOrderDetail] -- 120729 Duplicates are removed

-- For [Sales].[SalesOrderHeader]

Select Count(*) from [Sales].[SalesOrderHeader] -- 62930
Select top 1 * from [Sales].[SalesOrderHeader]

Select * into [Sales].[SalesOrderHeader_bkp] -- 62930
         From [Sales].[SalesOrderHeader]

ALTER TABLE [Sales].[SalesOrderDetail] DROP CONSTRAINT [FK_SalesOrderDetail_SalesOrderHeader]

Truncate Table [Sales].[SalesOrderHeader] 

ALTER TABLE [Sales].[SalesOrderDetail]  WITH NOCHECK ADD  CONSTRAINT [FK_SalesOrderDetail_SalesOrderHeader] FOREIGN KEY([SalesOrderID])
REFERENCES [Sales].[SalesOrderHeader] ([SalesOrderID])

ALTER TABLE [Sales].[SalesOrderDetail] CHECK CONSTRAINT [FK_SalesOrderDetail_SalesOrderHeader]

Insert Into [Sales].[SalesOrderHeader]  (RevisionNumber,OrderDate,DueDate,ShipDate,Status,OnlineOrderFlag,SalesOrderNumber
                                        ,PurchaseOrderNumber,AccountNumber,CustomerID,SalesPersonID,TerritoryID
										, BillToAddressID,ShipToAddressID,ShipMethodID,CreditCardID,CreditCardApprovalCode
										,CurrencyRateID,SubTotal,TaxAmt,Freight,TotalDue,Comment,rowguid,ModifiedDate)
Select distinct RevisionNumber,OrderDate,DueDate,ShipDate,Status,OnlineOrderFlag,SalesOrderNumber
                                        ,PurchaseOrderNumber,AccountNumber,CustomerID,SalesPersonID,TerritoryID
										, BillToAddressID,ShipToAddressID,ShipMethodID,CreditCardID,CreditCardApprovalCode
										,CurrencyRateID,SubTotal,TaxAmt,Freight,TotalDue,Comment,rowguid,ModifiedDate
      From [Sales].[SalesOrderHeader_bkp]

	  Select count(*) from [Sales].[SalesOrderHeader_bkp] -- 62930
	  Select count(*) from [Sales].[SalesOrderHeader] -- 31465 -- duplicates are removed.

		 



									    
