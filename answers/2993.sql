SELECT
    amount AS most_frequent_value
FROM
    value_table
GROUP BY
    amount
ORDER BY
    (COUNT(amount)) DESC
LIMIT 1