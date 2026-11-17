-- ============================================================================
-- Goal: Use the result of one query inside another query.
-- ============================================================================

USE company_db;

-- 1. Subquery in WHERE: Find employees earning MORE than the company average salary
-- Step A (Inner query): Calculates AVG(salary)
-- Step B (Outer query): Compares each employee's salary against that single number
SELECT first_name, last_name, salary
FROM employees
WHERE salary > (
    SELECT AVG(salary) FROM employees
);

-- 2. Subquery with IN: Find all employees who are leading a project
SELECT first_name, last_name, email
FROM employees
WHERE emp_id IN (
    SELECT lead_emp_id FROM projects WHERE lead_emp_id IS NOT NULL
);

-- 3. Subquery in FROM (Derived Table): Find the highest average salary among departments
SELECT MAX(dept_avg) AS highest_department_avg_salary
FROM (
    SELECT dept_id, AVG(salary) AS dept_avg
    FROM employees
    GROUP BY dept_id
) AS department_averages;