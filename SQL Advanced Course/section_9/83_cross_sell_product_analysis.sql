
select * from website_pageviews;

-- STEP 1: find pageview id and session id of sessions with cart and add new 'time_period' label
drop temporary table pageview_id_for_cart;

CREATE temporary table pageview_id_for_cart
select *,
       CASE WHEN created_at < '2013-09-25' then 'A. Pre_Cross_Sell'
            WHEN created_at >= '2013-09-25' then 'B. Post_Cross_Sell'
	   END AS time_period
from website_pageviews 
where pageview_url='/cart' 
      AND created_at BETWEEN '2013-08-25' AND '2013-10-25'
;

SELECT * from pageview_id_for_cart;


-- STEP 2: find website_sessions for cart and after
drop temporary table website_sessions_for_cart_and_after;

CREATE temporary table website_sessions_for_cart_and_after
select wp.website_session_id,
       wp.created_at,
	   wp.pageview_url,
       wp.website_pageview_id,
       pfc.time_period
from website_pageviews wp
     JOIN
     pageview_id_for_cart pfc
     ON wp.website_session_id = pfc.website_session_id
     AND wp.website_pageview_id >= pfc.website_pageview_id
;

SELECT * from website_sessions_for_cart_and_after;


-- STEP 3: Find after cart sessions
drop temporary table after_cart_sessions;

CREATE temporary table after_cart_sessions
SELECT wp.website_session_id,
       MIN(wp.website_pageview_id) as next_pageview_id,
       wp.pageview_url
from website_pageviews wp
     JOIN
     pageview_id_for_cart pfc
     ON wp.website_session_id = pfc.website_session_id
     AND wp.website_pageview_id > pfc.website_pageview_id
GROUP BY 1
;

SELECT * from after_cart_sessions;


-- STEP 4: Combine website_sessions_for_cart_and_after and after_cart_sessions with left join
drop temporary table all_cart_sessions;

CREATE temporary table all_cart_sessions
select wsc.website_session_id,
       wsc.created_at,
       wsc.pageview_url,
       acs.next_pageview_id,
       acs.pageview_url as next_page_url,
       wsc.time_period
from website_sessions_for_cart_and_after wsc
	 LEFT JOIN
     after_cart_sessions acs
     ON wsc.website_session_id = acs.website_session_id
order by wsc.website_session_id
;

SELECT * from all_cart_sessions;


-- STEP 5: all_cart_sessions left join with order
select acs.time_period, acs.website_session_id, acs.created_at, acs.pageview_url, acs.next_page_url, 
       o.order_id, o.primary_product_id, o.items_purchased, o.price_usd, o.cogs_usd
from all_cart_sessions  acs
     left join 
     orders o
     ON acs.website_session_id = o.website_session_id
group by acs.website_session_id
order by acs.website_session_id
;


select time_period, 
       COUNT(distinct website_session_id) as cart_sessions,
       COUNT(distinct CASE WHEN next_page_url is not null then website_session_id end) as clickthroughs,
       COUNT(distinct CASE WHEN next_page_url is not null then website_session_id end) / COUNT(distinct website_session_id) as cart_ctr,
       COUNT(distinct order_id) as orders_placed,
       SUM(items_purchased) as products_purchased,
       SUM(items_purchased) / COUNT(distinct order_id) as products_per_order,
       SUM(price_usd) / COUNT(distinct order_id) as avg_order_val,
       SUM(price_usd) / COUNT(distinct website_session_id) as rev_per_cart_session
from (
	  select acs.time_period, acs.website_session_id, acs.created_at, acs.pageview_url, acs.next_page_url, 
			   o.order_id, o.primary_product_id, o.items_purchased, o.price_usd, o.cogs_usd
		from all_cart_sessions  acs
			 left join 
			 orders o
			 ON acs.website_session_id = o.website_session_id
		group by acs.website_session_id
		order by acs.website_session_id
	 ) tbl
group by time_period
;

