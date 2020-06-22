

select primary_product_id, 
	   COUNT(order_id) as orders,
       SUM(price_usd) AS revenue,
       SUM(price_usd - cogs_usd) as margin,
       AVG(price_usd) as aov
from orders
where order_id between 10000 AND 11000
group by 1
order by 2 desc
;