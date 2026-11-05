
--подсчет выручки(суммы всех покупок) и среднего чека
SELECT 
    SUM(price) AS total_revenue,
    COUNT(DISTINCT user_session) AS total_orders,
    ROUND(SUM(price) / COUNT(DISTINCT user_session), 2) AS aov
FROM events
WHERE event_type = 'purchase';