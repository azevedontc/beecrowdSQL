WITH RankedCities AS (
    SELECT 
        city_name, 
        population,
        ROW_NUMBER() OVER (ORDER BY population DESC) AS PopRankDesc,
        ROW_NUMBER() OVER (ORDER BY population ASC) AS PopRankAsc
    FROM cities
)

SELECT city_name, population
FROM RankedCities
WHERE PopRankDesc = 2

UNION ALL

SELECT city_name, population
FROM RankedCities
WHERE PopRankAsc = 2;
