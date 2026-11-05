select 
    substr(event_time, 1, 10) as day,
    count(distinct user_id) as DAU,
    count(*) as total_events
from events
group by substr(event_time, 1, 10)
order by day
limit 30;
