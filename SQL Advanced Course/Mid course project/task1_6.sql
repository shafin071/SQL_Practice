
use mavenfuzzyfactory;


-- 1. Monthly trends of orders from gsearch sessions

select YEAR(ws.created_at),
       MONTH(ws.created_at), 
       COUNT(distinct ws.website_session_id) as total_sessions,
       COUNT(distinct o.website_session_id) as orders,
       COUNT(distinct o.website_session_id) / COUNT(distinct ws.website_session_id) * 100 as conversion_rate
from website_sessions ws
     LEFT JOIN
     orders o
     ON ws.website_session_id = o.website_session_id
WHERE ws.utm_source = 'gsearch' 
      AND ws.created_at < '2012-11-27'
GROUP BY 1,2
;


# --------------------------------------------------------------------------------------------------------------------------------------------------
-- 2. Show comparison of orders sourcing from gsearch brand and non-brand
select 
       YEAR(ws.created_at),
       MONTH(ws.created_at),
       COUNT(distinct CASE WHEN ws.utm_campaign = 'nonbrand' THEN ws.website_session_id END) as total_nonbrand_sessions,
       COUNT(distinct CASE WHEN ws.utm_campaign = 'nonbrand' THEN o.website_session_id END) as total_nonbrand_orders,
       COUNT(distinct CASE WHEN ws.utm_campaign = 'brand' THEN ws.website_session_id END) as total_brand_sessions,
       COUNT(distinct CASE WHEN ws.utm_campaign = 'brand' THEN o.website_session_id END) as total_brand_orders
from website_sessions ws
     LEFT JOIN
     orders o
     ON ws.website_session_id = o.website_session_id
WHERE ws.utm_source = 'gsearch' 
      AND ws.created_at < '2012-11-27'
GROUP BY 1,2
;


# --------------------------------------------------------------------------------------------------------------------------------------------------
-- 3. Orders split by device type for gsearch nonbrand
select 
       YEAR(ws.created_at) AS Yr,
       MONTH(ws.created_at) AS Mo,
       COUNT(distinct CASE WHEN ws.device_type = 'mobile' THEN ws.website_session_id END) as total_mobile_sessions,
       COUNT(distinct CASE WHEN ws.device_type = 'mobile' THEN o.website_session_id END) as total_mobile_orders,
       COUNT(distinct CASE WHEN ws.device_type = 'desktop' THEN ws.website_session_id END) as total_desktop_sessions,
       COUNT(distinct CASE WHEN ws.device_type = 'desktop' THEN o.website_session_id END) as total_desktop_orders
from website_sessions ws
     LEFT JOIN
     orders o
     ON ws.website_session_id = o.website_session_id
WHERE ws.utm_source = 'gsearch'
      AND ws.utm_campaign = 'nonbrand'
      AND ws.created_at < '2012-11-27'
group by 1,2
;


# --------------------------------------------------------------------------------------------------------------------------------------------------
-- 4. Monthly sessions from all the utm sources
select distinct utm_source, utm_campaign from website_sessions;

select distinct * from website_sessions;

select 
       YEAR(created_at) AS Yr,
       MONTH(created_at) AS Mo,
       COUNT(distinct CASE WHEN utm_source = 'gsearch' THEN website_session_id END) as gsearch_sessions,
       COUNT(distinct CASE WHEN utm_source = 'bsearch' THEN website_session_id END) as bsearch_orders,
       COUNT(distinct CASE WHEN utm_source is null AND http_referer is not null then website_session_id end) as organic_sesarch_sessions,
       COUNT(distinct CASE WHEN utm_source is null AND http_referer is null then website_session_id end) as direct_type_in_sessions
from website_sessions 
WHERE created_at < '2012-11-27'
group by 1,2
;


# --------------------------------------------------------------------------------------------------------------------------------------------------
-- 5. Session to order conversion rate by month
select 
       YEAR(ws.created_at) AS Yr,
       MONTH(ws.created_at) AS Mo,
       COUNT(distinct ws.website_session_id) as total_sessions,
       COUNT(distinct o.website_session_id) as total_orders,
       COUNT(distinct o.website_session_id) / COUNT(distinct ws.website_session_id) * 100 AS conversion_rate

from website_sessions ws
     LEFT JOIN
     orders o
     ON ws.website_session_id = o.website_session_id
WHERE ws.created_at < '2012-11-27'
group by 1,2
;


# --------------------------------------------------------------------------------------------------------------------------------------------------
-- 6 estimate revenue for gsearch lander test

select * from orders;

SELECT MIN(website_pageview_id) as first_test_pv
FROM website_pageviews
WHERE pageview_url = '/lander-1'
;

SELECT MIN(created_at) as first_test_pv
FROM website_pageviews
WHERE pageview_url = '/lander-1'
;
-- 2012/06/18


drop temporary table first_test_pageviews;

