-- 1. Adding a PRIMARY KEY Constraint

-- Suppose you have a table students with columns id, name, and age. Write an SQL statement to add a PRIMARY KEY constraint to the id column.

ALTER TABLE students ADD PRIMARY KEY (id);

-- 2. Removing a PRIMARY KEY Constraint

-- Write an SQL statement to remove the PRIMARY KEY constraint from the id column in the students table.

ALTER TABLE students DROP CONSTRAINT id_pkey;

-- 3. Adding a FOREIGN KEY Constraint

-- You have a table orders with a column customer_id. Write an SQL statement to add a FOREIGN KEY constraint to customer_id that references a customers table with a PRIMARY KEY of id.


ALTER TABLE orders ADD FOREIGN KEY (customer_id) REFERENCES customers (id);


-- 4. Removing a FOREIGN KEY Constraint

-- Write an SQL statement to remove the FOREIGN KEY constraint from the customer_id column in the orders table.

ALTER TABLE orders DROP CONSTRAINT customer_id_fkey;

-- 5. Adding a UNIQUE Constraint

-- You have a table employees with a column email. Write an SQL statement to ensure that the email addresses are unique across all employees.

ALTER TABLE employees ADD UNIQUE (email);

-- 6. Removing a UNIQUE Constraint



-- Write an SQL statement to remove the UNIQUE constraint from the email column in the employees table.

ALTER TABLE employees DROP CONSTRAINT uniq_email;

-- 7. Adding a NOT NULL Constraint

-- You have a table books with a column title. Write an SQL statement to ensure that the title column cannot have NULL values.

ALTER TABLE books ALTER COLUMN title SET NOT NULL;
-- 8. Adding a CHECK Constraint

-- You have a table products with a column price. Write an SQL statement to ensure that the price is always greater than 0.

ALTER TABLE products ADD CHECK (price > 0);

-- 9. Adding a DEFAULT Constraint

-- You have a table tasks with a column status. Write an SQL statement to set the default value of the status column to 'Pending'.

ALTER TABLE tasks ALTER COLUMN status SET DEFAULT 'pending';

-- 10. Tricky Question: Multiple Constraints

-- You have a table inventory with columns item_id and quantity. Write an SQL statement to add both a PRIMARY KEY constraint to item_id and a CHECK constraint to quantity to ensure it is never negative.

ALTER TABLE inventory 
  ADD PRIMARY KEY (item_id),
  ADD CHECK (quantity >= 0);