
use mavenfuzzyfactory;

-- count of visited urls
select 
	pageview_url, 
    COUNT( DISTINCT website_pageview_id) as count 
from website_pageviews
where website_pageview_id < 1000 
group by pageview_url 
order by count desc;


CREATE TEMPORARY TABLE first_pageview
select 
	website_session_id,
    MIN(website_pageview_id) AS min_pv_id
from website_pageviews
where website_pageview_id < 1000 
group by website_session_id 
order by website_session_id;

select * from first_pageview;

SELECT 
    wp.pageview_url AS landing_page,
    count(distinct fp.website_session_id) as sessions_hitting_this_lander
FROM first_pageview fp
	LEFT JOIN
    website_pageviews wp
    ON fp.min_pv_id = wp.website_pageview_id
GROUP BY wp.pageview_url
    ;




