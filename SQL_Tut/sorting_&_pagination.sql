-- ============================================================================
-- Goal: Control the order and number of rows returned by a query.
-- ============================================================================

USE company_db;

-- 1. DISTINCT: Return only unique values (removes duplicates)
SELECT DISTINCT dept_id
FROM employees
WHERE dept_id IS NOT NULL;

-- 2. ORDER BY: Sort results ascending (ASC - default) or descending (DESC)
SELECT first_name, salary
FROM employees
ORDER BY salary DESC; -- Highest salary first

-- 3. Multi-column sorting: Sort by department ascending, then salary descending
SELECT first_name, dept_id, salary
FROM employees
ORDER BY dept_id ASC, salary DESC;

-- 4. LIMIT: Get only the top N records (e.g., Top 3 highest paid employees)
SELECT first_name, last_name, salary
FROM employees
ORDER BY salary DESC
LIMIT 3;

-- 5. LIMIT with OFFSET: Used for pagination (e.g., Page 2 showing 2 records per page)
-- Skips the first 2 rows, then returns the next 2 rows.
SELECT emp_id, first_name, last_name
FROM employees
ORDER BY emp_id ASC
LIMIT 2 OFFSET 2;