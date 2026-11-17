-- ============================================================================
-- Goal: Automate recurring background cleanup tasks and prevent race conditions
--       when two users update the same record at the exact same millisecond.
-- ============================================================================

USE company_db;

-- ============================================================================
-- PART 1: MYSQL SCHEDULED EVENTS (BUILT-IN CRON JOBS)
-- ============================================================================

-- 1. Enable the global MySQL Event Scheduler thread
SET GLOBAL event_scheduler = ON;

-- 2. Create a recurring event that cleans up audit logs older than 1 year
-- Runs automatically every 1 day
DELIMITER //

CREATE EVENT IF NOT EXISTS cleanup_old_salary_logs
ON SCHEDULE EVERY 1 DAY
STARTS CURRENT_TIMESTAMP
DO
BEGIN
    DELETE FROM salary_audit_log
    WHERE changed_at < NOW() - INTERVAL 365 DAY;
END //

DELIMITER ;

-- 3. View all scheduled events in the database
SHOW EVENTS FROM company_db;

-- Optional: Disable or drop the event
-- ALTER EVENT cleanup_old_salary_logs DISABLE;
-- DROP EVENT IF EXISTS cleanup_old_salary_logs;


-- ============================================================================
-- PART 2: CONCURRENCY & PESSIMISTIC ROW LOCKING (FOR UPDATE)
-- Prevents "Lost Updates" when two transactions read and modify the same row
-- simultaneously (e.g., deducting from the same department budget).
-- ============================================================================

START TRANSACTION;

-- SELECT ... FOR UPDATE locks ONLY the matched row (dept_id = 1) until COMMIT/ROLLBACK.
-- Any other session trying to update dept_id = 1 will wait safely in line instead
-- of reading stale budget numbers.
SELECT dept_id, dept_name, budget
FROM departments
WHERE dept_id = 1
FOR UPDATE;

-- Perform safe budget deduction while holding the row lock
UPDATE departments
SET budget = budget - 5000.00
WHERE dept_id = 1;

-- Release the lock and permanently save the change
COMMIT;