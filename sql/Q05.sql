USE db1;

SELECT 
  a.artist_id, 
  a.first_name, 
  a.last_name, 
  a.birth_date, 
  COUNT(DISTINCT f.festival_id) AS festival_appearances
FROM 
  Artist a 
JOIN 
  Performance p ON a.artist_id = p.artist_id 
JOIN 
  Event e ON p.event_id = e.event_id 
JOIN 
  Festival f ON e.festival_id = f.festival_id 
WHERE 
  TIMESTAMPDIFF(YEAR, a.birth_date, CURDATE()) < 30 
GROUP BY 
  a.artist_id 
ORDER BY 
  festival_appearances DESC 
LIMIT 5;