-----����� ������ ����� ������ ��������� ��� ���
DELETE FROM SUPPORT_TICKET
WHERE Status = 'Closed' AND ResolvedDate < ADD_MONTHS(SYSDATE, -12);
commit;

----- ����� ������ �� ���� ������
DELETE FROM PAYMENT
WHERE OrderID IN (SELECT OrderID FROM AIR_ORDER WHERE CustomerID IN (SELECT CustomerID FROM CUSTOMERS WHERE Name = 'Japan'));
commit;
DELETE FROM AIR_ORDER
WHERE CustomerID IN (SELECT CustomerID FROM CUSTOMERS WHERE Name = 'Japan');
commit;

----����� ������ �� ������ (����� 'Cancelled')
DELETE FROM AIR_ORDER
WHERE Status = 'Cancelled';
commit;

