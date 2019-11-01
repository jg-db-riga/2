create table xx_course
(id number primary key,
 name VARCHAR2(10) NOT NULL,
 start_date DATE,
 CONSTRAINT id_check CHECK (id between 1 and 10)
);

insert into xx_course
values (1, null, SYSDATE);

insert into xx_course
values (12, 'DB', SYSDATE);

insert into xx_course
values (10, 'DB', SYSDATE);

insert into xx_course
values (10, 'DB', SYSDATE);

select *
from xx_course;