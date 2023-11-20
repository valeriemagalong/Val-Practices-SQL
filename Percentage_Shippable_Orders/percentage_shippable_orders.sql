/*
Question sourced from StrataScratch.com
https://platform.stratascratch.com/coding/10090-find-the-percentage-of-shipable-orders

Database: MySQL
*/

-- Find the percentage of shippable orders. Consider an order is shippable if the customer's
-- address is known.

-- My strategy: Since each row in the orders table represents a single order, left join the orders table
-- with the customers table.  Use conditional aggregation to get the total number of rows with a valid
-- address (i.e. no NULL in the address column), then divide this by the total number of rows in the result
-- set to get the proportion of shippable orders.

SELECT 100 * (
    SUM(IF(c.address IS NOT NULL, 1, 0)) / COUNT(*)
    ) AS percent_shippable
FROM orders o
LEFT JOIN customers c ON o.cust_id = c.id;
