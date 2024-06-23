CREATE OR REPLACE FUNCTION calculate_late_order_penalty(p_order_id NUMBER) RETURN NUMBER IS
    delivery_date DATE;
    order_date DATE;
    penalty_amount NUMBER;
BEGIN
    -- Initialize penalty amount
    penalty_amount := 0;

    -- Get order and delivery dates
    SELECT OrderDate, DeliveryDate
    INTO order_date, delivery_date
    FROM AIR_ORDER
    WHERE OrderID = p_order_id;

    DBMS_OUTPUT.PUT_LINE('Order Date: ' || order_date || ', Delivery Date: ' || delivery_date);

    -- Calculate penalty if the order is late (delivery date is after order date + 365 days (a year) days)
    IF delivery_date > order_date + 365 THEN
        penalty_amount := (delivery_date - order_date - 30) * 50;  -- $50 penalty per day late
        DBMS_OUTPUT.PUT_LINE('Late penalty for Order ' || p_order_id || ': $' || penalty_amount);
    END IF;

    RETURN penalty_amount;
EXCEPTION
    WHEN OTHERS THEN
        RAISE;
END;
/
