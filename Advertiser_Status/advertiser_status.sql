/*
Question sourced from DataLemur.com
https://datalemur.com/questions/updated-status

Database: PostgreSQL
*/

-- You're provided with two tables: the advertiser table contains information about advertisers
-- and their respective payment status, and the daily_pay table contains the current payment
-- information for advertisers, and it only includes advertisers who have made payments.

-- Write a query to update the payment status of Facebook advertisers based on the information in
-- the daily_pay table. The output should include the user ID and their current payment status,
-- sorted by the user id.

-- The payment status of advertisers can be classified into the following categories:
-- NEW: Advertisers who are newly registered and have made their first payment.
-- EXISTING: Advertisers who have made payments in the past and have recently made a current payment.
-- CHURN: Advertisers who have made payments in the past but have not made any recent payment.
-- RESURRECT: Advertisers who have not made a recent payment but may have made a previous payment and
-- have made a payment again recently.

-- My strategy: Full outer join the advertiser table with the daily_pay table, since there can be
-- new advertisers who show up only in the daily_pay table.  Use COALESCE() to derive a new user_id
-- column that encompasses all user IDs from both tables.  Use a CASE statement to derive a column
-- for the new payment status.  If there is a null in the paid column, then the new status is CHURN.
-- If the advertiser does not have a current status, but paid, then the new status is NEW.  If the
-- advertiser paid and has a current status of CHURN, then the new status is RESURRECT.  If the
-- advertiser paid and has a current status of NEW or EXISTING, then the new status is EXISTING.

SELECT COALESCE(a.user_id, dp.user_id) AS user_id,
  CASE
    WHEN paid IS NULL THEN 'CHURN'
    -- If a value makes it past this line, then there was a payment made
    WHEN status IS NULL THEN 'NEW'
    WHEN status = 'CHURN' THEN 'RESURRECT'
    ELSE 'EXISTING'
  END AS new_status
FROM advertiser a
FULL OUTER JOIN daily_pay dp ON a.user_id = dp.user_id
ORDER BY user_id;
