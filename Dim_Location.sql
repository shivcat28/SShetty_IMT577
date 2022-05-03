TRUNCATE Dim_Location;

--Check that table is clear
SELECT * FROM Dim_Location;

--CREATE TABLE
CREATE OR REPLACE TABLE Dim_Location(
    DimLocationID INT IDENTITY(1,1) CONSTRAINT PK_DimChannelID PRIMARY KEY NOT NULL --Surrogate Key
	,Address varchar(255) NOT NULL --Natural Key
	,City varchar(255) NOT NULL
    ,PostalCode VARCHAR(255) NOT NULL
    ,State_Province VARCHAR(255) NOT NULL
	,Country VARCHAR(255) NOT NULL
);

--does the table look like you want it? If not, modify the code and 
--re-create it or drop and re-create via the web interface.
DROP TABLE Dim_Location

--Load unknown members


SELECT * FROM Dim_Location;
select * from Dim_Location
select count(*) from Dim_Location

--Load characters
INSERT INTO Dim_Location
(
	Address
	,City
    ,PostalCode
    ,State_Province
	,Country
)
	SELECT 
	  address
     ,City
     ,PostalCode
    ,StateProvince  as State_Province
	,Country
	FROM stage_store 
    union
    SELECT 
	  address
     ,City
     ,PostalCode
    ,StateProvince as State_Province
	,Country
	FROM stage_customer
    union
    SELECT 
	  address
     ,City
     ,PostalCode
    ,StateProvince as State_Province
	,Country
	FROM stage_reseller

SELECT * FROM Dim_Location;
select * from stage_customer
select * from stage_reseller
select * from stage_store
TRUNCATE Dim_Channel;

--Check that table is clear
SELECT * FROM Dim_Channel;