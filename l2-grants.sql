1. Create xx_test table in WORKING schema
create table xx_test
(msg number);

2. Add some records there. Do not forget to commit transactions
insert into xx_test
values (1);
insert into xx_test
values (2);

3. Try to select this table from JGDBTEMP schema
select *
from working.xx_test;
-- table or view does not exist

4. Add grants from WORKING to JGDBTESMP schema
grant select on xx_test to jgdbtemp;
-- grant succeeded

5. Try to select this table from JGDBTEMP schema
select *
from working.xx_test;
-- records returned

6. Create a synonym for xx_temp from WORKING schema
create or replace synonym jgdbtemp.xx_test for xx_test;

7. Try to select this table from JGFBTEMP schema
select *
from xx_test;
--records returned