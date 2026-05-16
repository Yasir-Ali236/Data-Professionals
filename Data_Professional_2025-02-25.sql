DROP TABLE IF EXISTS sales_Canada;
CREATE TABLE sales_Canada(
Transaction_ID TEXT PRIMARY KEY,
Date DATE,
Country TEXT,
Product_ID TEXT,
Product_Name TEXT,
Category TEXT,
Price_Per_Unit NUMERIC,
Quantity_Purchased INT,
Cost_Price NUMERIC,
Discount_Applied NUMERIC,
Payment_Method TEXT,
Customer_Age_Group TEXT,
Customer_Gender TEXT,
Store_Location TEXT,
Sales_Representative TEXT);

SELECT * FROM sales_Canada;

CREATE TABLE sales_China(
Transaction_ID TEXT PRIMARY KEY,
Date DATE,
Country TEXT,
Product_ID TEXT,
Product_Name TEXT,
Category TEXT,
Price_Per_Unit NUMERIC,
Quantity_Purchased INT,
Cost_Price NUMERIC,
Discount_Applied NUMERIC,
Payment_Method TEXT,
Customer_Age_Group TEXT,
Customer_Gender TEXT,
Store_Location TEXT,
Sales_Representative TEXT);

SELECT * FROM sales_China;


CREATE TABLE sales_Nigeria(
Transaction_ID TEXT PRIMARY KEY,
Date DATE,
Country TEXT,
Product_ID TEXT,
Product_Name TEXT,
Category TEXT,
Price_Per_Unit NUMERIC,
Quantity_Purchased INT,
Cost_Price NUMERIC,
Discount_Applied NUMERIC,
Payment_Method TEXT,
Customer_Age_Group TEXT,
Customer_Gender TEXT,
Store_Location TEXT,
Sales_Representative TEXT);

SELECT * FROM sales_Nigeria;


CREATE TABLE sales_Uk(
Transaction_ID TEXT PRIMARY KEY,
Date DATE,
Country TEXT,
Product_ID TEXT,
Product_Name TEXT,
Category TEXT,
Price_Per_Unit NUMERIC,
Quantity_Purchased INT,
Cost_Price NUMERIC,
Discount_Applied NUMERIC,
Payment_Method TEXT,
Customer_Age_Group TEXT,
Customer_Gender TEXT,
Store_Location TEXT,
Sales_Representative TEXT);

SELECT * FROM sales_Uk;

CREATE TABLE sales_US(
Transaction_ID TEXT PRIMARY KEY,
Date DATE,
Country TEXT,
Product_ID TEXT,
Product_Name TEXT,
Category TEXT,
Price_Per_Unit NUMERIC,
Quantity_Purchased INT,
Cost_Price NUMERIC,
Discount_Applied NUMERIC,
Payment_Method TEXT,
Customer_Age_Group TEXT,
Customer_Gender TEXT,
Store_Location TEXT,
Sales_Representative TEXT);


SELECT * FROM sales_US;

CREATE TABLE sales_India(
Transaction_ID TEXT PRIMARY KEY,
Date DATE,
Country TEXT,
Product_ID TEXT,
Product_Name TEXT,
Category TEXT,
Price_Per_Unit NUMERIC,
Quantity_Purchased INT,
Cost_Price NUMERIC,
Discount_Applied NUMERIC,
Payment_Method TEXT,
Customer_Age_Group TEXT,
Customer_Gender TEXT,
Store_Location TEXT,
Sales_Representative TEXT);

SELECT * FROM sales_India;

CREATE TABLE sales_Data AS
SELECT * FROM sales_Canada
UNION ALL
SELECT * FROM sales_China
UNION ALL
SELECT * FROM sales_India
UNION ALL
SELECT * FROM sales_Nigeria
UNION ALL 
SELECT * FROM sales_Uk
UNION ALL
SELECT * FROM sales_US;

SELECT * FROM sales_Data;


SELECT * FROM sales_Data
WHERE 'transaction_id' IS NULL
OR
'date' IS NULL
OR
'country' IS NULL
OR
'price_per_unit' IS NULL
OR
'quantity_purchased' IS NULL
OR
'cost_price' IS NULL
OR
'discount_applied' IS NULL;


ALTER TABLE sales_Data
ADD COLUMN total_amount NUMERIC(10,2);

UPDATE sales_Data
SET "total_amount" = ("price_per_unit" * "quantity_purchased") - "discount_applied";

ALTER TABLE sales_Data
ADD COLUMN profit NUMERIC(10,2);

UPDATE sales_Data
SET "profit" = "total_amount" - ("cost_price" + "quantity_purchased");


-- Sales Reveune and Profit by Country
SELECT country,
SUM(total_amount) AS total_revenue,
SUM(profit) AS total_profit
FROM sales_Data
WHERE date BETWEEN '2025-01-10' AND '2025-09-10'
GROUP BY country
ORDER BY total_revenue DESC;

-- Top 5 selling products
SELECT product_name,
SUM(quantity_purchased) AS total_units_sold
FROM sales_Data
WHERE date BETWEEN '2025_01-10' AND '2025_09_14'
GROUP BY product_name
ORDER BY total_units_sold DESC
LIMIT 5;

-- Sales Representatives total Sales
SELECT sales_representative,
SUM(total_amount) AS total_sales
FROM sales_Data
WHERE date BETWEEN '2025-02-10' AND '2025-02-14'
GROUP BY sales_representative
ORDER BY total_sales DESC
LIMIT 5;

-- Which store locations generated the highest sales?
SELECT store_location,
SUM(total_amount) AS total_sales,
SUM(profit) AS total_profit
FROM sales_Data
WHERE date BETWEEN '2025-02-10' AND '2025-02-14'
GROUP BY store_location
ORDER BY total_sales DESC
LIMIT 5;

-- What are the key sales and profit insights for the selected period?

SELECT 
MIN(total_amount) AS min_sales_value,
MAX(total_amount) AS max_sales_value,
AVG(total_amount) AS avg_sales_value,
SUM(total_amount) AS total_sales_value,
MIN(profit) AS min_profit,
MAX(profit) AS max_profit,
AVG(profit) AS avg_profit,
SUM(profit) AS total_profit
FROM sales_Data
WHERE date BETWEEN '2025-02-10' AND '2025-02-14';

 


