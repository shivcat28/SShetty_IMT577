drop view view_FACT_SRCSALESTARGET
drop view view_FACT_PRODUCTSALESTARGET
drop view view_FACT_SALESACTUAL


--------FACT_SRCSALESTARGET--------
create view view_FACT_SRCSALESTARGET as 
select DIMSTOREID,
DIMRESELLERID,
DIMCHANNELID,
DIMTARGETDATEID,
SALESTARGETAMOUNT
from FACT_SRCSALESTARGET

------------FACT_PRODUCTSALESTARGET--------
create view view_FACT_PRODUCTSALESTARGET as
select DIMPRODUCTID,
DIMTARGETDATEID,
PRODUCTTARGETSALESQUANTITY
from FACT_PRODUCTSALESTARGET

-----------view_FACT_SALESACTUAL
create view view_FACT_SALESACTUAL as 
select 
DIMPRODUCTID,
DIMSTOREID,
DIMRESELLERID,
DIMCUSTOMERID,
DIMCHANNELID,
DIMSALEDATEID,
DIMLOCATIONID,
SOURCESALESHEADERID,
SOURCESALESDETAILID,
SALEAMOUNT,
SALEQUANTITY,
SALEUNITPRICE,
SALEEXTENDEDCOST
SALETOTALPROFIT
from FACT_SALESACTUAL