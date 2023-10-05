
1. Consider the last line of the following code. Will the code result in an error if we attempt to insert `NULL` value to a `student_id` column? Why or why not?

```sql
CREATE TABLE students (
	id serial PRIMARY KEY,
	name text
);

CREATE TABLE classes (
	id serial PRIMARY KEY,
	name text,
	student_id int REFERENCES students (id)
);

INSERT INTO students (name) VALUES ('Johny'), ('Edd');
INSERT INTO classes (name, student_id) 
	VALUES ('Math', 1), ('Art', NULL), ('Geography', 1);
```

This code will not result in an error because there is not an existing `NOT NULL` constraint on the `student_id` column. In this case, `students` and `classes` models a one-to-many relationship as one student may take many classes. It is true that a class may have many students as well, suggesting a many-to-many relationship, but since we are dealing with only two tables here- the absence of a join table necessary in modeling a many to many relationship is telling. The modality of the relationship between students and classes is 0 on both sides in this case since student_id accepts `NULL` values. This means a student can exist without being in a class, and a class can exists without any students assigned to it. 



#
#

2. Consider the code below. How are relations, rows, attributes, and entities represented in the example below? 

```sql
CREATE TABLE teachers (
	id serial PRIMARY KEY,
	name text,
);

CREATE TABLE classes (
	id serial PRIMARY KEY,
	name text,
	teacher_id int REFERENCES teachers (id) 
		ON DELETE CASCADE
);

INSERT INTO teachers (name) VALUES ('Marry Bee');
INSERT INTO classes (name, teacher_id) VALUES ('Math', 1);
```

The relations represented are `teachers` and `classes`. 

Rows within each relation would indicate a single entity instance of either a teacher or a class. These entity instances have attributes that correspond to the names of columns in the relation (`id`, `name`, `teacher_id`). 



#
#

3. Consider the code below. How is a relation represented on the code below? How is a relationship represented? 

```sql
CREATE TABLE teachers (
	id serial PRIMARY KEY,
	name text,
);

CREATE TABLE classes (
	id serial PRIMARY KEY,
	name text,
	teacher_id int REFERENCES teachers (id) 
		ON DELETE CASCADE
);
```

A relation is represented as a table. Here we have two relations, `teachers` and `classes`. The relationship between them has a cardinality of one to many and a modality of zero on the one side, and zero on the many side. 


#
#

4. Considering the following code explain how do defining keys and constraints ensure data integrity?

```sql
CREATE TABLE teachers (
	id serial PRIMARY KEY,
	name text,
);

CREATE TABLE classes (
	id serial PRIMARY KEY,
	name text,
	teacher_id int REFERENCES teachers (id) 
		ON DELETE CASCADE
);
```

Constraints are used to enforce rules and limitations around the data that is stored in a database. Keys serve as unique identifiers for particular records and allow us to create referential associations between data. Both constraints and keys benefit data integrity by ensuring that data is properly validated when it enters the database, and references to data among multiple tables remain consistent and accurate. 

In the example above, the `teachers` table contains an `id` column which has a `PRIMARY KEY` constraint. This `PRIMARY KEY` uniquely identifies each record in the table, and by default, ensures that its values are `NOT NULL` and `UNIQUE`. These constraints ensure that each individual record will maintain a unique identifier. 

In the classes table, we also have an `id` column which serves as the `PRIMARY KEY` for the table, but most notably, the table containts a `teacher_id` column and utilizes the `REFERENCES` keyword to associate the `teacher_id` column in the `classes` table and the `id` column in the `teachers` table. Thus, `teacher_id` is a `FOREIGN KEY`, referencing the `PRIMARY KEY` in another table. Utilizing `PRIMARY KEY`s and `FOREIGN KEY`s to associate data among multiple tables protects referential integrity between the two tables. The `ON DELETE CASCADE` clause applied to `teacher_id` further protects referential integrity, as when a record from the `teachers` table, which references a record in the `classes` table is deleted, the associated record in the `classes` table will be automatically removed as will. This ensures that references remain valid, and we do not orphan any data by removing only one side of the relationship. 



#
#

5. Explain how this `SELECT` query will be executed?

```sql
SELECT teachers.name, 
	FROM teachers
		JOIN classes
			ON teachers.id = classes.teacher_id
				GROUP BY teachers.name
					ORDER BY COUNT(classes.id);
```

