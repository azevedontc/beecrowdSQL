WITH cumulative_profit AS (
SELECT
c.name,
c.investment,
o.month,
SUM(o.profit) OVER (PARTITION BY o.client_id ORDER BY o.month) AS cumulative_profit
FROM
clients c
JOIN operations o ON c.id = o.client_id
),
payback AS (
SELECT
name,
investment,
MIN(month) AS payback_month,
MIN(cumulative_profit) - investment AS payback_value
FROM
cumulative_profit
WHERE
cumulative_profit >= investment
GROUP BY
name,
investment
)
SELECT *
FROM payback
ORDER BY payback_value DESC;