DECLARE
    v_account_manager_id INTEGER;
    v_production_order_id PRODUCTION_ORDERS.PRODUCTION_ORDER_ID%TYPE;
BEGIN
    FOR rec IN (SELECT PRODUCTION_ORDER_ID FROM PRODUCTION_ORDERS)
    LOOP
        -- בחירת account_manager_id רנדומלי מטבלת ACCOUNT_MANAGERS
        SELECT CAST(ACCOUNTMANAGERID AS INTEGER) INTO v_account_manager_id
        FROM ACCOUNT_MANAGER
        ORDER BY DBMS_RANDOM.VALUE
        FETCH FIRST 1 ROW ONLY;
        
        -- עדכון של account_manager_id בהזמנה ספציפית
        UPDATE PRODUCTION_ORDERS
        SET ACCOUNT_MANAGER_ID = v_account_manager_id
        WHERE PRODUCTION_ORDER_ID = rec.PRODUCTION_ORDER_ID;
    END LOOP;
    COMMIT;
END;
/
