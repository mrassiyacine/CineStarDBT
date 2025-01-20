WITH monthly_rentals AS (
    SELECT
        d.month_of_year,
        COUNT(f.rental_id) AS rental_count
    FROM {{ ref('fact_rentals') }} AS f
    JOIN {{ ref('dim_dates') }} AS d ON f.rental_date = d.date_day
    GROUP BY d.month_of_year
)

SELECT
    month_of_year,
    rental_count
FROM monthly_rentals
ORDER BY rental_count DESC
LIMIT 3