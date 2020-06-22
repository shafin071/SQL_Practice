
-- STEP 1: select all pageviews for relevant sessions
-- STEP 2: identify each relevant pageview as the specific funnel step
-- STEP 3: create the session_level conversion funnel view
-- STEP 4: aggregate the data to assess funnel performance

use mavenfuzzyfactory;

select distinct pageview_url from website_pageviews;


select 
	 wp.website_session_id, 
     wp.pageview_url,
     ws.created_at,
     CASE when wp.pageview_url = '/lander-1' then 1 else 0 end AS lander_1,
     CASE when wp.pageview_url = '/products' then 1 else 0 end AS products,
     CASE when wp.pageview_url = '/the-original-mr-fuzzy' then 1 else 0 end AS mrfuzzy,
     CASE when wp.pageview_url = '/cart' then 1 else 0 end AS cart,
     CASE when wp.pageview_url = '/shipping' then 1 else 0 end AS shipping,
     CASE when wp.pageview_url = '/billing' then 1 else 0 end AS billing,
     CASE when wp.pageview_url = '/thank-you-for-your-order' then 1 else 0 end AS thank_you
from website_pageviews wp
	 JOIN
     website_sessions ws
     ON wp.website_session_id = ws.website_session_id
WHERE ws.created_at BETWEEN '2012-08-05' AND '2012-09-05'
	  AND ws.utm_source = 'gsearch'
      AND ws.utm_campaign = 'nonbrand'
	  AND wp.pageview_url IN ('/lander-1', '/products', '/the-original-mr-fuzzy', '/cart', '/shipping', '/billing', '/thank-you-for-your-order')
;


create temporary table session_flags
select 
	website_session_id,
    MAX(lander_1) AS clicked_lander_1,
    MAX(products) AS clicked_products,
    MAX(mrfuzzy) AS clicked_mrfuzzy,
    MAX(cart) AS clicked_cart,
    MAX(shipping) AS clicked_shipping,
    MAX(billing) AS clicked_billing,
    MAX(thank_you) AS clicked_order
from
	(
		select 
			 wp.website_session_id, 
			 wp.pageview_url,
			 ws.created_at,
			 CASE when wp.pageview_url = '/lander-1' then 1 else 0 end AS lander_1,
			 CASE when wp.pageview_url = '/products' then 1 else 0 end AS products,
			 CASE when wp.pageview_url = '/the-original-mr-fuzzy' then 1 else 0 end AS mrfuzzy,
			 CASE when wp.pageview_url = '/cart' then 1 else 0 end AS cart,
			 CASE when wp.pageview_url = '/shipping' then 1 else 0 end AS shipping,
			 CASE when wp.pageview_url = '/billing' then 1 else 0 end AS billing,
			 CASE when wp.pageview_url = '/thank-you-for-your-order' then 1 else 0 end AS thank_you
		from website_pageviews wp
			 JOIN
			 website_sessions ws
			 ON wp.website_session_id = ws.website_session_id
		WHERE ws.created_at BETWEEN '2012-08-05' AND '2012-09-05'
			  AND ws.utm_source = 'gsearch'
			  AND ws.utm_campaign = 'nonbrand'
			  AND wp.pageview_url IN ('/lander-1', '/products', '/the-original-mr-fuzzy', '/cart', '/shipping', '/billing', '/thank-you-for-your-order')
    ) AS pageview_level
group by website_session_id
;


select * from session_flags;




-- aggregate the data to assess funnel performance
SELECT
	COUNT(distinct website_session_id) as total_sessions,
    COUNT(distinct CASE when clicked_lander_1 = 1 then website_session_id else NULL end) AS to_lander_1,
    COUNT(distinct CASE when clicked_products = 1 then website_session_id else NULL end) AS to_products,
    COUNT(distinct CASE when clicked_mrfuzzy = 1 then website_session_id else NULL end) AS to_mrfuzzy,
    COUNT(distinct CASE when clicked_cart = 1 then website_session_id else NULL end) AS to_cart,
    COUNT(distinct CASE when clicked_shipping = 1 then website_session_id else NULL end) AS to_shipping,
    COUNT(distinct CASE when clicked_billing = 1 then website_session_id else NULL end) AS to_billing,
    COUNT(distinct CASE when clicked_order = 1 then website_session_id else NULL end) AS to_order
FROM
	session_flags
    ;
    

-- find clickthrough rate
SELECT
	COUNT(distinct website_session_id) as total_sessions,
    COUNT(distinct CASE when clicked_products = 1 then website_session_id else NULL end) / COUNT(distinct website_session_id)  AS lander_click_rate,
    COUNT(distinct CASE when clicked_mrfuzzy = 1 then website_session_id else NULL end) / COUNT(distinct CASE when clicked_products = 1 then website_session_id else NULL end) AS product_click_rate,
    COUNT(distinct CASE when clicked_cart = 1 then website_session_id else NULL end) / COUNT(distinct CASE when clicked_mrfuzzy = 1 then website_session_id else NULL end) AS mrfuzzy_click_rate,
    COUNT(distinct CASE when clicked_shipping = 1 then website_session_id else NULL end) / COUNT(distinct CASE when clicked_cart = 1 then website_session_id else NULL end) AS cart_click_rate,
    COUNT(distinct CASE when clicked_billing = 1 then website_session_id else NULL end) / COUNT(distinct CASE when clicked_shipping = 1 then website_session_id else NULL end) AS shipping_click_rate,
    COUNT(distinct CASE when clicked_order = 1 then website_session_id else NULL end) / COUNT(distinct CASE when clicked_billing = 1 then website_session_id else NULL end) AS billing_click_rate
FROM
	session_flags
    ;


