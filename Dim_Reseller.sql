TRUNCATE Dim_Reseller;

--Check that table is clear
SELECT * FROM Dim_Reseller;
drop table Dim_Reseller
--CREATE TABLE
CREATE OR REPLACE TABLE Dim_Reseller(
    DimResellerID INT IDENTITY(1,1) CONSTRAINT PK_DimResellerID PRIMARY KEY NOT NULL --Surrogate Key
	,DimLocationID VARCHAR(255) NOT NULL --Natural Key 
	,ResellerID VARCHAR(255) NOT NULL
    ,ResellerName VARCHAR(255) NOT NULL
    ,ContactName VARCHAR(255) NOT NULL
	,PhoneNumber VARCHAR(255) NOT NULL
    ,Email VARCHAR(255) NOT NULL
);

--does the table look like you want it? If not, modify the code and 
--re-create it or drop and re-create via the web interface.
DROP TABLE Dim_Reseller
truncate Dim_Reseller
--Load unknown members

SELECT * FROM Dim_Reseller;
select * from Dim_Reseller
select count(*) from Dim_Reseller

--Load characters
INSERT INTO Dim_Reseller
(
	DimLocationID
	,ResellerID
    ,ResellerName
    ,ContactName
	,PhoneNumber
    ,Email
)
	SELECT 
	  DimLocationID
     ,ResellerID
     ,ResellerName
    ,Contact as ContactName
	,PhoneNumber
    ,EmailAddress as Email
	FROM stage_reseller a join dim_location b on  
    a.address=b.address and a.city=b.city and a.postalcode=b.postalcode and a.stateprovince=b.state_province
    

SELECT * FROM Dim_Customer;
select * from stage_reseller
select * from dim_reseller
select * from stage_store
TRUNCATE Dim_Channel;

--Check that table is clear
SELECT * FROM Dim_location