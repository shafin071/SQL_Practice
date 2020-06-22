
use mavenfuzzyfactory;


SELECT utm_content
FROM website_sessions
WHERE created_at BETWEEN '2014-01-01' AND '2014-02-01'
;

SELECT utm_content,
	   COUNT(distinct website_session_id) AS sessions
FROM website_sessions
WHERE created_at BETWEEN '2014-01-01' AND '2014-02-01'
GROUP BY 1
;


SELECT ws.utm_content,
	   COUNT(distinct ws.website_session_id) AS sessions,
       COUNT(distinct o.website_session_id) AS orders,
       COUNT(distinct o.website_session_id) / COUNT(distinct ws.website_session_id) AS conv_rate
FROM website_sessions ws
	 LEFT JOIN
     orders o
     ON o.website_session_id = ws.website_session_id
WHERE ws.created_at BETWEEN '2014-01-01' AND '2014-02-01'
GROUP BY 1
;

