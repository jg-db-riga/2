1.
select xi.name, xw.warehouse_name, xa.quantity
from xx_items xi,
     xx_availability xa,
     xx_warehouse xw
where xi.item_id = xa.item_id(+)
 and xw.warehouse_id(+) = xa.warehouse_id
 order by xi.item_id asc;

2.
select xi.name, count(distinct xo.order_number) orders_amount
from xx_items xi,
     xx_order_lines xol,
     xx_orders xo
where xi.item_id = xol.item_id
  and xol.order_id = xo.order_id
group by xi.name
order by count(distinct xo.order_number) desc;

3.
select xc.customer_name, xa.*, xo.order_number, xo.status, xo.shipment_date, xo.total_amount, xol.line_number, xi.name, xol.quantity
from xx_address xa,
     xx_customers xc,
     xx_orders xo,
     xx_order_lines xol,
     xx_items xi
where xa.address_id = xc.address_id
  and xo.customer_id = xc.customer_id
  and xol.order_id = xo.order_id
  and xi.item_id = xol.item_id
  and xa.country = 'Latvia'
  and xo.status = 'SHIPPED'
order by xc.customer_name asc; 

4.
select *
from (
select xw.warehouse_name, count(*)
from xx_warehouse xw,
     xx_orders xo
where xw.warehouse_id = xo.warehouse_id
group by xw.warehouse_name
order by count(*) asc)
where rownum <4;     

5.
select xc.customer_name, LISTAGG(xo.order_number, ',') WITHIN GROUP (order by xo.order_number)
from xx_orders xo,
     xx_customers xc
where xc.customer_id = xo.customer_id     
 and xo.status = 'ORDERED'
group by xc.customer_name;