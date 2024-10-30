use mavenfuzzyfactory;
select 
year(website_sessions.created_at) as year,quarter(website_sessions.created_at) as quarter,count(distinct website_sessions.website_session_id) as sessions,count(distinct orders.order_id) as orders
from website_sessions
left join orders
on website_sessions.website_session_id = orders.website_session_id
group by 1,2