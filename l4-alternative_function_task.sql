1. Create a function, which would return VARCHAR2 and would have only one incoming parameter: p_number. 
2. In a function make a SELECT of maximal order_id value stored in XX_ORDERS table
3. IF p_number passed value is equal to maximal order_id THEN return 'You are right!' message
4. IF p_number value is less than maximal order_id THEN return 'Too low...' message
5. IF p_number value is more than maximal order_id THEN return 'Too high...' message

Test function with 50, 48 and 49 p_number values by running following SQL statement:
select function(value)
from dual;