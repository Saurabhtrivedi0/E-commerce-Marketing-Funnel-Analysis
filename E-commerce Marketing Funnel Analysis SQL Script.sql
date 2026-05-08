-- define sales funnel and different stages

select 
	count(distinct case when event_type = "page_view" then user_id end) as stage_1_view,
    count(distinct case when event_type = "add_to_cart" then user_id end) as stage_2_cart,
    count(distinct case when event_type = "checkout_start" then user_id end) as stage_3_checkout,
    count(distinct case when event_type = "payment_info" then user_id end) as stage_4_payment,
    count(distinct case when event_type = "purchase" then user_id end) as stage_5_purchase
from user_events
where event_date >= (select timestamp(date_sub(max(event_date), interval 30 day)) from user_events);

-- conversion rate through the funnel

with funnel_stages as (
select
	count(distinct case when event_type = "page_view" then user_id end) as stage_1_view,
    count(distinct case when event_type = "add_to_cart" then user_id end) as stage_2_cart,
    count(distinct case when event_type = "checkout_start" then user_id end) as stage_3_checkout,
    count(distinct case when event_type = "payment_info" then user_id end) as stage_4_payment,
    count(distinct case when event_type = "purchase" then user_id end) as stage_5_purchase
from user_events
where event_date >= (select timestamp(date_sub(max(event_date), interval 30 day)) from user_events)
)
select 
	round(stage_2_cart / stage_1_view * 100, 1) as view_to_cart_rate,
    round(stage_3_checkout / stage_2_cart * 100, 1) as cart_to_checkout_rate,
    round(stage_4_payment / stage_3_checkout * 100, 1) as checkout_to_payment_rate,
    round(stage_5_purchase / stage_4_payment * 100, 1) as payment_to_purchase_rate,
    round(stage_5_purchase / stage_1_view * 100, 1) as view_to_purchase_rate
from funnel_stages;

-- funnel by source

with funnel_stages_by_traffic as (
select traffic_source,
	count(distinct case when event_type = "page_view" then user_id end) as views,
    count(distinct case when event_type = "add_to_cart" then user_id end) as cart,
    count(distinct case when event_type = "checkout_start" then user_id end) as checkout,
    count(distinct case when event_type = "payment_info" then user_id end) as payment,
    count(distinct case when event_type = "purchase" then user_id end) as purchase
from user_events
where event_date >= (select timestamp(date_sub(max(event_date), interval 30 day)) from user_events)
group by traffic_source
)
select
	traffic_source, views, cart, checkout, payment, purchase,
    round( cart *100 /views, 1) as cart_conv_rate,
    round( checkout *100 /cart, 1) as checkout_conv_rate,
    round( payment *100 /checkout, 1) as payment_conv_rate,
    round( purchase *100 /payment, 1) as purchase_conv_rate,
    round( purchase *100 /views, 1) as overall_conv_rate
from funnel_stages_by_traffic
order by purchase desc;

--
-- 

with funnel as (
select traffic_source, event_type,
	count(distinct user_id) as user_count
from user_events
where event_date >= (select timestamp(date_sub(max(event_date), interval 30 day)) from user_events)
group by traffic_source, event_type
order by traffic_source, user_count desc
)
select *, 
lag(user_count) over(PARTITION BY traffic_source ORDER BY user_count DESC) as lag_result,
round(user_count * 100 / lag(user_count) over(PARTITION BY traffic_source ORDER BY user_count DESC)
 , 1) as conversion_rate
from funnel;


-- time to conversion

with funnel_time_conv as (
select user_id,
	min(case when event_type = "page_view" then event_date end) as views_time,
    min(case when event_type = "add_to_cart" then event_date end) as cart_time,
    min(case when event_type = "checkout_start" then event_date end) as checkout_time,
    min(case when event_type = "payment_info" then event_date end) as payment_time,
    min(case when event_type = "purchase" then event_date end) as purchase_time
from user_events
where event_date >= (select timestamp(date_sub(max(event_date), interval 30 day)) from user_events)
group by user_id
having min(distinct case when event_type = "purchase" then event_date end) is not null
)
select count(*) as users_count,
round(avg(timestampdiff(minute, views_time, cart_time)), 2) as view_to_cart_time,
round(avg(timestampdiff(minute, cart_time, checkout_time)), 2) as cart_to_checkout_time,
round(avg(timestampdiff(minute, checkout_time, payment_time)), 2) as checkout_to_payment_time,
round(avg(timestampdiff(minute, payment_time, purchase_time)), 2) as payment_to_purchase_time,
round(avg(timestampdiff(minute, views_time, purchase_time)), 2) as overall_time
from funnel_time_conv;

--
-- revenue funnel analysis

with rev_analysis as (
select traffic_source,
	count(distinct case when event_type = "page_view" then user_id end) as total_visitor,
    count(distinct case when event_type = "purchase" then user_id end) as total_customer,
    round(sum(case when event_type = "purchase" then amount end),1) as total_revenue,
    count(case when event_type = "purchase" then 1 end) as total_order
from user_events
where event_date >= (select timestamp(date_sub(max(event_date), interval 30 day)) from user_events)
group by traffic_source
)
select *,
	round(total_revenue / total_customer, 1) as revenue_per_customer,
    round(total_revenue / total_visitor, 1) as revenue_per_visitor,
    round(total_revenue / total_order, 1) as avg_order_value
    
from rev_analysis;
