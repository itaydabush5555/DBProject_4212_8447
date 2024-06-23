CREATE OR REPLACE PROCEDURE escalate_unresolved_tickets(p_days_threshold NUMBER) IS
    CURSOR unresolved_tickets_cursor IS
        SELECT TicketID, AccountManagerID
        FROM SUPPORT_TICKET
        WHERE Status = 'Open'
          AND SYSDATE - CreatedDate > p_days_threshold;
    v_account_manager_email VARCHAR2(100);
BEGIN
    FOR ticket IN unresolved_tickets_cursor LOOP
        -- Update status to 'Escalated'
        UPDATE SUPPORT_TICKET
        SET Status = 'Escalated'
        WHERE TicketID = ticket.TicketID;

        -- Get account manager email
        SELECT Email INTO v_account_manager_email
        FROM ACCOUNT_MANAGER
        WHERE AccountManagerID = ticket.AccountManagerID;

        DBMS_OUTPUT.PUT_LINE('Ticket ID: ' || ticket.TicketID || ' has been escalated. Notifying Account Manager: ' || v_account_manager_email);
        
        -- Placeholder for sending email (not implemented in PL/SQL)
        -- send_email(v_account_manager_email, 'Ticket Escalation Notice', 'Ticket ID: ' || ticket.TicketID || ' has been escalated.');

    END LOOP;

    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error occurred while escalating unresolved tickets');
        ROLLBACK;
        RAISE;
END;
/