1. The query will start by gathering rows from tables included in the `FROM` clause and any `JOIN` clauses. In this case, all rows from the `teachers` table and the `classes` table will included. 

2. Next, the `ON` clause is evaluated and rows that meet the condition, namely that the value in teachers.id is equal to the value in teacher_id are joined together in a 'transient' table. 

3. The `GROUP BY` clause is evaluated and rows containing the same value for `teachers.name` will be grouped together. The remaining data in the grouped rows is then subject to aggregation or further grouping. 

4. The `SELECT` list is evaluated and values from the grouped data is selected- the `name` column of the `teachers` table. 

5. The selected data is sorted by the evaluated result of the aggregate function `COUNT(classes.id)` which will return the count of `id`s from the `classes` table that are associated with each teacher. The result set will be sorted in ascending order, with the teacher who has the smallest number of classes appearing first. 


#
#

6. Consider the code below: What are the different data types in this example. Describe each of them and describe the differences between them. 

```sql
CREATE TABLE example (
	id serial PRIMARY KEY,
	title varchar(200) NOT NULL UNIQUE,
	name char(100), 
	age numeric NOT NULL
);
```
- serial is a data type that creates a sequence object which automatically-increments when a record is inserted that does not already include a value for that column. This is often used along with `PRIMARY KEY` constraint to uniquely identify records. 

- varachar(200) this is a text data type that allows for variable text up to a maximum of 200 characters. 

- char(100) is a text data type, that allows for a maximum of 100 characters, but any text less than 100 characters in length will be automatically lengthened up to 100 characters using spaces. Thus, each entry in columns subject to this data type will be the same length. 

- numeric allows for any number to be entered. may be integer, decimal, etc. 


#
#

7. Consider the code below:

```sql
CREATE TABLE example(
	some_num numeric(10,2)
);

INSERT INTO example (some_num) VALUES (1);
```

Will this code raise an error? Why or why not?

This will not raise an error, as it fits within the constraints of the data type. `numeric(10, 2)` specifies that the column can store numbers up to 10 digits in length, two of which may be following the decimal point. 

When the value `1` is inserted, it will be stored as `1.00` which meets these requirements. 

#
#

8. Consider the code below:

```sql
CREATE TABLE example(
	some_num int,
	some_text text CHECK (length(some_text) > 0)
);

INSERT INTO example (some_num)
	VALUES (11);
```

Will this code raise an error? Why or why not?

Yes, this code will raise an error when attempting to run the `CREATE TABLE` statement. the `CHECK` in the `some_text` column is invalid, as we are not providing a valid comparison. We are likely attempting to ensure that the length of `some_text` is greater than 0, and must therefore evaluate the length utilizing `length(some_text) > 0;`


#
#

9. What will the following code return and why?

```SELECT NULL IS NOT NULL;```

False. Here we are evaluating `NULL` is NOT `NULL`. 

Similarly, if we said 5 is not 5. this would be false. We do not use a comparison operator here because we are dealing with `NULL` values. If either side of an operation is `NULL` the result of the operation will be `NULL`. Thus, in order to compare, we must use `IS NULL` or `IS NOT NULL` syntax to get a meaningful result. 




#
#


10. Consider the code below. Will this code raise an error? Why or why not?

```sql
CREATE TABLE some_table (
	some_num decimal(10,4) DEFAULT 'some text',
	some_t_or_f boolean DEFAULT true
);
```

This code will raise an error, as we are using an incompatible data type as a DEFAULT value for `some_num`. We specify a numeric data type (`decimal`) but then supply a text `DEFAULT` which would not meet the requirements enforced by the data type constraint. 


#
#

11. Consider the code below:

```sql
CREATE TABLE some_table(
	some_num decimal(10,4),
	some_t_or_f boolean DEFAULT true
);

INSERT INTO some_table (some_num, some_t_or_f)
	VALUES (11, NULL);
```

What values will be inserted into the table?

11.0000 will be inserted and the `some_t_or_f` column will contain a `NULL` value for the row. Here we do not have a constraint which would disallow `NULL` values. The fact that it is not a `boolean` data type is irrelevant, because it is not a data type at all, it is `NULL`, the absence of value. 




#
#

12. Consider the following code. What does `ON DELETE CASCADE` do in this example?

