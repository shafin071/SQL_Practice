

use mavenfuzzyfactory;



-- create table with first landing page ids for selected urls and date range

drop temporary table if exists first_landing_page;

create temporary table first_landing_page
select wp.website_session_id, 
	   MIN(wp.website_pageview_id) as first_pageview_id, 
       COUNT(wp.website_pageview_id) as count_pageviews,
       wp.created_at, 
       wp.pageview_url
from website_pageviews wp
	 LEFT JOIN
     website_sessions ws
     ON wp.website_session_id = ws.website_session_id
where ws.created_at > '2012-06-01'
	  AND ws.created_at < '2012-08-31'
	  AND ws.utm_source = 'gsearch'
      AND ws.utm_campaign = 'nonbrand'
GROUP BY ws.website_session_id;


select * from first_landing_page;


-- create the final table with total sessions and bounce rates 
select 
	DATE(MIN(created_at)) as week_start_date,
    COUNT(distinct website_session_id) as total_sessions,
    COUNT(distinct case when count_pageviews = 1 then website_session_id end) / COUNT(distinct website_session_id) AS bounce_rate,
    COUNT(distinct CASE when pageview_url = '/home' then website_session_id end) as home_count,
    COUNT(distinct CASE when pageview_url = '/lander-1' then website_session_id end) as lander_1_count
from first_landing_page group by yearweek(created_at);










