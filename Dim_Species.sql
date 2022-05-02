CREATE OR REPLACE TABLE Dim_Species(
    DimSpeciesID INT IDENTITY(1,1) CONSTRAINT PK_DimSpeciesID PRIMARY KEY NOT NULL --Surrogate Key
	,SpeciesID int --Natural Key
    ,Species varchar(255) NOT NULL
    , Classification varchar(255)
    , Designation varchar(255)
    , SKinHues varchar(255)
    , HairColors varchar(255)
    , EyeColors varchar(255)
    , Language varchar(255)

);
SELECT * FROM DIM_SPECIES
--does the table look like you want it? If not, modify the code and 
--re-create it or drop and re-create via the web interface.
DROP TABLE Dim_Planets

--Load unknown members
INSERT INTO Dim_species
(
     DimSpeciesID 
	,SpeciesID
    ,Species 
    , Classification
    , Designation
    , SKinHues 
    , HairColors 
    , EyeColors 
    , Language 
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

--Load characters
INSERT INTO Dim_Species
(
 DimSpeciesID 
	,SpeciesID
    ,Species 
    , Classification
    , Designation
    , SKinHues 
    , HairColors 
    , EyeColors 
    , Language 
)
	SELECT 
	  ID AS DimSpeciesID
     ,ID AS SpeciesID
     , name as species
     ,Classification 
     ,Designation
     ,Skincolors as SKinHues
     ,Haircolors
     ,eyecolors
     ,language
     
	FROM STAGE_STARWARSSPECIES;

SELECT* FROM STAGE_STARWARSSPECIES

SELECT * FROM Dim_PLANETS;
SELECT* FROM STAGE_STARWARSSPECIES