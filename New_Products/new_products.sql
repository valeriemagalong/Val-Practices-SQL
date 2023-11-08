/*
Question sourced from StrataScratch.com
https://platform.stratascratch.com/coding/10318-new-products

Database: MySQL
*/

-- You are given a table of product launches by company by year. Write a query to count the net
-- difference between the number of products companies launched in 2020 with the number of products
-- companies launched in the previous year. Output the name of the companies and a net difference of net
-- products released for 2020 compared to the previous year.

-- My strategy: The question is asking for the difference in total products launched in 2020 compared to
-- 2019 for each company.  Use conditional aggregation twice to get the 2019 total products and 2020 total
-- products, then derive a column for the difference between total number of products, grouping by company.

SELECT company_name,
    SUM(IF(year = '2020', 1, 0)) - SUM(IF(year = '2019', 1, 0)) AS difference_product_count
FROM car_launches
GROUP BY company_name;
