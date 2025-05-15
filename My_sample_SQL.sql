
USE Sample_db

Select * FROM sample_Opportunities_data --4,133

SELECT New_Account_No, Opportunitiy_ID From sample_Opportunities_Data

Select * FROM sample_Opportunities_data WHERE Product_category = 'Services' --1,269

Select * FROM sample_Opportunities_data where Opportunity_Stage <> 'Stage - 0'

Select * FROM sample_Opportunities_data where Opportunity_Stage IN ('Stage - 0', 'Stage - 1', 'Stage - 2', 'Stage - 3')

Select * FROM sample_Opportunities_data where Opportunity_Stage NOT IN ('Stage - 0', 'Stage - 1', 'Stage - 2', 'Stage - 3')

Select * From sample_Opportunities_data where New_Opportunity_name Like '%Phase - 1%'

Select * From sample_Opportunities_data where New_Opportunity_name NOT Like '%Phase - 1%'

Select * FROM sample_Opportunities_data WHERE Product_category = 'Services' AND Opportunity_Stage = 'Stage - 5'

Select * FROM sample_Opportunities_data WHERE Product_category = 'Services' OR Opportunity_Stage = 'Stage - 5'

Select * FROM sample_Opportunities_data WHERE (Product_category = 'Services' AND Opportunity_Stage = 'Stage - 5') OR New_Opportunity_Name Like '%Phase - 7%'

Select * FROM sample_Opportunities_data WHERE Est_Opportunity_Value > 50000

Select * FROM sample_Opportunities_data WHERE Est_Opportunity_Value Between 30000 AND 50000


--where clause with subqueries
Select * From sample_account_lookup
Select * FROM sample_Opportunities_data 
Select * from sample_Calendar_lookup

--Exm 1 - 1 condition from another table
Select * From sample_Opportunities_data Where New_Account_No IN (SELECT New_Account_No FROM sample_account_lookup Where Sector = 'Banking')

--exm 2- condition from another table - fy20
Select * From sample_Opportunities_data Where Est_completion_Month_ID IN (Select DISTINCT Month_ID FROM sample_Calendar_lookup Where Fiscal_year = 'FY20')

--exm 3- condition from another table - fy20 & 1 condition
Select * From sample_Opportunities_data Where Est_completion_Month_ID IN (Select DISTINCT Month_ID FROM sample_Calendar_lookup Where Fiscal_year = 'FY20') AND est_opportunity_Value > 50000


--changing column data in product_categroy from services to services and marketing
select * from sample_Opportunities_data

Select New_account_no, Opportunity_ID, New_Opportunity_Name, Est_Completion_Month_ID, IIF(Product_Category = 'Services', 'Services & Marketing', Product_Category) AS Product_Category,
Opportunity_Stage, Est_Opportunity_value From sample_Opportunities_Data

--ex multiple iif statements with a new column
	(
	select *, 
	IIF (New_Opportunity_Name LIKE '%Phase - 1%', 'Phase 1',
	IIF (New_Opportunity_Name LIKE '%Phase - 2%', 'Phase 2',
	IIF (New_Opportunity_Name LIKE '%Phase - 3%', 'Phase 3',
	IIF (New_Opportunity_Name LIKE '%Phase - 4%', 'Phase 4',
	IIF (New_Opportunity_Name LIKE '%Phase - 5%', 'Phase 5', 'Need Mapping'))))) AS Opps_Phase
	FROM sample_Opportunities_Data
	)

Select * FROM
		(
	select *, 
	IIF (New_Opportunity_Name LIKE '%Phase - 1%', 'Phase 1',
	IIF (New_Opportunity_Name LIKE '%Phase - 2%', 'Phase 2',
	IIF (New_Opportunity_Name LIKE '%Phase - 3%', 'Phase 3',
	IIF (New_Opportunity_Name LIKE '%Phase - 4%', 'Phase 4',
	IIF (New_Opportunity_Name LIKE '%Phase - 5%', 'Phase 5', 'Need Mapping'))))) AS Opps_Phase
	FROM sample_Opportunities_Data
	) a
