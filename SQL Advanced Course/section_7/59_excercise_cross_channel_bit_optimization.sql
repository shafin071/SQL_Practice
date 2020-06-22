
select *
from website_sessions
;


select ws.device_type, 
	   ws.utm_source, 
	   COUNT(distinct ws.website_session_id) as sessions,
       COUNT(distinct o.website_session_id) as orders,
       COUNT(distinct o.website_session_id) / COUNT(distinct ws.website_session_id) AS conv_rate
from website_sessions ws
	 LEFT JOIN
     orders o
     ON ws.website_session_id = o.website_session_id
where ws.created_at BETWEEN '2012-08-22' AND '2012-09-18'
      AND ws.utm_source IN ('gsearch', 'bsearch')
      AND ws.utm_campaign = 'nonbrand'
group by ws.device_type, ws.utm_source
;