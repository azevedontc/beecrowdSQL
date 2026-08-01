SELECT
    nome_cidade,
    regiao,
    qtd_pontos,
    ROUND(media_avaliacoes, 2) AS media_avaliacoes,
    RANK() OVER (
        PARTITION BY regiao
        ORDER BY media_avaliacoes DESC
    ) AS ranking_regional
FROM (
    SELECT
        c.nome_cidade,
        c.regiao,
        COUNT(DISTINCT p.ponto_id) AS qtd_pontos,
        AVG(a.nota) AS media_avaliacoes
    FROM Cidades c
    JOIN PontosTuristicos p
        ON c.cidade_id = p.cidade_id
    LEFT JOIN Avaliacoes a
        ON p.ponto_id = a.ponto_id
    GROUP BY
        c.cidade_id,
        c.nome_cidade,
        c.regiao
    HAVING COUNT(DISTINCT p.ponto_id) >= 2
) AS t
ORDER BY
    regiao,
    ranking_regional;