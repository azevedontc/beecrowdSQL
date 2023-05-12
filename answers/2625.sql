SELECT regexp_replace(np.cpf, '(\d{3})(\d{3})(\d{3})', '\1.\2.\3-')
FROM natural_person np
LEFT JOIN customers cus ON cus.id = np.id_customers