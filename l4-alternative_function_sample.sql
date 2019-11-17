CREATE OR REPLACE FUNCTION xx_guess_max_id(p_number NUMBER)
RETURN VARCHAR2
IS
    l_temp NUMBER;
    l_return VARCHAR2(200);
BEGIN
        select max(order_id)
        into l_temp
        from xx_orders;
        
        if l_temp = p_number then
            l_return := 'You are right!';
        elsif l_temp > p_number then
            l_return := 'Too low...';
        else
            l_return := 'Too high...';
        end if; 
            
        RETURN l_return;
END;

select xx_guess_max_id(50)
from dual;

select xx_guess_max_id(48)
from dual;

select xx_guess_max_id(49)
from dual;