USE db1;

SELECT 
    a.artist_id, 
    a.first_name, 
    a.last_name, 
    a.genre,
    CASE 
        WHEN EXISTS (
            SELECT 1
            FROM Performance p
            JOIN Event e ON p.event_id = e.event_id
            JOIN Festival f ON e.festival_id = f.festival_id
            WHERE p.artist_id = a.artist_id AND f.festival_year = 2025
        ) THEN 'YES'
        ELSE 'NO'
    END AS festival_participation
FROM Artist a
WHERE a.genre = 'rock'
ORDER BY a.last_name, a.first_name;
