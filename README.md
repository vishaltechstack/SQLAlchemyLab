# 🗄️ SQLPlayground 
# 🐬 Step-by-Step Database Engineering Tutorial

![MySQL](https://img.shields.io/badge/MySQL-8.0%2B-4479A1?style=for-the-badge&logo=mysql&logoColor=white)
![SQL](https://img.shields.io/badge/SQL-Relational_Database-CC2927?style=for-the-badge&logo=databricks&logoColor=white)
![Scripts](https://img.shields.io/badge/Modules-22_SQL_Files-2EA44F?style=for-the-badge)
![License](https://img.shields.io/badge/License-MIT-blue?style=for-the-badge)

A hands-on, modular **MySQL 8.0+ curriculum** designed to take you from creating your first database to mastering query optimization, window functions, database normalization, JSON storage, and concurrency locking. Every script is self-contained, thoroughly commented, and builds progressively on a realistic `company_db` schema.

---

## 📂 Repository Structure

```text
mysql-mastery-tutorial/
├── 01_database_setup.sql
├── 02_tables_and_data_types.sql
├── 03_constraints_and_keys.sql
├── 04_insert_data.sql
├── 05_select_and_filtering.sql
├── 06_sorting_and_pagination.sql
├── 07_update_and_delete.sql
├── 08_aggregate_functions_and_grouping.sql
├── 09_joins_explained.sql
├── 10_subqueries.sql
├── 11_views.sql
├── 12_indexes_and_performance.sql
├── 13_stored_procedures_and_functions.sql
├── 14_triggers.sql
├── 15_transactions_acid.sql
├── 16_ctes_and_window_functions.sql
├── 17_database_normalization.sql
├── 18_built_in_functions_and_case.sql
├── 19_set_operations.sql
├── 20_json_operations.sql
├── 21_users_and_permissions.sql
├── 22_scheduled_events_and_locks.sql
└── README.md
```

---

## ⚙️ Prerequisites & Setup

### 1. Requirements
* **MySQL Server 8.0+** (Required for CTEs, Window Functions, `INTERSECT`/`EXCEPT`, and native `JSON` operators)
* Any SQL client: **MySQL Workbench**, **DBeaver**, **VS Code (SQLTools)**, or the **MySQL Command-Line Client**

### 2. Running the Scripts
1. Clone or download this repository:
   ```bash
   git clone [https://github.com/](https://github.com/)<your-username>/mysql-mastery-tutorial.git
   cd mysql-mastery-tutorial
   ```
2. Open your SQL client and connect to your local MySQL instance.
3. **Run files `01` through `04` first in exact numerical order** to initialize `company_db`, create the relational tables, and seed the sample data.
4. Execute files `05` through `22` sequentially—each file selects `USE company_db;` automatically (except File `17`, which spins up a dedicated `normalization_demo_db` sandbox).

> **Tip (CLI Execution):** You can run any individual script directly from your terminal:
> ```bash
> mysql -u root -p < 01_database_setup.sql
> ```

---

## 🗺️ Curriculum Breakdown

### Phase 1: Schema Design & CRUD Fundamentals (`01` – `07`)
| File | Topic | Key Concepts Covered |
| :--- | :--- | :--- |
| **`01_database_setup.sql`** | Database Lifecycle | `SHOW DATABASES`, `CREATE DATABASE IF NOT EXISTS`, `USE`, `SELECT DATABASE()`, `DROP DATABASE` |
| **`02_tables_and_data_types.sql`** | Tables & Data Types | `CREATE TABLE`, `INT`, `VARCHAR`, `DECIMAL`, `DESCRIBE`, `ALTER TABLE` (`ADD`/`RENAME COLUMN`) |
| **`03_constraints_and_keys.sql`** | Data Integrity | `PRIMARY KEY`, `AUTO_INCREMENT`, `NOT NULL`, `UNIQUE`, `DEFAULT`, `CHECK`, `FOREIGN KEY` (`ON DELETE SET NULL`) |
| **`04_insert_data.sql`** | Inserting Records | Single-row & multi-row bulk `INSERT INTO`, auto-increment behavior, `DEFAULT` keyword |
| **`05_select_and_filtering.sql`** | Querying & Filtering | `SELECT`, column aliases (`AS`), `WHERE`, `AND`/`OR`, `IN`, `BETWEEN`, `LIKE` wildcards (`%`, `_`), `IS NULL` |
| **`06_sorting_and_pagination.sql`** | Ordering & Pagination | `DISTINCT`, multi-column `ORDER BY` (`ASC`/`DESC`), `LIMIT`, `OFFSET` |
| **`07_update_and_delete.sql`** | Modifying & Removing Data | Safe `UPDATE` and `DELETE` with `WHERE`, multi-column updates, `DELETE` vs. `TRUNCATE TABLE` |

---

### Phase 2: Relational Querying & Aggregations (`08` – `11`)
| File | Topic | Key Concepts Covered |
| :--- | :--- | :--- |
| **`08_aggregate_functions_and_grouping.sql`** | Summarizing Data | `COUNT`, `SUM`, `AVG`, `MIN`, `MAX`, `ROUND`, `GROUP BY`, `HAVING` vs. `WHERE` |
| **`09_joins_explained.sql`** | Combining Tables | `INNER JOIN`, `LEFT JOIN`, finding unmatched rows (`IS NULL`), multi-table 3-way joins |
| **`10_subqueries.sql`** | Nested Queries | Scalar subqueries in `WHERE`, list subqueries with `IN`, derived tables in `FROM` |
| **`11_views.sql`** | Virtual Tables | `CREATE OR REPLACE VIEW`, hiding sensitive columns (`salary`), querying & dropping views |

---

### Phase 3: Performance, Automation & ACID Transactions (`12` – `15`)
| File | Topic | Key Concepts Covered |
| :--- | :--- | :--- |
| **`12_indexes_and_performance.sql`** | Query Optimization | Execution plan analysis with `EXPLAIN` (`ALL` vs. `ref`), `CREATE INDEX`, `SHOW INDEXES`, write trade-offs |
| **`13_stored_procedures_and_functions.sql`** | Reusable SQL Logic | `DELIMITER`, `CREATE PROCEDURE` with `IN` parameters, `CALL`, deterministic `CREATE FUNCTION` |
| **`14_triggers.sql`** | Event-Driven Auditing | `AFTER UPDATE` triggers, `OLD` vs. `NEW` row references, automated `salary_audit_log` tracking |
| **`15_transactions_acid.sql`** | Atomic Operations | `START TRANSACTION`, `COMMIT`, `ROLLBACK`, preventing partial failures during multi-step updates |

---

### Phase 4: Modern SQL Analytics & Schema Architecture (`16` – `19`)
| File | Topic | Key Concepts Covered |
| :--- | :--- | :--- |
| **`16_ctes_and_window_functions.sql`** | MySQL 8+ Analytics | Common Table Expressions (`WITH`), chained CTEs, `OVER (PARTITION BY ... ORDER BY ...)`, `ROW_NUMBER`, `RANK`, `DENSE_RANK`, `LAG`, `LEAD`, running totals |
| **`17_database_normalization.sql`** | Schema Normalization | Step-by-step refactoring from Unnormalized (`0NF`) → `1NF` (atomic cells) → `2NF` (no partial dependencies) → `3NF` (no transitive dependencies) |
| **`18_built_in_functions_and_case.sql`** | Expressions & Functions | Conditional `CASE WHEN`, conditional aggregation, `COALESCE`, `UPPER`, `TRIM`, `SUBSTRING_INDEX`, `DATEDIFF`, `TIMESTAMPDIFF`, `DATE_ADD` |
| **`19_set_operations.sql`** | Vertical Query Merging | `UNION` vs. `UNION ALL`, `INTERSECT`, `EXCEPT` (MySQL 8.0.31+) |

---

### Phase 5: Semi-Structured Data, Security & Concurrency (`20` – `22`)
| File | Topic | Key Concepts Covered |
| :--- | :--- | :--- |
| **`20_json_operations.sql`** | Native JSON Storage | `JSON` column type, `JSON_OBJECT`, `JSON_ARRAY`, path extraction (`->>`), `JSON_CONTAINS`, partial updates with `JSON_SET` |
| **`21_users_and_permissions.sql`** | Security & DCL | `CREATE USER`, `GRANT` (Principle of Least Privilege), `FLUSH PRIVILEGES`, `SHOW GRANTS`, `REVOKE`, `DROP USER` |
| **`22_scheduled_events_and_locks.sql`** | Jobs & Concurrency | Global `event_scheduler`, recurring `CREATE EVENT` cleanup jobs, pessimistic row-level locking (`SELECT ... FOR UPDATE`) |

---

## 🛠️ Entity Relationship Overview (`company_db`)

```text
+------------------+       +--------------------+       +-------------------+
|   departments    |       |     employees      |       |     projects      |
+------------------+       +--------------------+       +-------------------+
| PK dept_id       |<------| FK dept_id         |       | PK project_id     |
|    dept_name     |       | PK emp_id          |<------| FK lead_emp_id    |
|    city          |       |    first_name      |       |    project_name   |
|    budget        |       |    last_name       |       +-------------------+
+------------------+       |    email           |
                           |    hire_date       |       +-------------------+
                           |    salary          |<------| employee_profiles |
                           +--------------------+       +-------------------+
                                     |                  | PK profile_id     |
                                     v                  | FK emp_id         |
                           +--------------------+       |    preferences    |
                           |  salary_audit_log  |       +-------------------+
                           +--------------------+
                           | PK log_id          |
                           |    emp_id          |
                           |    old_salary      |
                           |    new_salary      |
                           |    changed_at      |
                           +--------------------+
```

---

## 👨‍💻 Author

**Vishal Sharma**  
*Software Development & Quality Engineering Enthusiast*

[![GitHub](https://img.shields.io/badge/GitHub-181717?style=for-the-badge&logo=github&logoColor=white)](https://github.com/)
[![LinkedIn](https://img.shields.io/badge/LinkedIn-0A66C2?style=for-the-badge&logo=linkedin&logoColor=white)](https://www.linkedin.com/)
[![MySQL](https://img.shields.io/badge/SQL_&_Database_Validation-4479A1?style=for-the-badge&logo=mysql&logoColor=white)](#)

---

⭐ *If you find this MySQL tutorial helpful, feel free to star the repository and share it with others learning SQL!*





























# 🗄️ SQLPlayground  

![SQL](https://img.shields.io/badge/SQL-Database-blue)
![MySQL](https://img.shields.io/badge/MySQL-Supported-orange)
![SQL Server](https://img.shields.io/badge/SQL%20Server-Supported-red)
![PostgreSQL](https://img.shields.io/badge/PostgreSQL-Supported-blue)
![Status](https://img.shields.io/badge/Status-Active-success)

---

## 📘 Overview

SQLPlayground is a hands-on repository focused on practicing and mastering SQL across different database systems. It contains structured queries, database concepts, and real-world examples used in data analysis, backend development, and interview preparation.

This repository serves as a learning lab and long-term reference for working with relational databases.

---

## 🧰 Databases Covered

- MySQL  
- SQL Server  
- PostgreSQL  
- SQLite (optional / planned)

---

## 🧠 Topics Covered

- Database design basics
- DDL commands (CREATE, ALTER, DROP)
- DML commands (INSERT, UPDATE, DELETE)
- SELECT queries and filtering
- Joins (INNER, LEFT, RIGHT, FULL)
- Subqueries and nested queries
- Aggregate functions
- GROUP BY and HAVING
- Constraints and keys
- Indexes and performance basics
- Views and stored procedures
- Window functions (basic to advanced)

---

## Project Structure


- MySQL  
- PostgreSQL  
- Azure Data Studio

---

## How to Use This Repository

1. Choose a database folder  
2. Load sample datasets if provided  
3. Run SQL scripts in your database environment  
4. Modify queries and experiment with optimizations  

This repo is intentionally structured for hands-on practice.

---

## Use Cases

- SQL interview preparation
- Data Analyst and Data Engineer practice
- Backend development reference
- Query optimization learning
- Academic and self-study projects

---

## Best Practices Followed

- Clear query formatting
- Meaningful table and column names
- Comments inside SQL files
- Realistic data scenarios
- Database-agnostic concepts where possible

---

## Future Enhancements

- More advanced query patterns
- Performance tuning examples
- Real-world case studies
- Cloud SQL examples
- Automated query testing

---

## Author

**Vishal Sharma**  
Data Analyst | Python Developer | SQL Developer | Power BI Analyst | Data Engineer | Machine Learning Engineer 

---

## License

This project is open for learning and practice purposes.
- SQL Server Management Studio (SSMS)

(You can run most scripts on any SQL database with minor changes.)
