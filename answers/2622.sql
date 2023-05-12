SELECT cus.name
FROM legal_person lp
LEFT JOIN customers cus ON cus.id = lp.id_customers 