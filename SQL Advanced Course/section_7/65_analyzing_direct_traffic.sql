use mavenfuzzyfactory;

SELECT *
FROM website_sessions
WHERE created_at BETWEEN '2012-03-01' AND '2012-12-23'
;


SELECT YEAR(created_at) as yr,
	   MONTH(created_at) as mo,
       COUNT(distinct CASE WHEN utm_campaign='nonbrand' then website_session_id end) AS nonbrand,
       COUNT(distinct CASE WHEN utm_campaign='brand' then website_session_id end) AS brand,
       COUNT(distinct CASE WHEN utm_campaign='brand' then website_session_id end) / COUNT(distinct CASE WHEN utm_campaign='nonbrand' then website_session_id end) as brand_pct_of_nonbrand,
       COUNT(distinct CASE WHEN utm_source is null AND http_referer is NULL then website_session_id end) as direct,
       COUNT(distinct CASE WHEN utm_source is null AND http_referer is NULL then website_session_id end) / COUNT(distinct CASE WHEN utm_campaign='nonbrand' then website_session_id end) as direct_pct_of_nonbrand,
	   COUNT(distinct CASE WHEN utm_source is null AND http_referer is not NULL then website_session_id end) as organic,
       COUNT(distinct CASE WHEN utm_source is null AND http_referer is not NULL then website_session_id end) / COUNT(distinct CASE WHEN utm_campaign='nonbrand' then website_session_id end) as organic_pct_of_nonbrand
FROM website_sessions
WHERE created_at BETWEEN '2012-03-01' AND '2012-12-23'
GROUP BY 1,2
;