TRUNCATE Dim_Customer;

--Check that table is clear
SELECT * FROM Dim_Customer;
drop table Dim_Customer
--CREATE TABLE
CREATE OR REPLACE TABLE Dim_Customer(
    DimCustomerID INT IDENTITY(1,1) CONSTRAINT PK_DimCustomerID PRIMARY KEY NOT NULL --Surrogate Key
	,DimLocationID INTEGER CONSTRAINT FK_DimLocationIDCustomer FOREIGN KEY REFERENCES Dim_Location (DimLocationID) NOT NULL
	,CustomerID VARCHAR(255) NOT NULL
    ,CustomerFullName VARCHAR(255) NOT NULL
    ,CustomerFirstName VARCHAR(255) NOT NULL
	,CustomerLastName VARCHAR(255) NOT NULL
    ,CustomerGender VARCHAR(255) NOT NULL
);

--does the table look like you want it? If not, modify the code and 
--re-create it or drop and re-create via the web interface.
DROP TABLE Dim_Customer
truncate Dim_Customer
--Load unknown members

SELECT * FROM Dim_Customer;
select * from Dim_Customer
select count(*) from Dim_Customer
INSERT INTO Dim_Customer
(
	DimLocationID
	,CustomerID
    ,CustomerFullName
    ,CustomerFirstName
	,CustomerLastName
    ,CustomerGender
)
VALUES
( 
     -1
    ,'Unknown' 
    ,'Unknown'
    ,'Unknown'
    ,'Unknown'
    ,'Unknown'
);
--Load characters
INSERT INTO Dim_Customer
(
	DimLocationID
	,CustomerID
    ,CustomerFullName
    ,CustomerFirstName
	,CustomerLastName
    ,CustomerGender
)
	SELECT 
	  DimLocationID
     ,CustomerID
     ,concat(FirstName,' ',lastname) CustomerFullName
    ,FirstName  as CustomerFirstName
	,LastName as CustomerLastName
    ,Gender as CustomerGender
	FROM stage_customer a join dim_location b on  
    a.address=b.address and a.city=b.city and a.postalcode=b.postalcode and a.stateprovince=b.state_province
    

SELECT * FROM Dim_Customer;
select * from stage_customer
select * from stage_reseller
select * from stage_store
TRUNCATE Dim_Channel;

--Check that table is clear
SELECT * FROM Dim_Customer