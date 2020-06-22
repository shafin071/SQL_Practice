
use mavenfuzzyfactory;


-- 7. Show full conversion funnel from each of the two pages (home and lander-1) to orders for Jun 19 - Jul 28

drop temporary table pages_visited;

create temporary table pages_visited
select 
	ws.website_session_id,
    wp.pageview_url,
	CASE WHEN wp.pageview_url = '/home' THEN 1 ELSE 0 END AS home,
    CASE WHEN wp.pageview_url = '/lander-1' THEN 1 ELSE 0 END AS lander_1,
	CASE WHEN wp.pageview_url = '/products' THEN 1 ELSE 0 END AS product,
	CASE WHEN wp.pageview_url = '/the-original-mr-fuzzy' THEN 1 ELSE 0 END AS mrfuzzy,
	CASE WHEN wp.pageview_url = '/cart' THEN 1 ELSE 0 END AS cart,
    CASE WHEN wp.pageview_url = '/shipping' THEN 1 ELSE 0 END AS shipping,
	CASE WHEN wp.pageview_url = '/billing' THEN 1 ELSE 0 END AS billing,
	CASE WHEN wp.pageview_url = '/thank-you-for-your-order' THEN 1 ELSE 0 END AS order_complete
from website_sessions ws
	 JOIN
     website_pageviews wp
     ON ws.website_session_id = wp.website_session_id
WHERE ws.created_at BETWEEN '2012/06/19' AND '2012/07/28'
	  AND ws.utm_source = 'gsearch'
      AND ws.utm_campaign = 'nonbrand'
      AND wp.pageview_url IN ('/home', '/lander-1', '/products', '/the-original-mr-fuzzy', '/cart', '/shipping', '/billing', '/thank-you-for-your-order')
;


select * from pages_visited;



drop temporary table pages_visited_per_session;

create temporary table pages_visited_per_session
select website_session_id,
       MAX(home) as home,
       MAX(lander_1) as lander_1,
       MAX(product) as product,
       MAX(mrfuzzy) as mrfuzzy,
       MAX(cart) as cart,
       MAX(shipping) as shipping,
       MAX(billing) as billing,
       MAX(order_complete) as order_complete
from pages_visited
group by 1
;

select * from pages_visited_per_session;


-- funnel counts
select CASE WHEN home=1 then 'saw_homepage'
		    WHEN lander_1=1 then 'saw_custom_lander'
            END AS segment,
	   COUNT(distinct website_session_id) as sessions,
       COUNT(distinct CASE WHEN product=1 THEN website_session_id END) AS to_products,
       COUNT(distinct CASE WHEN mrfuzzy=1 THEN website_session_id END) AS to_mrfuzzy,
       COUNT(distinct CASE WHEN cart=1 THEN website_session_id END) AS to_cart,
       COUNT(distinct CASE WHEN shipping=1 THEN website_session_id END) AS to_shipping,
       COUNT(distinct CASE WHEN billing=1 THEN website_session_id END) AS to_billing,
       COUNT(distinct CASE WHEN order_complete=1 THEN website_session_id END) AS to_thankyou
from pages_visited_per_session
group by 1; 


-- funnel conversion rate
select CASE WHEN home=1 then 'saw_homepage'
		    WHEN lander_1=1 then 'saw_custom_lander'
            END AS segment,
	   COUNT(distinct CASE WHEN product=1 THEN website_session_id END) / COUNT(distinct website_session_id) AS lander_click_rate,
       COUNT(distinct CASE WHEN mrfuzzy=1 THEN website_session_id END) / COUNT(distinct CASE WHEN product=1 THEN website_session_id END) as products_click_rate,
       COUNT(distinct CASE WHEN cart=1 THEN website_session_id END) / COUNT(distinct CASE WHEN mrfuzzy=1 THEN website_session_id END) as mrfuzzy_click_rate,
       COUNT(distinct CASE WHEN shipping=1 THEN website_session_id END) / COUNT(distinct CASE WHEN cart=1 THEN website_session_id END) as cart_click_rate,
       COUNT(distinct CASE WHEN billing=1 THEN website_session_id END) / COUNT(distinct CASE WHEN shipping=1 THEN website_session_id END) as shipping_click_rate,
       COUNT(distinct CASE WHEN order_complete=1 THEN website_session_id END) / COUNT(distinct CASE WHEN billing=1 THEN website_session_id END) as billing_click_rate
from pages_visited_per_session
group by 1; 


#-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 8. Show revenue per billing page session from the billing page test from Sep 10 - Nov 10

-- First time billing-2 page was used
select MIN(website_pageview_id) from website_pageviews where pageview_url = '/billing-2' order by created_at;
select MIN(created_at) from website_pageviews where pageview_url = '/billing-2';

-- 53550
-- 2012-09-09 22:13:05

-- Show all website_session id for billing and billing-2 along with the order id and price
select
	wp.website_session_id,
    wp.pageview_url,
    o.order_id,
    o.price_usd
from
    website_pageviews wp
    LEFT JOIN
    orders o
    ON wp.website_session_id = o.website_session_id
WHERE wp.created_at between '2012-09-10' AND '2012-11-10'
      AND wp.pageview_url in ('/billing', '/billing-2')
;



-- show total sessions and revenue per billing page session for each billing page type
select
	wp.pageview_url,
    COUNT(distinct wp.website_session_id) as sessions,
    SUM(o.price_usd) / COUNT(distinct wp.website_session_id) as revenue_per_billing_page_seen
from
    website_pageviews wp
    LEFT JOIN
    orders o
    ON wp.website_session_id = o.website_session_id
WHERE wp.created_at between '2012-09-10' AND '2012-11-10'
      AND wp.pageview_url in ('/billing', '/billing-2')
GROUP BY wp.pageview_url 
;

-- billing revenue per session = 22.79
-- billing-2 revenue per session = 31.31
-- Increase in revenue per session = 31.31 - 22.79 = $8.52


-- Pull the no. of billing page sessions for the past month
SELECT COUNT(distinct website_session_id)
FROM website_pageviews
WHERE pageview_url in ('/billing', '/billing-2')
      AND created_at between '2012-10-27' AND '2012-11-27'
      
-- 1192 sessions
-- 1192 * 8.52 = $ 10155.85 increase in revenue





