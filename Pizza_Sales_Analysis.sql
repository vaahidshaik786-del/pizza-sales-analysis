-- DATABASE SETUP

create database pizza_sales;
use pizza_sales;
select count(*) from pizza_sales;

select * from pizza_sales;

-- DATA CLEANING AND TRANSFORMATION

ALTER TABLE pizza_sales
ADD COLUMN new_order_date DATE;

UPDATE pizza_sales
SET new_order_date = STR_TO_DATE(order_date,'%m/%d/%Y');

SET SQL_SAFE_UPDATES = 1;

-- If date conversion fails use alternate format

UPDATE pizza_sales
SET new_order_date = STR_TO_DATE(order_date,'%d-%m-%Y');

-- Deleting old order_date

alter table pizza_sales
drop column order_date;

-- Renaming new_order_date to order_date

alter table pizza_sales
rename column new_order_date to order_date;

-- Replacing order_date

alter table pizza_sales
modify column order_date date
after quantity;

-- KPI Analysis

select sum(total_price) as Total_Revenue
from pizza_sales;

select sum(total_price) / count(distinct order_id)
as Avg_Order_Value from pizza_sales;

select sum(quantity) as Total_Pizza_sales 
from pizza_sales;

select count(distinct order_id) as total_orders
from pizza_sales;

select sum(quantity) / 
count(distinct order_id) 
as avg_sales from pizza_sales;

-- Trend Analysis

SELECT 
DAYNAME(order_date) AS order_day,
COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY dayofweek(order_date),
dayname(order_date)
ORDER BY dayofweek(order_date);

select
monthname(order_date) as order_month,
count(distinct order_id) as Total_order
from pizza_sales
group by order_month
order by Total_order desc;

-- Category Analysis

select 
pizza_category, sum(total_price) * 100 / (select sum(total_price) from pizza_sales) as percentage_of_total_sales
from pizza_sales
group by pizza_category
order by percentage_of_total_sales desc;

select
pizza_category, sum(quantity) as Total_pizzas_sold 
from pizza_sales
group by pizza_category
order by Total_pizzas_sold desc;

-- Product Performance

select
pizza_name,
sum(total_price) as Total_Revenue,
sum(quantity) as Total_quantity,
count(distinct order_id) as Total_orders
from pizza_sales
group by pizza_name
order by Total_Revenue desc
limit 5;

select
pizza_name,
sum(total_price) as Total_Revenue,
sum(quantity) as Total_quantity,
count(distinct order_id) as Total_orders
from pizza_sales
group by pizza_name
order by Total_Revenue asc
limit 5;

 

