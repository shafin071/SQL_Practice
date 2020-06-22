use mavenfuzzyfactory;


select * from orders;
select * from order_items;

select *
from order_items where is_primary_item = 0
;

select 
       o.primary_product_id,
	   oi.product_id as cross_sell_product,
       COUNT(distinct o.order_id) as orders
from orders o
     LEFT JOIN
     order_items oi
     ON o.order_id = oi.order_id
	 AND oi.is_primary_item = 0
group by 1, 2
;


-- pivoting
select 
       o.primary_product_id,
       COUNT(distinct o.order_id) as orders,
       COUNT(distinct case when oi.product_id=1 then o.order_id end) as x_sell_prod1,
       COUNT(distinct case when oi.product_id=2 then o.order_id end) as x_sell_prod2,
       COUNT(distinct case when oi.product_id=3 then o.order_id end) as x_sell_prod3
from orders o
     LEFT JOIN
     order_items oi
     ON o.order_id = oi.order_id
	 AND oi.is_primary_item = 0
group by 1
;


