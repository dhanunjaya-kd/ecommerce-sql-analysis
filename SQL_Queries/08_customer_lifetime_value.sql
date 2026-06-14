-----Basic CLV

SELECT 
  c.customer_unique_id,
  COUNT(DISTINCT o.order_id) AS total_orders,
  ROUND(SUM(p.payment_value),2) AS lifetime_value
FROM customers_raw c
JOIN orders_raw o
ON c.customer_id = o.customer_id
JOIN order_payments_raw p
ON o.order_id = p.order_id
GROUP BY c.customer_unique_id
ORDER BY lifetime_value DESC;

----Top 20 Customers by CLV

SELECT 
   c.customer_unique_id,
   COUNT(DISTINCT o.order_id) AS total_orders,
   ROUND(SUM(p.payment_value),2) AS lifetime_value
FROM customers_raw c
JOIN orders_raw o
ON c.customer_id = o.customer_id
JOIN order_payments_raw p
ON o.order_id = p.order_id
GROUP BY c.customer_unique_id
ORDER BY lifetime_value DESC
LIMIT 20;

------Average CLV

WITH customer_clv AS
(
SELECT 
    c.customer_unique_id,
	SUM(p.payment_value) AS lifetime_value
FROM customers_raw c
JOIN orders_raw o
On c.customer_id = o.customer_id
JOIN order_payments_raw p
on o.order_id = p.order_id
GROUP BY c.customer_unique_id
)
SELECt 
  ROUND(AVG(lifetime_value),2) as avg_clv
FROM customer_clv;

----CLV Segmentation

WITH customer_clv AS
(
SELECT 
    c.customer_unique_id,
	SUM(p.payment_value) AS lifetime_value
FROM customers_raw c
JOIN orders_raw o
On c.customer_id = o.customer_id
JOIN order_payments_raw p
on o.order_id = p.order_id
GROUP BY c.customer_unique_id
)
SELECT 
    customer_unique_id,
	lifetime_value,
	CASE
	    WHEN lifetime_value >= 1000 THEN 'High Value'
		WHEN lifetime_value >= 500 THEN 'Medium Value'
		ELSE 'Low Value'
	END As customer_segment
FROM customer_clv;	













