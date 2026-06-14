---Basic RFM Metrics

SELECt 
  c.customer_unique_id,

  MAX(o.order_purchase_timestamp) AS last_purchase_date,

  CURRENT_DATE -
  MAX(o.order_purchase_timestamp)::DATE AS recency_days,

  COUNT(DISTINCT o.order_id) AS frequency,

  ROUND(SUM(p.payment_value), 2) AS monetary

FROM customers_raw c
JOIN orders_raw o
On c.customer_id = o.customer_id
JOIN order_payments_raw p
ON o.order_id = p.order_id

GROUP BY c.customer_unique_id;

----Top Customers by Monetary Value--total spending
SELECt 
   c.customer_unique_id,
   COUNT(DISTINCT o.order_id) AS frequency,
   ROUND(SUM(p.payment_value),2) AS monetary
FROM customers_raw c
JOIN orders_raw o
On c.customer_id = o.customer_id
JOIN order_payments_raw p
ON o.order_id = p.order_id

GROUP BY c.customer_unique_id
ORDER BY monetary DESC
LIMIT 20;

----RFM Segmentation---
---Recency = days since last purchase
---Frequency = total orders
---Monetary = total spending

WITH rfm AS 
(
   SELECT 
         c.customer_unique_id,

		 current_DATE -
		 MAX(o.order_purchase_timestamp)::DATE As recency_days,

		 COUNT(DISTINCT o.order_id) AS frequency,

		 SUM(p.payment_value) AS monetary
	FROM customers_raw c	
	JOIN orders_raw o
	On c.customer_id = o.customer_id

	JOIN order_payments_raw p
	ON o.order_id = p.order_id

	GROUP BY c.customer_unique_id

	)

	SELECT 
	     customer_unique_id,
		 recency_days,
		 frequency,
		 ROUND(monetary,2),

		 CASE
		     WHEN monetary >= 1000 THEN 'High Value'
			 WHEN monetary >= 500 THEN 'Medium Value'
			 ELSE 'Low Volume'
			END AS customer_segment
	FROM rfm;		






