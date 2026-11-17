-- ============================================================================
-- DATABASE NORMALIZATION (1NF, 2NF, AND 3NF)
-- Goal: Transform a poorly designed "all-in-one" table into clean, modular
--       tables that eliminate duplicate data and prevent data corruption.
-- ============================================================================

-- Create a separate sandbox database so we don't clutter 'company_db'
CREATE DATABASE IF NOT EXISTS normalization_demo_db;
USE normalization_demo_db;

-- ============================================================================
-- STEP 0: UNNORMALIZED FORM (0NF) - THE PROBLEM
-- Imagine storing an entire order system in a single Excel-like table:
-- ============================================================================
CREATE TABLE orders_0nf (
    order_id INT,
    order_date DATE,
    customer_name VARCHAR(50),
    customer_city VARCHAR(50),
    items_ordered VARCHAR(200),  -- PROBLEM 1: Multiple values crammed into one cell!
    item_prices VARCHAR(100),    -- PROBLEM 2: Hard to query, sum, or validate!
    dept_name VARCHAR(50),
    dept_manager VARCHAR(50)     -- PROBLEM 3: Repeated on every row (update anomaly)
);

INSERT INTO orders_0nf VALUES
(101, '2026-11-01', 'Aarav Patel', 'Bengaluru', 'Laptop, Mouse', '75000, 1200', 'IT', 'Sneha Rao'),
(102, '2026-11-02', 'Rohan Verma', 'Pune', 'Keyboard', '2500', 'IT', 'Sneha Rao');


-- ============================================================================
-- STEP 1: FIRST NORMAL FORM (1NF)
-- Rules for 1NF:
--   1. Every cell must hold a SINGLE atomic value (no comma-separated lists).
--   2. Every row must be uniquely identifiable (Primary Key).
-- ============================================================================

-- Fix: Split multi-valued items into separate rows and define a Composite Primary Key
-- (order_id + product_name together uniquely identify each line item).
CREATE TABLE orders_1nf (
    order_id INT,
    product_name VARCHAR(50),
    order_date DATE,
    customer_name VARCHAR(50),
    customer_city VARCHAR(50),
    unit_price DECIMAL(10, 2),
    dept_name VARCHAR(50),
    dept_manager VARCHAR(50),
    PRIMARY KEY (order_id, product_name)
);

INSERT INTO orders_1nf VALUES
(101, 'Laptop',   '2026-11-01', 'Aarav Patel', 'Bengaluru', 75000.00, 'IT', 'Sneha Rao'),
(101, 'Mouse',    '2026-11-01', 'Aarav Patel', 'Bengaluru',  1200.00, 'IT', 'Sneha Rao'),
(102, 'Keyboard', '2026-11-02', 'Rohan Verma', 'Pune',       2500.00, 'IT', 'Sneha Rao');

-- Why 1NF is still flawed (Partial Dependency):
-- Look at order 101: 'customer_name' and 'order_date' depend ONLY on 'order_id',
-- NOT on 'product_name'. Repeating Aarav's name on every item wastes space!


-- ============================================================================
-- STEP 2: SECOND NORMAL FORM (2NF)
-- Rules for 2NF:
--   1. Must already be in 1NF.
--   2. No Partial Dependencies: Every non-key column must depend on the ENTIRE
--      Primary Key, not just part of a composite key.
-- ============================================================================

-- Fix: Move order-level details into an 'orders_2nf' table, and keep item-level
-- details in 'order_items_2nf'. Also separate 'products' so prices live in one place.

CREATE TABLE orders_2nf (
    order_id INT PRIMARY KEY,
    order_date DATE NOT NULL,
    customer_name VARCHAR(50) NOT NULL,
    customer_city VARCHAR(50) NOT NULL,
    dept_name VARCHAR(50) NOT NULL,
    dept_manager VARCHAR(50) NOT NULL
);

CREATE TABLE products_2nf (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(50) NOT NULL UNIQUE,
    unit_price DECIMAL(10, 2) NOT NULL
);

CREATE TABLE order_items_2nf (
    order_id INT,
    product_id INT,
    quantity INT NOT NULL DEFAULT 1,
    PRIMARY KEY (order_id, product_id),
    FOREIGN KEY (order_id) REFERENCES orders_2nf(order_id),
    FOREIGN KEY (product_id) REFERENCES products_2nf(product_id)
);

-- Why 2NF is still flawed (Transitive Dependency):
-- In 'orders_2nf', 'dept_manager' does NOT directly describe the order—it describes
-- 'dept_name' (order_id -> dept_name -> dept_manager).
-- If Sneha Rao leaves the company, we have to update hundreds of old order rows!


-- ============================================================================
-- STEP 3: THIRD NORMAL FORM (3NF)
-- Rules for 3NF:
--   1. Must already be in 2NF.
--   2. No Transitive Dependencies: Non-key columns must depend ONLY on the
--      Primary Key ("The key, the whole key, and nothing but the key").
-- ============================================================================

-- Fix: Extract 'customers' and 'departments' into their own dedicated tables
-- and link them via Foreign Keys.

CREATE TABLE customers_3nf (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_name VARCHAR(50) NOT NULL,
    customer_city VARCHAR(50) NOT NULL
);

CREATE TABLE departments_3nf (
    dept_id INT PRIMARY KEY AUTO_INCREMENT,
    dept_name VARCHAR(50) NOT NULL UNIQUE,
    dept_manager VARCHAR(50) NOT NULL
);

CREATE TABLE orders_3nf (
    order_id INT PRIMARY KEY,
    order_date DATE NOT NULL,
    customer_id INT NOT NULL,
    dept_id INT NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customers_3nf(customer_id),
    FOREIGN KEY (dept_id) REFERENCES departments_3nf(dept_id)
);

-- Populate the clean 3NF schema
INSERT INTO customers_3nf (customer_name, customer_city) VALUES
('Aarav Patel', 'Bengaluru'),
('Rohan Verma', 'Pune');

INSERT INTO departments_3nf (dept_name, dept_manager) VALUES
('IT', 'Sneha Rao');

INSERT INTO products_2nf (product_name, unit_price) VALUES
('Laptop', 75000.00),
('Mouse', 1200.00),
('Keyboard', 2500.00);

INSERT INTO orders_3nf (order_id, order_date, customer_id, dept_id) VALUES
(101, '2026-11-01', 1, 1),
(102, '2026-11-02', 2, 1);

INSERT INTO order_items_2nf (order_id, product_id, quantity) VALUES
(101, 1, 1), -- Order 101: 1 Laptop
(101, 2, 1), -- Order 101: 1 Mouse
(102, 3, 1); -- Order 102: 1 Keyboard

-- ============================================================================
-- VERIFY: Reconstruct the full invoice cleanly using JOINS
-- ============================================================================
SELECT
    o.order_id,
    o.order_date,
    c.customer_name,
    c.customer_city,
    p.product_name,
    oi.quantity,
    p.unit_price,
    (oi.quantity * p.unit_price) AS line_total,
    d.dept_name,
    d.dept_manager
FROM orders_3nf o
INNER JOIN customers_3nf c   ON o.customer_id = c.customer_id
INNER JOIN departments_3nf d ON o.dept_id = d.dept_id
INNER JOIN order_items_2nf oi ON o.order_id = oi.order_id
INNER JOIN products_2nf p    ON oi.product_id = p.product_id
ORDER BY o.order_id;