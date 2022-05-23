/*--------------------------1---------------------
Give an overall assessment of stores number 10 and 21’s sales.

How are they performing compared to target? Will they meet their 2014 target?
Should either store be closed? Why or why not?
What should be done in the next year to maximize store profits?*/


--------------------Sales Views---------------
Drop view View_DailySales

CREATE VIEW View_DailySales
AS
  SELECT DISTINCT
    ds.StoreNumber,
    d.DATE,
    d.YEAR,
    SUM(S.SaleAmount) AS DailyTotalSaleAmount,
    SUM(S.SaleTotalProfit) AS DailySaleTotalProfit
  FROM view_FACT_SALESACTUAL S
        JOIN View_Dim_Store ds ON S.DimStoreID = DS.DimStoreID
        JOIN View_Dim_Date d ON S.DimSaleDateID = d.DATE_PKEY
    GROUP BY d.DATE, d.YEAR, DS.StoreNumber
    ORDER BY DS.StoreNumber, d.DATE
  
select * from View_DailySales
  
  
-----------Target Views----------------
CREATE VIEW View_DailyTarget
AS
  SELECT DISTINCT
    s.StoreNumber,
    d.DATE,
    d.YEAR,
    t.SalesTargetAmount AS DailyTarget
  FROM view_FACT_SRCSALESTARGET t
       JOIN View_Dim_Store s ON t.DimStoreID = s.DimStoreID
       JOIN View_Dim_Date d ON t.DimTargetDateID = d.DATE_PKEY
  ORDER BY s.StoreNumber, d.DATE
  
select * from View_DailyTarget
select * from view_fact_srcsalestarget

---------------Sales vs Target-----------------
drop view View_SalesToTarget

CREATE or replace VIEW View_SalesToTarget
AS
SELECT DISTINCT a.StoreNumber,
      a.YEAR,
      SUM(b.DailyTarget) AnnualTarget,
      SUM(a.DailyTotalSaleAmount) RunningTotalSaleAmount,
      (RunningTotalSaleAmount - AnnualTarget ) AS ExceededTargetBy,
      SUM(a.DailySaleTotalProfit) AnnualProfit
  FROM View_DailySales a
  LEFT JOIN View_DailyTarget b ON a.DATE = b.DATE
  WHERE a.StoreNumber IN (10, 21) and a.StoreNumber = b.StoreNumber
  GROUP BY a.StoreNumber, a.YEAR
  ORDER BY a.YEAR, a.StoreNumber
  
select * from View_SalesToTarget


/*How are they performing compared to target? Will they meet their 2014 target?
 Store 10 did very well for it exceeded its target for 2013 by $984,947.35. 
 Store 21 performed poorly in 2013 as it fell short of meeting the target by $8,981,1138.37
 Store 10 is $958322.87 far from target for the year 2014.
 Store 21 is -2892338.09 far from target for the year 2014.
 
 Thus, it seems like Store10 is only very little short of targte for the year 2014. However, the gap is not that huge and I believe they will be able to cover it 
 up to meet its 2014 target.
 However, this is not the case for store 21 as it is far behind the target and is unlikely that it would be able to cover the gap and meet 2014 target.

 Should either store be closed? Why or why not?
 We can estimate that Store 21 can well likely be closed as it fails to meet the target for 2 consecutive years and not helping with the revenue and generating 
 loss to the firm.
 

 What should be done in the next year to maximize store profits?
 The following can be some of the steps in my opinion that can be taken to increase the profits for the subsequent year:
 Replace the non-selling products with more popular products
 Decrease the price on unpopular products
 Stop selling the products in areas where it is not being sold
 Slightly increase the price on popular products

*/

/*--------------------------2---------------------
Recommend 2013 bonus amounts for each store if the total bonus pool is $2,000,000 using a comparison of 
2013 actual sales vs. 2013 sales targets as the basis for the recommendation.
-----------------------------------------------------------------------*/


CREATE or replace VIEW View_SalesToTarget_All
AS
SELECT DISTINCT a.StoreNumber,
      a.YEAR,
      SUM(b.DailyTarget) AnnualTarget,
      SUM(a.DailyTotalSaleAmount) RunningTotalSaleAmount,
      (RunningTotalSaleAmount - AnnualTarget ) AS ExceededTargetBy,
      SUM(a.DailySaleTotalProfit) AnnualProfit
  FROM View_DailySales a
  LEFT  JOIN View_DailyTarget b ON a.DATE = b.DATE
  WHERE a.StoreNumber = b.StoreNumber
  GROUP BY a.StoreNumber, a.YEAR
  ORDER BY a.YEAR, a.StoreNumber
  
  
 
  CREATE or replace VIEW view_Bonus
