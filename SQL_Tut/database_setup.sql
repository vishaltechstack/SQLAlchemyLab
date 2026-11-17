-- ============================================================================
-- Goal: Learn how to create, view, select, and delete a database in MySQL.
-- ============================================================================

-- 1. View all existing databases on your MySQL server
SHOW DATABASES;

-- 2. Create a new database named 'company_db'
-- 'IF NOT EXISTS' prevents an error if you accidentally run this script twice.
CREATE DATABASE IF NOT EXISTS company_db;

-- 3. Select the database so all upcoming queries run inside 'company_db'
USE company_db;

-- 4. Verify which database is currently active
SELECT DATABASE();

-- 5. How to delete a database (Keep commented out unless you want to wipe everything!)
-- DROP DATABASE IF EXISTS company_db;