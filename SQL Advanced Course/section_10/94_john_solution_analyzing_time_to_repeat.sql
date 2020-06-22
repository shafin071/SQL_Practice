
select user_id, website_session_id, created_at
from website_sessions 
where created_at >= '2014-01-01' AND created_at < '2014-11-03' 
  AND is_repeat_session=0
;
          


-- drop temporary table sessions_with_repeat_for_time_diff;

-- CREATE temporary table sessions_with_repeat_for_time_diff
select ns.user_id,
       ns.website_session_id as new_session_id,
	   ns.created_at as new_session_created_at,
       ws.website_session_id AS repeat_session_id,
       ws.created_at as repeat_session_created_at
from
     (
     select user_id, website_session_id, created_at
	 from website_sessions 
	 where created_at >= '2014-01-01' AND created_at < '2014-11-03' 
		  AND is_repeat_session=0
     ) as ns
     LEFT JOIN
     website_sessions ws
     ON ws.user_id = ns.user_id
     AND ws.website_session_id > ns.website_session_id
     AND ws.created_at < '2014-11-03'
     AND ws.created_at >= '2014-01-01'
;


#----------------------------------------------------------------------------------------------------------------
drop temporary table users_first_to_second;

CREATE temporary table users_first_to_second
select
	 rs.user_id,
     rs.new_session_id,
     rs.new_session_created_at,
     MIN(repeat_session_id) AS second_session_id,
     MIN(repeat_session_created_at) AS second_session_created_at
from 
	(
     select ns.user_id,
       ns.website_session_id as new_session_id,
	   ns.created_at as new_session_created_at,
       ws.website_session_id AS repeat_session_id,
       ws.created_at as repeat_session_created_at
		from
			 (
			 select user_id, website_session_id, created_at
			 from website_sessions 
			 where created_at >= '2014-01-01' AND created_at < '2014-11-03' 
				  AND is_repeat_session=0
			 ) as ns
			 LEFT JOIN
			 website_sessions ws
			 ON ws.user_id = ns.user_id
			 AND ws.website_session_id > ns.website_session_id
			 AND ws.created_at < '2014-11-03'
			 AND ws.created_at >= '2014-01-01'
    ) rs
where repeat_session_id is not null
group by 1,2,3
;


#------------------------------------------------------------------------------------------------------

select user_id, datediff(second_session_created_at, new_session_created_at) as days_first_to_second_session
from users_first_to_second
;

select
	ROUND(AVG(days_first_to_second_session)) as avg_days_first_to_second,
		   MIN(days_first_to_second_session) AS min_days_first_to_second,
		   MAX(days_first_to_second_session) as max_days_first_to_second
from (
	  select user_id, datediff(second_session_created_at, new_session_created_at) as days_first_to_second_session
	  from users_first_to_second
	 ) tbl
;






	