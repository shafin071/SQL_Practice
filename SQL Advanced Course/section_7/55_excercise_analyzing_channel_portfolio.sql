
select *
from website_sessions
;

select MIN(DATE(created_at)) as week_start_date,
       COUNT(distinct case when utm_source = 'gsearch' then website_session_id end) AS gsearch_sessions,
       COUNT(distinct case when utm_source = 'bsearch' then website_session_id end) AS bsearch_sessions
from website_sessions
where created_at BETWEEN '2012-08-26' AND '2012-11-29'
      AND utm_source IN ('gsearch', 'bsearch')
      AND utm_campaign = 'nonbrand'
group by WEEK(created_at)
;