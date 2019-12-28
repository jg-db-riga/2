CREATE OR REPLACE PACKAGE BODY XX_EMPLOYEES_PKG
AS
    C_INCOME_TAX CONSTANT NUMBER := 21;
    C_SOC_TAX CONSTANT NUMBER := 10;

    PROCEDURE put_log (p_msg VARCHAR2)
    IS
    BEGIN
        DBMS_OUTPUT.PUT_LINE(p_msg);
    END;    

    PROCEDURE INSERT_EMPLOYEE(P_ROW XX_EMPLOYEES%ROWTYPE)
    IS
    BEGIN
        INSERT INTO XX_EMPLOYEES
        values p_row;
    END;

    FUNCTION get_title(p_title VARCHAR2, p_error IN OUT VARCHAR2)
    RETURN NUMBER
    IS
        l_return number;
    BEGIN
        select title_id
        into l_return
        from XX_TITLES
        where name = p_title;
        
        RETURN l_return;
        
    EXCEPTION WHEN OTHERS THEN
        p_error := 'Tittle can not be found: ' || SQLERRM;
        return -1;
    END;

    FUNCTION get_salary_netto(p_gross_salary NUMBER, p_error IN OUT VARCHAR2)
    RETURN NUMBER
    IS
    BEGIN
        RETURN p_gross_salary - (p_gross_salary * C_INCOME_TAX / 100) - (p_gross_salary * C_SOC_TAX / 100);
    EXCEPTION WHEN OTHERS THEN
        p_error := 'Netto salary can not be found: ' || SQLERRM;
        return -1;        
    END;

    PROCEDURE CREATE_EMPLOYEE(P_NAME VARCHAR2, P_SURNAME VARCHAR2, P_EMAIL VARCHAR2, P_TITLE VARCHAR2, P_SALARY_GROSS NUMBER)
    IS
        l_employee_rec XX_EMPLOYEES%ROWTYPE;
        l_error_tmp VARCHAR2(2000);
        l_error VARCHAR2(2000);
    BEGIN
        l_employee_rec.name := p_name;
        l_employee_rec.surname := p_surname;
        l_employee_rec.email := p_email;
        
        IF (NVL(p_title, '-1') != '-1') THEN
            l_employee_rec.title := get_title(p_title, l_error_tmp);
            
            IF l_employee_rec.title = -1 THEN
                l_error := l_error_tmp || ';';
            END IF;
            
        END IF;
        
        IF (NVL(p_salary_gross, -1) != -1) THEN
            l_employee_rec.salary_netto := get_salary_netto(p_salary_gross, l_error_tmp);
            l_employee_rec.salary_gross := p_salary_gross;
            IF l_employee_rec.salary_netto = -1 THEN
                l_error := l_error || l_error_tmp || ';';
            END IF;
            
        END IF;
        
        IF NVL(l_error, '-1') != '-1' THEN
            put_log('Failure: ' || l_error);
        ELSE
            select xx_emp_id_seq.nextval
            into l_employee_rec.emp_id
            from dual;
            
            insert_employee(l_employee_rec);
            put_log ('Success: Employee record is created!');
        END IF;
        COMMIT;
    END;

END XX_EMPLOYEES_PKG;