

select * 
from orders
where created_at between '2012-03-01' AND '2014-10-15'
;


select * 
from order_items
where created_at between '2012-03-01' AND '2014-10-15'
;


select * 
from order_item_refunds
where created_at between '2012-03-01' AND '2014-10-15'
;


drop temporary table ordered_items;

CREATE temporary table ordered_items
select o.order_id,
       o.created_at,
       oi.product_id,
       o.items_purchased,
       oi.is_primary_item,
       oi.order_item_id
from 
	orders o 
    JOIN
	order_items oi
    ON o.order_id = oi.order_id
where o.created_at between '2012-03-01' AND '2014-10-15'
;

select * from ordered_items;

select * 
from ordered_items oi
     LEFT JOIN
     order_item_refunds oir
	 ON oi.order_id = oir.order_id
order by oi.order_id
;


-- My solution
select YEAR(oi.created_at) as yr,
       MONTH(oi.created_at) as mo,
       COUNT(CASE WHEN oi.product_id=1 THEN oi.order_id end) as p1_orders,
       COUNT(CASE WHEN oir.order_item_id is not null AND oi.product_id=1 then oi.order_id end) / COUNT(CASE WHEN oi.product_id=1 THEN oi.order_item_id end) as p1_refund_rt,
       
       COUNT(CASE WHEN oi.product_id=2 THEN oi.order_id end) as p2_orders,
       COUNT(CASE WHEN oir.order_item_id is not null AND oi.product_id=2 then oi.order_id end) / COUNT(CASE WHEN oi.product_id=2 THEN oi.order_item_id end) as p2_refund_rt,
       
       COUNT(CASE WHEN oi.product_id=3 THEN oi.order_id end) as p3_orders,
       COUNT(CASE WHEN oir.order_item_id is not null AND oi.product_id=3 then oi.order_id end) / COUNT(CASE WHEN oi.product_id=3 THEN oi.order_item_id end) as p3_refund_rt,
       
       COUNT(CASE WHEN oi.product_id=4 THEN oi.order_id end) as p4_orders,
       COUNT(CASE WHEN oir.order_item_id is not null AND oi.product_id=4 then oi.order_id end) / COUNT(CASE WHEN oi.product_id=4 THEN oi.order_item_id end) as p3_refund_rt
from ordered_items oi
     LEFT JOIN
     order_item_refunds oir
	 ON oi.order_id = oir.order_id
group by 1,2
order by oi.order_id
;


-- John's solution: same result
select YEAR(oi.created_at) as yr,
       MONTH(oi.created_at) as mo,
       COUNT(CASE WHEN oi.product_id=1 THEN oi.order_item_id end) as p1_orders,
       COUNT(CASE WHEN oi.product_id=1 then oir.order_item_id end) / COUNT(CASE WHEN oi.product_id=1 THEN oi.order_item_id end) as p1_refund_rt,
       
       COUNT(CASE WHEN oi.product_id=2 THEN oi.order_item_id end) as p2_orders,
       COUNT(CASE WHEN oi.product_id=2 then oir.order_item_id end) / COUNT(CASE WHEN oi.product_id=2 THEN oi.order_item_id end) as p2_refund_rt,
       
       COUNT(CASE WHEN oi.product_id=3 THEN oi.order_item_id end) as p3_orders,
       COUNT(CASE WHEN oi.product_id=3 then oir.order_item_id end) / COUNT(CASE WHEN oi.product_id=3 THEN oi.order_item_id end) as p3_refund_rt,
       
       COUNT(CASE WHEN oi.product_id=4 THEN oi.order_item_id end) as p4_orders,
       COUNT(CASE WHEN oi.product_id=4 then oir.order_item_id end) / COUNT(CASE WHEN oi.product_id=4 THEN oi.order_item_id end) as p4_refund_rt
from ordered_items oi
     LEFT JOIN
     order_item_refunds oir
	 ON oi.order_id = oir.order_id
group by 1,2
order by oi.order_id
;