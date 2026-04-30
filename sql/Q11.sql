USE db1;

SELECT a.artist_id, a.first_name, a.last_name, COUNT(DISTINCT e.festival_id) AS festival_participations 
FROM Artist a JOIN Performance p ON a.artist_id = p.artist_id 
JOIN Event e ON p.event_id = e.event_id 
GROUP BY a.artist_id, a.first_name, a.last_name 
HAVING festival_participations <= (SELECT MAX(festival_count) - 5 FROM (SELECT COUNT(DISTINCT e2.festival_id) AS festival_count FROM Artist a2 JOIN Performance p2 ON a2.artist_id = p2.artist_id JOIN Event e2 ON p2.event_id = e2.event_id GROUP BY a2.artist_id) AS sub) ORDER BY festival_participations DESC;