WHERE Opps_Phase = 'Need Mapping'


--case does same as IIF but IIF can be used 10 times where case can be used as many times
Select *,
CASE
	WHEN New_Opportunity_Name LIKE '%Phase - 1%' THEN 'Phase 1'
	Else 'Need Mapping'
	END AS Opps_Phase
FROM sample_Opportunities_Data


select * from sample_account_lookup

--exm 1:rename a column

select *, IIF(Sector = 'Capital Markets/Securities', 'Capital Markets', Sector) AS Sector2 FROM sample_account_lookup

update sample_account_lookup
SET Sector = IIF(Sector = 'Capital Markets/Securities', 'Capital Markets', Sector)


--exm 2: replace 

select *, IIF(Sector = 'Capital Markets/Securities', 'Capital Markets', Sector) AS Sector2, 
REPLACE(Account_Segment, 'PS', 'Public Sector') AS Account_Segment2

from sample_account_lookup

UPDATE sample_account_lookup
SET Account_Segment = REPLACE(Account_Segment, 'PS', 'Public Sector')

--exm 3 : insert into
INSERT INTO sample_account_lookup
SELECT '123123123123', 'New Account Name', 'Test Industry', NULL, NULL, NULL, NULL, 'Sufyan'

select * From sample_account_lookup WHere Industry_manager = 'Sufyan'

--exm 4 deleting data
DELETE FROM sample_account_lookup Where Industry_Manager = 'Sufyan'


Select * FROM sample_Opportunities_Data

--exm 1 SUM 1 column
Select Product_category, SUM(Est_Opportunity_Value) AS SUM_Est_Opportunity_Value FROM sample_Opportunities_Data
GROUP BY Product_Category


Select Product_category, Opportunity_Stage, SUM(Est_Opportunity_Value) AS SUM_Est_Opportunity_Value FROM sample_Opportunities_Data
WHERe Opportunity_Stage = 'Stage - 4'
GROUP BY Product_Category, Opportunity_Stage

--exm 2 sum 2 column
Select Product_category, Opportunity_Stage, SUM(Est_Opportunity_Value) AS SUM_Est_Opportunity_Value FROM sample_Opportunities_Data
--WHERe Opportunity_Stage = 'Stage - 4'
GROUP BY Product_Category, Opportunity_Stage
ORDER BY Product_Category, Opportunity_Stage


--exm 3 sum - order by value
Select Product_category, Opportunity_Stage, SUM(Est_Opportunity_Value) AS SUM_Est_Opportunity_Value FROM sample_Opportunities_Data
--WHERe Opportunity_Stage = 'Stage - 4'
GROUP BY Product_Category, Opportunity_Stage
ORDER BY SUM(Est_Opportunity_Value) DESC


--exm 4 COUNT 1 column
Select Product_category, COUNT(Opportunity_ID) AS No_Of_Opportunities FROM sample_Opportunities_Data
GROUP BY Product_Category
ORDER BY COUNT(Opportunity_ID) DESC

--exm 5 MIN
Select Product_category, MIN(Est_Opportunity_Value) AS MIN_Est_Opportunity_Value FROM sample_Opportunities_Data
GROUP BY Product_Category

--exm 6 Max
Select Product_category, Max(Est_Opportunity_Value) AS Max_Est_Opportunity_Value FROM sample_Opportunities_Data
GROUP BY Product_Category

Select * From sample_Opportunity_data where Est_Opportunity_value = 1000000



--left/full/cross join statement

select * From sample_Opportunities_Data
Select * from sample_account_lookup

--exm 1 left join

--1. we need to select the columns we need from the 2 or more tables we are going to join
--2. need to id the column that are identical in each table so we can join them
--3.need to specify on top which columns we need from each table

Select a.*, b.New_account_name, b.Industry
FROM
(
select New_account_No, Opportunity_ID, New_Opportunity_Name, Est_Completion_Month_ID, Product_Category, Opportunity_Stage, Est_Opportunity_Value From sample_Opportunities_data
) a --4,133

