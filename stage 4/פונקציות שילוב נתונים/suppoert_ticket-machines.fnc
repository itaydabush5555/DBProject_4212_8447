DECLARE
    v_machine_id MACHINES.MACHINE_ID%TYPE;
BEGIN
    FOR rec IN (SELECT TICKETID FROM SUPPORT_TICKET)
    LOOP
        -- ����� MACHINE_ID ������� ����� MACHINES
        SELECT MACHINE_ID INTO v_machine_id
        FROM MACHINES
        ORDER BY DBMS_RANDOM.VALUE
        FETCH FIRST 1 ROW ONLY;
        
        -- ����� �� MACHINE_ID ������ ��"� �������
        UPDATE SUPPORT_TICKET
        SET MACHINE_ID = v_machine_id
        WHERE TICKETID = rec.TICKETID;
    END LOOP;
    COMMIT;
END;
/
