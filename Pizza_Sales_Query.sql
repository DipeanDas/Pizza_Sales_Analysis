/*Database/Table Value Check*/
select * from pizza_sales*/
/*Total revenue*/
select SUM(total_price) from pizza_sales*/
/*Average Order Value*/
select (SUM(total_price)/COUNT(DISTINCT order_id)) as Average_Order_Value from pizza_sales*/
/*total Pizzas sold*/
select SUM(quantity) as Total_Pizzas_Sold from pizza_sales*/
/*Total Distinct orders*/
select COUNT(DISTINCT order_id) as Total_Orders from pizza_sales*/
/*Average Pizzas Per Order*/
select CAST(CAST(SUM(quantity) as Decimal(10,2))/CAST(COUNT(DISTINCT order_id) as Decimal(10,2)) as Decimal(10,2)) as AVG_Pizzas_per_Order from pizza_sales

/*Daily Trend*/
SELECT DATENAME(DW, order_date) as Order_day, COUNT (DISTINCT order_id) AS Total_orders
from pizza_sales
GROUP BY DATENAME(DW, order_date)
/*Hourly Trend*/
SELECT DATEPART(HOUR, order_time) AS Order_Hours, COUNT(DISTINCT order_id) AS Total_orders
from pizza_sales
GROUP BY DATEPART(HOUR, order_time)
ORDER BY DATEPART(HOUR, order_time)

/*Sales% by Pizza Type*/
SELECT pizza_category,sum(total_price) as Total_Sales, sum(total_price)*100/
(SELECT sum(total_price) from pizza_sales Where MONTH(order_date)=1 ) 
as Percentage_Total_Sales_per_Pizza_Type
from pizza_sales
Where MONTH(order_date)=1
GROUP BY pizza_category

SELECT pizza_category,sum(total_price) as Total_Sales, sum(total_price)*100/
(SELECT sum(total_price) from pizza_sales) 
as Percentage_Total_Sales_per_Pizza_Type
from pizza_sales
GROUP BY pizza_category

/*Sales% by Pizza Size*/
SELECT pizza_size,cast(sum(total_price) as Decimal(10,2)) as Total_Sales, cast(sum(total_price)*100)/
(SELECT cast(sum(total_price) from pizza_sales) as decimal(10,2))
as Percentage_Total_Sales_per_Pizza_size
from pizza_sales
GROUP BY pizza_size
ORDER BY Percentage_Total_Sales_per_Pizza_size DESC

SELECT pizza_size, CAST(SUM(total_price) AS DECIMAL(10,2)) as total_revenue,
CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) from pizza_sales) AS DECIMAL(10,2)) AS PCT
FROM pizza_sales
GROUP BY pizza_size
ORDER BY pizza_size

/*Monthly Sales*/
SELECT pizza_category, SUM(quantity) as Total_Quantity_Sold
FROM pizza_sales
WHERE MONTH(order_date) = 2
GROUP BY pizza_category
ORDER BY Total_Quantity_Sold DESC

/*Top 5 bestseller Pizza*/
SELECT Top 5 pizza_name, SUM(quantity) AS Total_Pizza_Sold
FROM pizza_sales
Where Month(order_date)=1
GROUP BY pizza_name
ORDER BY Total_Pizza_Sold DESC
