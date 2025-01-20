WITH customer_data AS (
    SELECT 
        c.customer_id,
        c.first_name || ' ' || c.last_name AS full_name,
        c.email,
        ci.city,
        co.country
    FROM 
        {{ var("source_schema") }}.customer AS c
    JOIN 
        {{ var("source_schema") }}.address AS a 
        ON c.address_id = a.address_id
    JOIN 
        {{ var("source_schema") }}.city AS ci 
        ON a.city_id = ci.city_id
    JOIN 
        {{ var("source_schema") }}.country AS co 
        ON ci.country_id = co.country_id
)

SELECT 
    customer_id,
    full_name,
    email,
    city,
    country
FROM 
    customer_data