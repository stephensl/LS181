# 181 Study Guide

## Relational Databases
  - A relation refers to a table in the database. 
  - A relationship is an association between data that is stored in relations. 

  - Relational data may be thought of as working with more than one table at a time. Data that is in relationship with other data, and working with the tables that store the data in order to examine or manipulate the data according to use case. 

  - Relational databases are structured stores of data that model relationships between data held in multiple tables. Relational databases distribute data among multiple tables, and create connections between data through the use of primary and foreign keys. The Relational Model informs the rules and structures governing the relationships between data held in the database. 

### Benefits of using relational databases include:
  - Reduction in data duplication: Normalization
   - Database normalization assists in reducing duplication, and maintaining integrity of data. The mechanism used to achieve normalization in a relational database includes distributing data among multiple tables and defining relationships between these tables. Normalization reduces the need to store the same data in more than one place, thus minimizing the risk of inconsistencies and update anomalies. 
    - data is distributed across multiple tables, and associations between data are established by reference.
    - reduces amount of data that needs to be stored
    - increases integrity of data as it is stored in one place
  - Data consistency
    - data stored in a relational database is structured in a way that reduces the likelihood of update anomalies as updates to data should occur in one place, rather than having to seek out all areas within a database that may reference the same data. 
  - Query flexibility
    - relational databases allow for data to be accessed in a flexible manner, as we can target specific data stored across multiple tables.
  - Organization and Modularity of data
    - relational databases allow for enhanced organization and modularity of data as we are able to avoid storing duplicate data and contributing to bloated tables. 
  - Scalability
    - organizing data in a relational database protects data integrity, consistency, and reliability as more data is added. 


  ### How relational databases support data integrity:
  - Use of constraints surrounding what types of data can be stored, and how it should be formatted for storage. 
  - Use of primary keys to uniquely identify records.
  - Use of foreign keys to associate records with data stored in elsewhere in the database, and maintain referential integrity. 
  - Unique constraints that limit duplication of data and increase referential integrity by ensuring unique identifiers. 
  - Check constraints that ensure data meets particular standards for storage.
  - Cascading Actions that automatically perform some action based on a triggering event. For example, foreign keys may contain an `ON DELETE` clause which tells the database how to properly handle associated data if records in related tables are deleted. 

## SQL

  ### About SQL

  SQL is a special purpose language used to interact with relational databases. 
    - Declarative syntax
      - describes what should be done, but hides implementation details
      - contrast with imperative language types (Ruby, JS, Python, etc.)

  #### Syntax Components

  We interact with a relational database through issuing SQL Statements. SQL statements are comprised of keywords and subjective identifiers that enable us to define, access, and modify data in a database. 

  SQL Commands: 
    - these keywords allow for describing the desired operation. 
    - `SELECT`, `UPDATE`, `ALTER TABLE`, `ALTER COLUMN`, `UPDATE`, `DROP`, `DELETE`
  SQL Clauses: 
    - allow for filtering or further refining desired data.
    - `FROM`, `WHERE`, `GROUP BY`, `HAVING`, `JOIN`, `ORDER BY`, `USING`
  SQL Expressions: 
    - allow for evaluation
    - conditional operators: `<`, `>`, `<=`, `>=`, `=`, `<>`, `!=`
    - logical operators: `AND`, `OR`, `NOT`
    - arithmetic operators: `+`, `-`, `*`, `/`, `%`
    - string operators: `||`, `LIKE`, `ILIKE`, `NOT LIKE`, `%`, `_`
    - special operators: `IN`, `BETWEEN`, `IS NULL`, `IS NOT NULL`, `DISTINCT`, `ALL`, `ANY`, `EXISTS`
  SQL Identifiers: 
    - these are the names of the tables, columns, or other objects in the database. 

  ##### Example Syntax Components

  ```sql
  SELECT name, age 
    FROM customers WHERE age > 18
    ORDER BY age;
  ```
  In the above SQL statement: 
    - `SELECT` is a command
    - `name` and `age` are column identifiers
    - `FROM` is a clause indicating the required table
    - `customers` is a table identifier
    - `WHERE` is a clause 
    - `age > 18` is a conditional expression
    - `ORDER BY` is a clause indicating sorting of result set

#

  ### How PostgreSQL Executes a Query

  *This example is based on a `SELECT` query. We use the example of a storage shed of boxes containing different items. The boxes themselves represent the tables. The items within the boxes represent the data stored in the table.* 

  1. Gather all the rows from tables referenced in the query
    - includes rows from tables in the `FROM` clause, and any `JOIN`ed tables.
    - this is roughly equivalent to gathering the required 'boxes'.

  2. Filter rows using `WHERE` conditions
    - evaluate each row based on the `WHERE` clause(s)
    - remove rows that do not meet the requirement
    - equivalent to opening each box, and checking to see if the item meets a requirement. 
      - "I am looking for pictures `WHERE` the photo was taken prior to a particular date."

  3. Rows may be divided into groups
    - If a `GROUP BY` clause exists, rows containing identical values for particular columns identified in the `GROUP BY` clause are combined into a single row. 
    - equivalent to stacking pictures of a particular person in a single stack. 

  4. Filter groups using `HAVING` conditions
    - `HAVING` conditions may further filter grouped data
    - `GROUP BY` and aggregate functions both group data, we use `HAVING` clause to refine these groups.
    - equivalent to looking through a grouped stack of pictures taken on a particular date and removing pictures that also include other people or some other condition. 
  
  5. Use `SELECT` list to compute values for results
    - Each element referenced in the `SELECT` list, including any functions, are associated with their column name, or last function evaluated. (unless alias provided)
    - photos of each individual person are listed under a column like `name` for example. 

  6. Sort the results
    - Results are sorted as specified in `ORDER BY` clause.
    - equivalent to sorting pictures based on exact time of day taken, earlier vs later. 
    
  7. Limit results
    - `LIMIT` or `OFFSET` may be used to adjust which results to include in the final set.
    - equivalent to keeping the earliest 3 photos of each person.

