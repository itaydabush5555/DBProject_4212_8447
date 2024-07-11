-- ����� ���� ������ ������ ������
CREATE or replace VIEW CustomerSupportView AS
SELECT
    c.CUSTOMERID,
    c.NAME,
    o.ORDERID,
    o.ORDERDATE,
    p.PAYMENTID,
    p.PAYMENTDATE,
    s.TICKETID,
    s.ISSUEDESCRIPTION,
    s.STATUS
FROM
    CUSTOMERS c
    JOIN AIR_ORDER o ON c.CUSTOMERID = o.CUSTOMERID
    JOIN PAYMENT p ON o.ORDERID = p.ORDERID
    LEFT JOIN SUPPORT_TICKET s ON c.CUSTOMERID = s.CUSTOMERID;

--������ 1: ����� �� ������� ��������� ���� ���� �����
SELECT
    NAME,
    ORDERID,
    ORDERDATE,
    PAYMENTID,
    PAYMENTDATE
FROM
    CustomerSupportView
WHERE
    NAME = 'USA';

---������ 2: ����� �� �������� ������� ������ ���� ���� �����
SELECT
    NAME,
    TICKETID,
    ISSUEDESCRIPTION,
    STATUS
FROM
    CustomerSupportView
WHERE
    NAME = 'Germany' AND STATUS = 'Open';

   