LEFT JOIN

(
Select New_account_No, New_account_name, Industry FROM sample_account_lookup
) b - 1,145
ON a.New_account_No = b.New_account_No

--4,133

SELECT Distinct New_account_No FROM sample_Opportunities_data --1139
SELECT Distinct New_account_No FROM sample_account_lookup --1145
) a

select * From sample_account_lookup where New_Account_No NOT IN (SELECT Distinct New_account_No FROM sample_Opportunities_data) --6 accounts

----
select a.*, b.New_account_name, b.Industry FROM sample_Opportunities_data a
LEFT JOIN sample_account_lookup b
ON a.New_account_No = b.New_account_No


-----ex2 full join

Select ISNULL(a.New_account_No, b.New_Account_No) AS New_Account_No,
a.Opportunity_ID, a.New_Opportunity_Name, a.Est_Completion_Month_ID, a.Product_Category, a.Opportunity_Stage, a.Est_Opportunity_Value, 
b.New_account_name, b.Industry
FROM
(
select New_account_No, Opportunity_ID, New_Opportunity_Name, Est_Completion_Month_ID, Product_Category, Opportunity_Stage, Est_Opportunity_Value From sample_Opportunities_data
) a --4,133

FULL JOIN

(
Select New_account_No, New_account_name, Industry FROM sample_account_lookup
) b -- 1,145
ON a.New_account_No = b.New_account_No

--before 4,133
--after 4,139

--exm 3 cross join


SELECT a.*, b.*
FROM
	(
	SELECT Product_category, SUM(Est_Opportunity_Value) AS Baseline FROM sample_Opportunities_Data
	WHere Est_Completion_Month_ID = (SELECT MAX(EST_Completion_Month_ID) FROM sample_Opportunities_Data)
	GROUP BY Product_Category
	) a

	CROSS JOIN

	(
	SELECT DISTINCT Fiscal_Month FROM sample_Calendar_lookup WHERE Fiscal_Year = 'FY19' AND [Date] > (SELECT GETDATE()+30)
	) b


---Union ALL---
--exm 1
	SELECT Product_category, SUM(Est_Opportunity_Value) AS Baseline FROM sample_Opportunities_Data
	GROUP BY Product_Category

	UNION ALL

	SELECT 'Totals:' AS Whatever, SUM(Est_Opportunity_Value) AS Est_Opportunity_Value FROM sample_Opportunities_Data

--exm 2
SELECT 'FY20-Q1 opps Value' AS [Period], SUM(Est_Opportunity_Value) AS SUM_Est_Opportunity_Value FROM sample_Opportunities_Data 
WHERE Est_Completion_Month_ID IN (SELECT DISTINCT Month_ID FROM sample_Calendar_lookup WHERE Fiscal_Quarter = 'FY20-Q1')

UNION ALL
SELECT 'FY20-Q2 opps Value' AS [Period], SUM(Est_Opportunity_Value) AS SUM_Est_Opportunity_Value FROM sample_Opportunities_Data 
WHERE Est_Completion_Month_ID IN (SELECT DISTINCT Month_ID FROM sample_Calendar_lookup WHERE Fiscal_Quarter = 'FY20-Q2')

UNION ALL
SELECT 'FY20-Q3 opps Value' AS [Period], SUM(Est_Opportunity_Value) AS SUM_Est_Opportunity_Value FROM sample_Opportunities_Data 
WHERE Est_Completion_Month_ID IN (SELECT DISTINCT Month_ID FROM sample_Calendar_lookup WHERE Fiscal_Quarter = 'FY20-Q3')

UNION ALL
SELECT 'FY20-Q4 opps Value' AS [Period], SUM(Est_Opportunity_Value) AS SUM_Est_Opportunity_Value FROM sample_Opportunities_Data 
WHERE Est_Completion_Month_ID IN (SELECT DISTINCT Month_ID FROM sample_Calendar_lookup WHERE Fiscal_Quarter = 'FY20-Q4')