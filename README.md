# 🗄️ SQLPlayground : Step-by-Step Database Engineering Tutorial

![MySQL](https://img.shields.io/badge/MySQL-8.0%2B-4479A1?style=for-the-badge&logo=mysql&logoColor=white)
![SQL](https://img.shields.io/badge/SQL-Relational_Database-CC2927?style=for-the-badge&logo=databricks&logoColor=white)
![Scripts](https://img.shields.io/badge/Modules-22_SQL_Files-2EA44F?style=for-the-badge)
![License](https://img.shields.io/badge/License-MIT-blue?style=for-the-badge)

A hands-on, modular **MySQL 8.0+ curriculum** designed to take you from creating your first database to mastering query optimization, window functions, database normalization, JSON storage, and concurrency locking. Every script is self-contained, thoroughly commented, and builds progressively on a realistic `company_db` schema.

---

## 📂 Repository Structure

```text
SQL-Tut/
├── database_setup.sql
├── tables_and_data_types.sql
├── constraints_and_keys.sql
├── insert_data.sql
├── select_and_filtering.sql
├── sorting_and_pagination.sql
├── update_and_delete.sql
├── aggregate_functions_and_grouping.sql
├── joins_explained.sql
├── subqueries.sql
├── views.sql
├── indexes_and_performance.sql
├── stored_procedures_and_functions.sql
├── triggers.sql
├── transactions_acid.sql
├── ctes_and_window_functions.sql
├── database_normalization.sql
├── built_in_functions_and_case.sql
├── set_operations.sql
├── json_operations.sql
├── users_and_permissions.sql
├── scheduled_events_and_locks.sql
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
| **`database_setup.sql`** | Database Lifecycle | `SHOW DATABASES`, `CREATE DATABASE IF NOT EXISTS`, `USE`, `SELECT DATABASE()`, `DROP DATABASE` |
| **`tables_&_data_types.sql`** | Tables & Data Types | `CREATE TABLE`, `INT`, `VARCHAR`, `DECIMAL`, `DESCRIBE`, `ALTER TABLE` (`ADD`/`RENAME COLUMN`) |
| **`constraints_&_keys.sql`** | Data Integrity | `PRIMARY KEY`, `AUTO_INCREMENT`, `NOT NULL`, `UNIQUE`, `DEFAULT`, `CHECK`, `FOREIGN KEY` (`ON DELETE SET NULL`) |
| **`insert_data.sql`** | Inserting Records | Single-row & multi-row bulk `INSERT INTO`, auto-increment behavior, `DEFAULT` keyword |
| **`select_&_filtering.sql`** | Querying & Filtering | `SELECT`, column aliases (`AS`), `WHERE`, `AND`/`OR`, `IN`, `BETWEEN`, `LIKE` wildcards (`%`, `_`), `IS NULL` |
| **`sorting_&_pagination.sql`** | Ordering & Pagination | `DISTINCT`, multi-column `ORDER BY` (`ASC`/`DESC`), `LIMIT`, `OFFSET` |
| **`update_&_delete.sql`** | Modifying & Removing Data | Safe `UPDATE` and `DELETE` with `WHERE`, multi-column updates, `DELETE` vs. `TRUNCATE TABLE` |

---

### Phase 2: Relational Querying & Aggregations (`08` – `11`)
| File | Topic | Key Concepts Covered |
| :--- | :--- | :--- |
| **`aggregate_functions_&_grouping.sql`** | Summarizing Data | `COUNT`, `SUM`, `AVG`, `MIN`, `MAX`, `ROUND`, `GROUP BY`, `HAVING` vs. `WHERE` |
| **`joins_explained.sql`** | Combining Tables | `INNER JOIN`, `LEFT JOIN`, finding unmatched rows (`IS NULL`), multi-table 3-way joins |
| **`subqueries.sql`** | Nested Queries | Scalar subqueries in `WHERE`, list subqueries with `IN`, derived tables in `FROM` |
| **`views.sql`** | Virtual Tables | `CREATE OR REPLACE VIEW`, hiding sensitive columns (`salary`), querying & dropping views |

---

### Phase 3: Performance, Automation & ACID Transactions (`12` – `15`)
| File | Topic | Key Concepts Covered |
| :--- | :--- | :--- |
| **`indexes_&_performance.sql`** | Query Optimization | Execution plan analysis with `EXPLAIN` (`ALL` vs. `ref`), `CREATE INDEX`, `SHOW INDEXES`, write trade-offs |
| **`stored_procedures_&_functions.sql`** | Reusable SQL Logic | `DELIMITER`, `CREATE PROCEDURE` with `IN` parameters, `CALL`, deterministic `CREATE FUNCTION` |
| **`triggers.sql`** | Event-Driven Auditing | `AFTER UPDATE` triggers, `OLD` vs. `NEW` row references, automated `salary_audit_log` tracking |
| **`transactions_acid.sql`** | Atomic Operations | `START TRANSACTION`, `COMMIT`, `ROLLBACK`, preventing partial failures during multi-step updates |

---

### Phase 4: Modern SQL Analytics & Schema Architecture (`16` – `19`)
| File | Topic | Key Concepts Covered |
| :--- | :--- | :--- |
| **`ctes_&_window_functions.sql`** | MySQL 8+ Analytics | Common Table Expressions (`WITH`), chained CTEs, `OVER (PARTITION BY ... ORDER BY ...)`, `ROW_NUMBER`, `RANK`, `DENSE_RANK`, `LAG`, `LEAD`, running totals |
| **`database_normalization.sql`** | Schema Normalization | Step-by-step refactoring from Unnormalized (`0NF`) → `1NF` (atomic cells) → `2NF` (no partial dependencies) → `3NF` (no transitive dependencies) |
| **`built_in_functions_&_case.sql`** | Expressions & Functions | Conditional `CASE WHEN`, conditional aggregation, `COALESCE`, `UPPER`, `TRIM`, `SUBSTRING_INDEX`, `DATEDIFF`, `TIMESTAMPDIFF`, `DATE_ADD` |
| **`set_operations.sql`** | Vertical Query Merging | `UNION` vs. `UNION ALL`, `INTERSECT`, `EXCEPT` (MySQL 8.0.31+) |

---

### Phase 5: Semi-Structured Data, Security & Concurrency (`20` – `22`)
| File | Topic | Key Concepts Covered |
| :--- | :--- | :--- |
| **`json_operations.sql`** | Native JSON Storage | `JSON` column type, `JSON_OBJECT`, `JSON_ARRAY`, path extraction (`->>`), `JSON_CONTAINS`, partial updates with `JSON_SET` |
| **`users_&_permissions.sql`** | Security & DCL | `CREATE USER`, `GRANT` (Principle of Least Privilege), `FLUSH PRIVILEGES`, `SHOW GRANTS`, `REVOKE`, `DROP USER` |
| **`scheduled_events_&_locks.sql`** | Jobs & Concurrency | Global `event_scheduler`, recurring `CREATE EVENT` cleanup jobs, pessimistic row-level locking (`SELECT ... FOR UPDATE`) |

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

Explore My Other SQL Repositories

| Repository | Tech Stack | Description |
| :--- | :--- | :--- |
| [![SQLForge](https://img.shields.io/badge/SQLForge)](https://github.com/vishaltechstack/SQLForge) | `MySQL 8.0+` `20 Domain Projects` | End-to-end relational database portfolio featuring 20 industry case studies with DDL schemas, seed datasets, and analytical queries. |
| [**QueryCraft**](https://github.com/vishaltechstack/QueryCraft) | `SQL` `Problem Solving` `Joins & CTEs` | Daily hands-on SQL coding challenges and query-building practice problems to sharpen relational logic. |

---

## 👨‍💻 Author

**Vishal Sharma**  
*Software Development & Quality Engineering Enthusiast*

[![GitHub](https://img.shields.io/badge/GitHub-181717?style=for-the-badge&logo=github&logoColor=white)](https://github.com/)
[![LinkedIn](https://img.shields.io/badge/LinkedIn-0A66C2?style=for-the-badge&logo=linkedin&logoColor=white)](https://www.linkedin.com/)
[![MySQL](https://img.shields.io/badge/SQL_&_Database_Validation-4479A1?style=for-the-badge&logo=mysql&logoColor=white)](#)

---

⭐ *If you find this MySQL tutorial helpful, feel free to star the repository and share it with others learning SQL!*
