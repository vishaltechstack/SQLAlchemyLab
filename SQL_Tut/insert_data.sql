-- ============================================================================
-- Goal: Populate our tables with realistic sample records.
-- ============================================================================

USE company_db;

-- 1. Insert multiple rows into 'departments' in a single query (faster than separate inserts)
-- Notice we skip 'dept_id' because AUTO_INCREMENT generates 1, 2, 3, 4 automatically.
INSERT INTO departments (dept_name, city, budget) VALUES
('Engineering', 'Bengaluru', 500000.00),
('Quality Assurance', 'Pune', 250000.00),
('Human Resources', 'Mumbai', 150000.00),
('Marketing', DEFAULT, 200000.00); -- Explicitly triggers the DEFAULT value ('Remote')

-- 2. Insert records into 'employees'
INSERT INTO employees (first_name, last_name, email, hire_date, salary, dept_id) VALUES
('Aarav', 'Patel', 'aarav.patel@company.com', '2022-03-15', 95000.00, 1),
('Sneha', 'Rao', 'sneha.rao@company.com', '2021-07-01', 110000.00, 1),
('Rohan', 'Verma', 'rohan.verma@company.com', '2023-01-10', 72000.00, 2),
('Priya', 'Nair', 'priya.nair@company.com', '2023-06-20', 68000.00, 2),
('Vikram', 'Singh', 'vikram.singh@company.com', '2020-11-05', 85000.00, 3),
('Ananya', 'Gupta', 'ananya.gupta@company.com', '2024-02-01', 60000.00, NULL); -- Freelancer/Unassigned

-- 3. Insert records into 'projects'
INSERT INTO projects (project_name, lead_emp_id) VALUES
('Payment Gateway API', 1),
('Automated Regression Suite', 3),
('Cloud Migration', 2);