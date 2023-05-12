SELECT emp.cpf, emp.enome, dep.dnome
FROM empregados emp
INNER JOIN departamentos dep ON emp.dnumero = dep.dnumero 
LEFT JOIN trabalha t ON emp.cpf = t.cpf_emp 
WHERE t.pnumero IS NULL 
ORDER BY emp.cpf