-- ============================================================================
-- Goal: Transform, clean, and categorize raw data directly inside SELECT queries.
-- ============================================================================

USE company_db;

-- 1. CASE WHEN: Acts like IF / ELSE IF / ELSE inside SQL
-- Categorize employees into salary tiers without modifying table data
SELECT
    first_name,
    last_name,
    salary,
    CASE
        WHEN salary >= 100000 THEN 'Senior / Executive Tier'
        WHEN salary >= 75000  THEN 'Mid-Level Tier'
        ELSE 'Entry / Junior Tier'
    END AS compensation_band
FROM employees
ORDER BY salary DESC;

-- 2. Conditional Aggregation: Count how many employees fall into each band in 1 row
SELECT
    COUNT(CASE WHEN salary >= 100000 THEN 1 END) AS high_earners,
    COUNT(CASE WHEN salary BETWEEN 75000 AND 99999 THEN 1 END) AS mid_earners,
    COUNT(CASE WHEN salary < 75000 THEN 1 END) AS junior_earners
FROM employees;

-- 3. NULL Handling: COALESCE() and IFNULL()
-- COALESCE returns the first non-NULL value from a list of arguments
SELECT
    e.first_name,
    COALESCE(d.dept_name, 'Unassigned / Freelancer') AS department_status
FROM employees e
LEFT JOIN departments d ON e.dept_id = d.dept_id;

-- 4. String Functions: Cleaning and formatting text
SELECT
    emp_id,
    UPPER(CONCAT(TRIM(first_name), ' ', TRIM(last_name))) AS formatted_full_name,
    SUBSTRING_INDEX(email, '@', 1) AS username_only,
    REPLACE(email, '@company.com', '@techcorp.io') AS migrated_email
FROM employees;

-- 5. Date & Time Functions: Tenure calculation and date formatting
SELECT
    first_name,
    hire_date,
    DATE_FORMAT(hire_date, '%M %d, %Y') AS readable_hire_date,
    TIMESTAMPDIFF(YEAR, hire_date, CURDATE()) AS completed_years,
    DATEDIFF(CURDATE(), hire_date) AS total_days_employed,
    DATE_ADD(hire_date, INTERVAL 90 DAY) AS probation_end_date
FROM employees;