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

SELECT
    P.DIMPRODUCTID,
    NVL(DS.DIMSTOREID, -1) AS DIMSTOREID,
    NVL(DR.DIMRESELLERID, -1) AS DIMRESELLERID,
    NVL(DC.DIMCUSTOMERID, -1) AS DIMCUSTOMERID,
    DCH.DIMCHANNELID,
    d.date_pkey as DimSaleDateID,
    COALESCE(DS.DIMLOCATIONID, DC.DIMLOCATIONID, DR.DIMLOCATIONID, -1) AS DIM_LOCATIONID,
    SH.SALESHEADERID AS SourceSalesHeaderID,
    S.SALESDETAILID AS SourceSalesDetailID,
    S.SALESAMOUNT AS SaleAmount,
    S.SALESQUANTITY AS SaleQuantity,
    p.productretailprice AS SALE_UNIT_PRICE,
   (s.SalesQuantity*p.productwholesaleprice)-(s.SalesQuantity*p.productcost) SaleExtendedCost
,(s.SalesQuantity*p.productretailprice)-(s.SalesQuantity*p.productcost) SaleTotalProfit
FROM stage_salesheader SH
INNER JOIN stage_salesdetail S ON SH.SALESHEADERID = S.SALESHEADERID
INNER JOIN DIM_PRODUCT P ON S.PRODUCTID = P.PRODUCTID
INNER JOIN DIM_CHANNEL DCH ON SH.CHANNELID = DCH.SOURCECHANNELID
LEFT JOIN DIM_STORE DS ON SH.STOREID = DS.DIMSTOREID
LEFT JOIN DIM_RESELLER DR ON SH.RESELLERID = DR.SOURCERESELLERID
LEFT JOIN DIM_CUSTOMER DC ON SH.CUSTOMERID = DC.SOURCECUSTOMERID
left join dim_date d on concat(2,right(cast(sh.date as date),9))= d.date

select * from Fact_SalesActual
