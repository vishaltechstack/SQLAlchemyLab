-- ============================================================================
-- Goal: Make searches on large tables dramatically faster using Indexes.
-- ============================================================================

USE company_db;

-- 1. Use EXPLAIN before a query to see how MySQL searches the table
-- Look at the 'type' column: 'ALL' means a slow Full Table Scan.
EXPLAIN SELECT * FROM employees WHERE last_name = 'Patel';

-- 2. Create an Index on 'last_name' (like creating an alphabetical index in a book)
-- Note: PRIMARY KEY and UNIQUE columns already have indexes automatically.
CREATE INDEX idx_employee_lastname ON employees(last_name);

-- 3. Run EXPLAIN again: 'type' changes from 'ALL' to 'ref' (fast index lookup!)
EXPLAIN SELECT * FROM employees WHERE last_name = 'Patel';

-- 4. View all indexes on the 'employees' table
SHOW INDEXES FROM employees;

-- Trade-off Rule: Indexes speed up SELECT queries, but slightly slow down INSERT/UPDATE
-- because MySQL has to update the index too. Only index columns you search/join often.