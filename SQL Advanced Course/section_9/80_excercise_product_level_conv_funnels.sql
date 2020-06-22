
-- Step 1: Find all sessions with mrfuzzy and lovebear and create new column product_seen

drop temporary table product_pageviews_id;

CREATE temporary table product_pageviews_id
select *,
       CASE WHEN pageview_url='/the-original-mr-fuzzy' then 'mrfuzzy'
            WHEN pageview_url='/the-forever-love-bear' then 'lovebear'
	   END AS product_seen
from website_pageviews wp
where created_at between '2013-01-06' AND '2013-04-10'
      AND pageview_url IN ('/the-original-mr-fuzzy', '/the-forever-love-bear')
;

select * from product_pageviews_id;


# ----------------------------------------------------------------------------------------------------------------------------------------------------
-- STEP 2: Find all pages visited during the sessions found in step 1 

drop temporary table pageview_urls_from_products;

CREATE temporary table pageview_urls_from_products
select wp.website_session_id,
       wp.website_pageview_id,
	   wp.pageview_url,
       pgi.product_seen
from website_pageviews wp
     JOIN
     product_pageviews_id pgi
     ON wp.website_session_id = pgi.website_session_id
WHERE wp.pageview_url in ('/products', '/the-original-mr-fuzzy', '/the-forever-love-bear', '/cart', '/shipping', '/billing-2', '/thank-you-for-your-order')
;

select * from pageview_urls_from_products;

# ----------------------------------------------------------------------------------------------------------------------------------------------------
-- STEP 3: convert page url to binary

drop temporary table pages_visited;

CREATE temporary table pages_visited
select website_session_id, product_seen,
       MAX(CASE when pageview_url = '/products' then 1 else 0 end) as to_products,
	   MAX(CASE when pageview_url = '/the-original-mr-fuzzy' then 1 else 0 end) AS to_mrfuzzy,
       MAX(CASE when pageview_url = '/the-forever-love-bear' then 1 else 0 end) AS to_lovebear,
	   MAX(CASE when pageview_url = '/cart' then 1 else 0 end) AS cart,
	   MAX(CASE when pageview_url = '/shipping' then 1 else 0 end) AS shipping,
	   MAX(CASE when pageview_url = '/billing-2' then 1 else 0 end) AS billing,
	   MAX(CASE when pageview_url = '/thank-you-for-your-order' then 1 else 0 end) AS thank_you
from pageview_urls_from_products
group by 1
;

select * from pages_visited;


# ----------------------------------------------------------------------------------------------------------------------------------------------------
-- STEP 4: Output 1

select product_seen, 
       COUNT(distinct website_session_id) as sessions,
       COUNT(distinct case when cart=1 then website_session_id end) as to_cart,
       COUNT(distinct case when shipping=1 then website_session_id end) as to_shipping,
       COUNT(distinct case when billing=1 then website_session_id end) as to_billing,
       COUNT(distinct case when thank_you=1 then website_session_id end) as to_thankyou
from pages_visited
group by product_seen
;


# ----------------------------------------------------------------------------------------------------------------------------------------------------
-- STEP 4: Output 2

select product_seen, 
       COUNT(distinct case when cart=1 then website_session_id end) / COUNT(distinct website_session_id) as product_page_click_rt,
       COUNT(distinct case when shipping=1 then website_session_id end) / COUNT(distinct case when cart=1 then website_session_id end) as cart_click_rt,
       COUNT(distinct case when billing=1 then website_session_id end) / COUNT(distinct case when shipping=1 then website_session_id end) as shipping_click_rt,
       COUNT(distinct case when thank_you=1 then website_session_id end) / COUNT(distinct case when billing=1 then website_session_id end) as billing_click_rt
from pages_visited
group by product_seen
;



       




