/*
Question sourced from DataLemur.com
https://datalemur.com/questions/alibaba-compressed-mode

Database: PostgreSQL
*/

-- You're given a table containing the item count for each order on Alibaba, along with the
-- frequency of orders that have the same item count. Write a query to retrieve the mode of the
-- order occurrences. Additionally, if there are multiple item counts with the same mode, the
-- results should be sorted in ascending order.

-- My strategy: Query the item count(s) (can be more than one row in case of a tie) with the
-- maximum number of order occurrences (i.e. the mode).  Filter based on a subquery that
-- returns the max of order_occurrences.  Order item counts in ascending order.

SELECT item_count AS mode
FROM items_per_order
WHERE order_occurrences = (
  SELECT MAX(order_occurrences)
  FROM items_per_order
)
ORDER BY item_count;
