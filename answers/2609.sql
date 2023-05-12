SELECT c.name, SUM(p.amount) AS sum
FROM products p
JOIN categories c ON p.id_categories = c.id
GROUP BY c.name;