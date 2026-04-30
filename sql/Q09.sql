USE db1;

WITH EventsPerVisitor AS (
    SELECT 
        t.visitor_id,
        YEAR(e.date_time) AS event_year,
        COUNT(DISTINCT t.event_id) AS total_events
    FROM 
        Ticket t
    JOIN 
        Event e ON t.event_id = e.event_id
    GROUP BY 
        t.visitor_id, event_year
    HAVING 
        total_events > 3
),
MatchingVisitors AS (
    SELECT 
        a.visitor_id AS visitor1_id,
        b.visitor_id AS visitor2_id,
        a.event_year,
        a.total_events
    FROM 
        EventsPerVisitor a
    JOIN 
        EventsPerVisitor b 
        ON a.total_events = b.total_events 
           AND a.event_year = b.event_year 
           AND a.visitor_id < b.visitor_id
)
SELECT 
    mv.event_year,
    mv.total_events,
    v1.first_name AS visitor1_first_name,
    v1.last_name AS visitor1_last_name,
    v2.first_name AS visitor2_first_name,
    v2.last_name AS visitor2_last_name
FROM 
    MatchingVisitors mv
JOIN 
    Visitor v1 ON mv.visitor1_id = v1.visitor_id
JOIN 
    Visitor v2 ON mv.visitor2_id = v2.visitor_id
ORDER BY 
    mv.event_year, mv.total_events DESC;
