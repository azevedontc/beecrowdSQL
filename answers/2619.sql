SELECT products.name, providers.name, products.price
FROM products, providers, categories
WHERE products.id_providers = providers.id
AND products.id_categories = categories.id
AND categories.name LIKE 'Super Luxury' 
AND price > 1000;