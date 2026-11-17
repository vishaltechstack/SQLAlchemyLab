-- ============================================================================
-- Goal: Ensure multi-step operations either ALL succeed or ALL fail cleanly.
-- ============================================================================

USE company_db;

-- Scenario: Transfer $25,000 of budget from Engineering (Dept 1) to QA (Dept 2).
-- If power fails halfway through, we must NOT lose $25,000 in thin air!

-- 1. Start a transaction (disables auto-commit temporarily)
START TRANSACTION;

-- Step 1: Deduct $25,000 from Engineering
UPDATE departments
SET budget = budget - 25000.00
WHERE dept_id = 1;

-- Step 2: Add $25,000 to Quality Assurance
UPDATE departments
SET budget = budget + 25000.00
WHERE dept_id = 2;

-- Inspect the temporary state (only visible to your current session so far)
SELECT dept_id, dept_name, budget FROM departments WHERE dept_id IN (1, 2);

-- 2. Decide whether to save permanently or undo:
-- Use COMMIT; to save both changes permanently to the database.
COMMIT;

-- Note: If an error occurred in Step 2, you would run:
-- ROLLBACK;  -- Reverts Step 1 completely as if nothing ever happened!