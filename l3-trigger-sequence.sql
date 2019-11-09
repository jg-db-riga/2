Step 1: Create table in WORKING schema
create table xx_cars 
(id NUMBER primary key,  manufacturer VARCHAR2(75), model VARCHAR2(75), issue_year NUMBER, availability_flag VARCHAR2(1));
/ 

Step 2: Create s xx_cars_seq sequence to store ID value
create sequence xx_cars_seq
MINVALUE 1
MAXVALUE 999999999
START WITH 1
INCREMENT BY 1
CYCLE;
/

Step 3: test sequence with currval and nextval
select xx_cars_seq.nextval
from dual;

select xx_cars_seq.currval
from dual;

Step 4: create before update trigger with automatic ID value population and default availability_flag setting to 'Y'
CREATE OR REPLACE TRIGGER xx_cars_bi
BEFORE INSERT ON xx_cars
FOR EACH ROW
DECLARE

BEGIN
   select xx_cars_seq.nextval
   into :NEW.ID
   from dual;

   :NEW.AVAILABILITY_FLAG := 'Y';

END;

Step 5: Test trigger execution by inserting new records to xx_cars
insert into xx_cars (manufacturer, model, issue_year)
values ('BMW', 'X5', '2019');

insert into xx_cars (manufacturer, model, issue_year)
values ('Toyota', 'RAV4', '2019');

insert into xx_cars (manufacturer, model, issue_year)
values ('KIA', 'Sportage', '2019');

Step 6: Commit transaction
COMMIT;

Step 7: Check that trigger worked successfully 
select *
from xx_cars;
 