# 181 Study Guide

## SQL

  ### Identify the different types of `JOIN`s and explain their differences.

  We often need to reference data that is distributed among multiple tables. In doing so, it may be useful to join tables together based on an association between them in order to access the targeted data. `JOIN` statements enable us to combine data from multiple tables and may utilize conditional expressions in order to access the desired data. 
  
  There are five main types of `JOIN`s, each allowing for different ways of merging and representing data across multiple tables.

  1. `INNER JOIN`

  This is the default `JOIN` used if simply using the statement `JOIN` without any other qualifiers. This type of `JOIN` will combine rows from two tables that satisfy a particular join condition. When two tables are joined, each row in the current table (left) will be compared to each row in the second table (right) and evaluated based on the join condition. If the two rows being compared satisfy the condition, they are joined together and included in a 'transient' table. The `SELECT` command will then utilize the 'transient' table in order to return targeted data as if it were querying a single table. 

  2. `LEFT OUTER JOIN`

  3. `RIGHT OUTER JOIN`

  4. `FULL OUTER JOIN`

  5. `CROSS JOIN` 













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