#
#
#

  ### Identify the different types of `JOIN`s and explain their differences.

  We often need to reference data that is distributed among multiple tables. In doing so, it may be useful to join tables together based on an association between them in order to access the targeted data. `JOIN` clauses enable us to combine rows from multiple tables by leveraging an associated column and a conditional expression to dictate how the tables should be joined. 
  
  There are five main types of `JOIN`s, each allowing for different ways of merging and representing data across multiple tables.

#

  #### `INNER JOIN`

  ##### Description: 
  
  The `INNER JOIN` is the default `JOIN` used if simply using `JOIN` without any other qualifiers. 
  
  This type of `JOIN` will combine rows from the two tables where the join condition comparing data in the specified columns evaluates to `true`. 
  
  When two tables are joined, each row in the first table (left) will be compared to each row in the second table (right) and evaluated on the join condition. If the two rows being compared satisfy the condition, they are joined together and included as a single joined row in a 'transient' table. 
  
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

  We utilize `LEFT OUTER JOIN` when we want to include in the result set all of the rows in the first table, while only including rows from the second table that meet the condition. Consequently, the omitted data from the second table will contain `NULL` values in their respective column positions within the row.

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

  #### Three sub-languages:
  
  - Data Definition Language
    - schema and overall structure
  - Data Manipulation Language
    - values stored in relations
  - Data Control Language
    - access permissions 

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

  `INSERT` a DML command that allows 

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

          Runners Table

    | id | name    | dob       |
    |----|---------|-----------|
    | 1  | Alice   | 1995-01-01|
    | 2  | Bob     | 1990-05-15|
    | 3  | Charlie | 1985-09-20|
    | 4  | Diana   | 2000-02-25|

-------------------------------------------
              
              Five_K Table

| id | run_date  | five_k_time | runner_id |
|----|-----------|-------------|-----------|
| 1  | 2023-09-01| 00:20:15    | 1         |
| 2  | 2023-09-15| 00:19:50    | 1         |
| 3  | 2023-09-01| 00:22:30    | 2         |
| 4  | 2023-09-20| 00:21:45    | 2         |
| 5  | 2023-09-01| 00:23:00    | 3         |
| 6  | 2023-09-20| 00:22:15    | 3         |
| 7  | 2023-09-12| 00:18:30    | 4         |
| 8  | 2023-09-20| 00:18:15    | 4         |

#

  - Objective: Return the fastest time recorded for each unique date.

  In this example, we want to group the run times by date- this means that even though there are multiple entries for particular dates, we only include unique dates in the result set. Ungrouped data must then be included in an aggregate function in order to return only one value for each date. 

  In this case we are returning the fastest time (minimum) time as the single value for each group of dates.

  ```sql
  SELECT run_date, MIN(five_k_time) AS fastest_time 
  FROM five_k 
    INNER JOIN runners ON five_k.runner_id = runners.id
  GROUP BY run_date
  ORDER BY run_date, fastest_time;

  --
  run_date  | fastest_time 
------------+--------------
 2023-09-01 | 00:20:15
 2023-09-12 | 00:18:30
 2023-09-15 | 00:19:50
 2023-09-20 | 00:18:15
(4 rows)
    ``` 



  Using subquery to also include name of runner who logged fastest time. 

```sql
  SELECT
    run_date,
    five_k_time AS fastest_time,
    name
FROM
    five_k
    JOIN runners ON runner_id = runners.id
WHERE (run_date, five_k_time) IN (
    SELECT
        run_date,
        MIN(five_k_time)
    FROM
        five_k
    GROUP BY
        run_date)
ORDER BY
    run_date,
    fastest_time;
```

#

  #### `ORDER BY`

  ##### Description:

  `ORDER BY` is used to define a particular sort order on the displayed results. We are able to sort results based on values in more than one column through comma separated expressions following `ORDER BY`. When results are sorted using multiple columns, the results of the first sort are further refined to reorder records within sets that contain identical values in the preceding column. 

  `ORDER BY` is positioned after the specified table name, and following the `WHERE` clause (if present). 

  ##### Use cases:

  `ORDER BY` is utilized when the results of a query should be displayed in a particular order. This can be useful in situations such as displaying book reviews. We can order the results in order to display the most recent review first/last, or the most popular review first/last. 
  
  We can also use `ORDER BY` in conjunction with a `LIMIT` clause to find the most recent, or most popular review by ordering the results to start with the most recent, or most popular and limiting the results to `1`. 


#

  #### `WHERE`

  ##### Description:

  The `WHERE` clause provides a search condition for the query that must return a `boolean` value. `WHERE` clauses are used to further refine queries based on a particular condition.

  The `WHERE` clause is positioned following the `FROM` clause which identifies the table. 

  ##### Use cases:

  Utilized to refine query based on a conditional expression. Suppose we had a table keeping track of 5k running times for particular athletes, and we wanted to return a list of times from athletes older than 25. We could utilize a `WHERE` clause to provide the condition, filtering out data from athletes 25 years of age or younger. 


