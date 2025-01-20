WITH category_profit AS (
    SELECT
        fl.category,
        SUM(f.amount) AS profit
    FROM {{ ref('fact_rentals') }} AS f
    JOIN {{ ref('dim_film') }} AS fl ON f.film_id = fl.film_id
    GROUP BY fl.category
)

SELECT
    category,
    profit
FROM category_profit
ORDER BY profit DESC