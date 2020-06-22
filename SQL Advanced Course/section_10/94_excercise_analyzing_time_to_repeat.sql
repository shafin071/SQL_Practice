

select user_id, website_session_id, is_repeat_session
from website_sessions 
where created_at between '2014-01-01' AND '2014-11-03' 
      AND is_repeat_session=0
;


drop temporary table next_session_ids;

CREATE temporary table next_session_ids
select fs.user_id, 
	   fs.website_session_id, 
       fs.created_at,
	   ws.website_session_id as next_session_id, 
       ws.created_at as next_created_at,
       datediff(ws.created_at, fs.created_at) as date_diff
from (
      select user_id, website_session_id, is_repeat_session, created_at
	  from website_sessions 
      where created_at between '2014-01-01' AND '2014-11-03' 
			AND is_repeat_session=0
	 ) fs
     JOIN
     website_sessions ws
     ON fs.user_id = ws.user_id
     AND ws.website_session_id > fs.website_session_id
where ws.created_at between '2014-01-01' AND '2014-11-03' 
group by 1
;

select * from next_session_ids;


select *, datediff(next_created_at, created_at)
from next_session_ids
;


select ROUND(AVG(datediff(next_created_at, created_at)), 2) as avg_days_first_to_second,
	   MIN(datediff(next_created_at, created_at)) AS min_days_first_to_second,
	   MAX(datediff(next_created_at, created_at)) as max_days_first_to_second
from next_session_ids
;








