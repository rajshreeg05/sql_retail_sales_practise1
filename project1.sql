SELECT * FROM retail_sales
LIMIT 10;

SELECT 
COUNT(*)
FROM retail_sales

--
SELECT * FROM retail_sales
WHERE transactions_id IS NULL

SELECT * FROM retail_sales
WHERE sale_date IS NULL

SELECT * FROM retail_sales
WHERE sale_time IS NULL

SELECT * FROM retail_sales
WHERE
transactions_id IS NULL
OR
sale_date IS NULL
OR
sale_time IS NULL
OR
gender IS NULL
OR
category IS NULL
OR
quantity IS NULL
OR
cogs IS NULL
OR
total_sale IS NULL;

-- Data Exploration

--Number of sales
SELECT COUNT(*) as total_sale FROM retail_sales

--Number of unique customers
SELECT COUNT(DISTINCT customer_id)as total_sale FROM retail_sales

--Number of unique categories
SELECT DISTINCT category FROM retail_sales

--Data Analysis

-- Write a SQL Query to retrieve all columns for sales made on '2022-11-05'.
SELECT *
FROM retail_sales
WHERE sale_date = '2022-11-05';

-- Write a SQL Query to retrieve all transactions where the category is clothing and the quantity sold is equal to or more than 4 in Nov-2022
SELECT *
FROM retail_sales
WHERE category= 'Clothing'
AND quantity>=4
AND sale_date>=DATE '2022-11-01'AND sale_date<DATE '2022-12-01';

--Write a SQL Query to write the total sales for each category
SELECT category,
SUM(total_sale) AS total_sales
FROM retail_sales
GROUP BY category
ORDER BY total_sales DESC;


--Write a SQL Query to find all the transactions where total sale is greater than 1000
SELECT * FROM retail_sales
WHERE total_sale>1000;

--Write a SQL Query to find the average age of customers who purchased items from the 'Beauty' category
SELECT ROUND(AVG(age),2) as avg_age
FROM retail_sales
WHERE category= 'Beauty';

--Write a SQL Query to find the total number of transactions (transaction_id) made by each gender in each category
SELECT category,
gender,
COUNT(*) as total_trans
FROM  retail_sales
GROUP BY
category,
gender
ORDER BY 1;

--Write a SQL Query to find the average sales in each month. Find out the best selling month in each year.
SELECT * FROM 
(
SELECT 
EXTRACT(YEAR FROM sale_date) as year,
EXTRACT (MONTH FROM sale_date) as month,
AVG(total_sale) as avg_sale,
RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) as rank
FROM retail_sales
GROUP BY 1,2
) as t1
WHERE rank = 1

-- Write SQL query to find the top 5 customers based on the highest total sales
SELECT customer_id,
SUM(total_sale) as total_sales
FROM retail_sales
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;

--Write a SQL query to find the number of unique customers who purchased items from each category
SELECT category,
COUNT(DISTINCT(customer_id)) as unique_customers
FROM retail_sales
GROUP BY category;

--Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17)
WITH hourly_sale
AS
(
SELECT *,
CASE 
WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
ELSE 'Evening'
END as shift
FROM retail_sales
)
SELECT shift, COUNT(*) as total_orders
FROM hourly_sale
GROUP BY shift;

--End of project








