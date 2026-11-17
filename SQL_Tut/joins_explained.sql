-- ============================================================================
-- Goal: Combine columns from multiple related tables using Foreign Keys.
-- ============================================================================

USE company_db;

-- 1. INNER JOIN: Returns ONLY rows that have a match in BOTH tables.
-- (Departments with 0 employees, like Marketing, will NOT appear here)
SELECT
    e.emp_id,
    e.first_name,
    e.salary,
    d.dept_name,
    d.city
FROM employees e
INNER JOIN departments d ON e.dept_id = d.dept_id;

-- 2. LEFT JOIN: Returns ALL rows from the Left table (departments),
-- plus matching rows from the Right table (employees). Unmatched right columns show NULL.
-- Great for finding departments that have NO employees!
SELECT
    d.dept_name,
    e.first_name AS employee_name
FROM departments d
LEFT JOIN employees e ON d.dept_id = e.dept_id;

-- 3. Multi-Table Join (3 tables: Projects -> Employees -> Departments)
SELECT
    p.project_name,
    CONCAT(e.first_name, ' ', e.last_name) AS project_lead,
    d.dept_name
FROM projects p
INNER JOIN employees e ON p.lead_emp_id = e.emp_id
INNER JOIN departments d ON e.dept_id = d.dept_id;