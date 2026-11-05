SELECT 
    substr(event_time, 1, 7) AS month,
    SUM(price) AS total_revenue,
    COUNT(DISTINCT user_session) AS total_orders,
    ROUND(SUM(price) / COUNT(DISTINCT user_session)) AS aov
FROM events
WHERE event_type = 'purchase'
GROUP BY month
ORDER BY month;
