-- ============================================================================
-- Goal: Summarize data into totals, averages, and counts per category.
-- ============================================================================

USE company_db;

-- 1. Basic Aggregate Functions across the entire table
SELECT
    COUNT(*) AS total_employees,
    SUM(salary) AS total_payroll,
    ROUND(AVG(salary), 2) AS average_salary,
    MIN(salary) AS lowest_salary,
    MAX(salary) AS highest_salary
FROM employees;

-- 2. GROUP BY: Group rows that share a value and calculate aggregates per group
SELECT
    dept_id,
    COUNT(emp_id) AS employee_count,
    ROUND(AVG(salary), 2) AS avg_dept_salary
FROM employees
GROUP BY dept_id;

-- 3. HAVING vs WHERE:
-- WHERE filters individual rows BEFORE grouping.
-- HAVING filters grouped summaries AFTER GROUP BY runs.
SELECT
    dept_id,
    COUNT(emp_id) AS employee_count,
    SUM(salary) AS dept_salary_total
FROM employees
GROUP BY dept_id
HAVING SUM(salary) > 150000; -- Only show departments whose combined salary exceeds 150k