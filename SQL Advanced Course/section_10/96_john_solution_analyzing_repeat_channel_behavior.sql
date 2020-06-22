
select utm_source,
       utm_campaign,
       http_referer,
       COUNT(CASE WHEN is_repeat_session=0 THEN website_session_id ELSE NULL END) AS new_sessions,
       COUNT(CASE WHEN is_repeat_session=0 THEN website_session_id ELSE NULL END) AS new_sessions
from website_sessions
where created_at < '2014-11-05' and created_at >= '2014-01-01'
group by 1,2,3
order by 4 desc
;


select
      CASE WHEN ws.http_referer is null and ws.utm_source is null then 'direct_type_in'
            WHEN ws.http_referer IN ('https://www.gsearch.com', 'https://www.bsearch.com') and ws.utm_source is null then 'organic_search'
            WHEN ws.utm_campaign = 'nonbrand' then 'paid_nonbrand'
            WHEN ws.utm_campaign = 'brand' then 'paid_brand'
            WHEN ws.utm_source = 'socialbook' then 'paid_social'
	   END AS channel_group,
	   COUNT(distinct CASE WHEN ws.is_repeat_session=0 THEN ws.website_session_id end) as new_sessions,
       COUNT(distinct CASE WHEN ws.is_repeat_session=1 THEN ws.website_session_id end) as repeat_sessions
from website_sessions ws
where ws.created_at < '2014-11-05' and ws.created_at >= '2014-01-01'
group by 1
order by 3 desc;
;






