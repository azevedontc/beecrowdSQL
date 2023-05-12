SELECT
    d.name,
    SUM(ROUND(((150*a.hours)*(1+(w.bonus/100))), 1)) AS salary
FROM
    attendances a
        INNER JOIN doctors d ON a.id_doctor = d.id
        INNER JOIN work_shifts w ON a.id_work_shift = w.id
GROUP BY
    d.name
ORDER BY
    salary DESC