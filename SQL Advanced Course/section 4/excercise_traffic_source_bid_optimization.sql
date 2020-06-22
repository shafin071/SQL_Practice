
SELECT
	ws.device_type, 
    COUNT(distinct ws.website_session_id) as sessions,
    COUNT(distinct o.order_id) as orders,
    COUNT(distinct o.order_id) / COUNT(distinct ws.website_session_id) * 100 AS session_to_order_conv_rate
FROM
	website_sessions ws
    LEFT JOIN
    orders o
    ON ws.website_session_id = o.website_session_id
WHERE ws.created_at < '2012-05-10' AND ws.utm_source = 'gsearch' AND ws.utm_campaign = 'nonbrand'
GROUP BY
	ws.device_type
    ;
