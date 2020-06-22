
-- John's solution: CORRECT

-- Break down count of sessions by wkday and hr 
select DATE(created_at) as created_date,
	   WEEKDAY(created_at) as wkday,
	   HOUR(created_at) as hr,
	   COUNT(distinct website_session_id) as website_sessions
from website_sessions
WHERE created_at between '2012-09-15' AND '2012-11-15' 
group by 1,2,3
;


-- Find average of sessions count for an hour for the week
-- For example: hr:0 mon:6.4 means at 0 hour every Monday, average session is 6.4 
select hr,
       ROUND(AVG(case when wkday = 0 then website_sessions end), 1) as 'mon',
       ROUND(AVG(case when wkday = 1 then website_sessions end), 1) as 'tue',
       ROUND(AVG(case when wkday = 2 then website_sessions end), 1) as 'wed',
       ROUND(AVG(case when wkday = 3 then website_sessions end), 1) as 'thu',
       ROUND(AVG(case when wkday = 4 then website_sessions end), 1) as 'fri',
       ROUND(AVG(case when wkday = 5 then website_sessions end), 1) as 'sat',
       ROUND(AVG(case when wkday = 6 then website_sessions end), 1) as 'sun'
from
	(
		select DATE(created_at) as created_date,
			   WEEKDAY(created_at) as wkday,
			   HOUR(created_at) as hr,
			   COUNT(distinct website_session_id) as website_sessions
		from website_sessions
		WHERE created_at between '2012-09-15' AND '2012-11-15' 
		group by 1,2,3
    ) AS daily_hourly_sessions
GROUP BY 1
ORDER BY 1
;



-- What I did: NOT EXACTLY WHAT THE ASSIGNMENT ASKED FOR. Example: I Showed sum of all sessions at Monday 0hr. 
-- There are 9 Mondays from '2012-09-15' AND '2012-11-15'. So there were total 58 sessions for all Mondays at 0hr
-- John calculated the average. so 58/9 = 6.4 sessions for a Monday @ 0 hr
select HOUR(created_at) as hr,
       COUNT(distinct case when weekday(created_at) = 0 then ws.website_session_id end) as 'mon',
       COUNT(distinct case when weekday(created_at) = 1 then ws.website_session_id end) as 'tue',
       COUNT(distinct case when weekday(created_at) = 2 then ws.website_session_id end) as 'wed',
       COUNT(distinct case when weekday(created_at) = 3 then ws.website_session_id end) as 'thu',
       COUNT(distinct case when weekday(created_at) = 4 then ws.website_session_id end) as 'fri',
       COUNT(distinct case when weekday(created_at) = 5 then ws.website_session_id end) as 'sat',
       COUNT(distinct case when weekday(created_at) = 6 then ws.website_session_id end) as 'sun'
from website_sessions ws
WHERE created_at between '2012-09-15' AND '2012-11-15' 
GROUP BY 1
;