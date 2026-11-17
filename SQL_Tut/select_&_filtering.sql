-- ============================================================================
-- Goal: Retrieve specific columns and filter rows using conditions.
-- ============================================================================

USE company_db;

-- 1. Select all columns (*) from a table
SELECT * FROM employees;

-- 2. Select only specific columns and use Aliases (AS) for readable output headers
SELECT
    first_name AS 'First Name',
    last_name AS 'Last Name',
    salary AS 'Annual Salary'
FROM employees;

-- 3. Filter rows using WHERE with comparison operators (=, !=, >, <, >=, <=)
SELECT first_name, salary
FROM employees
WHERE salary > 80000;

-- 4. Combine multiple conditions with AND / OR
SELECT first_name, dept_id, salary
FROM employees
WHERE dept_id = 1 AND salary >= 100000;

-- 5. IN operator: Cleaner alternative to multiple OR conditions
SELECT first_name, dept_id
FROM employees
WHERE dept_id IN (1, 3);

-- 6. BETWEEN operator: Filter within an inclusive range (works on numbers and dates)
SELECT first_name, hire_date
FROM employees
WHERE hire_date BETWEEN '2022-01-01' AND '2023-12-31';

-- 7. LIKE operator: Pattern matching with wildcards
-- '%' matches any number of characters; '_' matches a single character
SELECT first_name, email
FROM employees
WHERE first_name LIKE 'A%'; -- Starts with 'A' (Aarav, Ananya)

-- 8. IS NULL: Check for missing values (Never use '= NULL', it won't work!)
SELECT first_name, last_name
FROM employees
WHERE dept_id IS NULL;