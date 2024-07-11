-- יצירת המבט לניהול הייצור
CREATE or replace VIEW ProductionManagementView AS
SELECT
    po.PRODUCTION_ORDER_ID,
    po.QUANTITY,
    po.START_DATE,
    po.DUE_DATE,
    po.STATUS AS ORDER_STATUS,
    t.TOOL_ID,
    t.TOOL_NAME,
    t.STATUS AS TOOL_STATUS,
    mm.MAINTENANCE_ID,
    mm.MAINTENANCE_DATE,
    mm.MAINTENANCE_TYPE,
    m.MACHINE_ID,
    m.MACHINE_NAME,
    m.STATUS AS MACHINE_STATUS
FROM
    PRODUCTION_ORDERS po
    JOIN TOOLS t ON po.TOOL_ID = t.TOOL_ID
    JOIN MACHINES m ON t.TOOL_ID = m.MACHINE_ID
    LEFT JOIN MACHINE_MAINTENANCE mm ON m.MACHINE_ID = mm.MACHINE_ID;


--שאילתה 1: הצגת סה"כ  מספר תשלומים לכל לקוח

SELECT
    c.NAME,
    COUNT(p.PAYMENTID) AS NUM_PAYMENTS
FROM
    CustomerSupportView csv
    JOIN CUSTOMERS c ON csv.CUSTOMERID = c.CUSTOMERID
    JOIN PAYMENT p ON csv.PAYMENTID = p.PAYMENTID
GROUP BY
    c.NAME
ORDER BY
    NUM_PAYMENTS DESC;

---שאילתה 2: הצגת סה"כ כמות תמיכות טכניות לכל לקוח

SELECT
    c.NAME,
    COUNT(s.TICKETID) AS NUM_SUPPORT_TICKETS
FROM
    CustomerSupportView csv
    JOIN CUSTOMERS c ON csv.CUSTOMERID = c.CUSTOMERID
    LEFT JOIN SUPPORT_TICKET s ON csv.TICKETID = s.TICKETID
GROUP BY
    c.NAME
ORDER BY
    NUM_SUPPORT_TICKETS DESC;
