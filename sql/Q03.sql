USE db1;

SELECT 
    a.artist_id,
    a.first_name,
    a.last_name,
    f.festival_id,
    f.name AS festival_name,
    f.festival_year,
    COUNT(*)
 AS warm_up_appearances
FROM 
    Artist a
JOIN 
    Performance p ON a.artist_id = p.artist_id
JOIN 
    Performance_Type pt ON p.type_id = pt.type_id
JOIN 
    Event e ON p.event_id = e.event_id
JOIN 
    Festival f ON e.festival_id = f.festival_id
WHERE 
    pt.name = 'warm-up'
GROUP BY 
    a.artist_id, f.festival_id, f.name, f.festival_year
HAVING 
    warm_up_appearances > 2
ORDER BY 
    f.festival_year DESC, f.name, a.last_name, a.first_name;