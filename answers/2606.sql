SELECT id, name
FROM products
WHERE id_categories IN (
    SELECT id 
    FROM categories
    WHERE name LIKE 'super%'
);