select 
	a.driver_id,
	a.shipping_driver,
	count(b.detail_delivery_id) as shipment_count
from app.driver a
	join app.detail_delivery b
		on a.driver_id = b.driver_id 
	left join app.delivery c
		on b.delivery_id = c.delivery_id 
where to_char(c.sending_time,'YYYY-MM') = '2023-05'
	group by a.driver_id , a.shipping_driver 
	order by shipment_count desc 
	limit 2


select 
	a.product_id,
	a.product_name,
	count(b.delivery_id) as shipment_count
from app.product a
	join app.delivery b
		on a.product_id = b.product_id
	left join app.delivery c
		on b.delivery_id = c.delivery_id 
where to_char(c.sending_time,'YYYY-MM') = '2023-05'
	group by a.product_id , a.product_name 
	order by shipment_count desc 
	limit 10


