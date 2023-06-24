SELECT
		departamento.nome AS departamento,
		divisao.nome AS divisao,
		ROUND(AVG(salarios.salario), 2) AS media,
		ROUND(MAX(salarios.salario), 2) AS maior
	FROM (
		SELECT
		venc_agrupados.lotacao,
		venc_agrupados.lotacao_div,
		ROUND(SUM(total_vencimentos) - COALESCE(SUM(total_descontos), 0), 2) AS salario
		FROM (

			SELECT
				empregado.matr,
				empregado.lotacao,
				empregado.lotacao_div,
				COALESCE(SUM(vencimento.valor), 0) AS total_vencimentos
			FROM empregado
			LEFT JOIN emp_venc
				ON empregado.matr = emp_venc.matr
			LEFT JOIN vencimento
				ON emp_venc.cod_venc = vencimento.cod_venc
			GROUP BY empregado.matr, empregado.lotacao, empregado.lotacao_div

			) AS venc_agrupados

			LEFT JOIN (

				SELECT
					empregado.matr,
					empregado.lotacao,
					empregado.lotacao_div,
					COALESCE(SUM(desconto.valor), 0) AS total_descontos
				FROM empregado
				LEFT JOIN emp_desc
					ON empregado.matr = emp_desc.matr
				LEFT JOIN desconto
					ON emp_desc.cod_desc = desconto.cod_desc
				GROUP BY empregado.matr, empregado.lotacao, empregado.lotacao_div

			) AS desc_agrupados
				ON venc_agrupados.matr = desc_agrupados.matr
		GROUP BY venc_agrupados.matr, venc_agrupados.lotacao, venc_agrupados.lotacao_div
	) AS salarios
	INNER JOIN departamento
		ON salarios.lotacao = departamento.cod_dep
	INNER JOIN divisao
		ON salarios.lotacao_div = divisao.cod_divisao
	GROUP BY divisao.nome, departamento.nome
	ORDER BY media DESC