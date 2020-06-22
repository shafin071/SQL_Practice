

SELECT * FROM orders;


SELECT YEAR(created_at) as yr,
       MONTH(created_at) as mo,
       COUNT(distinct order_id) as number_of_sales,
       SUM(price_usd) as total_revenue,
       SUM(price_usd - cogs_usd) as total_margin
FROM orders 
where created_at <= '2013-01-04'
GROUP BY 1,2
;
