
use mavenfuzzyfactory;


select * from website_sessions;

select MIN(created_at), website_pageview_id from website_pageviews where  pageview_url = '/billing-2';


select *
from website_pageviews wp
	 LEFT JOIN
     orders o 
     ON wp.website_session_id = o.website_session_id
where wp.pageview_url IN ('/billing', '/billing-2') 
	  AND wp.website_pageview_id >= 53550
	  AND wp.created_at < '2012-11-10'
;


select 
	   pageview_url as billing_version_seen,
       COUNT(distinct wp.website_session_id) as sessions,
	   COUNT(distinct o.order_id) as orders,
       COUNT(distinct o.order_id) / COUNT(distinct wp.website_session_id) as billing_to_order_rt
from website_pageviews wp
	 LEFT JOIN
     orders o 
     ON wp.website_session_id = o.website_session_id
where wp.pageview_url IN ('/billing', '/billing-2') 
	  AND wp.website_pageview_id >= 53550
	  AND wp.created_at < '2012-11-10'
GROUP BY wp.pageview_url
;
      
      
