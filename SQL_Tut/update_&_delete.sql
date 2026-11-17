-- ============================================================================
-- Goal: Safely modify and delete existing records.
-- GOLDEN RULE: Always include a WHERE clause, or you will overwrite/wipe the whole table!
-- ============================================================================

USE company_db;

-- 1. Update a single record (Give Rohan a raise)
UPDATE employees
SET salary = 78000.00
WHERE emp_id = 3;

-- 2. Update multiple columns at once (Assign Ananya to QA and adjust salary)
UPDATE employees
SET dept_id = 2, salary = 65000.00
WHERE email = 'ananya.gupta@company.com';

-- 3. Verify the updates
SELECT emp_id, first_name, salary, dept_id FROM employees WHERE emp_id IN (3, 6);

-- 4. Delete a specific record
-- Let's insert a temporary dummy record first so we can safely delete it
INSERT INTO departments (dept_name, city, budget) VALUES ('Temp Dept', 'Delhi', 10000.00);

DELETE FROM departments
WHERE dept_name = 'Temp Dept';

-- Note on TRUNCATE vs DELETE:
-- DELETE removes rows one by one and can be filtered with WHERE.
-- TRUNCATE TABLE table_name; wipes ALL rows instantly and resets AUTO_INCREMENT to 1.