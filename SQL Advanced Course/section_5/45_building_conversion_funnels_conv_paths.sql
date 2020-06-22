

-- STEP 1: select all pageviews for relevant sessions
-- STEP 2: identify each relevant pageview as the specific funnel step
-- STEP 3: create the session_level conversion funnel view
-- STEP 4: aggregate the data to assess funnel performance


-- STEP 1: select all pageviews for relevant sessions
-- STEP 2: identify each relevant pageview as the specific funnel step
select 
	wp.website_session_id,
    wp.pageview_url,
    ws.created_at,
    CASE WHEN wp.pageview_url = '/products' THEN 1 ELSE 0 END AS products_page,
    CASE WHEN wp.pageview_url = '/the-original-mr-fuzzy' THEN 1 ELSE 0 END AS mrfuzzy_page,
    CASE WHEN wp.pageview_url = '/cart' THEN 1 ELSE 0 END AS carts_page
from
	website_sessions ws 
    LEFT JOIN
    website_pageviews wp
    ON wp.website_session_id = ws.website_session_id
WHERE ws.created_at BETWEEN '2014-01-01' AND '2014-02-01'
      AND wp.pageview_url IN ('/lander-2', '/products', '/the-original-mr-fuzzy', '/cart')
ORDER BY
	ws.website_session_id,
    ws.created_at
;



-- STEP 3: create the session_level conversion funnel view

drop temporary table if exists session_made_it_flag_demo;

create temporary table session_made_it_flag_demo
SELECT
	website_session_id,
    MAX(products_page) AS products_made_it,
    MAX(mrfuzzy_page) AS mrfuzzy_made_it,
    MAX(carts_page) AS carts_made_it
FROM
	(
		select 
			wp.website_session_id,
			wp.pageview_url,
			ws.created_at,
			CASE WHEN wp.pageview_url = '/products' THEN 1 ELSE 0 END AS products_page,
			CASE WHEN wp.pageview_url = '/the-original-mr-fuzzy' THEN 1 ELSE 0 END AS mrfuzzy_page,
			CASE WHEN wp.pageview_url = '/cart' THEN 1 ELSE 0 END AS carts_page
		from
			website_sessions ws 
			LEFT JOIN
			website_pageviews wp
			ON wp.website_session_id = ws.website_session_id
		WHERE ws.created_at BETWEEN '2014-01-01' AND '2014-02-01'
			  AND wp.pageview_url IN ('/lander-2', '/products', '/the-original-mr-fuzzy', '/cart')
		ORDER BY
			ws.website_session_id,
			ws.created_at
    ) AS pageview_level
GROUP BY website_session_id
    ;
    
    
select * from session_made_it_flag_demo;


-- STEP 4: aggregate the data to assess funnel performance

SELECT
	COUNT(distinct website_session_id) AS sessions,
	COUNT(distinct CASE WHEN products_made_it = 1 THEN website_session_id ELSE NULL END) AS to_products,
    COUNT(distinct CASE WHEN mrfuzzy_made_it = 1 THEN website_session_id ELSE NULL END) AS to_mrfuzzy,
    COUNT(distinct CASE WHEN carts_made_it = 1 THEN website_session_id ELSE NULL END) AS to_carts
FROM 
	session_made_it_flag_demo
;


-- get click rates

SELECT
	COUNT(distinct website_session_id) AS sessions,
	COUNT(distinct CASE WHEN products_made_it = 1 THEN website_session_id ELSE NULL END) /  COUNT(distinct website_session_id) AS lander_clickthrough_rate_to_products,
    COUNT(distinct CASE WHEN mrfuzzy_made_it = 1 THEN website_session_id ELSE NULL END) / COUNT(distinct CASE WHEN products_made_it = 1 THEN website_session_id ELSE NULL END) AS product_clickthrough_rate_to_mrfuzzy,
    COUNT(distinct CASE WHEN carts_made_it = 1 THEN website_session_id ELSE NULL END) / COUNT(distinct CASE WHEN mrfuzzy_made_it = 1 THEN website_session_id ELSE NULL END) AS mrfuzzy_clickthrough_rate_to_cart
FROM 
	session_made_it_flag_demo
;








