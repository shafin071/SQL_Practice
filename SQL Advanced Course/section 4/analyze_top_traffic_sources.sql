USE mavenfuzzyfactory;

SELECT * from website_sessions;


SELECT * FROM website_sessions where website_session_id BETWEEN 1000 AND 2000;

-- Find utm_content that brings the most sessions and conversion rate
SELECT 
	ws.utm_content, 
    COUNT(DISTINCT ws.website_session_id) as sessions,
    COUNT(DISTINCT o.order_id) AS orders,
	COUNT(DISTINCT o.order_id) / COUNT(DISTINCT ws.website_session_id) * 100 AS 'session_to_order_conv_rate(%)'
FROM website_sessions ws
	LEFT JOIN
    orders o
    ON ws.website_session_id = o.website_session_id
where ws.website_session_id BETWEEN 1000 AND 2000 
GROUP BY ws.utm_content
ORDER BY sessions DESC;



SELECT * FROM website_pageviews where website_session_id = 1059;

SELECT * FROM orders WHERE website_session_id = 1059;
