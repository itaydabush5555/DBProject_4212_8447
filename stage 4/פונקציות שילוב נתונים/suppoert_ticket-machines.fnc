DECLARE
    v_machine_id MACHINES.MACHINE_ID%TYPE;
BEGIN
    FOR rec IN (SELECT TICKETID FROM SUPPORT_TICKET)
    LOOP
        -- בחירת MACHINE_ID רנדומלי מטבלת MACHINES
        SELECT MACHINE_ID INTO v_machine_id
        FROM MACHINES
        ORDER BY DBMS_RANDOM.VALUE
        FETCH FIRST 1 ROW ONLY;
        
        -- עדכון של MACHINE_ID בתמיכת תצ"א ספציפית
        UPDATE SUPPORT_TICKET
        SET MACHINE_ID = v_machine_id
        WHERE TICKETID = rec.TICKETID;
    END LOOP;
    COMMIT;
END;
/
