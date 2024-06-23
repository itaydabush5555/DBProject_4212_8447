-- תוכנית ראשית: קריאה לפונקציה get_customer_order_summary ולפרוצדורה penalize_late_orders
DECLARE
    customer_id NUMBER;
    order_id NUMBER;
    order_summary VARCHAR2(4000);
BEGIN
    -- קלט מספר הזיהוי של הלקוח
    DBMS_OUTPUT.PUT('Enter Customer ID: ');
    customer_id := TO_NUMBER('&customer_id_input'); -- קלט מספר הלקוח מהמשתמש

    -- קריאה לפונקציה לקבלת סיכום הזמנות של הלקוח
    order_summary := get_customer_order_summary(customer_id);
    DBMS_OUTPUT.PUT_LINE(order_summary);

    -- איתור מספר הזיהוי של ההזמנה הראשונה של הלקוח
    SELECT OrderID INTO order_id
    FROM AIR_ORDER
    WHERE CustomerID = customer_id
    AND ROWNUM = 1; -- רק ההזמנה הראשונה

    -- קריאה לפרוצדורה להענשת הזמנות מאוחרות
    penalize_late_orders(order_id);

    DBMS_OUTPUT.PUT_LINE('Late order penalties applied for Order ID: ' || order_id);

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No orders found for Customer ID: ' || customer_id);
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error occurred: ' || SQLERRM);
END;
/
