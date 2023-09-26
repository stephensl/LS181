# 181 Study Guide

## SQL

  ### Identify the different types of `JOIN`s and explain their differences.

  We often need to reference data that is distributed among multiple tables. In doing so, it may be useful to join tables together based on an association between them in order to access the targeted data. `JOIN` clauses enable us to combine rows from multiple tables by leveraging a related column via a conditional expression which dictates how the tables should be joined. 
  
  There are five main types of `JOIN`s, each allowing for different ways of merging and representing data across multiple tables.

#

  #### `INNER JOIN`

  ##### Description: 
  
  The `INNER JOIN` is the default `JOIN` used if simply using `JOIN` without any other qualifiers. 
  
  This type of `JOIN` will combine rows from the two tables where the join condition comparing data in the specified columns evaluates to `true`. 
  
  When two tables are joined, each row in the first table (left) will be compared to each row in the second table (right) and evaluated on the join condition. If the two rows being compared satisfy the condition, they are joined together (including data from all columns in the row) and included as a single joined row in a 'transient' table. 
  
  The `SELECT` command will then utilize the 'transient' table in order to return targeted data as if it were querying a single table. 

  *The 'transient table' is a mental model representing the intermediate result of the operation, and helpful in visualizing the process happening behind the scenes in the SQL engine.*

  ##### Example: 

  If we have a table `employees`:

  | id | first_name | last_name  | department |
  |----|------------|------------|------------|
  | 1  | Alice      | Smith      | Sales      |
  | 2  | Bob        | Johnson    | Marketing  |
  | 3  | Carol      | Williams   | Finance    |
  | 6  | Emily      | Davis      | HR         |

  and a table `pets`:

  | id | employee_id | pet_name | species  |
  |----|-------------|----------|----------|
  | 1  | 1           | Fluffy   | Cat      |
  | 2  | 2           | Jax      | Dog      |
  | 3  |             | Sparky   | Fish     |
  | 4  |             | Coco     | Parrot   |
  | 5  |             |          | Hamster  |

  **Objective**: Find the first name of any employee who has a pet.

  This would provide a good use case for an `INNER JOIN` as we are interested only in data that satisfies the condition; we only want first names of employees who meet the condition of having a pet. 

  ```sql
  SELECT
    first_name
  FROM
    employees
    INNER JOIN pets ON employees.id = pets.employee_id;
  ```

  This would combine rows in the `employees` table with rows in the `pets` table that meet the condition. In this case the condition is that the value in the `employees.id` column is equal to the value in the `pets.employee_id` column of the two rows being compared. We then `SELECT` just the values in the `first_name` column from the 'transient table' and we return:

  ```sql
  first_name
  ----------
  Alice
  Bob

  (2 rows)
  ```