```sql
CREATE TABLE teachers (
	id serial PRIMARY KEY,
	name text,
);

CREATE TABLE classes (
	id serial PRIMARY KEY,
	name text,
	teacher_id int REFERENCES teachers (id) 
		ON DELETE CASCADE
);
```





#
#

13. Consider the following error message:

```sql
ERROR:  duplicate key value violates unique constraint "unique_id"
DETAIL:  Key (id)=(1) already exists.
```

When would PostgreSQL throw this error and why? Explain the information that this error message gives us.





#
#


14. Create a table `teachers` with a column called `set_up_date` and set it to `text`. Change the data type in that column to a `date` data type.

```sql
CREATE TABLE teachers (
  id serial PRIMARY KEY, 
  set_up_date text
);

ALTER TABLE teachers 
ALTER COLUMN set_up_date
  TYPE date USING set_up_date::date; 
```



#
#


15. Consider the table below: What indexes does this table have and what type of algorithms has been used for the indexing? Explain how they have been created:

```sql
my_books=# CREATE TABLE authors (
my_books(#   id serial PRIMARY KEY,
my_books(#   name varchar(100) NOT NULL
my_books(# );
CREATE TABLE
my_books=# CREATE TABLE books (
my_books(#   id serial PRIMARY KEY,
my_books(#   title varchar(100) NOT NULL,
my_books(#   isbn char(13) UNIQUE NOT NULL,
my_books(#   author_id int REFERENCES authors(id)
my_books(# );

CREATE TABLE
my_books=# \d books
Table "public.books"
Column     |          Type          |                     Modifiers
- ---------------+------------------------+----------------------------------------------------
id             | integer                | not null default nextval('books_id_seq'::regclass)
title          | character varying(100) | not null
isbn           | character(13)          | not null
author_id      | integer                |
Indexes:
"books_pkey" PRIMARY KEY, btree (id)
"books_isbn_key" UNIQUE CONSTRAINT, btree (isbn)
"books_author_id_idx" btree (author_id)
Foreign-key constraints:
"books_author_id_fkey" FOREIGN KEY (author_id) REFERENCES authors(id)
```







#
#

16. If we create a table with an `id` column and specify it as `serial`, and we look at the schema of that table, what will be shown as a `Type` of id? Why? 






#
#


17. Consider the following code:

```sql
SELECT age, full_name FROM students
WHERE id < 2;
```

What type of statement is this code presenting? Explain all components of this statement. 

This is a SQL Query. Utilizing a `SELECT` command, and 



#
#

18. Consider the code below:

```sql
SELECT year FROM schedule WHERE year > 2010;
```

Will this code result in an error? Why or why not? 




#
#


19. Consider the code below:

```sql
SELECT name, age FROM students WHERE age = NULL;
```

Will this result in an error? Why or why not? If not what will be the output of that code?






#
#


20. Consider the code below: 

```sql
SELECT full_name FROM students WHERE full_name ILIKE '%Johanson';
```

Which of the following names would be returned and why?
- Johanson
- 'Johanson Branson'
- 'Eva B. Johanson'
- 'johanson'






#
#


21. Consider the students table below: 

```sql
name   |   age   |   participated
---------------------------------
'Ann'  |   13    |   t
'Ben'  |   12    |   
'Emma' |   15    |   f
'Kat'  |   12    |   f
```

Write a query that retrieves all the names of kids for whom the value of `participated` column is not true.






#
#

22. Consider the error message below:

```sql
ERROR:  column "users.full_name" must appear in the GROUP BY clause or be used in an aggregate function
```

What does this error message tell us? Write a statement that could cause an error like that and describe ways to resolve this error. 






#
#


23. Consider a students table below: 

```sql
id |    name    |    year_of_birth    |    grade
-------------------------------------------------
1  |  'Eddie'   |   1986-01-01        |   A
2  |  'Maggie'  |   1975-04-11        |   B+
3  |  'Elenore' |   1995-03-13        |   A-
```

- Write a query that returns names of students who were born in April


- Write a query that returns names of students who were born on 11th of April


- Write a query that returns  all students who were born in 1986


- Write a query that returns the oldest person





#
#

24. What syntax would you use to remove all rows from an imaginative `students` table? Present a code that illustrates that. 




#
#

25. Why do we need to create multiple tables instead of just keeping all the data in one table? 







