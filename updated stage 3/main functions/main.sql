DECLARE
  v_vip_update_msg VARCHAR2(4000);
  v_top_support_team VARCHAR2(255);
  v_most_demanded_product VARCHAR2(255);
BEGIN
  -- Step 1: Update VIP Customers
  DBMS_OUTPUT.PUT_LINE('Step 1: Updating VIP Customers...');
  
  BEGIN
    Update_VIP_Customers;
    v_vip_update_msg := 'VIP customers have been successfully updated.';
  EXCEPTION
    WHEN OTHERS THEN
      v_vip_update_msg := 'Error while updating VIP customers: ' || SQLERRM;
  END;
  
  DBMS_OUTPUT.PUT_LINE(v_vip_update_msg);
  
  -- Step 2: Get the Top Support Team
  DBMS_OUTPUT.PUT_LINE('Step 2: Identifying the Top Support Team...');
  
  BEGIN
    v_top_support_team := Top_Support_Team;
    IF v_top_support_team IS NULL THEN
      v_top_support_team := 'No support teams found';
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      v_top_support_team := 'Error while identifying the top support team: ' || SQLERRM;
  END;
  
  DBMS_OUTPUT.PUT_LINE('Top Support Team: ' || v_top_support_team);
  
  -- Step 3: Get the Most Demanded Product
  DBMS_OUTPUT.PUT_LINE('Step 3: Identifying the Most Demanded Product...');
  
  BEGIN
    v_most_demanded_product := Most_Demanded_Product;
    IF v_most_demanded_product IS NULL THEN
      v_most_demanded_product := 'No demanded products found';
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      v_most_demanded_product := 'Error while identifying the most demanded product: ' || SQLERRM;
  END;
  
  DBMS_OUTPUT.PUT_LINE('Most Demanded Product: ' || v_most_demanded_product);

END;
