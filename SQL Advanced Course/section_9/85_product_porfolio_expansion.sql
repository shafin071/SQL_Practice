
drop temporary table session_with_time_period;

CREATE temporary table session_with_time_period
select *,
       CASE WHEN created_at < '2013-12-12' then 'A. Pre_Birthday_Bear'
            WHEN created_at > '2013-12-12' then 'B. Post_Birthday_Bear'
	   END AS time_period
from website_pageviews wp
where created_at between '2013-11-12' AND '2014-01-12'
;

select * from session_with_time_period;



drop temporary table sessions_with_without_orders;

CREATE temporary table sessions_with_without_orders
select swp.time_period, swp.website_session_id, 
	   o.order_id, o.items_purchased, o.price_usd, o.cogs_usd
from session_with_time_period swp
     LEFT JOIN
     orders o
     ON swp.website_session_id = o.website_session_id
group by swp.website_session_id
order by swp.website_session_id
;

select * from sessions_with_without_orders;


select time_period, 
	   COUNT(distinct website_session_id) as sessions,
       COUNT(distinct order_id) as orders,
       COUNT(distinct order_id) / COUNT(distinct website_session_id) as conv_rate,
       SUM(price_usd) / COUNT(distinct order_id) as avg_order_value,
       SUM(items_purchased) / COUNT(distinct order_id) as products_per_order,
       SUM(price_usd) / COUNT(distinct website_session_id) as rev_per_session
from sessions_with_without_orders
group by time_period
;






