WITH staff_data AS (
    SELECT 
        s.staff_id,
        s.first_name || ' ' || s.last_name AS full_name,
        s.email
    FROM 
        {{ var("source_schema") }}.staff AS s
)

SELECT 
    staff_id,
    full_name,
    email
FROM 
    staff_data