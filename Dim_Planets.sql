CREATE OR REPLACE TABLE Dim_Planets(
    DimPlanetID INT IDENTITY(1,1) CONSTRAINT PK_DimPlanetID PRIMARY KEY NOT NULL --Surrogate Key
	,PlanetID INTEGER NOT NULL --Natural Key
    ,PlanetName VARCHAR(255) NOT NULL
    ,Climate VARCHAR(255) NOT NULL
    ,Gravity VARCHAR(255) NOT NULL
    ,Terrain VARCHAR(255) NOT NULL
);

--does the table look like you want it? If not, modify the code and 
--re-create it or drop and re-create via the web interface.
DROP TABLE Dim_Planets

--Load unknown members
INSERT INTO Dim_Planets
(
     DimPlanetID
	,PlanetID 
    ,PlanetName
    ,Climate
    ,Gravity
    ,Terrain
)
VALUES
( 
     -1
    ,-1
    ,'Unknown' 
    ,'Unknown'
    ,'Unknown'
    ,'Unknown'
);

--Load characters
INSERT INTO Dim_Planets
(
    DimPlanetID
	,PlanetID 
    ,PlanetName
    ,Climate
    ,Gravity
    ,Terrain
)
	SELECT 
	  ID AS DimPlanetID
     ,ID AS PlanetID
     ,Name as PlanetName
     ,Climate
     ,Gravity
     ,Terrain
     
	FROM STAGE_STARWARSPLANETS

SELECT * FROM Dim_PLANETS;
SELECT COUNT(*) FROM STAGE_STARWARSPLANETS