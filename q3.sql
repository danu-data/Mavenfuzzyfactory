select 
year(website_sessions.created_at) as year,
quarter(website_sessions.created_at) as quarter,
count(distinct case when utm_source= 'gsearch' and  utm_campaign = 'nonbrand' then order_id else null end) as gsearch_nonbrand,
count(distinct case when utm_source= 'bsearch' and  utm_campaign = 'nonbrand' then order_id else null end) as bsearch_nonbrand,
count(distinct case when utm_campaign = 'brand' then order_id else null end) as brand,
count(distinct case when utm_source is null then order_id else null end) as organic_search
from website_sessions
left join orders on website_sessions.website_session_id = orders.website_session_id

group by 1,2