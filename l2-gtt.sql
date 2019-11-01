CREATE GLOBAL TEMPORARY TABLE table_name
(column column_data_type,
 ....
) ON COMMIT DELETE ROWS;


CREATE GLOBAL TEMPORARY TABLE xx_temp_test
(msg_data varchar2(500)
) ON COMMIT DELETE ROWS;

select *
from xx_temp_test;

insert into xx_temp_test
values ('first test');

select *
from xx_temp_test;