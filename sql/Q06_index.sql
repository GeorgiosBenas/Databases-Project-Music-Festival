USE db1;

EXPLAIN
SELECT 
    e.event_id,
    e.name AS event_name,
    f.name AS festival_name,
    f.festival_year,
    AVG(r.overall_score) AS avg_review_score
FROM Ticket t FORCE INDEX (idx_ticket_visitor_event)
JOIN Event e ON t.event_id = e.event_id
JOIN Festival f ON e.festival_id = f.festival_id
JOIN Review r FORCE INDEX (idx_review_ticket) ON r.ticket_id = t.ticket_id
WHERE t.visitor_id = 2
GROUP BY e.event_id, e.name, f.name, f.festival_year
ORDER BY f.festival_year DESC, f.name, e.name;
