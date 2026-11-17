-- ============================================================================
-- Goal: Write cleaner multi-step queries and run calculations across rows
--       without collapsing individual records (unlike GROUP BY).
-- ============================================================================

USE company_db;

-- ============================================================================
-- PART 1: COMMON TABLE EXPRESSIONS (CTEs)
-- A CTE creates a temporary, named result set that exists ONLY for the duration
-- of a single query. Think of it as a cleaner alternative to subqueries.
-- ============================================================================

-- 1. Basic CTE: Find employees earning above their own department's average
WITH DepartmentAvg AS (
    -- Step 1: Calculate average salary per department
    SELECT
        dept_id,
        ROUND(AVG(salary), 2) AS avg_dept_salary
    FROM employees
    WHERE dept_id IS NOT NULL
    GROUP BY dept_id
)
-- Step 2: Join the CTE back to employees just like a normal table
SELECT
    e.first_name,
    e.last_name,
    d.dept_name,
    e.salary,
    da.avg_dept_salary
FROM employees e
INNER JOIN DepartmentAvg da ON e.dept_id = da.dept_id
INNER JOIN departments d ON e.dept_id = d.dept_id
WHERE e.salary > da.avg_dept_salary;


-- 2. Chaining Multiple CTEs: Separate data prep from final filtering
WITH ActiveStaff AS (
    SELECT emp_id, first_name, last_name, salary, dept_id
    FROM employees
    WHERE dept_id IS NOT NULL
),
HighEarners AS (
    SELECT *
    FROM ActiveStaff
    WHERE salary >= 80000
)
SELECT
    he.first_name,
    he.salary,
    d.dept_name
FROM HighEarners he
INNER JOIN departments d ON he.dept_id = d.dept_id;


-- ============================================================================
-- PART 2: WINDOW FUNCTIONS (OVER, PARTITION BY, ORDER BY)
-- GROUP BY collapses 10 rows into 1 summary row per group.
-- Window functions keep all 10 rows and attach the calculation next to each row!
-- ============================================================================

-- 3. Ranking Functions: ROW_NUMBER(), RANK(), and DENSE_RANK()
-- PARTITION BY dept_id restarts the ranking counter for each department.
SELECT
    e.first_name,
    d.dept_name,
    e.salary,
    -- Assigns a unique sequential number (1, 2, 3...) even if salaries tie
    ROW_NUMBER() OVER (PARTITION BY e.dept_id ORDER BY e.salary DESC) AS row_num,
    -- Ties get the same rank, next rank skips a number (e.g., 1, 1, 3)
    RANK() OVER (PARTITION BY e.dept_id ORDER BY e.salary DESC) AS salary_rank,
    -- Ties get the same rank, next rank does NOT skip (e.g., 1, 1, 2)
    DENSE_RANK() OVER (PARTITION BY e.dept_id ORDER BY e.salary DESC) AS dense_salary_rank
FROM employees e
INNER JOIN departments d ON e.dept_id = d.dept_id;


-- 4. Combining a CTE + Window Function: Get the Top 1 highest paid per department
WITH RankedEmployees AS (
    SELECT
        e.first_name,
        e.last_name,
        d.dept_name,
        e.salary,
        DENSE_RANK() OVER (PARTITION BY e.dept_id ORDER BY e.salary DESC) AS rnk
    FROM employees e
    INNER JOIN departments d ON e.dept_id = d.dept_id
)
SELECT first_name, last_name, dept_name, salary
FROM RankedEmployees
WHERE rnk = 1;


-- 5. Value Comparison Functions: LAG() and LEAD()
-- Compare each employee's salary to the person hired right before or after them
SELECT
    first_name,
    hire_date,
    salary,
    -- LAG looks at the PREVIOUS row based on hire_date order
    LAG(salary, 1) OVER (ORDER BY hire_date ASC) AS prev_hire_salary,
    -- Calculate the salary difference compared to the previous hire
    salary - LAG(salary, 1) OVER (ORDER BY hire_date ASC) AS diff_from_prev_hire,
    -- LEAD looks at the NEXT row based on hire_date order
    LEAD(salary, 1) OVER (ORDER BY hire_date ASC) AS next_hire_salary
FROM employees
ORDER BY hire_date ASC;


-- 6. Running Total with SUM() OVER()
-- Calculates cumulative payroll cost in chronological order of hiring
SELECT
    first_name,
    hire_date,
    salary,
    SUM(salary) OVER (ORDER BY hire_date ASC) AS cumulative_payroll
FROM employees
ORDER BY hire_date ASC;