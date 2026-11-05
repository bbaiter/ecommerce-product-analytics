-- Среднее время в днях от первого просмотра до покупки
WITH first_view AS (
    SELECT 
        user_id, 
        MIN(event_time) AS first_view_time
    FROM events
    WHERE event_type = 'view'
    GROUP BY user_id
),
first_purchase AS (
    SELECT 
        user_id, 
        MIN(event_time) AS first_purchase_time
    FROM events
    WHERE event_type = 'purchase'
    GROUP BY user_id
)
SELECT 
    ROUND(AVG(
        julianday(substr(fp.first_purchase_time, 1, 19)) - 
        julianday(substr(fv.first_view_time, 1, 19))
    ), 1) AS avg_days_to_purchase
FROM first_view fv
JOIN first_purchase fp ON fv.user_id = fp.user_id
WHERE substr(fp.first_purchase_time, 1, 19) >= substr(fv.first_view_time, 1, 19);