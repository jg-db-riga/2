CREATE OR REPLACE PROCEDURE xx_type_test_proc (p_name VARCHAR2, p_street VARCHAR2, p_city VARCHAR2, p_state VARCHAR2, p_zip VARCHAR2)
IS    
    TYPE address_type_tbl IS TABLE OF address_type  index by binary_integer;
    l_address_type address_type_tbl;
BEGIN
    l_address_type(1) := address_type(null, null, null, null);
    
    l_address_type(1).street := p_name;
    l_address_type(1).city := p_city;
    l_address_type(1).state := p_state;
    l_address_type(1).zip := p_zip;
    
    INSERT INTO xx_type_test
    values (p_name, l_address_type(1));
    
    commit;
END;

DECLARE

BEGIN
    xx_type_test_proc('Oracle', 'Ojara Vaciesa 33 245', 'Riga', 'LV', 'LV1050');
END;

select *
from xx_type_test;