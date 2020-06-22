

-- STEP 1: find the relevant/products pageviews with website_session_id

drop temporary table product_pageviews;

CREATE temporary table product_pageviews
select website_session_id,
       website_pageview_id,
       created_at,
	   CASE WHEN DATE(created_at) < '2013-01-06' THEN 'A. Pre_Product_2' ELSE 'B. Post_Product_2' END AS time_period
from website_pageviews
where created_at BETWEEN '2012-10-06' AND '2014-04-06'
      AND pageview_url = '/products'
group by 1
;

select * from product_pageviews;


# ----------------------------------------------------------------------------------------------------------------------------------------------------
-- STEP 2: find next pageview id after clicking products

drop temporary table session_w_next_pageview_id;

create temporary table session_w_next_pageview_id
SELECT pp.time_period,
       pp.website_session_id,
       pp.website_pageview_id,
	   MIN(wp.website_pageview_id) AS min_next_pageview_id
from
	product_pageviews pp
    LEFT JOIN
    website_pageviews wp
    ON pp.website_session_id = wp.website_session_id
    AND wp.website_pageview_id > pp.website_pageview_id
GROUP BY 1,2
;

select * from session_w_next_pageview_id;


# ----------------------------------------------------------------------------------------------------------------------------------------------------
-- STEP 3: find pageview_url of next pageview id after clicking products

drop temporary table session_w_next_pageview_url;

create temporary table session_w_next_pageview_url
select snp.time_period,
       snp.website_session_id,
	   wp.pageview_url as next_pageview_url
from
    session_w_next_pageview_id snp
    LEFT JOIN
    website_pageviews wp
    ON snp.min_next_pageview_id = wp.website_pageview_id
;

select * from session_w_next_pageview_url;


# ----------------------------------------------------------------------------------------------------------------------------------------------------

-- STEP 4: summarize data and analyze the pre vs post periods
 SELECT time_period,
        COUNT(distinct website_session_id) AS sessions,
        COUNT(distinct case when next_pageview_url is not null then website_session_id end) AS w_next_page,
        COUNT(distinct case when next_pageview_url is not null then website_session_id end) / COUNT(distinct website_session_id) AS pct_w_next_page,
        COUNT(distinct case when next_pageview_url = '/the-original-mr-fuzzy' then website_session_id end) AS to_mrfuzzy,
        COUNT(distinct case when next_pageview_url = '/the-original-mr-fuzzy' then website_session_id end) / COUNT(distinct website_session_id) AS pct_to_mrfuzzy,
        COUNT(distinct case when next_pageview_url = '/the-forever-love-bear' then website_session_id end) AS to_lovebear,
        COUNT(distinct case when next_pageview_url = '/the-forever-love-bear' then website_session_id end) / COUNT(distinct website_session_id) AS pct_to_lovebear
 FROM session_w_next_pageview_url
 group by 1;
 






