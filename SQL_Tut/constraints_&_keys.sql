-- ============================================================================
-- Goal: Enforce rules on columns to prevent invalid or duplicate data.
-- ============================================================================

USE company_db;

-- 1. Parent Table: departments
CREATE TABLE IF NOT EXISTS departments (
    dept_id INT PRIMARY KEY AUTO_INCREMENT,   -- Uniquely identifies each row; auto-numbers 1, 2, 3...
    dept_name VARCHAR(50) NOT NULL UNIQUE,    -- Cannot be empty (NULL) and no two departments can share a name
    city VARCHAR(50) DEFAULT 'Remote',        -- Uses 'Remote' automatically if no city is provided
    budget DECIMAL(12, 2) CHECK (budget >= 0) -- Ensures budget can never be negative
);

-- 2. Child Table: employees (Linked to departments via FOREIGN KEY)
CREATE TABLE IF NOT EXISTS employees (
    emp_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    hire_date DATE NOT NULL,                  -- Format: 'YYYY-MM-DD'
    salary DECIMAL(10, 2) NOT NULL CHECK (salary > 0),
    dept_id INT,                              -- Holds the ID matching departments.dept_id

    -- Foreign Key links this table to 'departments'
    -- ON DELETE SET NULL: If a department is deleted, employee stays but dept_id becomes NULL
    CONSTRAINT fk_employee_department
        FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
        ON DELETE SET NULL
);

-- 3. Table for Employee Projects (Many-to-Many relationship example)
CREATE TABLE IF NOT EXISTS projects (
    project_id INT PRIMARY KEY AUTO_INCREMENT,
    project_name VARCHAR(100) NOT NULL,
    lead_emp_id INT,
    FOREIGN KEY (lead_emp_id) REFERENCES employees(emp_id)
);