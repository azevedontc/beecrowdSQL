SELECT NAME,
    CASE WHEN TYPE = 'A' then 20.0
    WHEN TYPE = 'B' then 70.0 
    WHEN TYPE = 'C' then 530.5
    END AS price
FROM products
ORDER BY TYPE, id DESC