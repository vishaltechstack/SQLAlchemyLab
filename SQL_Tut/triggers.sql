-- ============================================================================
-- Goal: Automatically execute SQL code when an INSERT, UPDATE, or DELETE occurs.
-- ============================================================================

USE company_db;

-- 1. Create an Audit Table to track all salary changes automatically
CREATE TABLE IF NOT EXISTS salary_audit_log (
    log_id INT PRIMARY KEY AUTO_INCREMENT,
    emp_id INT,
    old_salary DECIMAL(10, 2),
    new_salary DECIMAL(10, 2),
    changed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 2. Create an AFTER UPDATE Trigger on the 'employees' table
DELIMITER //

CREATE TRIGGER after_salary_update
AFTER UPDATE ON employees
FOR EACH ROW
BEGIN
    -- OLD refers to the row values before update; NEW refers to values after update
    IF OLD.salary <> NEW.salary THEN
        INSERT INTO salary_audit_log (emp_id, old_salary, new_salary)
        VALUES (OLD.emp_id, OLD.salary, NEW.salary);
    END IF;
END //

DELIMITER ;

-- 3. Test the Trigger by updating an employee's salary
UPDATE employees SET salary = 115000.00 WHERE emp_id = 2;

-- 4. Check the audit log—MySQL populated it automatically!
SELECT * FROM salary_audit_log;