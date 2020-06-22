


select * from website_pageviews;

drop table if exists first_pv_per_session;

create temporary table first_pv_per_session
select
	website_session_id, MIN(website_pageview_id) as landing_pageview_id
from website_pageviews
where created_at < '2012-06-12'
group by website_session_id
;

select * from first_pv_per_session;


SELECT
	wp.pageview_url as landing_page_url,
    count(distinct wp.website_session_id) as session_hitting_page
FROM
	website_pageviews wp
    JOIN
    first_pv_per_session fpv
    ON wp.website_pageview_id = fpv.landing_pageview_id
where created_at < '2012-06-12'
GROUP BY pageview_url
    ;