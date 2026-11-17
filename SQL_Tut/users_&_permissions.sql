-- ============================================================================
-- Goal: Secure your database by creating dedicated users with limited rights
--       instead of letting apps connect as 'root'.
-- Note: Must be run by an admin/root user.
-- ============================================================================

-- 1. View existing MySQL user accounts
SELECT user, host FROM mysql.user;

-- 2. Create a Read-Only Analyst user (can only connect from localhost)
CREATE USER IF NOT EXISTS 'report_analyst'@'localhost'
IDENTIFIED BY 'StrongPass@2026!';

-- 3. Create an Application Service user
CREATE USER IF NOT EXISTS 'app_service'@'localhost'
IDENTIFIED BY 'AppSecret@2026!';

-- 4. GRANT permissions (Principle of Least Privilege)
-- Give the analyst read-only (SELECT) access ONLY to the public directory view
GRANT SELECT ON company_db.public_employee_directory
TO 'report_analyst'@'localhost';

-- Give the backend app CRUD access on company_db, but NO permission to DROP tables
GRANT SELECT, INSERT, UPDATE, DELETE ON company_db.*
TO 'app_service'@'localhost';

-- 5. Apply privilege changes immediately and inspect granted permissions
FLUSH PRIVILEGES;
SHOW GRANTS FOR 'report_analyst'@'localhost';
SHOW GRANTS FOR 'app_service'@'localhost';

-- 6. REVOKE: Remove a specific permission if no longer needed
REVOKE DELETE ON company_db.* FROM 'app_service'@'localhost';

-- 7. Clean up demo users
DROP USER IF EXISTS 'report_analyst'@'localhost';
DROP USER IF EXISTS 'app_service'@'localhost';