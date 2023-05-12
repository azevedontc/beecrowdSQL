SELECT customers.id, customers.name
FROM customers
WHERE customers.id NOT IN (SELECT id_customers FROM locations)
ORDER BY customers.id ASC