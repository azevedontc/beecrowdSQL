SELECT prod.name
FROM products prod
INNER JOIN providers prov ON prov.id = prod.id_providers
WHERE prod.amount BETWEEN 10 AND 20
      AND prov.name LIKE 'P%'