-----decreases the total amount of any order containing more than 3 products by 15%
UPDATE AIR_ORDER
SET TotalAmount = TotalAmount * 0.85
WHERE OrderID IN (
    SELECT PO.OrderID
    FROM part_of PO
    GROUP BY PO.OrderID
    HAVING COUNT(PO.ProductID) > 3
);
commit;

------Mark all support tickets as 'Urgent' for customers who have placed orders totaling more than $1000000
UPDATE Support_Ticket
SET Status = 'Urgent'
WHERE CustomerID IN (
    SELECT O.CustomerID
    FROM AIR_ORDER O
    GROUP BY O.CustomerID
    HAVING SUM(O.TotalAmount) > 10000000
)AND Status != 'Closed';
commit;

---עדכון מחיר של מוצר לפי קטגוריה
UPDATE PRODUCT
SET Price = Price * 1.10
WHERE PRODUCT.CATEGORY = 'Defense Systems';
commit;

----עדכון סטטוס של כרטיסי תמיכה פתוחים שנפתחו לפני יותר מחודש
UPDATE SUPPORT_TICKET
SET Status = 'Pending Review'
WHERE Status = 'Open' AND CreatedDate < ADD_MONTHS(SYSDATE, -1);
commit;
