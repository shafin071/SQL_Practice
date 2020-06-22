

select YEAR(ws.created_at) as yr,
	   WEEK(ws.created_at) as wk,
       DATE(MIN(ws.created_at)) as week_start,
       COUNT(distinct ws.website_session_id) as sessions,
       COUNT(distinct o.website_session_id) as orders
from website_sessions ws
     LEFT JOIN
     orders o
     ON ws.website_session_id = o.website_session_id
WHERE YEAR(ws.created_at) = '2012'
GROUP BY 1,2
;