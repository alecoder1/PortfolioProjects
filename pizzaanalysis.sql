-- PIZZA SALES SQL QUERIES
use pizza_db;

select * from pizza_sales ps;

-- KPI’s
-- Total Revenue

select sum(total_price) as Total_Revenue
from pizza_sales ps 

-- Average Order Revenue
select sum(total_price) / count(distinct order_id)
as Avg_Order_Value
from pizza_sales ps 


-- Total Pizza sold
select sum(quantity) as Total_Pizza_sold
from pizza_sales ps 

-- Total orders placed
select count(distinct order_id) as Total_Orders
from pizza_sales ps 

-- Average pizzas sold per order
select cast(cast(sum(quantity) as Decimal(10,2)) / cast(count(distinct order_id) as decimal(10, 2)) 
as decimal(10, 2))
as Avg_pizza_sold_per_order
from pizza_sales ps 


-- CHART REQUIREMENTS

-- Daily trend
select DAYNAME(cast(order_date as DATE)) as order_day, 
	count(distinct order_id) as Total_orders
from pizza_sales ps 
group by DAYNAME(cast(order_date as DATE))


-- Hourly trend
select datepart(hour, order_time) as Order_Hours, count(distinct order_id) as Total_orders
from pizza_sales ps 
group by datepart(hour, order_time)
order by datepart(hour, order_time)

select extract(hour from order_time) as Order_Hours, 
	count(distinct order_id) as Total_orders
	from pizza_sales ps 
	group by extract(hour from order_time)
	order by extract(hour from order_time);


-- percentage of sales by pizza category
select pizza_category, SUM(total_price) as Total_price, sum(total_price) *100 / (select sum(total_price) from pizza_sales ps )
	as pct_Total_sales
from pizza_sales ps2 
-- where month(order_date) = 1
group by pizza_category


-- Total pizzas sold by pizza category

select pizza_size, cast(SUM(total_price)as DECIMAL(10, 2)) as Total_price, cast(sum(total_price) *100 / (select sum(total_price) from pizza_sales ps ) as DECIMAL(10, 2))
	as pct_Total_sales
from pizza_sales ps2 
-- where EXTRACT(quarter , order_date) = 1
-- where month(order_date) = 1
group by pizza_size
order by pct_Total_sales desc 


select pizza_category, sum(quantity) as Total_Pizzas_Sold
from pizza_sales ps 
group by pizza_category

select * from pizza_sales ps 


-- Top  5 best sellers by total pizzas sold

select pizza_name, sum(quantity) as Total_pizza_sold
from pizza_sales ps 
group by pizza_name
order by Total_pizza_sold DESC  
limit 5;

-- Bottom 5 worst sellers(pizza name) by total pizzas sold
select pizza_name, sum(quantity) as Total_pizza_sold
from pizza_sales ps 
group by pizza_name
order by Total_pizza_sold ASC  
limit 5;