#

  #### `LEFT OUTER JOIN`

  #### Description: 

  The `LEFT OUTER JOIN` will combine two tables based on join condition, but differs from `INNER JOIN` in that all of the rows from the first table (left) will be included in the result set regardless of whether the condition is satisfied for that row.

  We utilize `LEFT OUTER JOIN` when we want to include in the result set all of the rows in the first table, while only including rows from the second table that meet the condition. Consequently, the omitted data from the second table will contain `NULL` values in their respective column positions.

  ##### Example: 
  
  **employees**
  | id | first_name | last_name  | department |
  |----|------------|------------|------------|
  | 1  | Alice      | Smith      | Sales      |
  | 2  | Bob        | Johnson    | Marketing  |
  | 3  | Carol      | Williams   | Finance    |
  | 6  | Emily      | Davis      | HR         |

  **pets**
  | id | employee_id | pet_name | species  |
  |----|-------------|----------|----------|
  | 1  | 1           | Fluffy   | Cat      |
  | 2  | 2           | Jax      | Dog      |
  | 3  |             | Sparky   | Fish     |
  | 4  |             | Coco     | Parrot   |
  | 5  |             |          | Hamster  |

  **Objective**: Find first names of employees who have no pet. 

  In this case, we are looking for employees who do not have a pet, so an `INNER JOIN` would not suffice as the result set would only include data from rows that meet the join condition. Instead, we utilize a `LEFT OUTER JOIN` to ensure that all employee first names are included in the 'transient table' and we then `SELECT` the ones that do not include data from rows in the right table as a consequence of not satisfying the join condition. 

  ```sql
  SELECT 
    first_name
  FROM 
    employees
    LEFT OUTER JOIN pets ON employees.id = pets.employee_id
  WHERE 
    pets.employee_id IS NULL;
  ```

  This would result in first names from the `employees` table that do not have an associated `employee_id` value in the `pets` table indicated by the presence of `NULL` values for that column in the corresponding 'transient table' row.

  ```sql
  first_name
  ----------
  Carol
  Emily

  (2 rows)
  ```

  #

  #### `RIGHT OUTER JOIN`

  ##### Description: 

  The `RIGHT OUTER JOIN` clause functions similarly to `LEFT OUTER JOIN` except that the result set will include all rows from the second table, while only including data from rows in the first (left) table that satisfy the join condition. 

  ##### Example: 

  **employees**
  | id | first_name | last_name  | department |
  |----|------------|------------|------------|
  | 1  | Alice      | Smith      | Sales      |
  | 2  | Bob        | Johnson    | Marketing  |
  | 3  | Carol      | Williams   | Finance    |
  | 6  | Emily      | Davis      | HR         |

  **pets**
  | id | employee_id | pet_name | species  |
  |----|-------------|----------|----------|
  | 1  | 1           | Fluffy   | Cat      |
  | 2  | 2           | Jax      | Dog      |
  | 3  |             | Sparky   | Fish     |
  | 4  |             | Coco     | Parrot   |
  | 5  |             |          | Hamster  |

  **Objective**: Return the first name of each employee who owns a pet, along with the name of their pet. Include the names of pets that do not belong to any employees. 

  In this case, we only want the first names of employees who own a pet to be represented in the result set, along with the name of their respective pets. However, we also want to include the names of pets who do not belong to any employee. `RIGHT OUTER JOIN` allows us to accomplish this, as all rows from the right table will still be included in the result, even if they do not meet the join condition. Pets that are not associated with an employee will contain `NULL` values in their rows within the result. 

  ```sql
  SELECT 
    first_name, pet_name
  FROM 
    employees
    RIGHT OUTER JOIN pets ON employees.id = pets.employee_id;
  ```

  ```sql
  first_name | pet_name
  ---------------------
  Alice      | Fluffy
  Bob        | Jax
             | Sparky
             | Coco
  ```

#

  #### `FULL OUTER JOIN`

  ##### Description: 

  The `FULL OUTER JOIN` is essentially a combination of `LEFT OUTER JOIN` and `RIGHT OUTER JOIN` in that the result set will include all rows from both tables regardless of whether they satisfy the join condition associating the two. 
  
  Where the join condition is met, the corresponding rows from each table are joined together into a single row. If a row from either table doesn't satisfy the join condition with any row from the other table, it will still be included in the result set, but the columns that would have included data from the other table had the condition been met, will contain NULL values for that row.


  ##### Example: 

  **employees**
  | id | first_name | last_name  | department |
  |----|------------|------------|------------|
  | 1  | Alice      | Smith      | Sales      |
  | 2  | Bob        | Johnson    | Marketing  |
  | 3  | Carol      | Williams   | Finance    |
  | 6  | Emily      | Davis      | HR         |

  **pets**
  | id | employee_id | pet_name | species  |
  |----|-------------|----------|----------|
  | 1  | 1           | Fluffy   | Cat      |
  | 2  | 2           | Jax      | Dog      |
  | 3  |             | Sparky   | Fish     |
  | 4  |             | Coco     | Parrot   |
  | 5  |             |          | Hamster  |

  **Objective**: Return the first names of all employees with the names of their pet if applicable. Ensure that all employee first names, and all pet names are present in the result. 

  Here we want data from both tables regardless of whether there is a relationship between the employee and the pet. We join the rows where a relationship exists (where the condition evaluates to true), but still include rows from both tables that do not have an associated value in the other table. 

  ```sql
  SELECT 
    first_name, pet_name
  FROM 
    employees
    FULL OUTER JOIN pets ON employees.id = pets.employee_id;
  ```

  ```sql
  first_name | pet_name
  ---------------------
  Alice      | Fluffy
  Bob        | Jax
             | Sparky
             | Coco
  Carol      |
  Emily      |
  ```

