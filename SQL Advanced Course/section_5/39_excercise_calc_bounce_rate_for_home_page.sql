-- STEP 1: find the first website_pageview_id for relevant sessions
-- STEP 2: indentify the landing page of each session
-- STEP 3: counting pageviews for each session, to identify "bounces"
-- STEP 4: summarizing total sessions and bounced sessions by landing page

# ---------------------------------------------------------------------------------------------------------------

use mavenfuzzyfactory;

select * from website_pageviews;


-- STEP 1: find the first website_pageview_id for relevant sessions

drop temporary table if exists first_pageviews;

create temporary table first_pageviews
select website_session_id, MIN(website_pageview_id) as landing_page_id
from website_pageviews 
where created_at < '2012-06-14'
group by website_session_id;

select * from first_pageviews;
select * from first_pageviews where website_session_id = 175251;
select * from website_pageviews where website_session_id = 175251;
select * from website_sessions where website_session_id = 175251;

# ------------------------------------------------------------------------------------------------------------------
-- STEP 2: find all the sessions where /home was the landing page

drop temporary table if exists first_pageviews_url;

create temporary table first_pageviews_url
SELECT
	wp.website_session_id,
    wp.website_pageview_id,
	wp.pageview_url
FROM 
	website_pageviews wp
    RIGHT JOIN
    first_pageviews fp
    ON wp.website_pageview_id = fp.landing_page_id
WHERE wp.pageview_url = '/home'
;

select * from first_pageviews_url;
select * from first_pageviews_url where pageview_url = '/products';
select distinct pageview_url from first_pageviews_url;


# ------------------------------------------------------------------------------------------------------------------
-- STEP 3: counting pageviews for each session, to identify "bounces"

drop temporary table if exists bounced_pageview_url;

create temporary table bounced_pageview_url
select wp.website_session_id, 
	   wp.pageview_url, 
       COUNT(wp.website_pageview_id) as pageview_count
from website_pageviews wp
	 JOIN
     first_pageviews_url fpu
	 ON wp.website_session_id = fpu.website_session_id
group by wp.website_session_id
having COUNT(wp.website_pageview_id) = 1
;

select * from bounced_pageview_url;


# ------------------------------------------------------------------------------------------------------------------
-- STEP 4: summarizing total sessions and bounced sessions by landing page


SELECT
	fpu.pageview_url,
    fpu.website_session_id,
    bpu.website_session_id
FROM
	first_pageviews_url fpu
    LEFT JOIN
	bounced_pageview_url bpu
    ON fpu.website_session_id = bpu.website_session_id
    ;



SELECT
	fpu.pageview_url,
    COUNT(distinct fpu.website_session_id),
    COUNT(distinct bpu.website_session_id),
    COUNT(distinct bpu.website_session_id) / COUNT(distinct fpu.website_session_id) as bounce_rate
FROM
	first_pageviews_url fpu
    LEFT JOIN
	bounced_pageview_url bpu
    ON fpu.website_session_id = bpu.website_session_id
GROUP BY fpu.pageview_url
    ;
    
    

    


	








