TRUNCATE Dim_Product;

--Check that table is clear
SELECT * FROM Dim_Product;

--CREATE TABLE
CREATE OR REPLACE TABLE Dim_Product(
    DimProductID INTEGER IDENTITY(1,1) CONSTRAINT PK_DimChannelID PRIMARY KEY NOT NULL --Surrogate Key
	,ProductID INTEGER
	,ProductTypeID INTEGER NOT NULL --Natural Key
	,ProductCategoryID INTEGER NOT NULL
    ,ProductName VARCHAR(255) NOT NULL
    ,ProductType VARCHAR(255) NOT NULL
	,ProductCategory VARCHAR(255) NOT NULL
	,ProductRetailPrice FLOAT NOT NULL
	,ProductWholesalePrice FLOAT NOT NULL
	,ProductCost FLOAT NOT NULL
	,ProductRetailProfit FLOAT NOT NULL
	,ProductWholesaleUnitProfit FLOAT NOT NULL
	,ProductProfitMarginUnitPercent FLOAT NOT NULL
);


INSERT INTO Dim_Product
(
     ProductID
	,ProductTypeID
	,ProductCategoryID
    ,ProductName
    ,ProductType
	,ProductCategory
	,ProductRetailPrice
	,ProductWholesalePrice
	,ProductCost
	,ProductRetailProfit
	,ProductWholesaleUnitProfit
	,ProductProfitMarginUnitPercent
)
	SELECT 
	  a.ProductID
     ,a.ProductTypeID
	 ,b.ProductCategoryID
	 ,a.product as ProductName
	 ,b.producttype
	 ,c.ProductCategory
	 ,a.price as ProductRetailPrice
	 ,a.wholesaleprice as ProductWholesalePrice
	 ,a.cost as ProductCost
	 ,(a.price - a.cost) ProductRetailProfit
	 ,(a.wholesaleprice-a.cost) ProductWholesaleUnitProfit
	 ,round((a.price - a.cost)*100/a.price,2) ProductProfitMarginUnitPercent

     
	FROM STAGE_product a join stage_producttype b on a.ProductTypeID=b.ProductTypeID 
	join stage_productcategory c on b.productcategoryid=c.productcategoryid

SELECT * FROM Dim_Product;

TRUNCATE Dim_Product;
drop table Dim_Product
--Check that table is clear
SELECT * FROM Dim_Product;