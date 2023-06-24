WITH media_salarial_por_divisao AS (

	SELECT
		salarios.lotacao,
		salarios.lotacao_div,
		ROUND(AVG(salarios.salario), 2) AS media
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
	GROUP BY salarios.lotacao, salarios.lotacao_div
	
)

SELECT
	departamento.nome AS departamento,
	divisao.nome AS divisao,
	media_salarial_por_divisao.media AS media
FROM media_salarial_por_divisao
INNER JOIN departamento
	ON media_salarial_por_divisao.lotacao = departamento.cod_dep
INNER JOIN divisao
	ON media_salarial_por_divisao.lotacao_div = divisao.cod_divisao
WHERE media IN (SELECT MAX(media) OVER (PARTITION BY lotacao) FROM media_salarial_por_divisao)
ORDER BY media DESC
;