SELECT 
   order_id,
   customer_id,
   total_amount,
   RANK() OVER (
       ORDER BY total_amount DESC
   ) AS sales_rank
   FROM orders;

SELECT 
    order_id,
	customer_id,
	total_amount,
	ROW_NUMBER() OVER (
        ORDER BY total_amount DESC
    ) AS row_num
FROM orders	;


SELECT
    order_id,
	customer_id,
	total_amount,
	DENSE_RANK() OVER (
        ORDER BY total_amount DESC
	) AS dense_rank
FROM orders;


SELECT 
    order_id,
	total_amount,
	SUM(total_amount) OVER (
        ORDER BY order_date
	) AS running_total
FROM orders;	


SELECT
   c.customer_namr,
   SUM(o.total_amount) AS revenue,
   RANK() OVER (
      ORDER BY SUM(o.total_amount) DESC
   ) AS customer_rank
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_namr;


