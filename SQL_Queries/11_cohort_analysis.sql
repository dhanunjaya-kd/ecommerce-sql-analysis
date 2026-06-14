--Customer First Purchase Month

WITH customer_cohort AS (
   SELECT 
       c.customer_unique_id,
	   DATE_TRUNC('month',
           MIN(o.order_purchase_timestamp)
		   ) AS cohort_mont
		   FROM customers_raw c
		   JOIN orders_raw o
		      ON c.customer_id = o.customer_id
			  GROUP BY c.customer_unique_id
)

SELECT *
FROM customer_cohort;

--------Cohort Size

WITH customer_cohort AS(
   SELECT 
       c.customer_unique_id,
	   DATE_TRUNC('month',
	   MIN(o.order_purchase_timestamp)
	   ) AS cohort_month
   FROM customers_raw c
   JOIN orders_raw o
      ON c.customer_id = o.customer_id
	  GROUP BY c.customer_unique_id   
)

SELECT
     cohort_month,
	 COUNT(*) AS customers
FROM customer_cohort
GROUP BY cohort_month
ORDER BY cohort_month;


----Cohort Retention
WITH customer_cohort AS (
   SELECT 
       c.customer_unique_id,

	   DATE_TRUNC(
          'month',
		     MIN(o.order_purchase_timestamp)
			 ) AS cohort_month
	FROM customers_raw c
	JOIN orders_raw o
	   ON c.customer_id = o.customer_id

	   GROUP BY c.customer_unique_id
   ),

   customer_orders AS (
       SELECT
	       c.customer_unique_id,

		   DATE_TRUNC(
            'month',
			   o.order_purchase_timestamp
		   ) AS order_month

		FROM customers_raw c
		JOIN orders_raw o
		   ON c.customer_id = o.customer_id
   )
   SELECT 
        cc.cohort_month,
		co.order_month,
		COUNT(DISTINCT cc.customer_unique_id)
		     AS retained_customers
	FROM customer_cohort cc
	JOIN customer_orders co
	    ON cc.customer_unique_id =
		    co.customer_unique_id
	GROUP BY
	     cc.cohort_month,
		 co.order_month

	ORDER BY 
	     cc.cohort_month,
		 co.order_month;