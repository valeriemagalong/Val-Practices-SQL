/*
Question sourced from DataLemur.com
https://datalemur.com/questions/odd-even-measurements

Database: PostgreSQL
*/

-- Assume you're given a table with measurement values obtained from a Google sensor over
-- multiple days with measurements taken multiple times within each day.

-- Write a query to calculate the sum of odd-numbered and even-numbered measurements
-- separately for a particular day and display the results in two different columns.

-- My strategy: Use the ROW_NUMBER() window function to number the measurements for each date
-- ordered by time, and wrap this query in a CTE.  Use this CTE to group by date, deriving
-- columns for the sum of the odd rows and the sum of the even rows, respectively.

WITH numbered_measures AS (
  SELECT CAST(measurement_time AS DATE) AS measurement_day,
    measurement_value,
    ROW_NUMBER() OVER (
      PARTITION BY CAST(measurement_time AS DATE)
      ORDER BY CAST(measurement_time AS TIME)
    ) AS measurement_num
  FROM measurements
)
SELECT measurement_day,
  SUM(measurement_value)
    FILTER (WHERE measurement_num % 2 != 0) AS odd_sum,
  SUM(measurement_value)
    FILTER (WHERE measurement_num % 2 = 0) AS even_sum
FROM numbered_measures
GROUP BY measurement_day;

-- An alternative (slightly less readable) solution using CASE statement

WITH numbered_measures AS (
  SELECT CAST(measurement_time AS DATE) AS measurement_day,
    measurement_value,
    ROW_NUMBER() OVER (
      PARTITION BY CAST(measurement_time AS DATE)
      ORDER BY CAST(measurement_time AS TIME)
    ) AS measurement_num
  FROM measurements
)
SELECT measurement_day,
  SUM(CASE WHEN measurement_num % 2 != 0 THEN measurement_value
    ELSE 0 END) AS odd_sum,
  SUM(CASE WHEN measurement_num % 2 = 0 THEN measurement_value
    ELSE 0 END) AS even_sum
FROM numbered_measures
GROUP BY measurement_day;
