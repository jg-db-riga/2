1.
select xw.warehouse_name, LISTAGG(xc.customer_name, ',') WITHIN GROUP (order by xc.customer_name) customersList
from xx_warehouse xw,
     (select distinct customer_id, warehouse_id
     from xx_orders) xo,
     xx_customers xc
where xw.warehouse_id = xo.warehouse_id
 and xo.customer_id = xc.customer_id
group by xw.warehouse_name ;

2.
SELECT xc.customer_id, 
       xc.customer_name, 
       COUNT(xo.order_number) ordersCount, 
       LISTAGG(xo.order_number, ',') WITHIN GROUP (order by xo.order_number) ordersList,
       NVL(AVG(xo.total_amount),0) averageAmount,
       (
       select name
        from (
        select xi1.name, count(xol1.item_id) amount
        from xx_orders xo1,
             xx_order_lines xol1,
             xx_items xi1
        where xc.customer_id = xo1.customer_id
          and xo1.order_id = xol1.order_id
          and xi1.item_id = xol1.item_id
        group by xi1.name  
        order by count(xol1.item_id) desc)
        where rownum = 1) favouriteItem
FROM xx_customers xc,
     xx_orders xo
WHERE xc.customer_id = xo.customer_id(+)
GROUP BY xc.customer_id, xc.customer_name;

3.
select *
from (
select xc.customer_name, max(total_amount), xo.order_number
from xx_customers xc,
     xx_orders xo
where xc.customer_id = xo.customer_id
group by xc.customer_name, xo.order_number
order by max(total_amount) desc)
where rownum = 1;

4.
select  xi.name
from xx_warehouse xw,
     xx_availability xa,
     xx_items xi
where xw.warehouse_id = xa.warehouse_id
 and xi.item_id = xa.item_id
 and xw.warehouse_name = 'Riga Warehouse'
 and xa.quantity > 60
 order by xi.item_id;

5.
SELECT
    XMLELEMENT(
        "warehouses", XMLAGG(XMLELEMENT(
            "warehouse", XMLFOREST(xw.warehouse_name AS "name", xw.capacity AS "capacity", (select sum(quantity) from xx_availability where warehouse_id = xw.warehouse_id) AS "stored_quantity"
            ,(
                SELECT
                    XMLAGG(XMLELEMENT("item", XMLFOREST(xi.name AS "item", xi.weight AS "weight", xi.volume AS "volume", xa.quantity AS "available_qty")
                        ))
                FROM   xx_availability xa,
                       xx_items xi
                WHERE
                    xw.warehouse_id = xa.warehouse_id
                    and xi.item_id = xa.item_id
            ) "items")
        ))
    )
FROM
    xx_warehouse xw;