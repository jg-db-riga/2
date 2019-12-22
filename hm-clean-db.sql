CREATE OR REPLACE PROCEDURE clean_db(
    p_objectype nvarchar2,
    p_objectname nvarchar2
)
IS
  l_found_object nvarchar2(100) := '';
 
BEGIN
  IF p_objectname IS NULL THEN
      FOR i IN (SELECT object_name
                INTO l_found_object
                FROM user_objects
               WHERE object_type = p_objectype) LOOP
               
     DBMS_OUTPUT.PUT_LINE('DROP ' || p_objectype || ' ' || l_found_object);          
     EXECUTE IMMEDIATE 'DROP ' || p_objectype || ' ' || l_found_object;
     END LOOP;
  ELSE
  
  DBMS_OUTPUT.PUT_LINE('DROP ' || p_objectype || ' ' || p_objectname);  
  EXECUTE IMMEDIATE 'DROP ' || p_objectype || ' ' || p_objectname;

  END IF;
  
EXCEPTION
   WHEN OTHERS THEN
      dbms_output.put_line( SQLERRM );
END;