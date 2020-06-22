use mavenfuzzyfactory;


select * from orders;

select * from website_sessions where created_at between '2014-01-01' AND '2014-11-01' order by user_id;


-- This is not what the assignment asked.
-- Assignment: Find all new users and repeat users within 2014 time window.
-- What I did: count all users during the time period including repeat sessions where the original session for that user was before the time period
select repeat_sessions, COUNT(distinct user_id) as users
from (
		select 
			   user_id,
			   SUM(is_repeat_session) as repeat_sessions
		from website_sessions 
		where created_at between '2014-01-01' AND '2014-11-01' 
		group by user_id
		order by repeat_sessions
	 ) tbl
group by 1
;

#-------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Correct solution:

-- Step 1: find all new users in 2014
select 
	   user_id,
	   website_session_id,
       created_at,
       is_repeat_session
from website_sessions 
where created_at between '2014-01-01' AND '2014-11-01' 
      AND is_repeat_session=0
;


-- Step 2: join Step 1 table with website session

select ns.user_id,
       ns.website_session_id as new_session_id,
       ws.website_session_id as repeat_session_id,
       ws.is_repeat_session
from (
		select 
			   user_id,
			   website_session_id,
			   created_at,
			   is_repeat_session
		from website_sessions 
		where created_at >= '2014-01-01' AND created_at < '2014-11-01' 
			  AND is_repeat_session=0
     ) ns
     JOIN
     website_sessions ws
     ON ws.user_id = ns.user_id
WHERE ws.created_at >= '2014-01-01' AND ws.created_at < '2014-11-01'
;


-- Step 3: find sum of repeat sessions
drop temporary table sum_repeat_sessions;

CREATE temporary table sum_repeat_sessions
select user_id, SUM(is_repeat_session) as repeat_sessions
from (
      select ws.user_id,
		     ns.website_session_id as new_session_id,
		     ws.website_session_id as repeat_session_id,
		     ws.is_repeat_session
		from (
				select 
					   user_id,
					   website_session_id,
					   created_at,
					   is_repeat_session
				from website_sessions 
				where created_at between '2014-01-01' AND '2014-11-01' 
					  AND is_repeat_session=0
			 ) ns
			 LEFT JOIN
			 website_sessions ws
			 ON ws.user_id = ns.user_id
		WHERE ws.created_at >= '2014-01-01' AND ws.created_at < '2014-11-01'
	 ) us
group by 1
;

select * from sum_repeat_sessions;


-- Step 4: group by sum of repeat sessions and show final result
select repeat_sessions, COUNT(distinct user_id) as users
from sum_repeat_sessions
group by 1
;


select * from website_sessions where user_id = 272007 AND created_at between '2014-01-01' AND '2014-11-01';

select * from website_sessions where user_id = 272007;






#----------------------------------------------------------------------------------------------------------------------------



SELECT user_id,
   is_repeat_session,
   SUM(is_repeat_session) AS repeat_sessions
FROM website_sessions
WHERE created_at BETWEEN '2014-01-01' AND '2014-11-01'
GROUP BY 1
;


SELECT repeat_sessions,
   COUNT(user_id) AS users
FROM(
SELECT user_id,
   is_repeat_session,
   SUM(is_repeat_session) AS repeat_sessions
FROM website_sessions
WHERE created_at BETWEEN '2014-01-01' AND '2014-11-01'
GROUP BY 1) AS subquery
WHERE is_repeat_session = 0
GROUP BY 1
ORDER BY 1;


-- By Minh. Nice solution:
select
	sessions -1 as repeat_sessions,  -- exclude their first session
	count(distinct user_id) as users
from
	(select -- all user having first visit 
	user_id,
			count(distinct website_session_id) as sessions
	from website_sessions
	where created_at >= '2014-01-01' and created_at < '2014-11-01'
	group by user_id
	having min(is_repeat_session)=0)  -- if min = 1, they have already visited before 2014
    as new_users
group by sessions
order by sessions
;

-- checking his subquery:
select -- all user having first visit 
	user_id,
			count(distinct website_session_id) as sessions
	from website_sessions
	where created_at >= '2014-01-01' and created_at < '2014-11-01'
	group by user_id
	having min(is_repeat_session)=0
    ;
     