#

  #### `HAVING`

  ##### Description:

  The `HAVING` clause provides further refinement of grouped or aggregate data and allows for the elimination of groups of data from the results. Similar to the `WHERE` clause, but for grouped or aggregated data.

  The `HAVING` clause commonly follows a `GROUP BY` clause, but may be used without `GROUP BY` to filter aggregate data, as a `WHERE` clause cannot contain aggregate functions. 

  
  ##### Use cases:

  If we have a table containing 5k running times from athletes, we can group the data based on an athlete's age and then further refine the results utilizing a `HAVING` clause to eliminate results from athletes under 18. 

  ##### Example:

            Runners Table

    | id | name    | dob       |
    |----|---------|-----------|
    | 1  | Alice   | 1995-01-01|
    | 2  | Bob     | 1990-05-15|
    | 3  | Charlie | 1985-09-20|
    | 4  | Diana   | 2000-02-25|

-------------------------------------------
              
              Five_K Table

| id | run_date  | five_k_time | runner_id |
|----|-----------|-------------|-----------|
| 1  | 2023-09-01| 00:20:15    | 1         |
| 2  | 2023-09-15| 00:19:50    | 1         |
| 3  | 2023-09-01| 00:22:30    | 2         |
| 4  | 2023-09-20| 00:21:45    | 2         |
| 5  | 2023-09-01| 00:23:00    | 3         |
| 6  | 2023-09-20| 00:22:15    | 3         |
| 7  | 2023-09-12| 00:18:30    | 4         |
| 8  | 2023-09-20| 00:18:15    | 4         |


Objective: use `GROUP BY` and `HAVING` clause to return the fastest times on each unique date, only if the time is under 20 minutes. 

```sql
SELECT run_date, MIN(five_k_time) AS fastest_time
FROM five_k
GROUP BY run_date
HAVING MIN(five_k_time) < '00:20:00';

---

  run_date  | fastest_time 
------------+--------------
 2023-09-12 | 00:18:30
 2023-09-15 | 00:19:50
 2023-09-20 | 00:18:15
```