#
#


26. Consider the following students table: 

```sql
id |    name    |    year_of_birth    |    grade |  class
-----------------------------------------------------------
1  |  'Eddie'   |   1986-01-01        |   A      |  Math
2  |  'Maggie'  |   1975-04-11        |   B+     |  History
3  |  'Elenore' |   1995-03-13        |   A-     |  French
```

- We no longer want to have classes at the same table as students. What are the steps you would take to create another table `classes` and create a relationship between `students` and `classes`.

- Create `classes` table and the relationship between `classes` and `students`.






#
#


27. What benefits does presenting cardinality give us? How may the information that representing cardinality in our diagrams be useful for the database design?




#
#


28. Consider the ERD below. Describe the relationships between those entities:

![ERD](image.png)





#
#


29. Consider the following diagram. Describe what is the cardinality between entities?

![Diagram](image-1.png)







#
#

30. Consider two tables below: 

```sql
SELECT * FROM customers;
customer_id | name  
-------------+-------
           1 | Johny
           2 | Ben
           3 | Gary

SELECT * FROM orders;
order_id | customer_id | orders 
----------+-------------+--------
        1 |           1 | book
        2 |           2 | mug
        3 |           3 | chair

\d orders 

Column    |  Type   | Collation | Nullable |                 Default                  
-------------+---------+-----------+----------+------------------------------------------
 order_id    | integer |           | not null | nextval('orders_order_id_seq'::regclass)
 customer_id | integer |           |          | 
 orders      | text    |           |          | 
Indexes:
    "orders_pkey" PRIMARY KEY, btree (order_id)
Foreign-key constraints:
    "orders_customer_id_fkey" FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
```

What will happen if we run the following statement? Why? 

```sql
DELETE FROM customers WHERE customer_id = 3;
```






#
#

31. Consider the error below:

```sql
ERROR:  update or delete on table "customers" violates foreign key constraint "orders_customer_id_fkey" on table "orders"
DETAIL:  Key (customer_id)=(3) is still referenced from table "orders".
```

Why is this error raised? What can be done to eliminate this error?






#
#


32. Consider the code below. What type of cardinality does this example present? Explain how did you deduce that.

```sql
CREATE TABLE students (
	id serial PRIMARY KEY,
	name varchar(100) 
);   

CREATE TABLE addresses (
	student_id int, 
	address text,
	city text,
	PRIMARY KEY (student_id),
	FOREIGN KEY (student_id) REFERENCES students (id)
		ON DELETE CASCADE
);
```





#
#

33. Consider two tables below: 

```sql
 CREATE TABLE students (
	id serial PRIMARY KEY,
	name varchar(100) 
);   

CREATE TABLE addresses (
	student_id int, 
	address text,
	city text,
	PRIMARY KEY (student_id),
	FOREIGN KEY (student_id) REFERENCES students (id)
		ON DELETE CASCADE
);
```

Why can we add a student without an address but can't add an address without a student?






#
#


34. Consider two tables below:

```sql
CREATE TABLE students (
	id serial PRIMARY KEY,
	name varchar(100) 
);   

CREATE TABLE addresses (
	student_id int, 
	address text,
	city text,
	PRIMARY KEY (student_id),
	FOREIGN KEY (student_id) REFERENCES students (id)
);
```

What will happen if we delete a row in a `students` table, that is referenced by a record in  `addresses` table?





#
#


35. Consider two tables below:

```sql
table 'classes'
id |  name   
----+---------
  1 | math
  2 | german
  3 | physics

table 'students'

id | name  | class_id 
----+-------+----------
  1 | Harry |        1
  2 | Ben   |        2
  3 | Marry |        3
  4 | Marry |        2
```

Describe what the following statement will do and what will be the result of the query:

```sql
SELECT students.name as "Student Name", classes.name as "Class name"
	FROM students 
	INNER JOIN classes 
	ON students.class_id = classes.id;
```






#
#

36. Consider two tables below: 

```sql
table 'classes'
id |  name   
----+---------
  1 | math
  2 | german
  3 | physics

table 'students'

id | name  | class_id 
----+-------+----------
  1 | Harry |        1
  2 | Ben   |        2
  3 | Marry |        3
  4 | Marry |        2
```

What steps will PostgreSQL take in order to perform the following query and what will be the result?

