USE db1;

SELECT 
    s.staff_id, 
    s.first_name, 
    s.last_name, 
    s.role_id
FROM 
    Staff s
WHERE 
    s.staff_id NOT IN (
        SELECT emp.staff_id
        FROM Employment emp
        JOIN Event e ON emp.event_id = e.event_id
        WHERE DATE(e.date_time) = '2026-12-01'
    );
