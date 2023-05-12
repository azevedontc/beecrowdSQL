SELECT lr.name, round (lr.omega * 1.618, 3) AS n
FROM dimensions d
INNER JOIN life_registry lr ON lr.dimensions_id = d.id
WHERE lr.name LIKE 'Richard%' AND d.name IN ('C875', 'C774')
ORDER BY lr.omega ASC