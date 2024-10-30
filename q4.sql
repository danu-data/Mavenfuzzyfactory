create temporary table sessions_rate
select year(website_sessions.created_at) as year,quarter(website_sessions.created_at) as quarters, 
count(distinct order_id)/count(distinct website_sessions.website_session_id) as conversion_rate,
sum(orders.items_purchased *orders.price_usd)/count(distinct order_id) as revenue_per_order,
sum(orders.items_purchased *orders.price_usd)/count(distinct website_sessions.website_session_id) as revenue_per_session
from website_sessions
left join orders
on website_sessions.website_session_id = orders.website_session_id
group by 1,2
;

select 
year(website_sessions.created_at) as year,
quarter(website_sessions.created_at) as quarter,
count(distinct case when utm_source= 'gsearch' and  utm_campaign = 'nonbrand' then  order_id else null end)/count(distinct case when utm_source= 'gsearch' and  utm_campaign = 'nonbrand' then  website_sessions.website_session_id else null end )as gserach_nb_con_rate,
count(distinct case when utm_source= 'bsearch' and  utm_campaign = 'nonbrand' then  order_id else null end)/count(distinct case when utm_source= 'bsearch' and  utm_campaign = 'nonbrand' then  website_sessions.website_session_id else null end )as bserach_nb_con_rate

from website_sessions
left join orders
on website_sessions.website_session_id =orders.website_session_id
group by 1,2
