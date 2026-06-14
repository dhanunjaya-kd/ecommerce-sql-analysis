--Days Since Last Purchase

WITH customer_activity AS (
    SELECt 
	    c.customer_unique_id,
		MAX(o.order_purchase_timestamp)::DATE AS last_purchase_date,

		CURRENT_DATE -
		MAX(o.order_purchase_timestamp)::DATE AS days_since_last_purchase

FROM customers_raw c
JOIn orders_raw o
   ON c.customer_id = o.customer_id

GROUP BY c.customer_unique_id

)
SELECT *
FROM customer_activity;


----Churn Segmentation


WITH customer_activity AS (
    SELECt 
	    c.customer_unique_id,

		CURRENT_DATE -
		MAX(o.order_purchase_timestamp)::DATE AS days_since_last_purchase

FROM customers_raw c
JOIn orders_raw o
   ON c.customer_id = o.customer_id

GROUP BY c.customer_unique_id

)
SELECT

customer_unique_id,
days_since_last_purchase,

	CASE
	   WHEN days_since_last_purchase <=90
	   THEN 'Active'

	   WHEN days_since_last_purchase <=180
	   THEN 'At Risk'

	  ELSE 'Churned'
    
    END AS customer_status

FROM customer_activity;	


---Churn Summary

WITH customer_activity AS (
    SELECT
        c.customer_unique_id,

        CURRENT_DATE -
        MAX(o.order_purchase_timestamp)::DATE AS days_since_last_purchase

    FROM customers_raw c
    JOIN orders_raw o
        ON c.customer_id = o.customer_id

    GROUP BY c.customer_unique_id
),

customer_segments AS (
    SELECT
        CASE
            WHEN days_since_last_purchase <= 90
                THEN 'Active'

            WHEN days_since_last_purchase <= 180
                THEN 'At Risk'

            ELSE 'Churned'
        END AS customer_status

    FROM customer_activity
)

SELECT
    customer_status,
    COUNT(*) AS customers
FROM customer_segments
GROUP BY customer_status
ORDER BY customers DESC;