CREATE OR REPLACE FUNCTION get_customer_order_summary(p_customer_id NUMBER) RETURN VARCHAR2 IS
    order_count NUMBER;
    total_amount NUMBER;
    total_discount NUMBER;
    order_summary VARCHAR2(4000);
BEGIN
    -- Initialize totals
    order_count := 0;
    total_amount := 0;
    total_discount := 0;


    -- Calculate total orders and amount
    SELECT COUNT(*), SUM(TotalAmount)
    INTO order_count, total_amount
    FROM AIR_ORDER
    WHERE CustomerID = p_customer_id;

    DBMS_OUTPUT.PUT_LINE('Customer ' || p_customer_id || ': Total Orders: ' || order_count || ', Total Amount: $' || total_amount);

    -- Calculate total discount
    total_discount := calculate_discount(p_customer_id);

    -- Create order summary
    order_summary := 'Customer ID: ' || p_customer_id || 
                     ', Total Orders: ' || order_count || 
                     ', Total Amount: $' || total_amount ||
                     ', Total Discount: $' || total_discount;

    RETURN order_summary;
EXCEPTION
    WHEN OTHERS THEN
        RAISE;
END;
/
