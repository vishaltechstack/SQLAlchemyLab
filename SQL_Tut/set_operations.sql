-- ============================================================================
-- Goal: Stack results from two or more SELECT queries vertically.
-- RULE: Both queries must return the exact same number of columns with
--       compatible data types in the same order.
-- ============================================================================

USE company_db;

-- 1. UNION vs UNION ALL
-- UNION removes duplicate rows (slower because it sorts/deduplicates).
-- UNION ALL keeps all rows including duplicates (faster).

-- Example: Create a combined contact directory of Employees and Departments
SELECT
    first_name AS entity_name,
    'Employee' AS entity_type,
    email AS contact_or_location
FROM employees

UNION ALL

SELECT
    dept_name AS entity_name,
    'Department' AS entity_type,
    city AS contact_or_location
FROM departments;

-- 2. INTERSECT (Supported in MySQL 8.0.31+)
-- Returns ONLY rows that appear in BOTH query results.
-- Example: Find Employee IDs who belong to Dept 1 AND also lead a project
SELECT emp_id FROM employees WHERE dept_id = 1
INTERSECT
SELECT lead_emp_id FROM projects WHERE lead_emp_id IS NOT NULL;

-- 3. EXCEPT (Supported in MySQL 8.0.31+)
-- Returns rows from the FIRST query that are NOT present in the SECOND query.
-- Example: Find Employee IDs who are NOT leading any project
SELECT emp_id FROM employees
EXCEPT
SELECT lead_emp_id FROM projects WHERE lead_emp_id IS NOT NULL;