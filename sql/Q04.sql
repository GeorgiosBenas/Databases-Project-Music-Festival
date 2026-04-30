USE db1;


SELECT 
    a.artist_id, 
    a.first_name, 
    a.last_name, 
    AVG(r.performance_score) AS avg_performance_score, 
    AVG(r.overall_score) AS avg_overall_score
FROM Artist a
JOIN Performance p ON a.artist_id = p.artist_id
JOIN Ticket t ON p.event_id = t.event_id AND t.visitor_id IS NOT NULL
JOIN Review r ON r.ticket_id = t.ticket_id
WHERE a.artist_id = 1
GROUP BY a.artist_id, a.first_name, a.last_name
ORDER BY a.last_name, a.first_name;

