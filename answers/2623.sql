SELECT prod.name,
       cat.name
FROM products prod
INNER JOIN categories cat ON cat.id = prod.id_categories
WHERE prod.amount > 100
      AND prod.id_categories IN (1,2,3,6,9)