CREATE TEMPORARY TABLE first_test_pageviews
SELECT
	ws.website_session_id,
    MIN(wp.website_pageview_id) as min_pageview_id,
    wp.pageview_url,
    wp.created_at
FROM
	website_pageviews wp
    JOIN
    website_sessions ws
    ON wp.website_session_id = ws.website_session_id
WHERE
	wp.website_pageview_id >= 23504   -- first pageview_id for lander-1
    AND ws.created_at < '2012-07-28'
    AND ws.utm_source = 'gsearch'
    AND ws.utm_campaign = 'nonbrand'
    AND wp.pageview_url in ('/home', '/lander-1')
GROUP BY ws.website_session_id
;

select * from first_test_pageviews;


drop temporary table nonbrand_test_sessions_w_orders;

create temporary table nonbrand_test_sessions_w_orders
select
	ftp.website_session_id,
    ftp.pageview_url,
    ftp.created_at,
    o.order_id
from
	first_test_pageviews ftp
    left join
    orders o
    on ftp.website_session_id = o.website_session_id
;

select * from nonbrand_test_sessions_w_orders;

-- This part takes care of the what's asked in the hint: Look at the increase in CVR from the test(Jun 19 - Jul 28)
-- Jun 18 is when lander-1 page was launched
select
	pageview_url,
    COUNT(distinct website_session_id) as total_sessions,
    COUNT(distinct order_id) as total_order,
    COUNT(distinct order_id) / COUNT(distinct website_session_id) * 100 as conversion_rate
from
	nonbrand_test_sessions_w_orders
group by 1
;

-- Conv rate for home: 3.1816 %
-- Conv rate for lander-1: 4.0535 %
-- 0.8719 % or 0.008719 increase in orders per session


-- Find website session id of last home page landing from gsearch nonbrand
select
	MAX(wp.website_session_id)
from
	website_sessions ws
    LEFT JOIN
    website_pageviews wp
    ON ws.website_session_id = wp.website_session_id
where
	ws.utm_source = 'gsearch'
    AND ws.utm_campaign = 'nonbrand'
	AND wp.pageview_url = '/home'
    AND ws.created_at < '2012-11-27'
;

-- last session id with home page: 17145

select * from website_sessions where website_session_id = 17145;

-- session: 17145
-- created_at: 2012-07-29


select * from website_sessions;

-- Number of sessions since last use of home page

select COUNT(distinct website_session_id) as sessions_since_test from website_sessions
where created_at < '2012-11-27'
      AND website_session_id > 17145
      AND utm_source = 'gsearch'
      AND utm_campaign = 'nonbrand'
;

-- 22980 website sessions since the test (07/29)

-- 0.008719 increase in orders per session (from few steps before)

-- Incremental orders since 07/29: 22980 x 0.008719 = 200.4
-- So roughly 200 more orders compared to before 07/29
-- Split that over 4 months (07 to 11): 200 / 4 = 50 extra orders per month

-- My alternative approach was to the increase in orders per month starting from 03/01 to 11/27
-- so we can see the comparison in numbers before and after the 07/29 date
-- Here is the code for that:

create temporary table order_trends
select
	YEAR(ws.created_at) as Yr,
    MONTH(ws.created_at) as Mo,
    COUNT(distinct ws.website_session_id) as sessions,
    COUNT(distinct o.order_id) as orders
from 
	website_sessions ws
    LEFT JOIN
    orders o
    ON ws.website_session_id = o.website_session_id
where
	-- ws.website_session_id > 17145
    ws.created_at >= '2012-03-01'
    AND ws.utm_source = 'gsearch'
    AND ws.utm_campaign = 'nonbrand'
    AND ws.created_at < '2012-11-27'
group by 1,2
    ;
    

select
    ot1.Yr,
    ot1.Mo as last_mo,
    ot2.Mo as present_mo,
    ot1.sessions as last_mo_sessions,
    ot1.orders as last_mo_orders,
    ot2.sessions as present_mo_sessions,
    ot2.orders as present_mo_orders,
    CASE WHEN ot1.Mo = ot2.Mo-1 then ot2.orders - ot1.orders
	 ELSE NULL END AS Order_increment
from order_trends ot1
	 JOIN
     (
		select
			YEAR(ws.created_at) as Yr,
			MONTH(ws.created_at) as Mo,
			COUNT(distinct ws.website_session_id) as sessions,
			COUNT(distinct o.order_id) as orders
		from 
			website_sessions ws
			LEFT JOIN
			orders o
			ON ws.website_session_id = o.website_session_id
		where
			-- ws.website_session_id > 17145
            ws.created_at >= '2012-03-01'
			AND ws.utm_source = 'gsearch'
			AND ws.utm_campaign = 'nonbrand'
			AND ws.created_at < '2012-11-27'
		group by 1,2
     ) ot2
	ON ot2.Mo = ot1.Mo+1





	


	




	
    







