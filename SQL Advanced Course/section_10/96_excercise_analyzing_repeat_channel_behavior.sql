
-- This part is not required. Assignment does not ask for new users within time frame
select user_id, website_session_id, is_repeat_session, utm_content, http_referer
from website_sessions 
where created_at between '2014-01-01' AND '2014-11-05' 
      AND is_repeat_session=0
;


drop temporary table channel_groups;

CREATE temporary table channel_groups
select ws.user_id, 
	   ws.website_session_id, 
       ws.created_at,
       ws.is_repeat_session,
       ws.utm_source,
       ws.utm_campaign,
       ws.utm_content,
       ws.http_referer,
       CASE WHEN ws.http_referer is null and ws.utm_source is null then 'direct_type_in'
            WHEN ws.http_referer IN ('https://www.gsearch.com', 'https://www.bsearch.com') and ws.utm_source is null then 'organic_search'
            WHEN ws.utm_campaign = 'nonbrand' then 'paid_nonbrand'
            WHEN ws.utm_campaign = 'brand' then 'paid_brand'
            WHEN ws.utm_source = 'socialbook' then 'paid_social'
	   END AS channel_group
from 
     website_sessions ws
where ws.created_at between '2014-01-01' AND '2014-11-05' 
order by ws.user_id
;


select * from channel_groups;


select channel_group,
       COUNT(distinct CASE WHEN is_repeat_session=0 THEN website_session_id end) as new_sessions,
       COUNT(distinct CASE WHEN is_repeat_session=1 THEN website_session_id end) as repeat_sessions
from channel_groups
group by 1
order by 3 desc
;



