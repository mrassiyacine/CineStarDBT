WITH rental_duration_ranges AS (
    SELECT
        CASE
            WHEN rental_duration <= 3 THEN '1-3 Days'
            WHEN rental_duration <= 7 THEN '4-7 Days'
            ELSE '7+ Days'
        END AS duration_range,
        COUNT(*) AS rental_count
    FROM {{ ref('fact_rentals') }}
    GROUP BY duration_range
)

SELECT
    duration_range,
    rental_count
FROM rental_duration_ranges
ORDER BY rental_count DESC