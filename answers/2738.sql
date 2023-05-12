SELECT c.name,
       round (((s.math * 2) + (s.specific * 3) + (s.project_plan*5)) / 10, 2) AS media
FROM candidate c
INNER JOIN score s ON s.candidate_id = c.id
ORDER BY media DESC