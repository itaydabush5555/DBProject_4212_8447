-----מחיקת כרטיסי תמיכה סגורים שמאוחסנים מעל שנה
DELETE FROM SUPPORT_TICKET
WHERE Status = 'Closed' AND ResolvedDate < ADD_MONTHS(SYSDATE, -12);
commit;

----- מחיקת הזמנות של לקוח ספציפי
DELETE FROM PAYMENT
WHERE OrderID IN (SELECT OrderID FROM AIR_ORDER WHERE CustomerID IN (SELECT CustomerID FROM CUSTOMERS WHERE Name = 'Japan'));
commit;
DELETE FROM AIR_ORDER
WHERE CustomerID IN (SELECT CustomerID FROM CUSTOMERS WHERE Name = 'Japan');
commit;

----מחיקת הזמנות לא פעילות (סטטוס 'Cancelled')
DELETE FROM AIR_ORDER
WHERE Status = 'Cancelled';
commit;

