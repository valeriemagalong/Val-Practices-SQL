/*
Question sourced from StrataScratch.com
https://platform.stratascratch.com/coding/10353-workers-with-the-highest-salaries

Database: MySQL
*/

-- You have been asked to find the job titles of the highest-paid employees.

-- Your output should include the highest-paid title or multiple titles with the same salary.

-- My strategy: Join the worker table with the salary table, and filter only the row(s) equal
-- to the maximum salary in the table.

SELECT t.worker_title
FROM worker w
JOIN title t ON w.worker_id = t.worker_ref_id
WHERE w.salary = (SELECT MAX(salary) FROM worker);
