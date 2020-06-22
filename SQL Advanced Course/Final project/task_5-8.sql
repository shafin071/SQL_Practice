
use mavenfuzzyfactory;

select * from order_items;

-- 5. Show monthly trend for revenue and margin by product, along with total sales and revenue

select YEAR(created_at), MONTH(created_at), 
	   SUM(CASE WHEN product_id=1 THEN price_usd END) as prod_1_rev,
       SUM(CASE WHEN product_id=2 THEN price_usd END) as prod_2_rev,
       SUM(CASE WHEN product_id=3 THEN price_usd END) as prod_3_rev,
       SUM(CASE WHEN product_id=4 THEN price_usd END) as prod_4_rev,
       
       SUM(CASE WHEN product_id=1 THEN (price_usd-cogs_usd) END) as prod_1_margin,
       SUM(CASE WHEN product_id=2 THEN (price_usd-cogs_usd) END) as prod_2_margin,
       SUM(CASE WHEN product_id=3 THEN (price_usd-cogs_usd) END) as prod_3_margin,
       SUM(CASE WHEN product_id=4 THEN (price_usd-cogs_usd) END) as prod_4_margin,
       
       COUNT(distinct order_id) as total_sales,
       SUM(price_usd) as total_revenue,
       SUM(price_usd-cogs_usd) as total_margin

from order_items 
group by 1,2
;


# -----------------------------------------------------------------------------------------------------------------------------------------


-- 6. Show monthly sessions to /product page and show clickthrough rate to next page. 
--    Also show monthly trend of conversion from /products to order

-- Step 1: find all sessions with /products
select *
from website_pageviews 
where pageview_url = '/products'
;

-- Step 2: Left join step 1 table with website pageviews to find next page (if any) after /products
drop temporary table product_seesions;

CREATE temporary table product_sessions
select p.website_session_id,
       p.pageview_url,
       p.website_pageview_id,
       p.created_at,
       wp.website_session_id as next_session_id,
       wp.pageview_url as next_url,
       wp.website_pageview_id as next_pageview_id
from (select website_session_id,
		     pageview_url,
		     website_pageview_id,
             created_at
		from website_pageviews 
		where pageview_url = '/products'
		) p
	 LEFT JOIN
     website_pageviews wp
     ON p.website_session_id = wp.website_session_id
     AND p.website_pageview_id <  wp.website_pageview_id
group by p.website_session_id 
;

select * from product_sessions;

-- Step 3: left join with order and show result
select YEAR(ps.created_at) as Yr, MONTH(ps.created_at) as Mo,
       COUNT(distinct ps.website_session_id) as sessions,
       ROUND(COUNT(distinct ps.next_session_id) / COUNT(distinct ps.website_session_id), 2) as product_click_rate,
       COUNT(distinct o.order_id) as orders,
       ROUND(COUNT(distinct o.order_id) / COUNT(distinct ps.website_session_id), 3) as conv_rate
       
from product_sessions ps
     LEFT JOIN
     orders o
     ON ps.website_session_id = o.website_session_id
group by 1,2
;


# -----------------------------------------------------------------------------------------------------------------------------------------

-- 7. Show how well each product cross-sell from one another since Dec 05, 2014

select * from orders;
select * from order_items;

-- Step 1: find all cross sold items
select order_id, product_id, is_primary_item from order_items where is_primary_item=0;


drop temporary table x_sell;

CREATE temporary table x_sell
select o.order_id, o.website_session_id, o.primary_product_id, o.items_purchased, 
       csi.order_id as cross_sold_order_id, csi.product_id, csi.is_primary_item
from orders o
	 LEFT JOIN
     (select order_id, product_id, is_primary_item from order_items where is_primary_item=0) csi
     ON o.order_id = csi.order_id
WHERE o.created_at >= '2014-12-05'
;

select * from x_sell;


select primary_product_id,
       COUNT(distinct order_id) as orders,
	   COUNT(distinct CASE WHEN product_id=1 then cross_sold_order_id end) as prod_1_x_sold,
	   COUNT(distinct CASE WHEN product_id=2 then cross_sold_order_id end) as prod_2_x_sold,
       COUNT(distinct CASE WHEN product_id=3 then cross_sold_order_id end) as prod_3_x_sold,
       COUNT(distinct CASE WHEN product_id=4 then cross_sold_order_id end) as prod_4_x_sold,
       
       COUNT(distinct CASE WHEN product_id=1 then cross_sold_order_id end) / COUNT(distinct order_id) as x_sold_1,
       COUNT(distinct CASE WHEN product_id=2 then cross_sold_order_id end) / COUNT(distinct order_id) as x_sold_2,
       COUNT(distinct CASE WHEN product_id=3 then cross_sold_order_id end) / COUNT(distinct order_id) as x_sold_3,
       COUNT(distinct CASE WHEN product_id=4 then cross_sold_order_id end) / COUNT(distinct order_id) as x_sold_4
       
from x_sell
group by 1;



