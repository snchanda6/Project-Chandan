Task4

1. Database Creation

a. Create a database to store the sales data (PostgreSQL). 
CREATE DATABASE SalesData;

b. Create a table named "sales_sample" with the specified columns:
Product_Id (Integer)
Region (varchar(50))-like East ,West etc
Date (Date) Sales_Amount (int/numeric)
CREATE TABLE sales_sample (Product_Id INTEGER,
Region VARCHAR(50),
Date DATE,
Sales_Amount NUMERIC);

2. Data Creation

a. Insert 10 sample records into the "sales_sample" table, representing sales data.
INSERT INTO sales_sample (Product_Id, Region, Date, Sales_Amount)
VALUES (1, 'East', '2024-06-01', 1000),
(1, 'West', '2024-06-02', 1500),
(1, 'South', '2024-06-03', 2000),
(2, 'North', '2024-06-04', 2500),
(2, 'South', '2024-06-05', 3000),
(2, 'West', '2024-06-06', 1000),
(2, 'East', '2024-06-07', 1500),
(3, 'South', '2024-06-08', 2000),
(3, 'East', '2024-06-09', 2500),
(3, 'North', '2024-06-10', 3000);

3. Perform OLAP operations

a) Drill Down-Analyze sales data at a more detailed level. Write a query to perform drill down from region to product level to understand sales performance.
SELECT Region, Product_Id, SUM(Sales_Amount) AS Total_Sales FROM sales_sample
GROUP BY Region, Product_Id
ORDER BY Region, Product_Id;

b) Rollup- To summarize sales data at different levels of granularity. Write a query to perform roll up from product to region level to view total sales by region.
SELECT Region, SUM(Sales_Amount) AS Total_Sales FROM sales_sample
GROUP BY ROLLUP(Region);

c) Cube - To analyze sales data from multiple dimensions simultaneously. Write a query to Explore sales data from different perspectives, such as product, region, and date.
SELECT Region, Product_Id, Date, SUM(Sales_Amount) AS Total_Sales FROM sales_sample
GROUP BY CUBE(Region, Product_Id, Date)
ORDER BY Region, Product_Id, Date;

d) Slice - To extract a subset of data based on specific criteria. Write a query to slice the data to view sales for a particular region or date range.
SELECT * FROM sales_sample
WHERE Region = 'East';
SELECT * FROM sales_sample
WHERE Date BETWEEN '2024-06-01' AND '2024-06-05';

e) Dice - To extract data based on multiple criteria. Write a query to view sales for specific combination of product, region and date
SELECT * FROM sales_sample
WHERE Product_Id = 1 AND Region = 'East' AND Date = '2024-06-01';