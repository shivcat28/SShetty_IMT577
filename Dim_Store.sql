TRUNCATE Dim_Store;

--Check that table is clear
SELECT * FROM Dim_Store;
drop table Dim_Store
--CREATE TABLE
CREATE OR REPLACE TABLE Dim_Store(
    DimStoreID INT IDENTITY(1,1) CONSTRAINT PK_DimStoreID PRIMARY KEY NOT NULL --Surrogate Key
	,DimLocationID VARCHAR(255) NOT NULL --Natural Key 
	,SourceStoreID VARCHAR(255) NOT NULL
    ,StoreName VARCHAR(255) NOT NULL
    ,StoreNumber VARCHAR(255) NOT NULL
	,StoreManager VARCHAR(255) NOT NULL
);

--does the table look like you want it? If not, modify the code and 
--re-create it or drop and re-create via the web interface.
DROP TABLE Dim_Store
truncate Dim_Store
--Load unknown members

SELECT * FROM Dim_Reseller;
select * from Dim_Reseller
select count(*) from Dim_Reseller

--Load characters
INSERT INTO Dim_Store
(
DimLocationID
	,SourceStoreID
    ,StoreName
    ,StoreNumber
	,StoreManager
)
	SELECT 
	  DimLocationID
     ,StoreID SourceStoreID
     ,StoreName
    ,StoreNumber
	,StoreManager
	FROM stage_STORE a join dim_location b on  
    a.address=b.address and a.city=b.city and a.postalcode=b.postalcode and a.stateprovince=b.state_province
    

SELECT * FROM Dim_Customer;
select * from stage_reseller
select * from dim_reseller
select * from stage_store
TRUNCATE Dim_Channel;

--Check that table is clear
SELECT * FROM Dim_location