```sql
SELECT students.name as "Student Name", classes.name as "Class name"
	FROM students 
	INNER JOIN classes 
	ON students.class_id = classes.id;
```





#
#


37. Consider two tables below:

```sql
table 'classes'
id |  name   
----+---------
  1 | math
  2 | german
  3 | physics

table 'students'

id | name  | class_id 
----+-------+----------
  1 | Harry |        1
  2 | Ben   |        2
  3 | Marry |        3
  4 | Marry |        2
```

Describe how would a 'join table' look like. How many columns would it have and what would be their names? What rows would be included in that table?

```sql
SELECT students.name as "Student Name", classes.name as "Class name"
	FROM students 
	INNER JOIN classes 
	ON students.class_id = classes.id;
```





#
#

38. Consider the following tables:

```sql
table 'classes'
id |  name   
----+---------
  1 | math
  2 | german
  3 | physics

table 'students'

 id | name  | year_of_birth | class_id 
----+-------+---------------+---------
  1 | Harry |  1987-02-04   |      1
  2 | Ben   |  1976-11-13   |      2
  3 | Marry |  1995-03-21   |      3
  4 | Marry |  1995-03-21   |      2
```

Write a query:
  - return a list of students names who are born in 90' and attend German classes
  - return a list of students born in  February along with a class they attend. 





#
#



39. Consider the schema below:

```sql
  Table "public.birds"
 Column  |         Type          | Collation | Nullable |              Default              
---------+-----------------------+-----------+----------+-----------------------------------
 id      | integer               |           | not null | nextval('birds_id_seq'::regclass)
 name    | character varying(25) |           |          | 
 age     | integer               |           |          | 
 species | character varying(15) |           |          | 
Indexes:
    "birds_pkey" PRIMARY KEY, btree (id)
```

Let say we alter the table with the following command: 

```sql
ALTER TABLE birds ADD CHECK (age > 0);
```

Explain what this command does and where will the information be added to the schema?





#
#


40. Consider the following students table:

```sql
 id | name  | year_of_birth | phone_num     | class_id 
----+-------+---------------+---------------+---------
  1 | Harry |  1987-02-04   |  909432987    |  1
  2 | Ben   |  1976-11-13   |  099876567    |  2
  3 | Marry |  1995-03-21   |  098787654    |  3
  4 | Marry |  1995-03-21   |  908675356    |  2
```

Add following constraints to the table: 
  - if there is no `name` given `anonymous` should be added
  - `class_id` should always be greater than 0
  - `phone_num` should not allow duplicates
  - `year_of_birth` should be required






#
#

41. Consider the code below. Will the following code result in an error, why?:

```sql
CREATE TABLE some_table(
  name varchar(50) CHECK(length(name)> 1)
  last_name varchar(100)
);

INSERT INTO some_table (last_name) VALUES ('Ericsson');
```





#
#


42. Consider the code snippet below. What SQL sub-language does this code present:

```sql
ALTER TABLE elephants
	 DROP CONSTRAINT some_const;
```



#
#

43. Consider the code snippet below. What SQL sub-language does this code present?

```sql
UPDATE elephants 
	SET num_legs = 4
	WHERE num_legs = 5;
```




#
#

44. Consider table below: 

```sql
CREATE TABLE students (
  id serial PRIMARY KEY,
  name varchar(25),
  age int 
);

INSERT INTO students (name, age) 
  VALUES ('Mary', 11), ('John', 12), ('Valery', 12);
```

Will the following code result in an error? What is the code trying to do? 

```sql
ALTER TABLE students 
  ALTER COLUMN name TYPE varchar(1);
```


How about this code:

```sql
ALTER TABLE students 
  ALTER COLUMN name TYPE varchar(100);
```






#
#

45. Consider students table below:

```sql
id | name  |year_of_birth|phone_num    | average_points 
----+-------+---------------+---------------+---------
 1 | Harry | 1987-02-04 |  909432987   |  1
 2 | Ben   | 1976-11-13 |  099876567   |  6
 3 | Marry | 1995-03-21 |  098787654   |  7
 4 | Marry | 1995-03-21 |  908675356   |  0
```

The schema is as follow:

