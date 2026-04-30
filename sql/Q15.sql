USE db1;

SELECT v.first_name AS visitor_first_name, 
v.last_name AS visitor_last_name, 
a.first_name AS artist_first_name, 
a.last_name AS artist_last_name, 
SUM(r.overall_score) AS total_score 
FROM Review r 
JOIN Ticket t ON r.ticket_id = t.ticket_id 
JOIN Visitor v ON t.visitor_id = v.visitor_id 
JOIN Event e ON t.event_id = e.event_id 
JOIN Performance p ON e.event_id = p.event_id 
JOIN Artist a ON p.artist_id = a.artist_id 
WHERE r.overall_score IS NOT NULL 
GROUP BY v.visitor_id, a.artist_id 
ORDER BY total_score DESC LIMIT 5; 