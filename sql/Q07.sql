USE db1;

SELECT 
    f.name AS festival_name,
    f.festival_year,
    AVG(el.degree) AS avg_experience_level
FROM 
    Employment emp
JOIN Staff s ON emp.staff_id = s.staff_id
JOIN Experience_Level el ON s.experience_level_id = el.experience_level_id
JOIN Event e ON emp.event_id = e.event_id
JOIN Festival f ON e.festival_id = f.festival_id
GROUP BY f.festival_id
ORDER BY avg_experience_level ASC
LIMIT 1;