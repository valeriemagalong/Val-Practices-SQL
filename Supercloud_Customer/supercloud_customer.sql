/*
Question sourced from DataLemur.com
https://datalemur.com/questions/supercloud-customer

Database: PostgreSQL
*/

-- A Microsoft Azure Supercloud customer is defined as a company that purchases at
-- least one product from each product category.

-- Write a query that effectively identifies the company ID of such Supercloud customers.

-- My strategy: Create a CTE, joining customer_contracts with products. Group by
-- customer, aggregating by the count of the unique product categories where
-- purchases were made.  Then, query only the customers that have a total category
-- count equal to the total number of product categories (i.e. customers who made
-- purchases in all product categories).

WITH category_counts AS (
  SELECT cc.customer_id,
    COUNT(DISTINCT p.product_category) AS total_categories
  FROM customer_contracts cc
  JOIN products p ON cc.product_id = p.product_id
  GROUP BY cc.customer_id
)
SELECT customer_id
FROM category_counts
WHERE total_categories = (
  SELECT COUNT(DISTINCT product_category)
  FROM products
);
