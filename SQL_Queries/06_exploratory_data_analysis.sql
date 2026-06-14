----Total Orders---

SELECT COUNT(*) AS total_orders
FROM ORDERS_raw;

-- Total Customers--
SELECT COUNT(DISTINCT customer_unique_id) AS total_customers
FROM customers_raw;

--Order Status Distribution
SELECT 
   order_status,
   COUNT(*) AS total_orders
FROM orders_raw
GROUP BY order_status
ORDER BY total_orders DESC;


---Revenue--

SELECT 
    ROUND(SUM(payment_value),2) AS total_revenue
FROM order_payments_raw;	


--Average Order Value

SELECT 
      ROUND(AVG(payment_value),2) AS total_revenue
FROM order_payments_raw;	  
