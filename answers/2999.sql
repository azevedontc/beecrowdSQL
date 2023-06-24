WITH salarios AS (
	SELECT
		venc_agrupados.matr,
		venc_agrupados.lotacao_div,
		ROUND(SUM(total_vencimentos) - COALESCE(SUM(total_descontos), 0), 2) AS salario
	FROM (

		SELECT
			empregado.matr,
			empregado.lotacao_div,
			COALESCE(SUM(vencimento.valor), 0) AS total_vencimentos
		FROM empregado
		LEFT JOIN emp_venc
			ON empregado.matr = emp_venc.matr
		LEFT JOIN vencimento
			ON emp_venc.cod_venc = vencimento.cod_venc
		GROUP BY empregado.matr, empregado.lotacao_div

	) AS venc_agrupados
	LEFT JOIN (

		SELECT
			empregado.matr,
			empregado.lotacao_div,
			COALESCE(SUM(desconto.valor), 0) AS total_descontos
		FROM empregado
		LEFT JOIN emp_desc
			ON empregado.matr = emp_desc.matr
		LEFT JOIN desconto
			ON emp_desc.cod_desc = desconto.cod_desc
		GROUP BY empregado.matr, empregado.lotacao_div

	) AS desc_agrupados
	ON venc_agrupados.matr = desc_agrupados.matr
	GROUP BY venc_agrupados.matr, venc_agrupados.lotacao_div
),
	media_salarial_div AS (

		SELECT
			lotacao_div,
			AVG(salario) as salario_medio
		FROM salarios
		GROUP BY lotacao_div
)

SELECT 
	empregado.nome,
	salarios.salario
FROM salarios
INNER JOIN media_salarial_div
	ON salarios.lotacao_div = media_salarial_div.lotacao_div
	AND salarios.salario > media_salarial_div.salario_medio
	AND salarios.salario > 8000 
INNER JOIN empregado
	ON salarios.matr = empregado.matr
ORDER BY salarios.lotacao_div
;