#

  #### `CROSS JOIN`

  #### Description: 

  A `CROSS JOIN` or Cartesian `JOIN` returns every possible combination of a row in first table, with a row from the second table. This type of `JOIN` does not match rows based on any condition, and therefore does not utilize an `ON` clause. 

  ##### Example: 

  **employees**
  | id | first_name | last_name  | department |
  |----|------------|------------|------------|
  | 1  | Alice      | Smith      | Sales      |
  | 2  | Bob        | Johnson    | Marketing  |
  | 3  | Carol      | Williams   | Finance    |
  | 6  | Emily      | Davis      | HR         |

  **pets**
  | id | employee_id | pet_name | species  |
  |----|-------------|----------|----------|
  | 1  | 1           | Fluffy   | Cat      |
  | 2  | 2           | Jax      | Dog      |
  | 3  |             | Sparky   | Fish     |
  | 4  |             | Coco     | Parrot   |
  | 5  |             |          | Hamster  |

  Here we have `4` records in the `employees` table and `5` records in the `pets` table. The Cartesian product would therefore yield 20 different combinations, so we return `20 rows`.

  ```sql
  SELECT
    *
  FROM
    employees
    CROSS JOIN pets;
  ```
  Result: 
  ```sql
  | first_name | last_name | department | pet_name | species  |
  |------------|-----------|------------|----------|----------|
  | Alice      | Smith     | Sales      | Fluffy   | Cat      |
  | Alice      | Smith     | Sales      | Jax      | Dog      |
  | Alice      | Smith     | Sales      | Sparky   | Fish     |
  | Alice      | Smith     | Sales      | Coco     | Parrot   |
  | Alice      | Smith     | Sales      |          | Hamster  |
  | Bob        | Johnson   | Marketing  | Fluffy   | Cat      |
  | Bob        | Johnson   | Marketing  | Jax      | Dog      |
  | Bob        | Johnson   | Marketing  | Sparky   | Fish     |
  | Bob        | Johnson   | Marketing  | Coco     | Parrot   |
  | Bob        | Johnson   | Marketing  |          | Hamster  |
  | Carol      | Williams  | Finance    | Fluffy   | Cat      |
  | Carol      | Williams  | Finance    | Jax      | Dog      |
  | Carol      | Williams  | Finance    | Sparky   | Fish     |
  | Carol      | Williams  | Finance    | Coco     | Parrot   |
  | Carol      | Williams  | Finance    |          | Hamster  |
  | Emily      | Davis     | HR         | Fluffy   | Cat      |
  | Emily      | Davis     | HR         | Jax      | Dog      |
  | Emily      | Davis     | HR         | Sparky   | Fish     |
  | Emily      | Davis     | HR         | Coco     | Parrot   |
  | Emily      | Davis     | HR         |          | Hamster  |
  
  (20 rows)
  ```

#

  #### Multiple `JOIN`s

  Requirements of a query may necessitate the use of multiple `JOIN`s in order to combine data from multiple tables. In doing so, the 'transient table' becomes the 'left' table in the subsequent `JOIN`, and the table named in the `JOIN` statement acts as the 'right' table. After the final `JOIN`, the 'transient table' is then evaluated based on the columns in the `SELECT` list, and subject to further filtering if a `WHERE` or `HAVING` clause exists. 


#
#
#


  ### Name and define the three sub-languages of SQL and be able to classify different statements by sub-language.

  #### DDL

  Data Definition Language is utilized to define and manage schema. Schema pertains to the overall structure of the database including its tables, column names, data types, and constraints. 

  *Database schema is largely a `DDL` concern, but parts of schema are managed by `DCL` (access, permissions).*

  ##### Common DDL commands include: 
  - `CREATE`
    - `CREATE TABLE`, `CREATE DATABASE`, `CREATE SEQUENCE`, `CREATE TYPE`
  - `ALTER`
    - `ALTER TABLE`, `ALTER COLUMN`
  - `RENAME`
  - `DROP`
    - `DROP DATABASE`, `DROP TABLE`, `DROP CONSTRAINT`, `DROP DEFAULT`, `DROP COLUMN`
  - `TRUNCATE`
    - `TRUNCATE TABLE`

  #### DML

  Data Manipulation Language allows for inserting, retrieving, updating, and deleting data from a database table. `DML` statements map to `CRUD` (create, read, update, delete) operations common to many web applications. The corresponding SQL commands are: 
  `INSERT`, `SELECT`, `UPDATE`, and `DELETE`.

  ##### Common DML commands include: 
  - `INSERT INTO`
  - `SELECT`
  - `UPDATE`
  - `DELETE FROM`

  #### DCL

  Data Control Language is utilized to grant or restrict access to a database based on defined permissions pertaining to DML commands. 

  ##### Common DCL commands include: 
  - `GRANT`
  - `REVOKE`

