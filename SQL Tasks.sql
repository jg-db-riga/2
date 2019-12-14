
select order_number, total_amount
from xx_orders
where total_amount = (select max(total_amount) from xx_orders);

select xw.warehouse_name, count(xo.order_number)
from xx_warehouse xw,
     xx_orders xo
where xw.warehouse_id = xo.warehouse_id(+)
group by xw.warehouse_name;

select *
from xx_items xi,
     xx_availability xa,
     xx_warehouse xw
where xi.item_id = xa.item_id
  and xw.warehouse_id = xa.warehouse_id
  and xa.quantity > 30
  and xw.warehouse_name like '%Riga%';

select xc.customer_name, count(xo.order_number)
from xx_customers xc,
     xx_orders xo
where xc.customer_id = xo.customer_id
having count(xo.order_number) >= 2 
group by xc.customer_name;

select xc.customer_name, nvl(count(xo.order_number), 0)
from xx_customers xc,
     xx_orders xo
where xc.customer_id = xo.customer_id(+)
having nvl(count(xo.order_number), 0) = 0 
group by xc.customer_name;

