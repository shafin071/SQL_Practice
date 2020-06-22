
-- 1. Show overall growth in sessions and order by quaters
select YEAR(ws.created_at) as yr,
	   quarter(ws.created_at) as qtr,
       COUNT(distinct ws.website_session_id) as sessions,
       COUNT(distinct o.order_id) as orders,
       COUNT(distinct o.order_id) / COUNT(distinct ws.website_session_id) as conv_rate
from website_sessions ws
     LEFT JOIN
     orders o 
     ON ws.website_session_id = o.website_session_id
group by 1,2
;


-- 2. Show session-to-order conv rates, rev per order and session
 select YEAR(ws.created_at) as yr,
	   quarter(ws.created_at) as qtr,
       COUNT(distinct o.order_id) / COUNT(distinct ws.website_session_id) as conv_rate,
       SUM(price_usd) / COUNT(distinct o.order_id) as rev_per_order,
       SUM(price_usd) / COUNT(distinct ws.website_session_id) as rev_per_session
from website_sessions ws
     LEFT JOIN
     orders o 
     ON ws.website_session_id = o.website_session_id
group by 1,2
;


-- 3. Quaterly view of orders from gsearch/bsearch nonbrand, brand search overall, organic search and direct type-in
select YEAR(ws.created_at) as yr,
	   quarter(ws.created_at) as qtr,
       COUNT(distinct case when ws.utm_source='gsearch' and ws.utm_campaign='nonbrand' then o.order_id end) as gsearch_nonbrand_order,
       COUNT(distinct case when ws.utm_source='bsearch' and ws.utm_campaign='nonbrand' then o.order_id end) as bsearch_nonbrand_order,
       COUNT(distinct case when ws.utm_campaign='brand' then o.order_id end) as brand_order,
       COUNT(distinct case when ws.http_referer IN ('https://www.gsearch.com', 'https://www.bsearch.com') and ws.utm_source is null then o.order_id end) as organic_search_order,
       COUNT(distinct CASE WHEN ws.http_referer is null and ws.utm_source is null then o.order_id end) as direct_type_in_orders
from 
     website_sessions ws
     JOIN
     orders o
     ON ws.website_session_id = o.website_session_id
group by 1,2
;


-- 4. Show session to order conv rate for task 3

select YEAR(ws.created_at) as yr,
	   quarter(ws.created_at) as qtr,
       COUNT(distinct case when ws.utm_source='gsearch' and ws.utm_campaign='nonbrand' then o.order_id end)
       / COUNT(distinct case when ws.utm_source='gsearch' and ws.utm_campaign='nonbrand' then ws.website_session_id end) as gsearch_nonbrand_conv_rate,
       
       COUNT(distinct case when ws.utm_source='bsearch' and ws.utm_campaign='nonbrand' then o.order_id end)
       / COUNT(distinct case when ws.utm_source='bsearch' and ws.utm_campaign='nonbrand' then ws.website_session_id end) as bsearch_nonbrand_conv_rate,
       
       COUNT(distinct case when ws.utm_campaign='brand' then o.order_id end)
       / COUNT(distinct case when ws.utm_campaign='brand' then ws.website_session_id end) as brand_conv_rate,
       
       COUNT(distinct case when ws.http_referer IN ('https://www.gsearch.com', 'https://www.bsearch.com') and ws.utm_source is null then o.order_id end)
       / COUNT(distinct case when ws.http_referer IN ('https://www.gsearch.com', 'https://www.bsearch.com') and ws.utm_source is null then ws.website_session_id end) as brand_conv_rate,
       
       COUNT(distinct CASE WHEN ws.http_referer is null and ws.utm_source is null then o.order_id end)
       / COUNT(distinct CASE WHEN ws.http_referer is null and ws.utm_source is null then ws.website_session_id end) as direct_type_in_orders
from 
     website_sessions ws
     LEFT JOIN
     orders o
     ON ws.website_session_id = o.website_session_id
group by 1,2
;