-- Create or replace the function
CREATE OR REPLACE FUNCTION Most_Demanded_Product
RETURN VARCHAR2 IS
  v_product_id Product.ProductID%TYPE;
  v_order_count NUMBER;
  CURSOR c_products IS
    SELECT p.ProductID, COUNT(*) AS order_count
    FROM part_of po
    JOIN Product p ON po.ProductID = p.ProductID
    JOIN AIR_ORDER ao ON po.OrderID = ao.OrderID
    WHERE ao.OrderDate >= ADD_MONTHS(SYSDATE, -36)
    GROUP BY p.ProductID
    ORDER BY order_count DESC;
BEGIN
  OPEN c_products;
  FETCH c_products INTO v_product_id, v_order_count;
  IF c_products%FOUND THEN
    DBMS_OUTPUT.PUT_LINE('Product ID: ' || v_product_id || ', Order Count: ' || v_order_count);
    CLOSE c_products;
    RETURN v_product_id;
  ELSE
    CLOSE c_products;
    RETURN 'No products found';
  END IF;
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    RETURN 'No products found';
  WHEN OTHERS THEN
    RETURN 'Error: ' || SQLERRM;
END;
/
