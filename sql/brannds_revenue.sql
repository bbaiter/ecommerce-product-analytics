--вывод 10 лучших по выручке брендов
SELECT 
    p.brand,
    COUNT(DISTINCT e.user_id) AS unique_buyers,
    SUM(e.price) AS total_brand_revenue
FROM events e
JOIN products p ON e.product_id = p.product_id
WHERE e.event_type = 'purchase' AND p.brand IS NOT NULL
GROUP BY p.brand
ORDER BY total_brand_revenue DESC
LIMIT 10;
