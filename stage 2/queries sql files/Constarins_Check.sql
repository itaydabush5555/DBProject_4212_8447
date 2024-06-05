-- Inserting a negative price value into PRODUCT (should fail due to the check constraint)
INSERT INTO Product (ProductID, Name, Category, Price, Description, InventoryCount)
VALUES (1, 'Negative Price Product', 'Electronics', -100, 'This product has a negative price.', 10);
-- This insert should fail with an error: ORA-02290: check constraint (YOUR_SCHEMA.CHCK_PRICEPOSITIVE) violated

-- Inserting a payment without specifying the PaymentMethod (should use the default)
INSERT INTO Payment (PaymentID, PaymentDate, Amount, TransactionID, OrderID)
VALUES (1222222222222, SYSDATE, 150.75, 'ABC123', 1);
-- PaymentMethod should default to 'Credit Card'

-- Inserting an order with negative total amount (should fail due to the check constraint)
INSERT INTO AIR_ORDER (OrderID, OrderDate, DeliveryDate, Status, TotalAmount, CustomerID)
VALUES (1, SYSDATE, SYSDATE + 7, 'Pending', -200, 1);
-- This insert should fail with an error: ORA-02290: check constraint (YOUR_SCHEMA.CHCK_TOTAL_AMOUNT) violated

-- Inserting a support ticket with ResolvedDate earlier than CreatedDate (should fail due to the check constraint)
INSERT INTO Support_Ticket (TicketID, IssueDescription, Status, CreatedDate, ResolvedDate, CustomerID, AccountManagerID)
VALUES (1, 'Test issue', 'Open', SYSDATE, SYSDATE - 1, 1, 1);
-- This insert should fail with an error: ORA-02290: check constraint (YOUR_SCHEMA.CHEK_DATES) violated
