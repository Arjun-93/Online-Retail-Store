-- SQLBook: Code
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


-- -- 1. show table
-- SELECT * FROM Customer;
-- SELECT * FROM product;
-- SELECT * FROM Supplier;
-- SELECT * FROM Category;
-- SELECT * FROM Account;
-- SELECT * FROM Employee;
-- SELECT * FROM Orders;

-- SELECT product_id FROM chooses WHERE customer_id = 1;


-- -- 2. add entries in table
-- insert into Customer (Customer_ID, customer_name, DOB, Gender, customer_address, phone_no, customer_email) values (101, 'Sarthak Kumar', '2002-04-09', 'Male', 'IIITD', '101-387-5766', 'sarthak20241@iiitd.ac.in');


-- 3. delete entries in table
DELETE FROM customer WHERE Customer_ID = 15;
DELETE FROM product WHERE P_id = 10;


-- 4. update entries in table

-- Update the email address of a customer and name of a customer whose customer_id is 1:
UPDATE customer SET customer_email = 'sarthak20241@iiitd.ac.in' WHERE customer_id = 1;
UPDATE customer SET customer_name = 'Sarthak' WHERE customer_id = 1;

-- Update the price of all products in the "Toys" category to be 10% higher:
UPDATE Products SET Price = Price * 1.1 WHERE Category = 'Toys';


-- 5. select entries in table
-- Find the product name and price of the most expensive product.
SELECT Pname, Price
FROM product
WHERE Price = (
    SELECT MAX(p.Price)
    FROM product p
);


-- Find the product name and price of the cheapest product.
SELECT Pname, Price
FROM product
WHERE Price = (
    SELECT MIN(p.Price)
    FROM product p
);


-- Show the total price of an order by a specific customer:
SELECT SUM(Price) FROM product 
WHERE P_id IN (SELECT product_id FROM has WHERE Customer_ID = 1);

-- Retrieve the names and email addresses of all customers who have a rating of 5 in the "Feedback" forum:
SELECT customer_name, customer_email
FROM Customer
JOIN has_rating ON Customer.Customer_ID = has_rating.Customer_ID
WHERE has_rating.forum = 'Feedback' AND has_rating.rating = 5;


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
JOIN orders o ON c.Cid = o.customer_id
JOIN product p ON o.product_id = p.product_id
WHERE p.price > 100 AND o.quantity > 5


-- This query retrieves all customer names such that for every product, the customer has ordered that product at least once. We achieve this by using the division operator, which finds all customers who have ordered every product in the database.
SELECT DISTINCT c.customer_name
FROM Customer c
WHERE NOT EXISTS (
    SELECT p.Pname
    FROM product p
    WHERE NOT EXISTS (
        SELECT o.O_id
        FROM Orders o
        WHERE o.product_id = p.product_id
        AND o.Customer_ID = c.Customer_ID
    )
);

-- Retrieve the names of all products and their prices, sorted by price in descending order:/
SELECT Pname, Price
FROM product
ORDER BY Price DESC;

-- Retrieve the names of all customers who have made an order:
SELECT DISTINCT customer_name
FROM Customer
JOIN has_order ON Customer.Customer_ID = has_order.Customer_ID;

-- Retrieve the names of all products in a specific category:
SELECT Pname
FROM product
JOIN chooses ON product.P_id = chooses.product_id
WHERE chooses.category_id = 2;




