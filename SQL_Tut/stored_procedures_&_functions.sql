-- ============================================================================
-- Goal: Save reusable blocks of SQL logic inside the database.
-- ============================================================================

USE company_db;

-- Change delimiter from ';' to '//' so MySQL doesn't stop reading mid-procedure
DELIMITER //

-- 1. Stored Procedure: Give a percentage raise to all employees in a specific department
CREATE PROCEDURE GiveDepartmentRaise(
    IN target_dept_id INT,
    IN raise_percentage DECIMAL(5, 2)
)
BEGIN
    UPDATE employees
    SET salary = salary + (salary * (raise_percentage / 100))
    WHERE dept_id = target_dept_id;
END //

-- 2. Stored Function: Must always return a single value (usable inside SELECT queries)
CREATE FUNCTION CalculateAnnualBonus(emp_salary DECIMAL(10, 2))
RETURNS DECIMAL(10, 2)
DETERMINISTIC
BEGIN
    DECLARE bonus DECIMAL(10, 2);
    IF emp_salary >= 100000 THEN
        SET bonus = emp_salary * 0.15; -- 15% bonus for high earners
    ELSE
        SET bonus = emp_salary * 0.10; -- 10% bonus otherwise
    END IF;
    RETURN bonus;
END //

-- Reset delimiter back to normal ';'
DELIMITER ;

-- 3. Call the Stored Procedure (Give Dept 2 a 5% raise)
CALL GiveDepartmentRaise(2, 5.00);

-- 4. Use the Custom Function inside a normal SELECT statement
SELECT
    first_name,
    salary,
    CalculateAnnualBonus(salary) AS estimated_bonus
FROM employees;