#
#
#


 ### Understand how to create and remove constraints, including CHECK constraints

 #### Constraints

 Constraints are an integral part of database schema, and enforce limits on the types of data that can be stored in a database, and how it should be structured. Constraints ensure data integrity, as data must conform to a defined set of rules, and deviation from these constraints disqualifies data from entering the database. Constraints effectively 'screen' data, to ensure that it is consistent, and accurately represents the entity being modeled. 

 ##### Description:

 While data types serve as one level of constraint limiting the data that may exist in a relation, there are numerous additional constraints to offer more precise control and protect data integrity. These constraints also allow for data to be constrained in relation to other data present in the table. Generally, constraints create eligibility requirements that prospective data must meet in order to be stored. 

 ##### Common Constraints: 

  ###### `PRIMARY KEY`
  
  A `PRIMARY KEY` is a unique identifier for a particular row of data in a table. A table may have only one `PRIMARY KEY`, and enforces `NOT NULL` and `UNIQUE` constraints by default. Establishing a column as the `PRIMARY KEY` indicates within the schema that we may identify unique records in the table using the values in that column. In order to establish consistent relationships between tables, we must be able to uniquely identify rows containing particular data. `PRIMARY KEYS` are often utilized in conjunction with `FOREIGN KEYS` to associate a row in one table, with a row in another table. These keys effectively enable data to become 'relational'.

  ###### Syntax Options: Defining `PRIMARY KEY`

  - Defining `PRIMARY KEY` within `CREATE TABLE` statement. 
    
    - Inline: 

      ```sql
      CREATE TABLE users (
        id serial PRIMARY KEY, 
        name text, 
        age integer
      );
      ``` 

    - Explicit: 

      ```sql
      CREATE TABLE users (
        id serial, 
        name text, 
        age integer, 
        PRIMARY KEY (id)
      );
      ``` 
    
  - Defining `PRIMARY KEY` in existing table, using `ALTER TABLE`

    ```sql
    ALTER TABLE users
      ADD PRIMARY KEY (id);
    ```
  
  - Dropping `PRIMARY KEY` from table

    ```sql
    ALTER TABLE users
      DROP CONSTRAINT users_pkey;
    ```

  ##### `FOREIGN KEY`

  A `FOREIGN KEY` is utilized in order to create a relationship between two records, typically by referencing a row's `PRIMARY KEY` in another table. When defining a `FOREIGN KEY` we utilize the `REFERENCES` keyword, followed by the name of the table, and column being referenced in the association. `FOREIGN KEYS` are vital in ensuring referential integrity between tables. Referential integrity ensures that the data being referenced actually exists, and the relationship remains consistent by enforcing the boundaries of the association as a one-to-one, one-to-many, or many-to-many relationship.   
      - Error thrown if try to add value to Foreign Key column of a table if Primary Key column of the table it is referencing does not already contain that value. 


  ###### Syntax Options: 

    - Defining `FOREIGN KEY` within `CREATE TABLE` statement
      
      - Inline:

        ```sql
        CREATE TABLE pets (
          id serial PRIMARY KEY, 
          name text, 
          owner_id integer REFERENCES owners (id)
        );
        ```
      
      - Explicit: 

        ```sql
        CREATE TABLE pets (
          id serial, 
          name text, 
          owner_id integer, 
          PRIMARY KEY (id), 
          FOREIGN KEY (owner_id) REFERENCES owners (id)
        );
        ```

    - Defining `FOREIGN KEY` using `ALTER TABLE`

      - With `ADD CONSTRAINT` allows for custom naming

        ```sql
        ALTER TABLE pets
          ADD CONSTRAINT owner_id_owners_id_fkey
          FOREIGN KEY (owner_id) REFERENCES owners (id);
        ```

      - Without `ADD CONSTRAINT` utilizes SQL engine generated name

        ```sql
        ALTER TABLE pets 
          ADD FOREIGN KEY (owner_id) REFERENCES owners (id);
        ```

    - Dropping `FOREIGN KEY` from table

      ```sql
      ALTER TABLE pets 
        DROP CONSTRAINT owner_id_owners_id_fkey;
      ```

  ###### `UNIQUE`

  A `UNIQUE` constraint ensures that each value stored in the column subject to the constraint is unique, and ensures no duplication of values.

  ###### When to use `UNIQUE` and when NOT to use it. 

    - `PRIMARY` keys enforce `UNIQUE` constraint by default.
    
    - `FOREIGN` keys in one-to-one relationships in order to preserve referential integrity
      - the nature of a one-to-one relationship means that an entity in one table can only be associated with one particular entity in another table, and vice versa. 
        - example: A car has a unique VIN number, this VIN number is only associated with one particular vehicle. 
    
    - Join tables in many-to-many relationships often have a `UNIQUE` constraint on combinations of `FOREIGN KEYS` represented in the table.
      - a join table associates entities in a many-to-many relationship by referencing the `PRIMARY KEY`s of each entity as `FOREIGN KEY`s in the join table. Each row represents an instance of the many-to-many relationship
        - example: A doctor has many patients, and a patient may have many doctors. In the join table, each row would include a `FOREIGN KEY` referencing a doctor, paired with a `FOREIGN KEY` referencing a patient in their respective tables. `UNIQUE` constraints are utilized to guard against duplication of the relationship in the join table.
    
    - `UNIQUE` constraints should NOT be applied to the `FOREIGN KEY` column on the 'many' side of a one-to-many relationship. 
      - a one to many relationship means that one entity instance may be associated with any number of entity instances in another table. If we were to apply a `UNIQUE` constraint on the 'many' side of the relationship, this would violate referential integrity of the association being modeled. 
        - example: A person has one date of birth, but this date of birth is associated with numerous other people. If date of birth were a `FOREIGN KEY` and we utilized a `UNIQUE` constraint, we would effectively be creating a invalid one-to-one relationship. 
    

  ###### Syntax Options: 

    - Including `UNIQUE` constraint in `CREATE TABLE` statement

      - Inline: 
      
        ```sql
        CREATE TABLE fish (
          id serial PRIMARY KEY, 
          name varchar(50) UNIQUE,
          lifespan integer 
        );
        ```

      - Explicit: 

        ```sql
        CREATE TABLE fish (
          id serial PRIMARY KEY, 
          name varchar(50), 
          lifespan integer, 
          UNIQUE (name)
        );
        ```

    - Adding `UNIQUE` constraint to existing table

      - Using `ALTER TABLE` and `ADD CONSTRAINT` to add custom constraint name

        ```sql
        ALTER TABLE fish
          ADD CONSTRAINT fish_unique_name
          UNIQUE (name);
        ```

      - Using `ALTER TABLE` and `ADD UNIQUE` to utilize SQL engine generated constraint name

        ```sql
        ALTER TABLE fish 
          ADD UNIQUE (name);
        ```
    
    - Dropping `UNIQUE` constraint

      ```sql
      ALTER TABLE 
        DROP CONSTRAINT fish_unique_name;
      ```

  ##### `CHECK`

  A `CHECK` constraint is used to apply a conditional expression to data in a particular column to ensure that the data is valid. The conditional expression in a `CHECK` constraint will evaluate to a boolean value, or `NULL` if either side of the conditional operator is `NULL`.

  ###### Syntax Options: 

    - Use within `CREATE TABLE` statement

      - Inline

        ```sql
        CREATE TABLE surfers (
          id serial PRIMARY KEY, 
          name varchar(50), 
          age integer CHECK (age BETWEEN 18 AND 100)
        );
        ```
      
      - Explicit:
        
        ```sql
        CREATE TABLE surfers (
          id serial PRIMARY KEY, 
          name varchar(50), 
          age integer, 
          CHECK (age BETWEEN 18 AND 100)
        );
        ```

    - Add `CHECK` to column in existing table

      - Using `ALTER TABLE` and `ADD CONSTRAINT` to use custom name

        ```sql
        ALTER TABLE surfers
          ADD CONSTRAINT check_surfer_age
          CHECK (age BETWEEN 18 AND 100);
        ```

      - Using `ALTER TABLE` and `ADD CHECK` to use SQL engine generated name:

        ```sql
        ALTER TABLE surfers
          ADD CHECK (age BETWEEN 18 AND 100);
        ```
    
    - Dropping `CHECK` constraint:

    ```sql
    ALTER TABLE surfers 
      DROP CONSTRAINT check_surfer_age;
    ```

  ##### `NOT NULL`

  The `NOT NULL` constraint restricts the subjected column from holding any `NULL` values. This constraint is utilized when we want to guarantee that a particular column holds a value. 

  ###### When to use `NOT NULL` and when NOT to use it

    - `PRIMARY KEY`s enforce `NOT NULL` constraint by default

    - `FOREIGN KEY`s in one-to-many, and many-to-many relationships
      - example: one-to-many: person and date of birth
      - example: many-to-many: does not make sense in join tables as they exist to tie together entities from other tables. If the join table contains a `NULL` value as a `FOREIGN KEY` for one of the members in the modeled relationship, there is no relationship. 

    - The use of `NOT NULL` constraints often is tied directly to the business logic, and the relationships between data in associated tables. 

  
  ###### Syntax Options: 
  
    - Within `CREATE TABLE` statement:

      - Inline: 
      
        ```sql
        CREATE TABLE students (
          id serial PRIMARY KEY, 
          name varchar(50) NOT NULL, 
          dob date NOT NULL
        );
        ```

      - Explicit: `CONSTRAINT` allowing for custom name, with `CHECK`

        ```sql
        CREATE TABLE students (
          id serial PRIMARY KEY, 
          name varchar(50), 
          dob date, 
          CONSTRAINT name_not_null CHECK (name IS NOT NULL), 
          CONSTRAINT dob_not_null CHECK (dob IS NOT NULL)
        );
        ```

    - Add `NOT NULL` constraint to existing table: 

      - Using `ALTER TABLE`, `ALTER COLUMN`, `SET`

        ```sql
        ALTER TABLE students
          ALTER COLUMN name SET NOT NULL,
          ALTER COLUMN dob SET NOT NULL;
        ```

    - Drop `NOT NULL` constraint

      ```sql
      ALTER TABLE students
        ALTER COLUMN name DROP NOT NULL, 
        ALTER COLUMN dob DROP NOT NULL;
      ```

  ##### `DEFAULT`

  The `DEFAULT` constraint will automatically insert a default value for rows in the subjected column when no other value is provided.

  ###### When to use `DEFAULT` constraints and when NOT to

    - Warranted by nature of column data
      - examples: 
        - `created_at` column includes default timestamp
        - `serial` includes default auto-incrementing value
        - `status` set to inactive until activated, vice versa
    - In order to avoid `NULL` values in calculations by defaulting to a safe value
    
  
  ###### Syntax Options: 
    
    - Within `CREATE TABLE` statement:

        ```sql
        CREATE TABLE orders (
          id serial PRIMARY KEY, 
          status varchar(50) DEFAULT 'Pending', 
          created_at timestamp DEFAULT CURRENT_TIMESTAMP
        );
        ```

    - Adding `DEFAULT` to existing column in table. 

      ```sql
      ALTER TABLE orders
        ALTER COLUMN status SET DEFAULT 'Pending';
      ```

    - Dropping `DEFAULT` constraint

      ```sql
      ALTER TABLE orders 
        ALTER COLUMN status DROP DEFAULT;
      ```




