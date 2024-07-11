DECLARE
    v_customer_id CUSTOMERS.CUSTOMERID%TYPE;
    v_machine_id MACHINES.MACHINE_ID%TYPE;
BEGIN
    FOR rec IN (SELECT MACHINE_ID FROM MACHINES)
    LOOP
        -- בחירת customer_id רנדומלי מטבלת CUSTOMERS
        SELECT CUSTOMERID INTO v_customer_id
        FROM CUSTOMERS
        ORDER BY DBMS_RANDOM.VALUE
        FETCH FIRST 1 ROW ONLY;
        
        -- עדכון של customer_id במכונה ספציפית
        UPDATE MACHINES
        SET CUSTOMER_ID = v_customer_id
        WHERE MACHINE_ID = rec.MACHINE_ID;
    END LOOP;
    COMMIT;
END;
/
