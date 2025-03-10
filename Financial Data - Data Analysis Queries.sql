create database financial_db;

use financial_db;

-- High-Level Insights Derived from the Data

-- 1. Retrieve all records
select * 
from financial_data;

-- 2. Retrieve specific columns
Select 
Country, 
Sales
from financial_data;

-- 3. Filter by a specific country
Select 
country,
sales
from financial_data
where country = 'France';

-- 4. Filter by a specific product and discount band
Select *
from financial_data
where product = 'Paseo' and `Discount Band` = 'Medium';

-- 5. Calculate total sales by country

select Country, sum(sales) as Total_Sales
from financial_data
where country = 'Germany';

-- 6. Calculate average profit by product

Select Product,
Avg(profit) as Avg_profit
from financial_data
where product = 'VTT'
group by product;

-- 7. Sort by sales in descending order

select *
from financial_data
order by sales Desc;

-- 8. Sort by month name and then by sales

Select *
from financial_data
order by `Month Name`, Sales Desc;

-- 9. Calculate profit margin

select product,
(sum(profit)/ sum(`Gross Sales`))*100 as Profit_Margin
from financial_data
group by product;

-- 10. Filter sales for a specific year

Select *
from financial_data
where year = 2021;

-- 11. Get monthly sales totals
select `Month Name`, 
sum(Sales) as Monthly_Sales
from financial_data
group by `Month Name`
;

-- 12. Get a list of unique products

select distinct product
from financial_data;

-- 13. Get unique discount bands
select distinct `Discount Band`
from financial_data;

-- 14. Create a new column based on conditions (using CASE)
select *,
case
when profit > '90000' then 'High_Profit'
when profit > '40000' then 'Medium_Profit'
else 'Low_Profit'
End as Profit_Efficency
from financial_data
Order by Profit_Efficency;

-- 15. Find products with sales above the average sales

select Product
from financial_data
where Sales > (select avg(sales)
from financial_data);

-- 16. Calculate Yearly Sales and Profit

select Year,
sum(sales) as Total_Sales,
sum(profit) as total_profit
from financial_data
group by `year`
order by `year`
;

-- 17. Top 3 Products by Sales
Select Product,
sum(Sales) as Total_Sales
from financial_data
group by Product
Order by Total_Sales
Limit 3;

-- 18. Monthly Sales Trend

Select `Month Name`, 
Sum(Sales) as Total_Sales
from financial_data
where `year` = '2021'
group by `Month Name`, `Month Number`
order by `Month Number`;

-- 19. Sales by Segment and Country

Select Segment, 
Country,
Sum(Sales) as Total_Sales
from financial_data
group by segment, country
order by Total_sales Desc;

-- 20.  Average Discount by Product

Select Product,
Avg(Discounts) as Average_Discount
from financial_data
group by product
order by Average_Discount;

-- 21. Profit Margin by Product

select product,
sum(profit) as Total_profit,
sum(`gross sales`) as Total_Gross,
(Sum(profit)/Sum(`gross Sales`))*100 as Profit_Margin
from financial_data
group by product
order by profit_margin Desc
;

 -- 22. Identify Underperforming Products
 
 select product,
 sum(sales) as Total_sales
 from financial_data
 group by product
 Having Total_sales < (select Avg(sales) from financial_data)
 ;
 
 -- 23. Using Row Number Windows Function
 select Product,
 Country, 
 row_number() over() as `Row Numbers`,
 avg(sales) over(partition by country order by Country) as rolling_average
 from financial_data;
 
 -- 24. Rank Window Function
select Product,
 Country, Sales,
 rank() over(partition by country  order by sales Desc) as Rank_by_Sales,
 sum(sales) over(partition by country order by sales) as rolling_Sum
 from financial_data;
 
 -- 25. Cumulative Sales Over Time
 select `Date`,
 sum(sales) over( order by `Date`) as cumulative_Sales
 from financial_data;
 
 -- 26. Units Sold by product
 
 Select 
 product, 
 sum(`Units Sold`) as Units_Sold
 from financial_data
 group by product;
 
 -- 27. Calculate Total Units Sold by Year
 
 select
 `year`,
 sum(`units Sold`)
 from financial_data
 group by `year`;
 
  -- 28. Find Products with the Highest Profit Margin
  Select
  product,
  sum(profit) as Total_profit,
  sum(`Gross Sales`) as Total_Gross_Sales,
  (sum(profit)/sum(`Gross Sales`))*100 as Profit_Margin
  from financial_data
  Group by product
  order by profit_Margin Desc
  Limit 5;
  
  -- 29. Monthly Sales Comparison Between Two Years
  Select
  `Month Name`,
  sum(CASE 
		when `year` = '2021' Then Sales 
        Else 0
        End) as Sales_2021,
	Sum(Case
		When `year` = '2020' Then Sales
        Else 0
        End) as Sales_2020
	From financial_data
    Group by `Month Name`;
        
-- 30. Top 3 Countries by Total Profit
Select 
country,
sum(profit) as `Total Profit`
from financial_data
group by country
order by `Total Profit`
Limit 3;		

-- 31. Sales Performance by Segment
Select
Segment,
sum(sales) as Total_Sales,
Avg(profit) as Average_Profit
from financial_data
group by Segment
order by Total_sales;
 
 -- 32. Identify Seasonal Trends
 Select
 `Month Name`,
 Avg(sales) as Average_Monthly_Sales
 from Financial_data
 group by `Month Name`, `Month Number`
 order by `Month Number`;
 
 -- 33. Find the Month with the Highest Sales
 Select 
 `Month Name`,
 sum(sales) as Total_Sales
from Financial_data
group by `Month Name`
order by Total_Sales
Limit 1;
 
 -- 34. Identify Products with No Sales
 Select
 product,
 Sum(Sales) as Total_Sales
 from Financial_data
 group by product
 having Total_Sales = '0';
 
 -- 35. Average Sales Amount by Product using CTE
 
 With Montly_Sales as (
 select product,
 Avg (sales) as Average_Sales
 from Financial_data
 group by product
 )
 Select product,
 Average_Sales
 from Montly_Sales;
 
-- 36. Monthly Sales Summary

select
`Month Name`,
sum(sales) as Total_Sales
from Financial_data
group by `Month Name`;


 