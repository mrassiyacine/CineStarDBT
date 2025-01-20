WITH rental_payment_data AS (
    SELECT 
        r.rental_id,
        DATE(r.rental_date) AS rental_date,
        DATE_PART('day', r.return_date - r.rental_date) AS rental_duration_days,
        r.customer_id,
        r.staff_id,
        i.film_id,
        i.store_id,
        p.amount
    FROM 
        {{ var("source_schema") }}.rental AS r
    JOIN 
        {{ var("source_schema") }}.inventory AS i 
        ON r.inventory_id = i.inventory_id
    JOIN 
        {{ var("source_schema") }}.payment AS p 
        ON r.rental_id = p.rental_id
)
SELECT 
    rental_id,
    rental_date,
    rental_duration_days AS rental_duration,
    customer_id,
    staff_id,
    film_id,
    store_id,
    amount
FROM 
    rental_payment_data
WHERE rental_id IN (
    SELECT rental_id
    FROM rental_payment_data
    GROUP BY rental_id
    HAVING COUNT(rental_id) = 1
)