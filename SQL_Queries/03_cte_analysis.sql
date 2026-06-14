WITH customer_revenue AS (
   SELECT 
       customer_id,
	   SUM(total_amount) AS revenue
	   FROM orders
	   GROUP BY customer_id
)

SELECT *

FROm customer_revenue;


WITH customer_revenue AS (
    SELECT 
	   customer_id,
	   SUM(total_amount)
 AS revenue
FROM orders
GROUP BY customer_id
)  

SELECT * 
FROM customer_revenue
ORDER BY revenue DESC;


WITH customer_revenue AS (
   SELECT 
     customer_id, 
	 SUM(total_amount) AS revenue
   FROM orders
    GROUP BY customer_id
	)

SELECT *
FROM customer_revenue
WHERE revenue >
(
    SELECT AVG(revenue)
    FROM customer_revenue
);


