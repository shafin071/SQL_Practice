
SELECT
	DATE(MIN(created_at)) AS week_start_date,
    COUNT(CASE WHEN device_type = 'desktop' THEN device_type END) AS dtop_sessions,
    COUNT(CASE WHEN device_type = 'mobile' THEN device_type END) AS mob_sessions
FROM website_sessions
WHERE created_at BETWEEN '2012-04-15' AND '2012-06-09' AND utm_source = 'gsearch' AND utm_campaign = 'nonbrand'
GROUP BY YEAR(created_at), WEEK(created_at)
;