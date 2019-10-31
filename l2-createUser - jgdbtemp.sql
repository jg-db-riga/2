alter session set "_ORACLE_SCRIPT"=true;
CREATE USER jgdbtemp IDENTIFIED BY jgdbtemp;
grant connect to jgdbtemp;
grant connect, resource to jgdbtemp;
grant create session to jgdbtemp;
grant unlimited tablespace to jgdbtemp;
grant create table to jgdbtemp;