#
#
#


  ### Write SQL statements using `INSERT`, `UPDATE`, `DELETE`, `CREATE`/`ALTER`/`DROP` TABLE, `ADD`/`ALTER`/`DROP` COLUMN.

  #### `INSERT`

  General syntax: 
  
  ```sql
  INSERT INTO table_name (column_name)
    VALUES (val);
  ```

  Example: Insert a single row into a table named employees:

  ```sql
  INSERT INTO employees (name, age, salary)
    VALUES ('Max', 45, 90000);
  ```

#

  #### `UPDATE`

  General syntax: 

  ```sql
  UPDATE table_name 
    SET column_name = val 
    WHERE expression;
  ```
  *without `WHERE` clause, will update all values in the stated column.*

  Example: Update the salary of an employee named 'Max' to 95,000:

  ```sql
  UPDATE employees 
    SET salary = 95000 
    WHERE name = 'Max';
  ```

#

  #### `DELETE`

  General Syntax:

  ```sql
  DELETE FROM table_name 
    WHERE expression; 
  ```

  Example: Delete all employees younger than 30. 

  ```sql
  DELETE FROM employees
    WHERE age < 30;
  ```

  #

  #### `CREATE`
  
  Used to create a new table, database.

  General syntax: 

  ```sql
  CREATE TABLE table_name (
    column_name data_type constraints, 
    ...
  );
  ```

  Example: Create a table called users, with auto incrementing id as primary identifier, as well as age and favorite color.

  ```sql
  CREATE TABLE users (
    id serial PRIMARY KEY, 
    age integer,
    favorite_color varchar(20)
  );
  ```

  #### `ALTER`

  Used to alter schema of an existing table, such as renaming tables or columns, adding new columns, changing a column's data type, or removing a column/table. 

  General syntax:

  ```sql
  ALTER TABLE table_name 
    ADD COLUMN column_name data_type constraints;
  ```

  Example: Add a new column for storing the department of each employee:

  ```sql
  ALTER TABLE employees
    ADD COLUMN department varchar(30);
  ```

  #### `DROP`

  Used to remove an entire database, table, or column.

  General syntax: 

  ```sql
  DROP TABLE table_name;

  DROP DATABASE database_name;

  ALTER TABLE table_name
    DROP COLUMN column_name;
  ```

  Example: Remove a column named department from the employees table.

  ```sql
  ALTER TABLE employees 
    DROP COLUMN department;
  ```

#
#
#
  
  
  ### Understand how to use GROUP BY, ORDER BY, WHERE, and HAVING.

  #### `GROUP BY`
  
  ##### Description: 

  `GROUP BY` is used in order to organize rows into groups based on particular values held in one or more columns. `GROUP BY` allows us to treat grouped rows as belonging to a particular category, and perform aggregate functions on them. This allows for elimination of redundant data and access to information pertaining to the group.

  `GROUP BY` clause is positioned after the `WHERE` clause, and before `ORDER BY` or `HAVING` in the SQL statement. 

  ##### Use cases:

  Utilized in order to form a group of rows based on common values held in one or more columns. Grouping allows for us to query meaningful data corresponding to more than one record, based on shared characteristics. `GROUP BY` is commonly used in conjunction with aggregate functions in order to achieve some collective insight into records sharing particular attributes.

  For example, you are a running coach and have a table representing individual runners, their ages, and fastest 5k results. You would like to find the average 5k time based on particular age groups. You could group the data based on the ages of the runners and perform an aggregate function to find the average 5k time of each age group. 

  Grouped and ungrouped columns may be present in the query results, non-grouped columns may still only contain one value representing the group. This means that we must aggregate the data from ungrouped columns from the `SELECT` list in some way to produce a single value for each group. The exception to this rule occurs when the ungrouped column is functionally dependent on the grouped column, meaning that the grouped column is the `PRIMARY KEY` of the table. We can include ungrouped columns in the select list outside of an aggregate function if the column being grouped is the primary key in the table containing the ungrouped column because each group will only contain one record due to the `UNIQUE` and `NOT NULL` constraints inherent in `PRIMARY KEY`s. 

  ##### Examples:



  ##### Tricky ones: 

