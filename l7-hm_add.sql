CREATE OR REPLACE TYPE xx_skills_t AS OBJECT
( description VARCHAR2(75),
  expertise VARCHAR2(25),
  experience NUMBER
);

CREATE OR REPLACE TYPE xx_skills_tab AS TABLE OF xx_skills_t; 

CREATE TABLE xx_employees
(
 id NUMBER,
 name VARCHAR2(200),
 surname VARCHAR2(200),
 department VARCHAR2(100),
 skills xx_skills_tab
) NESTED TABLE skills STORE AS skills_tab;


INSERT INTO xx_employees 
VALUES (1, 'John', 'Dwayne', 'IT', xx_skills_tab(xx_skills_t('Java', 'Medium', 3)));

INSERT INTO TABLE 
(SELECT t1.skills
 FROM xx_employees t1
 WHERE id = 1
)
VALUES ('Oracle', 'Senior', 8);

INSERT INTO TABLE 
(SELECT t1.skills
 FROM xx_employees t1
 WHERE id = 1
)
VALUES ('SAP', 'Novice', 1);


INSERT INTO xx_employees 
VALUES (2, 'Arthur', 'Filips', 'IT', xx_skills_tab(xx_skills_t('JavaScript', 'Senior', 5)));

INSERT INTO TABLE 
(SELECT t1.skills
 FROM xx_employees t1
 WHERE id = 2
)
VALUES ('Python', 'Senior', 6);


INSERT INTO xx_employees 
VALUES (3, 'Anna', 'Williams', 'Sales', xx_skills_tab(xx_skills_t('Negotiation', 'Senior', 10)));

INSERT INTO TABLE 
(SELECT t1.skills
 FROM xx_employees t1
 WHERE id = 3
)
VALUES ('Communication', 'Senior', 8);

INSERT INTO TABLE 
(SELECT t1.skills
 FROM xx_employees t1
 WHERE id = 3
)
VALUES ('Product Knowledge', 'Medium', 4);

select t1.id, t1.name, t1.surname, t1.department, t2.*
from xx_employees t1,
     TABLE(t1.skills) t2;

DELETE FROM TABLE
(SELECT t1.skills
 FROM xx_employees t1
 WHERE id = 1
)
WHERE description = 'SAP';

UPDATE TABLE 
(SELECT t1.skills
 FROM xx_employees t1
 WHERE id = 3
) tbl
SET tbl.experience = 8, expertise = 'Senior'
WHERE tbl.description = 'Product Knowledge';


