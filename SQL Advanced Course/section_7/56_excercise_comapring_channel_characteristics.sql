select *
from website_sessions
;



select utm_source,
	   COUNT(distinct website_session_id) as sessions,
       COUNT(CASE when device_type='mobile' then website_session_id end) as mobile_sessions,
       COUNT(CASE when device_type='mobile' then website_session_id end) / COUNT(distinct website_session_id) as pct_mobile
from website_sessions
where created_at BETWEEN '2012-08-22' AND '2012-11-30'
      AND utm_source IN ('gsearch', 'bsearch')
      AND utm_campaign = 'nonbrand'
group by utm_source
;