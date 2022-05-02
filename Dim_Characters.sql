TRUNCATE Dim_Characters;

--Check that table is clear
SELECT * FROM Dim_Characters;

--CREATE TABLE
CREATE OR REPLACE TABLE Dim_Characters(
    DimCharacterID INT IDENTITY(1,1) CONSTRAINT PK_DimCharacterID PRIMARY KEY NOT NULL --Surrogate Key
	,CharactersID INTEGER NOT NULL --Natural Key
    ,Name VARCHAR(255) NOT NULL
    ,HairColor VARCHAR(255) NOT NULL
    ,SkinHue VARCHAR(255) NOT NULL
    ,EyeColor VARCHAR(255) NOT NULL
    ,Gender VARCHAR(50) NOT NULL
    ,Homeworld VARCHAR(255) NOT NULL
    ,Species VARCHAR(255) NOT NULL
);

--does the table look like you want it? If not, modify the code and 
--re-create it or drop and re-create via the web interface.
DROP TABLE Dim_Characters

--Load unknown members
INSERT INTO Dim_Characters
(
     DimCharacterID
	,CharactersID
    ,Name
    ,HairColor
    ,SkinHue
    ,EyeColor
    ,Gender
    ,Homeworld
    ,Species
)
VALUES
( 
     -1
    ,-1
    ,'Unknown' 
    ,'Unknown'
    ,'Unknown'
    ,'Unknown'
    ,'Unknown'
    ,'Unknown'
    ,'Unknown'
);

SELECT * FROM Dim_Characters;
select * from stage_starwarscharacters
select count(*) from Dim_Characters

--Load characters
INSERT INTO Dim_Characters
(
     DimCharacterID
	,CharactersID
    ,Name
    ,HairColor
    ,SkinHue
    ,EyeColor
    ,Gender
    ,Homeworld
    ,Species
)
	SELECT 
	  ID AS DimCharacterID
     ,ID AS CharacterID
     ,Name
     ,HairColor
     ,SkinColor
     ,EyeColor
     ,Gender
     ,HomeWorld
     ,Species
     
	FROM STAGE_STARWARSCHARACTERS

SELECT * FROM Dim_Characters;

TRUNCATE Dim_Characters;

--Check that table is clear
SELECT * FROM Dim_Characters;