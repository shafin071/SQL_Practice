
-- STEP 1: find the first website_pageview_id for relevant sessions
-- STEP 2: indentify the landing page of each session
-- STEP 3: counting pageviews for each session, to identify "bounces"
-- STEP 4: summarizing total sessions and bounced sessions by landing page

# -----------------------------------------------------------------------------------------------------------------------------------------    
-- STEP 1: find the first website_pageview_id for relevant sessions
create temporary table first_pageviews_demo
SELECT
	wp.website_session_id,
    MIN(wp.website_pageview_id) as min_pageview_id
FROM 
	website_pageviews wp
    inner join
    website_sessions ws
    ON wp.website_session_id = ws.website_session_id
WHERE ws.created_at between '2014-01-01' AND '2014-02-01'
GROUP BY wp.website_session_id
;


SELECT * from first_pageviews_demo;


# -----------------------------------------------------------------------------------------------------------------------------------------    
-- STEP 2: indentify the landing page of each session
create temporary table sessions_w_landing_page_demo
SELECT
	fpd.website_session_id,
	wp.pageview_url
from
	first_pageviews_demo fpd
    JOIN
    website_pageviews wp
    ON
    fpd.min_pageview_id = wp.website_pageview_id
    ;
    
select * from sessions_w_landing_page_demo;
    
    
# -----------------------------------------------------------------------------------------------------------------------------------------    
-- STEP 3: counting pageviews for each session, to identify "bounces"

create temporary table bounced_sessions_only
SELECT
	wp.website_session_id,
    wp.pageview_url as landing_page,
    count(distinct wp.website_pageview_id) as count_of_pages_viewed
FROM
	sessions_w_landing_page_demo slpd
    JOIN
    website_pageviews wp
    ON 
    slpd.website_session_id = wp.website_session_id
group by wp.website_session_id
having count_of_pages_viewed = 1
    ;

select * from bounced_sessions_only;
    
    
# -----------------------------------------------------------------------------------------------------------------------------------------   
-- STEP 4: summarizing total sessions and bounced sessions by landing page

select
	slpd.pageview_url as landing_page,
    slpd.website_session_id,
    bs.website_session_id AS bounced_website_session_id
from
	sessions_w_landing_page_demo slpd
    LEFT JOIN
	bounced_sessions_only bs
    ON slpd.website_session_id = bs.website_session_id
group by slpd.website_session_id
;



-- FINAL OUTPUT
select
	slpd.pageview_url as landing_page,
    COUNT(distinct slpd.website_session_id) as sessions,
    COUNT(distinct bs.website_session_id) as bounced_sessions,
    COUNT(distinct bs.website_session_id) / COUNT(distinct slpd.website_session_id) * 100 as bounce_rate
from
	sessions_w_landing_page_demo slpd
    LEFT JOIN
	bounced_sessions_only bs
    ON slpd.website_session_id = bs.website_session_id
group by slpd.pageview_url
;



	




    




