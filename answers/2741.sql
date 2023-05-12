SELECT concat ('Approved:',' ', NAME), grade
FROM students
WHERE grade > 6
ORDER BY grade DESC