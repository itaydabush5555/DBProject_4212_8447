-------שאילתא המציגה את כל המוצרים שהוזמנו ע"י לקוחות מסוימים לפי סכום ההזמנות-----
SELECT C.Name AS CustomerName, P.Name AS ProductName, O.TotalAmount
FROM Customers C
JOIN AIR_ORDER O ON C.CustomerID = O.CustomerID
JOIN part_of PO ON O.OrderID = PO.OrderID
JOIN Product P ON PO.ProductID = P.ProductID
ORDER BY C.Name, O.TotalAmount DESC;

---סיכום תשלומים ללקוח כולל פרטי מנהל החשבון
SELECT c.Name AS CustomerName, am.Name AS AccountManagerName, SUM(p.Amount) AS TotalPayments
FROM CUSTOMERS c
JOIN ACCOUNT_MANAGER am ON c.AccountManagerID = am.AccountManagerID
JOIN AIR_ORDER o ON c.CustomerID = o.CustomerID
JOIN PAYMENT p ON o.OrderID = p.OrderID
GROUP BY c.Name, am.Name
ORDER BY TotalPayments DESC;

-----כרטיסי תמיכה פתוחים עם פרטי הלקוחות ומנהלי החשבון

SELECT st.TicketID, c.Name AS CustomerName, am.Name AS AccountManagerName, st.IssueDescription, st.CreatedDate
FROM SUPPORT_TICKET st
JOIN CUSTOMERS c ON st.CustomerID = c.CustomerID
JOIN ACCOUNT_MANAGER am ON st.AccountManagerID = am.AccountManagerID
WHERE st.Status = 'Open'
ORDER BY st.CreatedDate;


-----דוח הכנסות לפי חודש ולקוח

SELECT TO_CHAR(p.PaymentDate, 'YYYY-MM') AS Month, c.Name AS CustomerName, SUM(p.Amount) AS TotalIncome
FROM PAYMENT p
JOIN AIR_ORDER o ON p.OrderID = o.OrderID
JOIN CUSTOMERS c ON o.CustomerID = c.CustomerID
GROUP BY TO_CHAR(p.PaymentDate, 'YYYY-MM'), c.Name
ORDER BY Month DESC, TotalIncome DESC;

-----מציאת הלקוחות עם מספר ההזמנות הגבוה ביותר

SELECT c.Name AS CustomerName, COUNT(o.OrderID) AS OrderCount
FROM CUSTOMERS c
JOIN AIR_ORDER o ON c.CustomerID = o.CustomerID
GROUP BY c.Name
ORDER BY OrderCount DESC, c.Name;

-----שאילתא המראה את כל תשלומים שבוצעו בשיטת תשלום מסוימת, כוללת מידע על ההזמנה והלקוח
SELECT P.PaymentID, P.PaymentDate, P.PaymentMethod, P.Amount, O.OrderID, C.Name AS CustomerName
FROM Payment P
JOIN AIR_ORDER O ON P.OrderID = O.OrderID
JOIN Customers C ON O.CustomerID = C.CustomerID
WHERE P.PaymentMethod = 'Credit Card'
ORDER BY P.PaymentDate;


