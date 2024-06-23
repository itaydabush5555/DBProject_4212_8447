CREATE OR REPLACE NONEDITIONABLE PROCEDURE penalize_late_orders(p_customer_id NUMBER) IS
    CURSOR order_cursor IS
        SELECT OrderID FROM AIR_ORDER WHERE CustomerID = p_customer_id;
    penalty_amount NUMBER;
BEGIN
    -- Iterate over each order of the customer
    FOR order_record IN order_cursor LOOP
        -- Calculate penalty for the order
        penalty_amount := calculate_late_order_penalty(order_record.OrderID);

        -- Update payment with penalty amount
        UPDATE PAYMENT
        SET Amount = Amount - penalty_amount
        WHERE OrderID = order_record.OrderID;

        -- print the penalty 
        DBMS_OUTPUT.PUT_LINE('Order ID: ' || order_record.OrderID || ', Penalty Amount: $' || penalty_amount);
    END LOOP;

    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END;
/
