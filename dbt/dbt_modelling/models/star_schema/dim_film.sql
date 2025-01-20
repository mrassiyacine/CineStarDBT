WITH film_data AS (
    SELECT 
        f.film_id,
        f.title,
        f.release_year,
        f.rental_duration,
        f.rating,
        c.name AS category
    FROM 
        {{ var("source_schema") }}.film AS f
    JOIN 
        {{ var("source_schema") }}.film_category AS fc 
        ON f.film_id = fc.film_id
    JOIN 
        {{ var("source_schema") }}.category AS c 
        ON c.category_id = fc.category_id
)

SELECT 
    film_id,
    title,
    release_year,
    rental_duration,
    rating,
    category
FROM 
    film_data