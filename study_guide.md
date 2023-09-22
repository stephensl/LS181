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














  - Name and define the three sub-languages of SQL and be able to classify different statements by sub-language.
  - Write SQL statements using INSERT, UPDATE, DELETE, CREATE/ALTER/DROP TABLE, ADD/ALTER/DROP COLUMN.
  - Understand how to use GROUP BY, ORDER BY, WHERE, and HAVING.
  - Understand how to create and remove constraints, including CHECK constraints
  - Be familiar with using subqueries

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
