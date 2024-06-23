-- תוכנית ראשית: קריאה לפונקציה calculate_discount ולפרוצדורה escalate_unresolved_tickets
DECLARE
    customer_id NUMBER;
    total_discount NUMBER;
    days_threshold NUMBER;
BEGIN
    -- קלט מספר הזיהוי של הלקוח
    DBMS_OUTPUT.PUT('Enter Customer ID: ');
    customer_id := TO_NUMBER('&customer_id_input'); -- קלט מספר הלקוח מהמשתמש

    -- קריאה לפונקציה לחישוב הנחת הלקוח
    total_discount := calculate_discount(customer_id);
    DBMS_OUTPUT.PUT_LINE('Total discount for Customer ID ' || customer_id || ': ' || total_discount);

    -- קלט מספר הימים לסף הסלמה
    DBMS_OUTPUT.PUT('Enter days threshold for ticket escalation: ');
    days_threshold := TO_NUMBER('&days_threshold_input'); -- קלט מספר הימים מהמשתמש

    -- קריאה לפרוצדורה להסלמת קריאות פתוחות שלא נפתרו
    escalate_unresolved_tickets(days_threshold);

    DBMS_OUTPUT.PUT_LINE('Unresolved tickets escalated for days threshold: ' || days_threshold);

EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error occurred: ' || SQLERRM);
END;
