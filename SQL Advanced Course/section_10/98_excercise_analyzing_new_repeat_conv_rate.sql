use mavenfuzzyfactory;


select * from website_sessions where created_at between '2014-01-01' AND '2014-11-08'; 


select ws.is_repeat_session,
       COUNT(distinct ws.website_session_id) as sessions,
       COUNT(distinct o.order_id) / COUNT(distinct ws.website_session_id) as conv_rate,
       SUM(o.price_usd) / COUNT(distinct ws.website_session_id) as rev_per_session
from website_sessions ws
     LEFT JOIN
     orders o
     ON ws.website_session_id = o.website_session_id
where ws.created_at between '2014-01-01' AND '2014-11-08'
group by 1
;
