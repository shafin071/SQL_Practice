
SELECT
	MIN(DATE(created_at)) AS week_start_date,
    COUNT(distinct website_session_id) as sessions
FROM
	website_sessions
WHERE created_at < '2012-05-10' AND utm_source = 'gsearch' AND utm_campaign = 'nonbrand'
GROUP BY YEAR(created_at), WEEK(created_at)
;
	