AS
  select *, 
    case when rn=1 then '30%'
         when rn=2 then '25%'
         when rn=3 then '20%'
         when rn=4 then '15%'
         when rn=5 then '10%'
         else '0%'
    end as BonusPercent,
    case when rn=1 then 0.3*2000000
         when rn=2 then 0.25*2000000
         when rn=3 then 0.20*2000000
         when rn=4 then 0.15*2000000
         when rn=5 then 0.10*2000000
         else 0
    end as BonusAmount 
    FROM (
  SELECT dense_RANK() OVER (PARTITION BY YEAR ORDER BY ExceededTargetBy DESC) AS rn, 
      Year,  
      StoreNumber,
      AnnualTarget,
      RunningTotalSaleAmount AS AnnualSaleAmount,
      AnnualProfit,
      ExceededTargetBy
    FROM View_SalesToTarget_All) a
       WHERE YEAR = 2013
       
 select * from View_SalesToTarget_All
       
/*
The stores with the least target to sales difference would be recommended the most bonus, 30 percent and the store with the highest target
to sales difference the least bonus, 0
*/

----------------------------------------------3------------------------------------------------------------
/*Assess product sales by day of the week at stores 10 and 21. What can we learn about sales trends? */


CREATE or replace VIEW View_Trend as 
  SELECT DISTINCT SV.StoreNumber,
      D.DAY_NUM_IN_WEEK,
      SUM(S.SaleAmount) SaleAmount,
      SUM(S.SaleQuantity) SaleQuantity,
      SUM(S.SaleTotalProfit) SaleTotalProfit
  FROM  view_FACT_SALESACTUAL as S
      INNER JOIN View_Dim_Product P ON S.DimProductID = P.DimProductID
      INNER JOIN View_Dim_Date D ON S.DimSaleDateID = D.Date_PKEY
      INNER JOIN View_Dim_Store SV ON S.DimStoreID = SV.DimStoreID
  WHERE SV.DimStoreID IS NOT NULL
      AND SV.StoreNumber IN (10, 21)
group by sv.storenumber,DAY_NUM_IN_WEEK
order by sv.storenumber, DAY_NUM_IN_WEEK

/* Store 10
Total Sales Amount has a downward trend on weekdays, from Tuesday to Friday and an upward trend on weekends, ie Friday to Monday.

Store 21
Total Sales Amount has an upward trend on weekends, ie Friday to Sunday, falls on Monday and Tuesday, 
increases from Wednesday-Thursday and finally depreceates by a small amount on Friday.
*/

select distinct 
    a.storenumber,
    c.dimproductid,
    DAY_NUM_IN_WEEK,
    sum(b.saleamount) SaleAmount,
    sum(SaleTotalProfit) SaleTotalProfit,
    sum(ProductRetailProfit) ProductRetailProfit
from dim_store a 
join fact_salesactual b on a.dimstoreid=b.dimstoreid
join dim_product c on b.dimproductid=c.dimproductid
join dim_date d on b.DIMSALEDATEID=d.date_pkey 
where a.dimstoreid in (5,7) 
group by a.storenumber,c.dimproductid,DAY_NUM_IN_WEEK
order by a.storenumber, c.dimproductid, DAY_NUM_IN_WEEK

/*
The above query shows stores 10 and 21's product level analysis:

-----------------------------------------4--------------------------------------
--Should any new stores be opened? Include all stores in your analysis if necessary. If so, where? Why or why not?*/

  
create or replace view View_StorePerformanceByLocation as
  SELECT dense_RANK() OVER (PARTITION BY YEAR ORDER BY ExceededTargetBy DESC) AS rn,
      a.StoreNumber,
      Year,
      AnnualTarget,
      RunningTotalSaleAmount AS AnnualSaleAmount,
      AnnualProfit,
      ExceededTargetBy,
      c.state_province, c.City, c.Country, c.PostalCode
    FROM View_SalesToTarget_All a
    JOIN View_Dim_Store b ON a.StoreNumber = b.StoreNumber
    JOIN View_Dim_Location c ON b.DimLocationID = c.DimLocationID
  ORDER BY rn,StoreNumber,YEAR, AnnualProfit DESC, ExceededTargetBy DESC
  

/*

Stores in Arkansas that Failed to meet Target:
2013:
Store Number21
Store Number8

2014:
Store Number21

We can see that stores 8 and 21 fails to meet the target for the year 2013. 
Store 8 picks up in 2014, however, store 21 still does not meet the target and can be considered to be closed in Arkansas 


Stores in Mississippi that Failed to meet Target:
2013- Store Number39
2014- Store Number39

Store 39 fails to meet the target in both 2013 and 2014 and can be considered to be closed. 

Stores in Missouri that Failed to meet Target:
2014- StoreNumber10

Though Store10 fails to meet the target in 2014, we can wait for another year, evaluate its performance and then make a decision on whether it should 
be closed or not.

*/