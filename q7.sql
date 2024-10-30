use mavenfuzzyfactory;
create temporary table primary_products
select primary_product_id,
order_id as orders, created_at as order_date
from orders
where created_at >= '2014-12-05'
;
with primary_cross_cell as(
select primary_products.*,order_items.product_id as product_cross_sell
from primary_products
left join order_items on primary_products.orders = order_items.order_id
and order_items.is_primary_item = 0)
select primary_product_id,
count(distinct orders) as total_orders,
count(distinct case when product_cross_sell = 1 then orders else null end) as xslod_pro1,
count(distinct case when product_cross_sell = 2 then orders else null end) as xslod_pro2,
count(distinct case when product_cross_sell = 3 then orders else null end) as xslod_pro3,
count(distinct case when product_cross_sell = 4 then orders else null end) as xslod_pro4,
count(distinct case when product_cross_sell = 1 then orders else null end)/count(distinct orders) as pro1_xsell,
count(distinct case when product_cross_sell = 2 then orders else null end)/count(distinct orders) as pro2_xsell,
count(distinct case when product_cross_sell = 3 then orders else null end)/count(distinct orders) as pro3_xsell,
count(distinct case when product_cross_sell = 4 then orders else null end)/count(distinct orders) as pro4_xsell
from primary_cross_cell
group by 1;