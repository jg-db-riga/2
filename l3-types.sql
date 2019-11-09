1. Create a custom type
CREATE OR REPLACE TYPE ADDRESS_TYPE AS OBJECT
(Štreet VARCHAR2(80),
 City VARCHAR2(80),
 State VARCHAR2(2),
 Zip VARCHAR2(10)
);

2. Create a new table, which is using a custom type
CREATE TABLE XX_TYPE_TEST
(NAME VARCHAR2(100), ADDRESS ADDRESS_TYPE);

3. insert a record to new created table
INSERT INTO XX_TYPE_TEST
VALUES ('JavaGuru',ADDRESS_TYPE('Skolas iela', 'Riga', 'LV', '1070'));

4. commit transaction
COMMIT;