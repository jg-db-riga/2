create table xx_course
(
 course_id NUMBER primary key, 
 course_name VARCHAR2(200),
 start_date DATE
);

create table xx_topics
(
topic_id NUMBER primary key,
course_id NUMBER,
description VARCHAR2(500),

CONSTRAINT kf_topic
  FOREIGN KEY (course_id)
  REFERENCES xx_course (course_id)
);

insert into xx_topics 
values (1, 1, 'Lesson 1');
-- integrity constraint issue

insert into xx_course
values (1, 'DB', sysdate);

insert into xx_topics 
values (1, 1, 'Lesson 1');

drop table xx_course;
drop table xx_topics;
