-- Медианное время в часах от первого просмотра до покупки
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
),
deltas AS (
    SELECT 
        fp.user_id,
        (julianday(substr(fp.first_purchase_time, 1, 19)) - 
         julianday(substr(fv.first_view_time, 1, 19))) * 24 AS hours_to_purchase
    FROM first_view fv
    JOIN first_purchase fp ON fv.user_id = fp.user_id
    WHERE substr(fp.first_purchase_time, 1, 19) >= substr(fv.first_view_time, 1, 19)
),
ranked AS (
    SELECT 
        hours_to_purchase,
        ROW_NUMBER() OVER (ORDER BY hours_to_purchase) AS rn,
        COUNT(*) OVER () AS total_count
    FROM deltas
)
SELECT 
    ROUND(AVG(hours_to_purchase), 1) AS median_hours_to_purchase
FROM ranked
WHERE rn IN ((total_count + 1) / 2, (total_count + 2) / 2);