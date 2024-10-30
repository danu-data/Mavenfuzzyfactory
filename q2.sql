select year(website_sessions.created_at) as year,quarter(website_sessions.created_at) as quarter, 
count(distinct order_id)/count(distinct website_sessions.website_session_id) as conversion_rate,
sum(orders.items_purchased *orders.price_usd)/count(distinct order_id) as revenue_per_order,
sum(orders.items_purchased *orders.price_usd)/count(distinct website_sessions.website_session_id) as revenue_per_session
from website_sessions
left join orders
on website_sessions.website_session_id = orders.website_session_id
group by 1,2