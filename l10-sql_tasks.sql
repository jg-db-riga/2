1.
select count(xo.order_number) counted, LISTAGG(xc.customer_name, ',') WITHIN GROUP (ORDER BY xc.customer_name) customers 
from xx_orders xo,
     xx_customers xc,
     xx_warehouse xw
where xo.warehouse_id = xw.warehouse_id
 and xc.customer_id = xo.customer_id
 and xw.warehouse_name = 'Berlin Warehouse';

2.
 select xc.customer_name, NVL(SUM(xo.total_amount),0)
 from xx_customers xc,
      xx_orders xo
 where xc.customer_id = xo.customer_id(+)
 group by xc.customer_name
 order by NVL(SUM(xo.total_amount),0) desc;

3.
 select *
 from xx_items xi
 where 
 NOT EXISTS 
 (select 1
  from xx_availability xa
  where xa.item_id = xi.item_id
 );

4.
 select xi.name, NVL(SUM(xol.quantity),0), LISTAGG(xo.order_number, ',') WITHIN GROUP (ORDER BY xo.order_number) orders 
 from xx_items xi,
      xx_order_lines xol,
      xx_orders xo
 where xi.item_id = xol.item_id(+)
  and xol.order_id = xo.order_id(+)
 group by xi.name
 order by NVL(SUM(xol.quantity),0) desc;

5.
select xc.customer_name, xo.order_number, xo.status
from xx_customers xc,
     xx_orders xo
where xo.customer_id = xc.customer_id
 and xo.status NOT IN ('CLOSED', 'SHIPPED');

6.
 select *
 from xx_customers xc,
    xx_orders xo
 where xc.customer_id = xo.customer_id
  and xo.status = 'CLOSED'
  and 1 = (select count(distinct status)
           from xx_orders 
           where customer_id = xc.customer_id
           group by customer_id)
  order by xc.customer_name asc;