
select *
from website_sessions
;


select MIN(DATE(created_at)),
       COUNT(distinct case when utm_source='gsearch' AND device_type='desktop' then website_session_id end) as g_dtop_sessions,
       COUNT(distinct case when utm_source='bsearch' AND device_type='desktop' then website_session_id end) as b_dtop_sessions,
       COUNT(distinct case when utm_source='bsearch' AND device_type='desktop' then website_session_id end) / COUNT(case when utm_source='gsearch' AND device_type='desktop' then website_session_id end) as b_pct_of_g_dtop,
       COUNT(distinct case when utm_source='gsearch' AND device_type='mobile' then website_session_id end) as g_mob_sessions,
       COUNT(distinct case when utm_source='bsearch' AND device_type='mobile' then website_session_id end) as b_mob_sessions,
       COUNT(distinct case when utm_source='bsearch' AND device_type='mobile' then website_session_id end) / COUNT(case when utm_source='gsearch' AND device_type='mobile' then website_session_id end) as b_pct_of_g_mob
from website_sessions
where created_at between '2012-11-04' AND '2012-12-22'
	  AND utm_source IN ('gsearch', 'bsearch')
      AND utm_campaign = 'nonbrand'
GROUP BY YEARWEEK(created_at)
;


