/*
Question sourced from DataLemur.com
https://datalemur.com/questions/sql-third-transaction

Database: PostgreSQL
*/

-- Assume you are given a table on Uber transactions made by users.  Write a query to
-- obtain the third transaction of every user. Output the user id, spend and transaction date.

-- My strategy: Derive a column that has the rank of a given transaction for a specific user,
-- then filter rows by transactions that are ranked third.

WITH transactions_ranked AS (
  SELECT *,
    RANK() OVER (PARTITION BY user_id ORDER BY transaction_date) AS transaction_number
  FROM transactions
)
SELECT user_id, spend, transaction_date
FROM transactions_ranked
WHERE transaction_number = 3;
