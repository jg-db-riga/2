1. Create XX_CARS table with following attributes: ID PRIMARY KEY NUMBER, MANUFACTURER VARCHAR2(100), MODEL VARCHHAR2(100), YEAR VARCHAR2(4)
create table xx_cars
( id number primary key,
  manufacturer varchar2(200),
  model varchar2(100),
  year varchar2(4)
);

2. Insert a new car to XX_CARS table
insert into xx_cars
values (1, 'BMW', 'X5', '2017');

3. COMMIT transaction
COMMIT;

4. Create XX_CARS_MV materialized view with following properties: BUILD DEFERRED, REFRESH FORCE, ON DEMAND. Query to use: Get all data from xx_cars
CREATE MATERIALIZED VIEW xx_cars_mv
BUILD DEFERRED
REFRESH FORCE 
ON DEMAND
AS
SELECT * 
FROM xx_cars;

5. Check that no data exists in XX_CARS_MV despite you have inserted table to XX_CARS. Try to explain why?
select *
from xx_cars_mv;

6. Run gather statistics command:
BEGIN
  DBMS_STATS.gather_table_stats(
    ownname => 'WORKING',
    tabname => 'XX_CARS_MV');
END;

7. Run DBMS_REFRESH.make command:
BEGIN
   DBMS_REFRESH.make(
     name                 => 'WORKING.MINUTE_REFRESH',
     list                 => '',
     next_date            => SYSDATE,
     interval             => '/*1:Mins*/ SYSDATE + 1/(60*24)',
     implicit_destroy     => FALSE,
     lax                  => FALSE,
     job                  => 0,
     rollback_seg         => NULL,
     push_deferred_rpc    => TRUE,
     refresh_after_errors => TRUE,
     purge_option         => NULL,
     parallelism          => NULL,
     heap_size            => NULL);
END;

8. Add DBMS_REFRESH.add command:
BEGIN
   DBMS_REFRESH.add(
     name => 'WORKING.MINUTE_REFRESH',
     list => 'WORKING.XX_CARS_MV',
     lax  => TRUE);
END;

9. Wait and check till XX_CARS_MV will return record inserted to XX_CARS.
select *
from XX_CARS_MV;

10. Insert two more records to XX_CARS
insert into xx_cars
values (2, 'Audi', 'Q5', '2018');

insert into xx_cars
values (3, 'Ford', 'Focus', '2015');

11. Commit transaction
COMMIT;

12. Wait and check till new records created appears in XX_CARS_MV. Try to explain why?
select *
from XX_CARS_MV;

13. Run DBMS_REFRESH.destroy command:
BEGIN
  DBMS_REFRESH.destroy(name => 'WORKING.MINUTE_REFRESH');
END;

14. Drop XX_CARS_MV materialized VIEW
DROP MATERIALIZED VIEW XX_CARS_MV;

15. Think about SYSDATE + 1/(60*24) expession. Change it in order to return current time + 10 minutes. Write select <expression> from dual; SQL statement to prove it.
select SYSDATE + 10/(60*24)
from dual;

16. Think about SYSDATE + 1/(60*24) expession. Change it in order to return current time + 2 hours. Write select <expression> from dual; SQL statement to prove it.
select SYSDATE + 1/(24)
from dual;

17. Think about SYSDATE + 1/(60*24) expession. Change it in order to return current time + 1 day + 2 hours. Write select <expression> from dual; SQL statement to prove it.
select SYSDATE + 1 + (2/24)
from dual;