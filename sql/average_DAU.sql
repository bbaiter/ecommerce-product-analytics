WITH daily_dau AS (
    SELECT
        substr(event_time, 1, 10) AS day,
        count(DISTINCT user_id)   AS dau
    FROM events
    GROUP BY substr(event_time, 1, 10)
)
SELECT
    substr(day, 1, 7)         AS month,
    round(avg(dau), 2)        AS avg_dau,
    count(*)                  AS days_in_month
FROM daily_dau
GROUP BY substr(day, 1, 7)
ORDER BY month;