--колько уникальных сессий дошли до добавления в корзину, но не завершились покупкой.

WITH sessions AS (
    SELECT 
        user_session,
        MAX(CASE WHEN event_type = 'cart' THEN 1 ELSE 0 END) AS has_cart,
        MAX(CASE WHEN event_type = 'purchase' THEN 1 ELSE 0 END) AS has_purchase
    FROM events
    GROUP BY user_session
)
SELECT 
    COUNT(CASE WHEN has_cart = 1 THEN 1 END) AS total_cart_sessions,
    COUNT(CASE WHEN has_cart = 1 AND has_purchase = 0 THEN 1 END) AS abandoned_sessions,
    ROUND(
        100.0 * COUNT(CASE WHEN has_cart = 1 AND has_purchase = 0 THEN 1 END) / COUNT(CASE WHEN has_cart = 1 THEN 1 END), 
        2
    ) AS abandonment_rate_pct
FROM sessions;