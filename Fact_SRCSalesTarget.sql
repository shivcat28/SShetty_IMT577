drop table Fact_SRCSalesTarget
truncate table Fact_SRCSalesTarget

CREATE TABLE Fact_SRCSalesTarget
(
	DimStoreID INT CONSTRAINT FK_DimStoreID FOREIGN KEY REFERENCES Dim_Store(DimStoreID) --Foreign Key
	 ,DimResellerID INT CONSTRAINT FK_ResellerID FOREIGN KEY REFERENCES Dim_Reseller(DimResellerID) --Foreign Key 
	,DimChannelID INT CONSTRAINT FK_ChannelID FOREIGN KEY REFERENCES Dim_Channel(DimChannelID) --Foreign Key
    ,DimTargetDateID number(9) CONSTRAINT FK_Date_pkey FOREIGN KEY REFERENCES Dim_Date(Date_pkey) --Foreign Key
	,salestargetamount float

);


insert into Fact_SRCSalesTarget
(DimStoreID 
	 ,DimResellerID
	,DimChannelID
    ,DimTargetDateID
	,salestargetamount)
    
SELECT DISTINCT 
NVL(s.DimStoreID, -1) AS DimStoreID
,NVL(r.DimResellerID, -1) AS DimResellerID
,c.DimChannelID
,d.DATE_PKEY AS DimTargetDateID
,t.TargetSalesAmount/365 SalesTargetAmount
from STAGE_TARGETDATACHANNELRESELLERANDSTORE t
    JOIN Dim_Date d ON d.YEAR = t.YEAR
    JOIN Dim_Channel c ON C.ChannelName = 
          CASE 
              WHEN t.ChannelName = 'Online' THEN 'On-line'
              ELSE t.ChannelName
          END
    LEFT JOIN Dim_Reseller r ON t.TargetName = 
          CASE 
              WHEN r.ResellerName = 'Mississipi Distributors' THEN 'Mississippi Distributors' -- Mississippi is spelt wrong
              ELSE r.ResellerName
          END
    LEFT JOIN Dim_Store s ON s.StoreNumber = 
          CASE 
              WHEN t.TargetName = 'Store Number 5' THEN 5
              WHEN t.TargetName = 'Store Number 8' THEN 8
              WHEN t.TargetName = 'Store Number 10' THEN 10
              WHEN t.TargetName = 'Store Number 21' THEN 21
              WHEN t.TargetName = 'Store Number 34' THEN 34
              WHEN t.TargetName = 'Store Number 39' THEN 39
              ELSE NULL
          END

      
SELECT * FROM Fact_SRCSalesTarget;