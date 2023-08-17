/*
Question sourced from DataLemur.com
https://datalemur.com/questions/rolling-average-tweets

Database: PostgreSQL
*/

-- Given a table of tweet data over a specified time period, calculate the 3-day rolling
-- average of tweets for each user. Output the user ID, tweet date, and rolling averages
-- rounded to 2 decimal places.

-- My strategy: Per Twitter user, for each row of data, i.e. a tweet
-- date, calculate the average tweet count for the row and its preceding
-- two rows (using a window function).