```sql
Table "public.students"
     Column     |  Type   | Collation | Nullable |               Default                
----------------+---------+-----------+----------+--------------------------------------
 id             | integer |           | not null | nextval('students_id_seq'::regclass)
 name           | text    |           | not null | 
 year_of_birth  | text    |           |          | 
 phone_num      | text    |           |          | 
 average_points | integer |           |          | 
Indexes:
    "students_pkey" PRIMARY KEY, btree (id) 
```


- change `name` data type to take strings with max length of 50
- change `year_of_birth` data type to `DATE`
- change `phone_num` data type to be an integer
- change `average_points` to be able to take decimal point numbers that must be greater than 0 but less than 10
- add a new column called `highest_grade` that is obligatory and can take a string with max length of 1 character.
- now change the data type of `highest_grade` to only accept one of the following characters: `('A', 'B', 'C', 'D', 'F')`




#
#



46. Consider the following schema:

```sql
Table "public.students"
     Column     |     Type     | Collation | Nullable |               Default                
----------------+--------------+-----------+----------+--------------------------------------
 id             | integer      |           | not null | nextval('students_id_seq'::regclass)
 name           | text         |           | not null | 
 year_of_birth  | date         |           |          | 
 phone_num      | integer      |           |          | 
 average_points | numeric(2,1) |           |          | 
 highest_grade  | grade_type   |           |          | 
Indexes:
    "students_pkey" PRIMARY KEY, btree (id)
Check constraints:
    "students_average_points_check" CHECK (average_points >= 0.0 AND average_points <= 9.9)
```

Where `grade_type` is: 

```sql
CREATE TYPE grade_type as ENUM ('A', 'B', 'C', 'D', 'F');
```

Will the following code result in an error? Why or why not?

```sql
INSERT INTO students (name, year_of_birth, phone_num, average_points)
  VALUES ('Edd', '1990-01-02', 123123432, 0.8);
```







#
#

47. Consider the table below: 

```sql
CREATE TABLE students (
	id serial PRIMARY KEY,
	name varchar(100) NOT NULL,
  year_of_birth date,
  passed boolean DEFAULT true  
);
```

Write all possible ways to insert data into the table where the only data we have is the name 'John'. (take advantage of the DEFAULT value).






#
#

48. Imagine you have two tables below: 

```sql
table 'classes'
id |  name   
----+---------
  1 | math
  2 | german
  3 | physics
  4 | french

table 'students'

 id | name  | year_of_birth | 
----+-------+---------------+
  1 | Harry |  1987-02-04   |  
  2 | Ben   |  1976-11-13   | 
  3 | Marry |  1995-03-21   | 
  4 | John  |  1994-13-21   |  

table 'students-classes'

 id | class_id | student_id | 
----+----------+------------+
  1 |      1   |   1
  2 |      2   |   2
  3 |      3   |   3
  4 |      2   |   3

```

What will be the result if we run the following query:

```sql
SELECT students.name, classes.name 
  FROM students
  JOIN students_classes
    ON students_classes.students_id = students.id
    JOIN classes
      ON classes.id = students_classes.class_id;
```






#
#


49. This code is a result of running a `FULL OUTER JOIN` on three tables `students`, `students_classes` and `classes`:

```sql
 name  |  name   
-------+---------
 Harry | math
 Ben   | german
 Marry | physics
 Marry | german
 John  | 
       | french
(6 rows)
```

Here are the tables: 

```sql
table 'classes'
id |  name   
----+---------
  1 | math
  2 | german
  3 | physics
  4 | french

table 'students'

 id | name  | year_of_birth | 
----+-------+---------------+
  1 | Harry |  1987-02-04   |  
  2 | Ben   |  1976-11-13   | 
  3 | Marry |  1995-03-21   | 
  4 | John  |  1994-13-21   |  

table 'students-classes'

 id | class_id | student_id | 
----+----------+------------+
  1 |      1   |   1
  2 |      2   |   2
  3 |      3   |   3
  4 |      2   |   3
```

We know that each `JOIN` operation creates a transient table. How did the transient table from the first `JOIN` operation look?









#
#

50. Write a query that returns words concatenated into a single column: 
  - Johny
  - Likes
  - Mc
  - Donald's




#
#


51. Lets say you have a database dump file called `file_to_import.sql`. What are two ways you can import this file to your database?




#
#


52. Consider the output when loading database dump named `file_to_load.sql`. What does each line of the output mean? What statements would output such results? 

