-- ============================================================================
-- Goal: Store flexible, semi-structured key-value data (like user preferences
--       or API payloads) and query/update specific keys inside SQL.
-- ============================================================================

USE company_db;

-- 1. Create a table with a native JSON column
-- MySQL automatically validates that inserted text is valid JSON syntax.
CREATE TABLE IF NOT EXISTS employee_profiles (
    profile_id INT PRIMARY KEY AUTO_INCREMENT,
    emp_id INT UNIQUE,
    preferences JSON NOT NULL,
    FOREIGN KEY (emp_id) REFERENCES employees(emp_id) ON DELETE CASCADE
);

-- 2. Insert structured JSON using JSON_OBJECT() and JSON_ARRAY()
INSERT INTO employee_profiles (emp_id, preferences) VALUES
(1, JSON_OBJECT(
        'theme', 'dark',
        'notifications', true,
        'skills', JSON_ARRAY('Java', 'Spring Boot', 'MySQL'),
        'work_setup', JSON_OBJECT('os', 'Windows', 'monitors', 2)
    )),
(2, '{"theme": "light", "notifications": false, "skills": ["AWS", "Docker", "Kubernetes"]}');

-- 3. Query JSON fields using ->> (extracts and unquotes string value)
-- '$' represents the root of the JSON document
SELECT
    emp_id,
    preferences ->> '$.theme' AS ui_theme,
    preferences ->> '$.work_setup.os' AS operating_system,
    preferences ->> '$.skills[0]' AS primary_skill
FROM employee_profiles;

-- 4. Filter rows based on a value inside a JSON array using JSON_CONTAINS()
SELECT emp_id, preferences
FROM employee_profiles
WHERE JSON_CONTAINS(preferences -> '$.skills', '"MySQL"');

-- 5. Update a single key inside JSON without overwriting the whole document
-- JSON_SET updates existing keys or adds new ones if missing
UPDATE employee_profiles
SET preferences = JSON_SET(preferences, '$.theme', 'high-contrast', '$.two_factor_auth', true)
WHERE emp_id = 1;

-- Verify the partial JSON update
SELECT emp_id, preferences FROM employee_profiles WHERE emp_id = 1;