-- отношение dau/mau -- насколько продукт залипательный
WITH daily_dau AS (
    -- DAU для каждого дня
    SELECT 
        substr(event_time, 1, 7) AS month,
        substr(event_time, 1, 10) AS day,
        COUNT(DISTINCT user_id) AS dau
    FROM events
    GROUP BY substr(event_time, 1, 7), substr(event_time, 1, 10)
),
monthly_stats AS (
    --средний DAU и MAU для каждого месяца
    SELECT 
        month,
        AVG(dau) AS avg_dau,
        SUM(dau) AS total_dau_sum -- (это не MAU, просто для проверки)
    FROM daily_dau
    GROUP BY month
),
mau_calc AS (
    SELECT 
        substr(event_time, 1, 7) AS month,
        COUNT(DISTINCT user_id) AS mau
    FROM events
    GROUP BY substr(event_time, 1, 7)
)
SELECT 
    m.month,
    ROUND(m.avg_dau) AS avg_dau,
    c.mau,
    ROUND(100.0 * m.avg_dau / c.mau, 2) AS stickiness_pct
FROM monthly_stats m
JOIN mau_calc c ON m.month = c.month
ORDER BY m.month;