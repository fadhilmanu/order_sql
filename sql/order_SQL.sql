USE go;
SELECT * FROM Orders;
-- 1. What is the total revenue generated from all orders? --r1
SELECT SUM(ListPrice * Quantity) AS TotalRevenue FROM orders;

-- 2. What is the total profit, considering cost price and list price? --r2
SELECT SUM((ListPrice - costprice) * Quantity) AS TotalProfit FROM orders;

-- 3. How many orders were placed each month? --r3
SELECT DATE_FORMAT(STR_TO_DATE(OrderDate, '%d-%m-%Y'), '%Y-%m') AS Month, COUNT(OrderId) AS OrdersCount 
FROM orders GROUP BY Month ORDER BY Month;

-- 4. What is the average order value (total revenue divided by number of orders)? --a4
SELECT SUM(ListPrice * Quantity) / COUNT(DISTINCT OrderId) AS AverageOrderValue FROM orders;

-- 5. Which shipping mode is used the most? --a5
SELECT ShipMode, COUNT(*) AS UsageCount FROM orders GROUP BY ShipMode ORDER BY UsageCount DESC LIMIT 1;


-- 6. What is the total sales value for each shipping mode? -a6
SELECT ShipMode, SUM(ListPrice * Quantity) AS TotalSales FROM orders GROUP BY ShipMode ORDER BY TotalSales DESC;


-- --7. How many unique products have been sold?
SELECT  COUNT(DISTINCT ProductId) AS Unique_products FROM Orders;

-- --8. Which product has been sold the most in terms of quantity?
SELECT ProductId, SUM(Quantity) AS TotalQuantity FROM orders GROUP BY ProductId ORDER BY TotalQuantity DESC
LIMIT 1;

-- --9. What are the top 5 highest-selling products by revenue?
SELECT ProductId, SubCategory, SUM(ListPrice * Quantity) AS TotalRevenue FROM orders GROUP BY ProductId, SubCategory
ORDER BY TotalRevenue DESC
LIMIT 5;
-- 10. Which category generates the highest total sales? --d10
select Category, sum(ListPrice * Quantity) as Total_Sales from orders group by Category limit 1;

-- 11. What is the average discount given across all orders? --d11
select avg(DiscountPercent) as avgdiscount from orders;

-- 12. Which city has the highest total sales? --d12
SELECT City, SUM(ListPrice * Quantity) AS TotalSales FROM orders GROUP BY City ORDER BY TotalSales DESC LIMIT 1;

-- 13. What is the total sales amount for each region?
select region, sum( ListPrice * quantity) as totalsales  from orders  group by region;  

-- 14. How many orders were placed in each state?
select state, count(orderid) as totalorders  from orders  group by state  order by totalorders desc;

-- 15. Which customer segment has the highest sales value?
select segment, sum(listprice * quantity) as totalsales  from orders  group by segment  order by totalsales desc  limit 1;
-- 16. What is the percentage contribution of each category to total revenue? --n16
SELECT 
    Category,
    SUM((ListPrice - (ListPrice * DiscountPercent / 100)) * Quantity) AS Revenue,
    (SUM((ListPrice - (ListPrice * DiscountPercent / 100)) * Quantity) / 
    (SELECT SUM((ListPrice - (ListPrice * DiscountPercent / 100)) * Quantity) FROM orders)) * 100 AS Percentage_contribution
FROM orders GROUP BY Category ORDER BY Percentage_contribution DESC;

-- 17. What is the profit margin percentage for each product? --n17
SELECT  
    ProductId,  
    SubCategory,  
    Category,  
    SUM((ListPrice - (ListPrice * DiscountPercent / 100)) * Quantity) AS Revenue,  
    SUM(CostPrice * Quantity) AS Cost,  
    SUM(((ListPrice - (ListPrice * DiscountPercent / 100)) * Quantity) - (CostPrice * Quantity)) AS Profit,  
    (SUM(((ListPrice - (ListPrice * DiscountPercent / 100)) * Quantity) - (CostPrice * Quantity)) ) /  
    SUM((ListPrice - (ListPrice * DiscountPercent / 100)) * Quantity) * 100 AS Profit_Margin_Percentage  
FROM orders  
GROUP BY ProductId, SubCategory, Category  
ORDER BY Profit_Margin_Percentage DESC;

-- 18. Which products have the highest discount percentage? --n18
SELECT  
    ProductId,  
    SubCategory,  
    Category,  
    ListPrice,  
    DiscountPercent  
FROM orders  
ORDER BY DiscountPercent DESC  
LIMIT 10;

-- 19)Total quantity of items sold per month:
SELECT DATE_FORMAT(orderdate, '%Y-%m') AS YearMonth,SUM(Quantity) AS TotalQuantity FROM orders GROUP BY YearMonth ORDER BY YearMonth;
-- 20) Number of orders with a discount greater than 10%:
SELECT COUNT(*) AS OrdersWithHighDiscount FROM orders WHERE DiscountPercent > 10;
-- 21)State with the highest average order value:
select state, avg(listprice * quantity) as avgordervalue  from orders  group by state  order by avgordervalue desc limit 1;