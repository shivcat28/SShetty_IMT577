drop table Fact_ProductSalesTarget 
truncate Fact_ProductSalesTarget
CREATE or replace TABLE Fact_ProductSalesTarget
(
	DimProductID INT CONSTRAINT FK_DimProductID FOREIGN KEY REFERENCES Dim_Product(DimProductID) --Foreign Key
	 ,DimTargetDateID number(9) CONSTRAINT FK_Date_pkey FOREIGN KEY REFERENCES Dim_Date(Date_pkey) --Foreign Key
	,producttargetsalesquantity float

);


insert into Fact_ProductSalesTarget
(
  DimProductID
	 ,DimTargetDateID
	,producttargetsalesquantity )
    
values
(-1,
-1,
-1)

insert into Fact_ProductSalesTarget
(
  DimProductID
	 ,DimTargetDateID
	,producttargetsalesquantity )
    
select distinct p.dimproductid,d.date_pkey DimTargetDateID
    ,t.SALESQUANTITYTARGET/365 producttargetsalesquantity
    from dim_product p --join stage_saleshead h on o.sourcestoreid=h.storeid 
     join STAGE_TARGETDATAPRODUCT t on p.productid=t.productid 
        join dim_date d on d.year=t.year

    select * from dim_date
    select * from dim_product
select * from Fact_ProductSalesTarget
select * from STAGE_TARGETDATAPRODUCT