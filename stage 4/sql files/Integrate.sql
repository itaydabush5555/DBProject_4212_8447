--הוספת עמודה בטבלת machines לתיאור מספר זהות של לקוח כמפתח זר
ALTER TABLE MACHINES ADD customer_id NUMBER(38);
ALTER TABLE MACHINES ADD CONSTRAINT fk_customer_id FOREIGN KEY (customer_id) REFERENCES Customers(CUSTOMERID);


--הוספת עמודה לתיאור מספר זהות של מכונה בטבלת כרטיסי תמיכה- להוספת תמיכה בטיפול במכונות
ALTER TABLE SUPPORT_TICKET ADD machine_id INTEGER;
ALTER TABLE SUPPORT_TICKET ADD CONSTRAINT fk_machine_id FOREIGN KEY (machine_id) REFERENCES MACHINES(machine_id);

--יצירת טבלאות קשר רבים לרבים

---Order - MACHINE:
CREATE TABLE Order_Machine (
    order_id INTEGER NOT NULL,
    machine_id INTEGER NOT NULL,
    PRIMARY KEY (order_id, machine_id),
    FOREIGN KEY (order_id) REFERENCES AIR_ORDER(ORDERID),
    FOREIGN KEY (machine_id) REFERENCES MACHINES(machine_id)
);

--AIRֹֹ_ORDER-TOOL 

CREATE TABLE Order_Tool (
    order_id INTEGER NOT NULL,
    tool_id INTEGER NOT NULL,
    PRIMARY KEY (order_id, tool_id),
    FOREIGN KEY (order_id) REFERENCES AIR_ORDER(orderid),
    FOREIGN KEY (tool_id) REFERENCES TOOLS(tool_id)
);

--Customer - RAW_MATERIALS:

CREATE TABLE Customer_Raw_Materials (
    customer_id INTEGER NOT NULL,
    material_id INTEGER NOT NULL,
    PRIMARY KEY (customer_id, material_id),
    FOREIGN KEY (customer_id) REFERENCES Customers(customerid),
    FOREIGN KEY (material_id) REFERENCES RAW_MATERIALS(material_id)
);

---Support Ticket - TOOL:
CREATE TABLE Support_Ticket_Tool (
    ticket_id INTEGER NOT NULL,
    tool_id INTEGER NOT NULL,
    PRIMARY KEY (ticket_id, tool_id),
    FOREIGN KEY (ticket_id) REFERENCES Support_Ticket(TICKETID),
    FOREIGN KEY (tool_id) REFERENCES TOOLS(tool_id)
);



---הוספת קשר נוסף: 

ALTER TABLE PRODUCTION_ORDERS ADD account_manager_id INTEGER;
ALTER TABLE PRODUCTION_ORDERS ADD CONSTRAINT fk_account_manager_id FOREIGN KEY (account_manager_id) REFERENCES ACCOUNT_MANAGER(ACCOUNTMANAGERID);

----השינויים שעשינו כרגע נועדו על מנת לחבר בין המערכות השונות בצורה יעילה, שתאפשר למשל שימוש באותו מנהל חשבון של מחלקת לקוחות, שינהל עבור הלקוחות גם את ניהול המוצר
