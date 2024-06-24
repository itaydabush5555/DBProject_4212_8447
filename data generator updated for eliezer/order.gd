
[General]
Version=1

[Preferences]
Username=
Password=2886
Database=
DateFormat=
CommitCount=0
CommitDelay=0
InitScript=

[Table]
Owner=SYS
Name=AIR_ORDER
Count=10

[Record]
Name=ORDERID
Type=NUMBER
Size=38
Data=Random(10000000, 99999999)
Master=

[Record]
Name=ORDERDATE
Type=DATE
Size=
Data=Random(01/01/2022, 01/05/2023)
Master=

[Record]
Name=DELIVERYDATE
Type=DATE
Size=
Data=Random(01/05/2023, 01/05/2024)
Master=

[Record]
Name=STATUS
Type=VARCHAR2
Size=50
Data=List('Pending', 'Processed', 'Shipped', 'Delivered', 'Completed')
Master=

[Record]
Name=TOTALAMOUNT
Type=NUMBER
Size=255
Data=SQL(SELECT PRICE 
=FROM PRODUCT
=ORDER BY DBMS_RANDOM.VALUE
=FETCH FIRST 1 ROW ONLY)+5000
Master=

[Record]
Name=CUSTOMERID
Type=NUMBER
Size=38
Data=SQL(SELECT CUSTOMERID 
=FROM CUSTOMERS
=ORDER BY DBMS_RANDOM.VALUE
=FETCH FIRST 1 ROW ONLY)
Master=

