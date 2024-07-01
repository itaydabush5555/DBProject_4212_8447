CREATE OR REPLACE FUNCTION Top_Support_Team
RETURN VARCHAR2 IS
  v_department Account_Manager.Department%TYPE;
  CURSOR c_teams IS
    SELECT am.Department, COUNT(st.TicketID) AS ticket_count
    FROM support_ticket st
    JOIN Account_Manager am ON st.AccountManagerID = am.AccountManagerID
    WHERE st.CreatedDate >= ADD_MONTHS(SYSDATE, -24)
    GROUP BY am.Department
    ORDER BY ticket_count ASC;
BEGIN
  FOR r_team IN c_teams LOOP
    v_department := r_team.Department;
    DBMS_OUTPUT.PUT_LINE('Department: ' || v_department || ' | Ticket Count: ' || r_team.ticket_count);
    EXIT;  -- Exit after the first iteration, as the cursor is ordered by ticket_count ASC
  END LOOP;
  RETURN v_department;
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('No departments found');
    RETURN 'No departments found';
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
    RETURN 'Error: ' || SQLERRM;
END;
/
