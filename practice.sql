-- CREATE TABLE menu_items (
--   item varchar(30), 
--   prep_time integer CHECK (prep_time < 60), 
--   ingredient_cost decimal(5, 2), 
--   sales integer, 
--   menu_price decimal(5, 2)
-- );

-- INSERT INTO menu_items 
--   (item, prep_time, ingredient_cost, sales, menu_price)
-- VALUES 
--   ('omelette', 10, 1.50, 182, 7.99), 
--   ('tacos', 5, 2.00, 254, 8.99), 
--   ('oatmeal', 1, 0.50, 79, 5.99); 

SELECT DISTINCT substr(email, (strpos(email, '@') + 1)) AS domain, 
                COUNT(id) AS number_of_people
FROM people
GROUP BY domain
ORDER BY number_of_people DESC;