#
#
#


### Be familiar with using subqueries

#### When to use subqueries

Personal preference until looking at optimization metrics. In some situations, one may be more readable, more logical, or simpler.

For example, if you want to return data from one table conditional on data from another table, but don't need to return any data from the second table, a subquery may make more logical sense and aid readability. 

If you need to return data from both tables, use a join. 

  #### Subqueries

  ##### Description: 
  In some situations, a subquery can be more efficient that using a join.

  Subqueries essentially issue a `SELECT` query, and then use the results of that `SELECT` query as a condition in another `SELECT` query. We are nesting queries here. 

  Subquery expressions: PostgreSQL provides expressions that can be used specifically with subqueries such as:
  - `IN`
  - `NOT IN`
  - `ANY`
  - `SOME`
  - `ALL`

These essentially compare values to the result of a subquery.

  ##### Examples: 

  ```sql
  my_books=# SELECT * FROM authors;
 id |      name
----+----------------
  1 | William Gibson
  2 | Iain M. Banks
  3 | Philip K. Dick
(3 rows)

my_books=# SELECT * FROM books;
 id |        title         |     isbn      | author_id
----+----------------------+---------------+-----------
  1 | Neuromancer          | 9780441569595 |         1
  2 | Consider Phlebas     | 9780316005388 |         2
  3 | Idoru                | 9780425158647 |         1
  4 | The State of the Art | 0929480066    |         2
  5 | The Simulacra        | 9780547572505 |         3
  6 | Pattern Recognition  | 9780425198681 |         1
  7 | A Scanner Darkly     | 9780547572178 |         3
(7 rows)
  ```

### Using `=` because subquery returns single value

```sql
SELECT title FROM books WHERE author_id = 
  (SELECT id FROM authors WHERE name = 'William Gibson');
```

1. The nested query, when executed, returns the `authors.id` value that satisfies the condition (`name = 'William Gibson`).
2. The subquery returns the integer `1`. 
3. The outer query, then uses this value to complete its operation.
  - `SELECT title FROM books WHERE author_id = 1;`


#

### `EXISTS`

Checks whether *any* rows at all are returned by the nested query. 
  - if at least one row returned, evaluates to true, otherwise false. 

```sql
SELECT 1 WHERE EXISTS
  (SELECT id FROM books
    WHERE isbn = '9780316005388');

--- returns

?column?
-----------
        1
(1 row)
```
This returns `1` if there is a row in the `books` table with the corresponding `isbn` and no rows otherwise.

```sql

SELECT name FROM bidders
  WHERE EXISTS (
    SELECT 1 FROM bids 
      WHERE bids.bidder_id = bidders.id
  );
```
#

### `IN`

Compares an evaluated expression to every row in the subquery result. 
  - If a row equal to the evaluated expression is found, then the result of `IN` is true, otherwise false.

```sql
SELECT name FROM authors WHERE id IN
  (SELECT author_id FROM books
    WHERE title LIKE 'The%');

--- returns

  name
----------
Iain M. Banks
Philip K. Dick
(2 rows)
```

In this case, the nested query returns a list of `author_id` values `(2, 3)` from the `books` table where the title of the books for that row starts with `'The'`. 

The outer query returns the `name` value from any row of the `authors` table where the `id` for that row is in the results from the nested query. 

#

### `NOT IN`

Similar to `IN` except result of `NOT IN` is true if an equal row is NOT found, and false otherwise. 

```sql
SELECT name FROM authors WHERE id NOT IN
  (SELECT author_id FROM books
    WHERE title LIKE 'The%');

--- returns

  name
---------
William Gibson
(1 row)
```  
  
