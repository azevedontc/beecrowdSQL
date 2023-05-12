SELECT c.name,
       o.id
FROM customers c
INNER JOIN orders o ON o.id_customers = c.id
WHERE extract(YEAR FROM orders_date) = 2016  AND extract(MONTH FROM orders_date) IN (1,2,3,4,5,6)