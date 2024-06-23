CREATE OR REPLACE FUNCTION calculate_discount(p_customer_id NUMBER) RETURN NUMBER IS
    total_orders NUMBER;
    total_discount NUMBER;
    CURSOR order_cursor IS
        SELECT OrderID, TotalAmount FROM AIR_ORDER WHERE CustomerID = p_customer_id;
BEGIN
    -- Initialize the discount total
    total_discount := 0;

    -- Count the total number of orders for the customer
    SELECT COUNT(*)
    INTO total_orders
    FROM AIR_ORDER
    WHERE CustomerID = p_customer_id;

    DBMS_OUTPUT.PUT_LINE('Customer ID: ' || p_customer_id || ', Total Orders: ' || total_orders);

    -- If the customer has more than 10 orders, calculate a 10% discount for each order
    IF total_orders > 4 THEN
        FOR order_record IN order_cursor LOOP
            total_discount := total_discount + (order_record.TotalAmount * 0.1);
            DBMS_OUTPUT.PUT_LINE('Order ID: ' || order_record.OrderID || 
            ', Total Amount: ' ||
             order_record.TotalAmount ||
              ', Discount for this order: ' || 
              (order_record.TotalAmount * 0.1));
        END LOOP;
    END IF;

    DBMS_OUTPUT.PUT_LINE('Total Discount for Customer ' || p_customer_id || ': ' || total_discount);

    RETURN total_discount;
EXCEPTION
    WHEN OTHERS THEN
        RAISE;
END;
/