```sql
NOTICE:  table "students" does not exist, skipping
DROP TABLE
CREATE TABLE 
INSERT 0 1 
INSERT 0 1 
INSERT 0 1 
```




#
#


53. Assume there is a table `students`. We need to add the following columns to that table: 

- a column called `passed` and update all of the rows to `true`
- a column `updated` of `timestamp` data type and update it with `DEFAULT` value of current time.
- a column called `year_of_acceptance` and set it to `2021`.

Write two statements that do that. 






#
#


54. Consider the antiques table below: 

```sql
id |  item  | production_year
---------------------------
1  |  chair | 1802
---------------------------
2  |  book  | 1789
```

Write a query that will return a table with two columns: the name of the item and how old it is. The query should always be the same while the output should be changed every year. 




#
#


55. Create a table that looks like:

```sql
id |    name    |    year_of_birth    |    grade
-------------------------------------------------
1  |  'Eddie'   |   1986-01-01        |   A
2  |  'Maggie'  |   1975-04-11        |   B+
3  |  'Elenore' |   1995-03-13        |   A-
```

- next, change all the grades to be 'A+'
- add new record: ('Johny', '1987-07-23', 'C-', 'French')
- add a new column called `classes`
- add data to the column so that Eddie attends Math, Maggie attends Physics and Elenore attends History.
- remove the last record 
- Eddie is no longer participating in Math classes. He doesn't attend any classes. How would you reflect that in the table?
- We discovered that we have the wrong information about Elenore. Change her year of birth to '1994-03-13', grade to 'B' and class to 'Science'. 





#
#



56.  Consider the employees table below:

```sql
id | employees_name | salary | to_pay
-----------------------------------------
1  | Chris Rock     | 2000.00   | 2000.00
2  | Benny George   | 2500.00   | 2500.00
3  | Melissa Fu     | 3000.00   | 3000.00
```

- Everyone got a 10% raise. Write a query that reflects that.
- Now on top of that everyone got a bonus of 100. Write a query that reflects that. 





#
#

57. Consider the following error: 

```sql
ERROR:  new row for relation "students" violates check constraint "students_name_check"
DETAIL:  Failing row contains (, 1990-01-01, 'A+', '0989-22-22-12').
```

Describe why the error was thrown and what information does this error message give us:



#
#

58. How can we restrict what information is stored in a table while designing a schema? 





#
#


59. Consider the following students table:

```sql
id |    name    |    year_of_birth    |    grade
-------------------------------------------------
1  |  'Eddie'   |   1986-01-01        |   A
2  |  'Maggie'  |   1975-04-11        |   B+
3  |  'Eleanor' |   1995-03-13        |   A-
```
- Write a statement to remove the "Eleanor" record from the table.
- Write a statement to add a record with data as follows: ('John', '1994-08-09', 'A');
- What will be `id` number for the "John" record knowing that `id` is a data type `serial`? Why?




#
#


60. Create a table students that:
- `id` has an auto-incrementing integer column that provides the same constraints as PRIMARY KEY
- `name` of the student that can store text max 200 char
- `grade` storing 2 char string 

- Do not use `serial` in `id` column.
- Do not use `PRIMARY KEY` constraint.






#
#

61. Consider the code below:

```sql
SELECT name FROM users
  WHERE admin <> true OR admin IS NULL;
```

Will this code result in an error? 

What is the `<>` operator?





#
#


62. Consider the table below: 

```sql
CREATE TABLE school (
	id serial, 
	class_name varchar(100), 
	teacher_name vanrchar(300),
	teacher_contact_number int, 
	number_of_students int,
	average_grade int 
);
```

What are the problems with a table like this? 

How would you fix it?




#
#


63. Imagine you are hired to design a database for a school. The school board need to be able to get information such as (name, classes that they teach), students (name, classes they attend, and the grade for each class), and classes (name of the class, what teacher teaches it and what students attend the class). 

- Design an entity-relationship diagram using Crow Foot Notation (remember about modality and cardinality)
- Design a physical schema.
- Create a schema
- Insert some data into the schema
- Present how  your database can present the following information:
- all the classes and names of the teachers who teach those classes
- all the students with only 'A' grades
- all the classes that one of the students attend
- the average grade for each class
- the average grade for each student
- the average grade from all the subjects that a teacher teaches. 









#####
#####



