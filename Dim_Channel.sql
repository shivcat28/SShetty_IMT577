TRUNCATE Dim_Channel;
DROP TABLE Dim_Channel
--Check that table is clear
SELECT * FROM Dim_Channel;

--CREATE TABLE
CREATE OR REPLACE TABLE Dim_Channel(
    DimChannelID INT IDENTITY(1,1) CONSTRAINT PK_DimChannelID PRIMARY KEY NOT NULL --Surrogate Key
	,SourceChannelID INTEGER NOT NULL --Natural Key
	,SourceChannelCategoryID INTEGER NOT NULL
    ,ChannelName VARCHAR(255) NOT NULL
    ,ChannelCategory VARCHAR(255) NOT NULL
);

--does the table look like you want it? If not, modify the code and 
--re-create it or drop and re-create via the web interface.
DROP TABLE Dim_Channel

--Load unknown members


SELECT * FROM Dim_Channel;
select * from stage_channel
select count(*) from Dim_Channel

INSERT INTO Dim_Channel
(
     SourceChannelID
	,SourceChannelCategoryID 
    ,ChannelName
    ,ChannelCategory
)
VALUES
( 
     -1
    ,-1
    ,'Unknown' 
    ,'Unknown'
);
--Load characters
INSERT INTO Dim_Channel
(
     SourceChannelID
	,SourceChannelCategoryID 
    ,ChannelName
    ,ChannelCategory
)
	SELECT 
	  a.ChannelID SourceChannelID
     ,a.ChannelCategoryID SourceChannelCategoryID
     ,Channel as ChannelName
	 ,ChannelCategory
     
	FROM STAGE_channel a join stage_channelcategory b on a.channelcategoryid=b.channelcategoryid

SELECT * FROM Dim_Channel;

TRUNCATE Dim_Channel;

--Check that table is clear
SELECT * FROM Dim_Channel;