CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
	customer_namr VARCHAR(100),
	signup_date DATE
);

INSERT INTO Customers (customer_namr, signup_date)
VALUES
('Rahul', '2025-01-10'),
('Priya', '2025-02-15');

SELECT * FROM customers;

CREATE TABLE products (
    products_id SERIAL PRIMARY KEY,
	product_name VARCHAR(100),
	category VARCHAR(50),
	price NUMERIC(10,2)
);

INSERT INTO products (product_name, category, price)
VALUES
('IPhone 15', 'Mobile', 79999),
('OneplusNord', 'Mobile', 35000),
('Boat Headphone', 'Accessories', 5000),
('HP Laptop', 'Laptop', 45000),
('Logitech Mouse', 'Accessories', 999);
SELECT * FROM products;

CREATE TABLE orders(
    Order_id SERIAL PRIMARY KEY,
	customer_id INT,
	order_date DATE,
	total_amount NUMERIC(10,2)
);

INSERT INTO orders(customer_id, order_date, total_amount)
VALUES
(1, '2025-12-01', 79999),
(2, '2025-12-02', 35000),
(1, '2025-12-09', 5000),
(2, '2025-12-07', 45000);
SELECT * FROM orders;


SELECT 
    SUM(total_amount) AS total_sales
FROM orders;	

SELECT
    customer_id,
	SUM(total_amount) AS total_sales
FROM orders
GROUP BY customer_id;

SELECT 
    c.customer_namr,
	o.order_id,
	o.order_date,
	o.total_amount
From customers c
JOIN orders o
ON c.customer_id = o.customer_id;

SELECT
c.customer_namr,
SUM(o.total_amount) AS revenue
FROM customers c
JOIN orders o 
ON c.customer_id = o.customer_id
GROUP BY c.customer_namr;

