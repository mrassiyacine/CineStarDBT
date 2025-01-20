WITH store_data AS (
    SELECT 
        s.store_id,
        ci.city,
        co.country
    FROM 
        {{ var("source_schema") }}.store AS s
    JOIN 
        {{ var("source_schema") }}.address AS a 
        ON s.address_id = a.address_id
    JOIN 
        {{ var("source_schema") }}.city AS ci 
        ON a.city_id = ci.city_id
    JOIN 
        {{ var("source_schema") }}.country AS co 
        ON ci.country_id = co.country_id
)

SELECT 
    store_id,
    city,
    country
FROM 
    store_data