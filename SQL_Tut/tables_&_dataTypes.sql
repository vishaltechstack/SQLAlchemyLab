-- ============================================================================
-- Goal: Create tables using standard MySQL data types and modify table columns.
-- ============================================================================

USE company_db;

-- 1. Create a 'departments' table
CREATE TABLE IF NOT EXISTS departments (
    dept_id INT,                 -- Whole numbers (e.g., 1, 2, 100)
    dept_name VARCHAR(50),       -- Variable-length text up to 50 characters
    location VARCHAR(50)
);

-- 2. Inspect the structure (columns and data types) of the table
DESCRIBE departments;

-- 3. Modify an existing table using ALTER TABLE
-- Add a new column for department budget with 2 decimal places (up to 99,999,999.99)
ALTER TABLE departments
ADD COLUMN budget DECIMAL(10, 2);

-- Rename a column
ALTER TABLE departments
RENAME COLUMN location TO city;

-- 4. Drop (delete) the table so we can rebuild it cleanly with Constraints in File 03
DROP TABLE IF EXISTS departments;