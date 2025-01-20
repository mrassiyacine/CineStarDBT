WITH customer_lifetime_value AS (
    SELECT
        c.customer_id,
        c.full_name,
        SUM(f.amount) AS lifetime_value
    FROM {{ ref('fact_rentals') }} AS f
    JOIN {{ ref('dim_customer') }} AS c ON f.customer_id = c.customer_id
    GROUP BY c.customer_id, c.full_name
)

SELECT
    customer_id,
    full_name,
    lifetime_value
FROM customer_lifetime_value
ORDER BY lifetime_value DESC
LIMIT 10