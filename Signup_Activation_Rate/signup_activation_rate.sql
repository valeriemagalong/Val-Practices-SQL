/*
Question sourced from DataLemur.com
https://datalemur.com/questions/signup-confirmation-rate

Database: PostgreSQL
*/

-- New TikTok users sign up with their emails. They confirmed their signup by
-- replying to the text confirmation to activate their accounts. Users may receive
-- multiple text messages for account confirmation until they have confirmed their
-- new account.

-- A senior analyst is interested to know the activation rate of specified users in
-- the emails table. Write a query to find the activation rate. Round the percentage
-- to 2 decimal places.

-- My strategy: Activation rate is the number of users that confirmed divided by total
-- users.  Create a CTE for total users from the emails table.  Create a CTE for
-- number of confirmed users from the texts table.  Finally, derive activation rate
-- from these two CTEs.

WITH all_users AS (
  SELECT COUNT(user_id) AS total_users
  FROM emails
),
all_confirmed AS (
  SELECT email_id, COUNT(*) AS num_confirms
  FROM texts
  WHERE signup_action = 'Confirmed'
  GROUP BY email_id
)
SELECT ROUND(SUM(num_confirms) / (SELECT total_users FROM all_users), 2)
  AS confirm_rate
FROM all_confirmed;
