--какова конверсия просмотра в покупку
--доля покупателей среди всех пользователей

SELECT 
    COUNT(DISTINCT user_id) AS total_users,
    COUNT(DISTINCT CASE WHEN event_type = 'purchase' THEN user_id END) AS buyers,
    ROUND(100*COUNT(DISTINCT CASE WHEN event_type = 'purchase' THEN user_id END) / COUNT(DISTINCT user_id), 3) AS conversion_rate_pct
    FROM events;

