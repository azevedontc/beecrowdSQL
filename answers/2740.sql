(SELECT 'Podium: ' || team FROM league ORDER BY position LIMIT 3)
UNION ALL
(WITH t AS (SELECT * FROM league ORDER BY position DESC LIMIT 2)
  SELECT 'Demoted: '|| team FROM t ORDER BY position ASC);