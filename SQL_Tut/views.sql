-- ============================================================================
-- Goal: Save complex queries as reusable virtual tables.
-- ============================================================================

USE company_db;

-- 1. Create a View that hides sensitive 'salary' data while showing directory info
CREATE OR REPLACE VIEW public_employee_directory AS
SELECT
    e.emp_id,
    CONCAT(e.first_name, ' ', e.last_name) AS full_name,
    e.email,
    d.dept_name,
    d.city
FROM employees e
LEFT JOIN departments d ON e.dept_id = d.dept_id;

-- 2. Query the View just like a normal table!
-- Note: Views do not store physical data; they run the underlying query live.
SELECT * FROM public_employee_directory
WHERE dept_name = 'Engineering';

-- 3. Delete a View if no longer needed
-- DROP VIEW IF EXISTS public_employee_directory;