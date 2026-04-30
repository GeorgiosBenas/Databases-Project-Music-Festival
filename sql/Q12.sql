USE db1;

SELECT 
    f.name AS festival_name,
    DATE(e.date_time) AS event_date,
    sr.name AS staff_role,

    CASE 
        WHEN LOWER(sr.name) = 'security' THEN CEIL(SUM(st.capacity) * 0.05)
        WHEN LOWER(sr.name) = 'support'  THEN CEIL(SUM(st.capacity) * 0.02)
        ELSE NULL
    END AS required_staff

FROM 
    Staff s
JOIN Employment emp ON s.staff_id = emp.staff_id
JOIN Event e ON emp.event_id = e.event_id
JOIN Festival f ON e.festival_id = f.festival_id
JOIN Staff_Role sr ON s.role_id = sr.role_id
JOIN Stage st ON e.stage_id = st.stage_id

WHERE LOWER(sr.name) IN ('security', 'support')

GROUP BY 
    f.name, DATE(e.date_time), sr.name
ORDER BY 
    event_date ASC, staff_role;
