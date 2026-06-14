--Monthly Revenue Trend

SELECT 
    DATE_TRUNC('month', o.order_purchase_timestamp) AS month,
	ROUND(SUM(p.payment_value),2) AS revenue
FROM orders_raw o
JOIN order_payments_raw p
ON o.order_id = p.order_id
GROUP BY month
ORDER BY month;

-----Top 10 Customers by Revenue

SELECT 
    c.customer_unique_id,
	ROUND(SUM(p.payment_value),2) AS revenue
FROM customers_raw c
JOIN orders_raw o
ON c.customer_id = o.customer_id
JOIN order_payments_raw p
On o.order_id = p.order_id
GROUP BY c.customer_unique_id
ORDER by  revenue DESC
LIMIT 10;


---Top Product Categories

SELECT
    pr.product_category_name,
	COUNT(*) AS total_items_sold
FROM order_items_raw oi
JOIN products_raw pr
ON oi.product_id = pr.product_id
GROUP BY pr.product_category_name
ORDER BY total_items_sold DESC
LIMIT 10;

---Revenue by Payment Type

SELECT 
    pr.product_category_name,
	COUNT(*) AS total_items_sold
FROM order_items_raw oi
JOIN products_raw pr
ON oi.product_id = pr.product_id
GROUP BY pr.product_category_name
ORDER BY total_items_sold DESC
limit 10;