#

### `ANY` / `SOME`

`ANY` and `SOME` are synonyms and can be used interchangeably. 

These expressions are used along with an operator (`=`, `<`, `>`, etc). 

The result of `ANY` or `SOME` is true if *any* true result is obtained when the expression to the left of the operator is evaluated using that operator against the results of the nested query. 

```sql
SELECT name FROM authors WHERE length(name) > ANY
  (SELECT length(title) FROM books
    WHERE title LIKE 'The%');

--- returns

 name
----------------
 William Gibson
 Philip K. Dick
(2 rows)
```

The nested query will return a list of lengths (integers) of titles that start with 'The'. 

The outer query then returns the name of any author where the length of name is greater than any of the results from the nested query. 

Two of the author names are 14 characters in length and so satisfy the condition since they are greater in length than at least one of the title lengths (13) from the results of the nested query.

Note: when the = operator is used with ANY / SOME, this is equivalent to IN.

#

### `ALL`

`ALL` is used alongside an operator.

The result is true if *all* the results are true when the expression to the left of the operator is evaluated using that operator against the results of the nested query. 

```sql
SELECT name FROM authors WHERE length(name) > ALL
  (SELECT length(title) FROM books
    WHERE title LIKE 'The%');

--- returns
 name
------
(0 rows)
```

NOTE: when the `<>` or `!=` operator is used with `ALL` this is equivalent to `NOT IN`. 

#

## PostgreSQL

  - Describe what a sequence is and what they are used for.
    
    ### What is a sequence?
    
    A sequence is a database object that generates sequential, unique integer values. 

    A sequence is created using the syntax `CREATE SEQUENCE sequence_name;`. We can optionally define particular start values, increment intervals, minimum and maximum values, etc. when a sequence is created. Unless otherwise specified, the default starting value for a newly created sequence is 1, and it will increment by 1 each time the sequence is called. 
    
    Once created, a sequence exists in the database independent of any association with tables, though the sequence may be utilized by numerous tables. 
    
    ### What is a sequence used for?

    Sequences are often used as value generators for surrogate keys in relations, which may or may not act as the table's `PRIMARY KEY`. The PostgreSQL convention of using `serial` as a pseudo-data-type provides a shorthand way of creating a sequence of default values for a particular column. 
    
    When creating a table, we often encounter the following syntax: 

    ```sql
    CREATE TABLE my_table (
      id serial PRIMARY KEY
      ...
    )
    ```
    Utilizing `serial`, we create a new sequence, and set the default value for the `id` column to the next value generated by the sequence. By utilizing a sequence object in this way (as `PRIMARY KEY`), we can ensure that values in the `id` column are system generated, `NOT NULL`, `UNIQUE`, and serve as unique identifiers for rows of data. 

    In addition to use in generating surrogate keys, a sequence can be called directly to generate a value. We can use `nextval()` to return the next value in the sequence, `currval()` to return the current value, or `setval()` to manually assign a current value. 
    
    A sequence can be reset to a starting value using the following syntax: 

    ```sql
    ALTER SEQUENCE your_sequence_name RESTART WITH 1;
    ```
    
    The core functionality of a sequence is the generation of sequential, unique, numeric values. The way these values are utilized and leveraged is determined by the overall schema. 

#

  - Create an auto-incrementing column.

  ```sql
  CREATE TABLE my_table (
    id serial PRIMARY KEY,
    name text, 
    lucky_number serial
  );
  ```

   `serial` is not a true data type, but instead a PostgreSQL convention and acts as a pseudo-data-type. `serial` provides shorthand notation for creating a sequence object and assigning it as the default value for the column.
   
  In the example above, we create two auto-incrementing columns (id and lucky_number). We use the `serial`, which is shorthand for: 

  ```sql
  --- Create a sequence 

  CREATE SEQUENCE my_table_id_seq;

  --- and set as default for column

  CREATE TABLE... 
    id integer DEFAULT nextval('my_table_id_seq'),
    ...

  --- AND 

  CREATE SEQUENCe lucky_num_seq;

  lucky_number integer DEFAULT nextval('lucky_num_seq');
  
  ```
 Once a number is returned by `nextval` for a standard sequence, it will not be returned again, regardless of whether the value was stored in a row or not. 

```sql
 CREATE [ { TEMPORARY | TEMP } | UNLOGGED ] SEQUENCE [ IF NOT EXISTS ] name
    [ AS data_type ]
    [ INCREMENT [ BY ] increment ]
    [ MINVALUE minvalue | NO MINVALUE ] [ MAXVALUE maxvalue | NO MAXVALUE ]
    [ START [ WITH ] start ] [ CACHE cache ] [ [ NO ] CYCLE ]
    [ OWNED BY { table_name.column_name | NONE } ]
```
 #
 #


- Be able to describe what primary, foreign, natural, and surrogate keys are.
   - Keys 
    - special type of constraint used to establish relationships and uniqueness. 
 
 How relationships established
  - The relationships between tables are established through the use of primary and foreign keys. Primary keys are unique identifiers for a row of data in a table, while foreign keys typically reference a primary key of another table in order to form an association. Primary and foreign keys work together to support referential integrity between normalized data by ensuring that the data being referenced exists, and that the relationship remains consistent.  


