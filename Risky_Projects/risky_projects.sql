/*
Question sourced from StrataScratch.com
https://platform.stratascratch.com/coding/10304-risky-projects

Database: MySQL
*/

-- Identify projects that are at risk for going overbudget. A project is considered to be overbudget
-- if the cost of all employees assigned to the project is greater than the budget of the project.

-- You'll need to prorate the cost of the employees to the duration of the project. For example, if the
-- budget for a project that takes half a year to complete is $10K, then the total half-year salary of
-- all employees assigned to the project should not exceed $10K. Salary is defined on a yearly basis, so
-- be careful how to calculate salaries for the projects that last less or more than one year.

-- Output a list of projects that are overbudget with their project name, project budget, and prorated
-- total employee expense (rounded to the next dollar amount).

-- My strategy: Using the linkedin_projects table, derive a column for the project length in days by
-- subtracting the project start date from the project end date.  Then, derive a column for the
-- proportion of one year taken up by the project by dividing the project length by 365 days.  Inner
-- join the linkedin_projects table with the linkedin_emp_projects and linkedin_employees tables.
-- Wrap this result set in a CTE, then use the project length in terms of proportion of the year to
-- calculate each employee's prorated salary for that project.  Sum the prorated salaries associated
-- with a project, then filter by projects with total salaries exceeding the project budget.

WITH project_summary AS (
    SELECT lp.title, lp.budget, le.salary,
        DATEDIFF(lp.end_date, lp.start_date) / 365 AS project_length_prop_yr
    FROM linkedin_projects lp
    JOIN linkedin_emp_projects lep ON lp.id = lep.project_id
    JOIN linkedin_employees le ON lep.emp_id = le.id
)
SELECT title, budget,
    CEILING(SUM(salary * project_length_prop_yr)) AS total_prorated_salaries
FROM project_summary
GROUP BY title
HAVING total_prorated_salaries > budget;
