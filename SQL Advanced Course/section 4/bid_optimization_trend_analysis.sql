
SELECT 
	MONTH(created_at), 
    WEEK(created_at), YEAR(created_at), 
    MIN(DATE(created_at)),
    COUNT( DISTINCT website_session_id) as sessions
FROM website_sessions
WHERE website_session_id BETWEEN 100000 AND 115000
GROUP BY 1,2
;


-- Pivot table

SELECT 
	primary_product_id,
    COUNT(CASE WHEN items_purchased = 1 then order_id ELSE NULL END) AS single_item_orders,
    COUNT(CASE WHEN items_purchased = 2 then order_id ELSE NULL END) AS two_item_orders
FROM orders
WHERE order_id between 31000 AND 32000
GROUP BY 1
;