#

  #### `ORDER BY`

  ##### Description:

  `ORDER BY` is used to define a particular sort order on the displayed results. We are able to sort results based on values in more than one column through comma separated expressions following `ORDER BY`. When results are sorted using multiple columns, the results of the first sort are further refined to reorder records within sets that contain identical values in the preceding column. 

  `ORDER BY` is positioned after the specified table name, and following the `WHERE` clause (if present). 

  ##### Use cases:

  `ORDER BY` is utilized when the results of a query should be displayed in a particular order. This can be useful in situations such as displaying book reviews. We can order the results in order to display the most recent review first/last, or the most popular review first/last. 
  
  We can also use `ORDER BY` in conjunction with a `LIMIT` clause to find the most recent, or most popular review by ordering the results to start with the most recent, or most popular and limiting the results to `1`. 

  ##### Examples:

  ##### Tricky ones: 

#

  #### `WHERE`

  ##### Description:

  The `WHERE` clause provides a search condition for the query that must return a `boolean` value. `WHERE` clauses are used to further refine queries based on a particular condition.

  The `WHERE` clause is positioned following the `FROM` clause which identifies the table. 

  ##### Use cases:

  Utilized to refine query based on a conditional expression. Suppose we had a table keeping track of 5k running times for particular athletes, and we wanted to return a list of times from athletes older than 25. We could utilize a `WHERE` clause to provide the condition, filtering out data from athletes 25 years of age or younger. 

  ##### Examples:

  ##### Tricky ones: 

#

  #### `HAVING`

  ##### Description:

  The `HAVING` clause provides further refinement of grouped or aggregate data and allows for the elimination of groups of data from the results. Similar to the `WHERE` clause, but for grouped or aggregated data.

  The `HAVING` clause commonly follows a `GROUP BY` clause, but may be used without `GROUP BY` to filter aggregate data, as a `WHERE` clause cannot contain aggregate functions. 

  
  ##### Use cases:

  If we have a table containing 5k running times from athletes, we can group the data based on an athlete's age and then further refine the results utilizing a `HAVING` clause to eliminate results from athletes under 18. 

  ##### Examples:

  ##### Tricky ones: 

#
#
#


 ### Understand how to create and remove constraints, including CHECK constraints

 #### Constraints

 ##### Description:

 While data types serve as one level of constraint limiting the data that may exist in a relation, there are numerous additional constraints to offer more precise control and protect data integrity. These constraints also allow for data to be constrained in relation to other data present in the table. Generally, constraints create eligibility requirements that prospective data must meet in order to be stored. 

 ##### Common Constraints: 

  ###### `PRIMARY KEY`
  
  A `PRIMARY KEY` is a unique identifier for a particular row of data.  

  ##### `FOREIGN KEY`

  A `FOREIGN KEY` is utilized in order to create a relationship between two records, typically by referencing a row's `PRIMARY KEY` in another table. 

  ###### `UNIQUE`

  A `UNIQUE` constraint ensures that each value stored in the column subject to the constraint is unique, and ensures no duplication of values.

  ###### `CHECK`

  A `CHECK` constraint is used to apply a conditional expression to data in a particular column to ensure that the data is valid. 

  ###### `NOT NULL`

  The `NOT NULL` constraint restricts the subjected column from holding any `NULL` values.

  ###### `DEFAULT`

  The `DEFAULT` constraint will automatically insert a default value for rows in the subjected column when no other value is provided. 

#
#
#


  ### Be familiar with using subqueries

  #### Subqueries

  ##### Description:

  ##### Subqueries vs `JOIN`s

  ##### Examples: 

  ##### Tricky ones: 

  ##### Optimization Implications





## PostgreSQL

  - Describe what a sequence is and what they are used for.
  - Create an auto-incrementing column.
  - Define a default value for a column.
  - Be able to describe what primary, foreign, natural, and surrogate keys are.
  - Create and remove CHECK constraints from a column.
  - Create and remove foreign key constraints from a column.

## Database Diagrams

  - Talk about the different levels of schema.
  - Define cardinality and modality.
  - Be able to draw database diagrams using crow's foot notation.
