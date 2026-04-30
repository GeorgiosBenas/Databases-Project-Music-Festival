USE db1;

WITH genre_year_counts 
AS (SELECT a.genre, 
YEAR(e.date_time) AS year, 
COUNT(*) AS appearances 
FROM Artist a 
JOIN Performance p ON a.artist_id = p.artist_id 
JOIN Event e ON p.event_id = e.event_id 
WHERE a.genre IS NOT NULL 
GROUP BY a.genre, 
YEAR(e.date_time) 
HAVING COUNT(*) >= 3)
SELECT g1.genre, 
g1.year AS year1, 
g2.year AS year2, 
g1.appearances 
FROM genre_year_counts g1 
JOIN genre_year_counts g2 ON g1.genre = g2.genre 
AND g1.year + 1 = g2.year 
AND g1.appearances = g2.appearances 
ORDER BY g1.genre, g1.year;