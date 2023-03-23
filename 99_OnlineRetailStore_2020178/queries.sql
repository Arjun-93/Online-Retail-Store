-- show table 
-- add entries in table 
-- delete entries in table
-- update entries in table
-- select entries in table
-- select entries in table with condition
-- select entries in table with condition and order by

-- relational queries
-- join queries
-- aggregate queries
-- nested queries
-- subqueries
-- set operations
-- group by
-- having
-- with clause
-- create view


-- 1. show table
SELECT * FROM Customer;
SELECT * FROM product;
SELECT * FROM Supplier;
SELECT product_id FROM chooses WHERE customer_id = 1;


-- 2. add entries in table
INSERT INTO Customer (Customer_ID, Customer_Name, Customer_Address, Customer_Phone, Customer_Email) VALUES (1, 'John', '123 Main St', '123-456-7890')

-- 3. delete entries in table
DELETE FROM customer WHERE Customer_ID = 15;
DELETE FROM product WHERE product_id = 10;


-- 4. update entries in table

-- Update the email address of a customer and name of a customer whose customer_id is 1:
UPDATE customer SET customer_email = 'sarthak20241@iiitd.ac.in' WHERE customer_id = 1;
UPDATE cutomer SET customer_name = 'Sarthak' WHERE customer_id = 1;

-- Update the price of all products in the "Toys" category to be 10% higher:
UPDATE Products
SET Price = Price * 1.1
WHERE Category = 'Toys'


-- 5. select entries in table
-- Find the product name and price of the most expensive product.
SELECT product_name, price
FROM product
WHERE price = (
    SELECT MAX(price)
    FROM product
)

-- Find the product name and price of the cheapest product.
SELECT product_name, price
FROM product
WHERE price = (
    SELECT MIN(price)
    FROM product
)

-- Show the total price of an order by a specific customer:
SELECT SUM(Price) FROM product 
WHERE P_id IN (SELECT product_id FROM has WHERE Customer_ID = 1);


-- Show all the products and their corresponding categories
SELECT Pname, Category_Name FROM product 
INNER JOIN has_product ON product.P_id = has_product.product_id 
INNER JOIN has_category ON has_product.Supplier_ID = has_category.Supplier_ID AND has_product.category_id = has_category.category_id 
INNER JOIN Category ON has_category.category_id = Category.Cid;


-- Show the employees and their corresponding resolved customer service issues:
SELECT Ename, forum FROM Employee 
INNER JOIN resolve ON Employee.Employee_ID = resolve.Employee_ID;


-- Find the names of all customers who have placed an order for a product with a price greater than Rs 100 and a quantity greater than 5.
SELECT DISTINCT c.name
FROM customer c
JOIN orders o ON c.customer_id = o.customer_id
JOIN product p ON o.product_id = p.product_id
WHERE p.price > 100 AND o.quantity > 5


-- This query retrieves all customer names such that for every product, the customer has ordered that product at least once. We achieve this by using the division operator, which finds all customers who have ordered every product in the database.
SELECT DISTINCT c.customer_name
FROM customers c
WHERE NOT EXISTS (
    SELECT p.product_name
    FROM products p
    WHERE NOT EXISTS (
        SELECT o.order_id
        FROM orders o
        WHERE o.product_id = p.product_id
        AND o.customer_id = c.customer_id
    )
);
























