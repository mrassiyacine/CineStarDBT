WITH rental_counts AS (
    SELECT
        customer_id,
        COUNT(rental_id) AS rental_count
    FROM {{ ref('fact_rentals') }}
    GROUP BY customer_id
)

SELECT
    CASE
        WHEN rental_count >= 10 THEN 'Frequent Renters'
        ELSE 'Occasional Renters'
    END AS segment,
    COUNT(*) AS customer_count
FROM rental_counts
GROUP BY segment