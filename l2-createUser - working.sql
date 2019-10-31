alter session set "_ORACLE_SCRIPT"=true;
CREATE USER working IDENTIFIED BY working;
grant connect to working;
grant connect, resource, dba to working;
grant create session to working;
grant unlimited tablespace to working;
grant create table to working;