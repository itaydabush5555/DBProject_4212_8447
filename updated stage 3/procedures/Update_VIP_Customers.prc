CREATE OR REPLACE NONEDITIONABLE PROCEDURE Update_VIP_Customers AS
  CURSOR vip_customers IS
    SELECT c.CustomerID, c.Name, am.AccountManagerID
    FROM Customers c
    JOIN AIR_ORDER o ON c.CustomerID = o.CustomerID
    JOIN Account_Manager am ON c.AccountManagerID = am.AccountManagerID
    WHERE o.TotalAmount > 100000  -- Criterion for selecting important customers
    GROUP BY c.CustomerID, c.Name, am.AccountManagerID
    ORDER BY SUM(o.TotalAmount) DESC;
  
  customer_row vip_customers%ROWTYPE;
  new_manager_id Account_Manager.AccountManagerID%TYPE;
  
BEGIN
  DBMS_OUTPUT.PUT_LINE('Updating important customers and their account managers');
  
  -- Loop through the important customers
  FOR customer_row IN vip_customers LOOP
    BEGIN
      -- Find a new account manager for each important customer
      SELECT AccountManagerID
      INTO new_manager_id
      FROM Account_Manager
      WHERE Department = 'vip'  -- Special department for VIP customers
      AND ROWNUM = 1;   
      -- Update the customer's account manager
      UPDATE Customers
      SET AccountManagerID = new_manager_id
      WHERE CustomerID = customer_row.CustomerID;
      
      DBMS_OUTPUT.PUT_LINE('Customer ' || customer_row.Name || ' has been updated with a new account manager');
      
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No suitable account manager found for customer ' || customer_row.Name);
      WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
    END;
  END LOOP;
END Update_VIP_Customers;
/