### Natural Keys
  - natural 'part of the data' and unique identifiers *by nature* of the data they represent. 
    - They are attributes of the entity itself, that happen to represent information qualified to uniquely identify a particular entity. 
    - Not ideal solution for large data sets, where there may be difficulty establishing enduring distinct values. 
  - natural keys are unique identifiers that are part of the data set itself, and have some business or real world meaning. natural keys may be attributes of a data set that are inherently likely to be unique, such as social security numbers, isbn numbers, VIN numbers, etc. They serve as identifiers for specific entities based on the nature of the data they represent as being attributable to only one entity. 
  - natural keys can be problematic however, as they are subject to environmental forces in the real world and may change. By using natural keys we create a dependency between the database and the business or real world. 

  - Example of natural key: 
    - Home address
       the id here is by *nature*, unique. It uniquely identifies a particular house within a larger geographic area. and most notably it is naturally associated with the house. Addresses lend themselves naturally to identify real estate. The address marks an area where the collection of attributes which comprise the house, exists. And even if all of the other attributes besides its address were the exact same as hundreds of other entries, we still can find our house by its address.

### Surrogate Keys
  - Surrogate keys are effective in mitigating risks inherent in utilizing natural keys in a database. Surrogate keys are unique identifiers for rows of data that only have meaning within the context of the database itself. Surrogate keys do not have any real-world or business meaning, but exist solely identify a particular record. Surrogate keys are commonly system generated as we see with auto-incrementing integers serving as `PRIMARY KEY`s in a relation. A distinct benefit of utilizing surrogate keys is that they are not subject to real-world changes that may affect the entity itself, while it is entirely possible that a natural key like an address may change over time, a surrogate key remains consistent. 

## Foreign Keys (additional)


### Foreign Keys May refer to two different, but related things:

1. Foreign Key Column
  - column that represents relationship between two rows, by pointing to a specific row in another table using its *primary key*. 
  - stores reference to primary key column elsewhere in the database.

2. Foreign Key Constraint
  - constraint that enforces rules about what values are permitted in these foreign key relationships. 


### Creating Foreign Key Columns

Create a column of the same type as the primary key column it will point to. 

#### Creating Foreign Key Constraints

Two syntax options...

1. Add `REFERENCES` clause to description of a column in `CREATE TABLE` statement.

```sql
CREATE TABLE orders (
  id serial PRIMARY KEY, 
  product_id integer REFERENCES products (id),
  quantity integer NOT NULL
);
```


2. Add foreign key constraint separately to existing table

```sql
ALTER TABLE orders ADD CONSTRAINT orders_product_id_fkey FOREIGN KEY (product_id) REFERENCES products(id);
```


**Benefit of Referential Integrity**

Using foreign key constraints preserves referential integrity of the data in the database. 

Ensures every value in a foreign key column exists in the primary key column of the table being referenced. 

If attempt to insert row that violate the constraint, will raise error. 




### FOREIGN KEY constraints DO NOT prevent NULL values from being stored in the column

Often necessary to use `NOT NULL` and a foreign key constraint together. 

## Database Diagrams

  - Ask:
    - what level of schema is represented?
    - how are relationships shown?
    - are attributes and data types shown?

  - Talk about the different levels of schema.
    - Conceptual
      - higher level concepts/entities
      - thinking about data abstractly, not how data or relationships will be stored in database
      - focus is identifying entities and their relationships
      
      - Entity relationship diagram is an example of conceptual schema
        - focus purely on entities and how they relate
          - not focused on tables
        - thinking about what data being represented, adn how grouped into entities that represent specific pieces of functionality of application. 
    
    
    - Logical 
      - may include attributes and data types, but not lower level implementation details for a particular database
    
    
    - Physical
      - implementation details of how the data will be stored and relationships between data. 
      - attributes, data-types, constraints
      - low level, database specific

      - In model, shows description of actual tables being used
        - table names
        - column names
        - data types
        - keys
        - constraints
        - relationships

    - The physical schema of one-to-one and one-to-many relationships are essentially the same. 
    May make more sense to move into same table for one-to-one. 

  - Define cardinality and modality.

    ## Cardinality

      - Description: 
      
      Cardinality refers to the number of entity instances on each side of the relationship being modeled. One way to think about cardinality between entities is to consider a single entity instance on one side of the relationship, and ask "what is the maximum number of times that this particular row could be associated with a row in the other relation?" 

      Cardinality is expressed as: 

      - One-to-One relationships exist when an entity instance in one table could be associated with a maximum of one entity instance in another table. An example of a one-to-one relationship is a car and its associated VIN number. Each car has a unique VIN number. When we consider a particular entity instance of a car, let's say my 2015 Honda Fit, the maximum number of times that my car could be associated with an entity instance of a VIN number is one. In return, a particular VIN number may be associated with a maximum of one vehicle.

        - `FOREIGN KEY`s in one-to-one relationships should have a `UNIQUE` and `NOT NULL` constraint in order to preserve referential integrity. 
    

      - One-to-many relationships exist when an entity instance in one table may be associated with numerous entity instances in another table. Consider a table holding customer data, and another keeping records of pizza orders. When we select a single person, in the `customers` table, it is entirely possible that this customer is associated with many different order instances in the `orders` table. However, if we select one entity instance from the `orders` table, it may be associated with a maximum of one customer in the `customers` table. 

        - `UNIQUE` constraints should NOT be applied to the `FOREIGN KEY` column on the 'many' side of a one-to-many relationship. If we were to apply a `UNIQUE` constraint on the 'many' side of the relationship, this would violate referential integrity of the association being modeled. 
          - example: A person has one date of birth, but this date of birth is associated with numerous other people. If date of birth were a `FOREIGN KEY` and we utilized a `UNIQUE` constraint, we would effectively be creating a invalid one-to-one relationship. 


      - Many-to-many relationships exist when an entity instance in one table may be associated with numerous entity instances in another table, and vice-versa. For example, consider an entity representing `books` and another representing `genres`. It would make sense relationally that a single book may be associated with many genres, and one particular genre may be associated with many different books. 

        - Join tables in many-to-many relationships often have a `UNIQUE` constraint on combinations of `FOREIGN KEYS` represented in the table.
        
        - a join table associates entities in a many-to-many relationship by referencing the `PRIMARY KEY`s of each entity as `FOREIGN KEY`s in the join table. Each row represents an instance of the many-to-many relationship
        
          - example: A doctor has many patients, and a patient may have many doctors. In the join table, each row would include a `FOREIGN KEY` referencing a doctor, paired with a `FOREIGN KEY` referencing a patient in their respective tables. `UNIQUE` constraints are utilized to guard against duplication of the relationship in the join table.


