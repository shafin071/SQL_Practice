
SELECT distinct primary_product_id
FROM orders 
where created_at <= '2013-03-05'
;


select YEAR(ws.created_at) as yr,
	   MONTH(ws.created_at) as mo,
       COUNT(distinct o.website_session_id) as orders,
       COUNT(distinct o.website_session_id) / COUNT(distinct ws.website_session_id) as conv_rate,
       SUM(o.price_usd) / COUNT(distinct ws.website_session_id) as revenue_per_session,
       COUNT(distinct case when o.primary_product_id=1 then o.website_session_id end) as product_one_orders,
       COUNT(distinct case when o.primary_product_id=2 then o.website_session_id end) as product_two_orders
from website_sessions ws
     LEFT JOIN
     orders o
     ON ws.website_session_id = o.website_session_id
where ws.created_at BETWEEN '2012-04-01' AND '2013-03-31'
GROUP BY 1,2
;