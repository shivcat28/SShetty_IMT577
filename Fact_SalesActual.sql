drop table Fact_SalesActual
TRUNCATE table Fact_SalesActual
CREATE TABLE Fact_SalesActual
(
	 DimProductID INTEGER CONSTRAINT FK_DimProductID FOREIGN KEY REFERENCES Dim_Product(DimProductID) --Foreign Key
   ,DimStoreID INT CONSTRAINT FK_DimStoreID FOREIGN KEY REFERENCES Dim_Store(DimStoreID) --Foreign Key
    ,DimResellerID INT CONSTRAINT FK_ResellerID FOREIGN KEY REFERENCES Dim_Reseller(DimResellerID) --Foreign Key
	,DimCustomerID INT CONSTRAINT FK_CustomerID FOREIGN KEY REFERENCES Dim_Customer(DimCustomerID) --Foreign Key
    ,DimChannelID INT CONSTRAINT FK_ChannelID FOREIGN KEY REFERENCES Dim_Channel(DimChannelID) --Foreign Key
    ,DimSaleDateID number(9) CONSTRAINT FK_Date_pkey FOREIGN KEY REFERENCES Dim_Date(Date_pkey) --Foreign Key
    ,DimLocationID INT CONSTRAINT FK_LocationID FOREIGN KEY REFERENCES Dim_Location(DimLocationID) --Foreign Key
    ,SourceSalesHeaderID INT
	,SourceSalesDetailID INT
	,SaleAmount FLOAT
	,SaleQuantity FLOAT
	,SaleUnitPrice FLOAT
	,SaleExtendedCost FLOAT
	,SaleTotalProfit FLOAT
);



insert into Fact_SalesActual(
    DimProductID
    ,DimStoreID
    ,DimResellerID
	,DimCustomerID
    ,DimChannelID
    ,DimSaleDateID
    ,DimLocationID
    ,SourceSalesHeaderID
	,SourceSalesDetailID
	,SaleAmount
	,SaleQuantity
	,SaleUnitPrice
	,SaleExtendedCosT
	,SaleTotalProfit
)
 select p.dimproductid
,NVL(o.DimStoreID,-1) DimStoreID
,NVL(r.dimresellerid,-1) dimresellerid
,NVL(c.dimcustomerid,-1) DimCustomerID
,e.dimchannelid DimChannelID
,d.date_pkey DimSaleDateID
,NVL(l.dimlocationid,-1) dimlocationid
,s.salesheaderid SourceSalesHeaderID
,s.salesdetailid SourceSalesDetailID
,s.SalesAmount SaleAmount
,s.SalesQuantity salequantity
,p.ProductRetailPrice SaleUnitPrice
,(s.SalesQuantity*P.Productwholesaleprice)-(s.SalesQuantity*p.Productcost) SaleExtendedCost
,(s.SalesQuantity*p.ProductRetailPrice)-(s.SalesQuantity*p.Productcost) SaleTotalProfit
    from stage_salesheader h left join stage_salesdetail s on  s.salesheaderid=h.salesheaderid
    left join dim_product p on p.productid=s.productid 
    left join dim_store o on h.storeid=o.sourcestoreid
    left join dim_reseller r on r.sourceresellerid=h.resellerid
    left join dim_customer c on c.sourcecustomerid=h.customerid
    left join dim_channel e on e.sourcechannelid=h.channelid
    left join dim_date d on concat(2,right(cast(h.date as date),9))= d.date
    left join dim_location l on l.dimlocationid=r.dimlocationid
 