#
#


  ## Modality
  - the minimum number of entity instances that are required to exist on either side of a relationship. Typically represented by 0 (not required) or 1 (required)

  - for example: 

  we have a runners table containing runners in a particular club, we have a race table that lists times attributed to individual runners. this is a one to many relationship with a modality of 1 on the runners side and 0 on the race side.. we require a runner to be associated with a time, but we don't require that all runners participate in the race

  - Be able to draw database diagrams using crow's foot notation.




## Resources

### `psql` Meta Commands

| Meta Command | Description                                      | Example             |
|--------------|--------------------------------------------------|---------------------|
| `\c $dbname` | Connect to database `$dbname`.                   |`\c blog_development`|
| `\d`         | Describe available relations.                    |                     |
| `\d $name`   | Describe relation `$name`.                       | `\d users`          |
| `\?`         | List of console commands and options.            |                     |
| `\h`         | List of available SQL syntax Help topics.        |                     |
| `\h $topic`  | SQL syntax Help on syntax for `$topic`.          | `\h INSERT`         |
| `\q`         | Quit.                                            |                     |

#
#

### Data Types

| Data Type                  | Type       | Value                               | Example Values         |
|--------------------------- |------------|-------------------------------------|----------------------- |
| `varchar(length)`          | character  | up to length characters of text     | `canoe`                |
| `text`                     | character  | unlimited length of text            | `a long string of text`|
| `integer`                  | numeric    | whole numbers                       | `42, -1423290`         |
| `real`                     | numeric    | floating-point numbers              | `24.563, -14924.3515`  |
| `decimal(precision, scale)`| numeric    | arbitrary precision numbers         | `123.45, -567.89`      |
| `timestamp`                | date/time  | date and time                       | `1999-01-08 04:05:06`  |
| `date`                     | date/time  | only a date                         | `1999-01-08`           |
| `boolean`                  | boolean    | true or false                       | `true, false`          |


#
#

### Note on `NULL`

`NULL` represents an empty value. 

```sql
SELECT NULL = NULL;
```

This would return `NULL`, an empty value. 

When `NULL` appears on either side of a comparison operator `=`, `>`, `<`, `<=`, `>=`. The operator will return `NULL` instead of a `boolean`. 

Must use `IS NULL` or `IS NOT NULL` to make meaningful comparison to a `NULL` value. 

```sql
SELECT NULL IS NULL;

-- t
```

#
#

## Schema to limit values

### List three ways to use the schema to restrict what values can be stored in a column.

  - Data type (which can include a length limitation)
  - NOT NULL Constraint
  - Check Constraint


##

### Database dumps
  - extract with insert statements 
  
  `pg_dump -d my_database -t my_table --inserts > dump.sql`


  Setting up reference to ensure **referential integrity** of a relationship.
    - assurance that a column value within a record must reference an existing value.
      - Error thrown if try to add value to Foreign Key column of a table if Primary Key column of the table it is referencing does not already contain that value. 


### using Copy for csv files

-- Copy data for bidders from the csv file to the bidders table
`\copy bidders FROM 'bidders.csv' WITH HEADER CSV`

-- Copy data for items from the csv file to the items table
`\copy items FROM 'items.csv' WITH HEADER CSV`

-- Copy data for bids from the csv file to the bids table
`\copy bids FROM 'bids.csv' WITH HEADER CSV`


More subquery examples:

```sql
SELECT items.name FROM items
WHERE items.id IN (
  SELECT item_id FROM bids
);
```
```sql
SELECT e.name, e.department_id
FROM employees e
WHERE e.salary > (
    SELECT AVG(e2.salary)
    FROM employees e2
    WHERE e2.department_id = e.department_id
);

In this example, e.department_id from the outer query is used in the subquery to calculate the average salary for each department.
```

```sql
SELECT MAX(bid_counts.count) FROM
  (SELECT COUNT(bidder_id) FROM bids GROUP BY bidder_id) AS bid_counts;
```


## Scalar subqueries 


Scalar Subqueries

For this exercise, use a scalar subquery to determine the number of bids on each item. The entire query should return a table that has the name of each item along with the number of bids on an item.

Here is the expected output:

    name      | count
--------------+-------
Video Game    |     4
Outdoor Grill |     1
Painting      |     8
Tent          |     4
Vase          |     9
Television    |     0
(6 rows)

Refer to the PostgreSQL documentation on scalar subqueries to solve this exercise. Keep a few key facts in mind:

    You may reference columns within your subquery from the outer SELECT query. Those values will act as constants for the current subquery evaluation.
    A scalar subquery must only return one column and one row.

Solution
```sql
SELECT name,
       (SELECT COUNT(item_id) FROM bids WHERE item_id = items.id)
FROM items;
```
## using ROW operation to get id

```sql
SELECT id FROM items
WHERE ROW('Painting', 100.00, 250.00) =
  ROW(name, initial_price, sales_price);
```


###