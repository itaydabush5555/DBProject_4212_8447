
[General]
Version=1

[Preferences]
Username=
Password=2981
Database=
DateFormat=
CommitCount=0
CommitDelay=0
InitScript=

[Table]
Owner=SYS
Name=PAYMENT
Count=400

[Record]
Name=PAYMENTID
Type=NUMBER
Size=38
Data=Random(10000000, 99999999)
Master=

[Record]
Name=PAYMENTDATE
Type=DATE
Size=
Data=Random(01/01/2022, 01/05/2023)
Master=

[Record]
Name=PAYMENTMETHOD
Type=VARCHAR2
Size=50
Data=List('credit card', 'trade', 'stocks' , 'cash')
Master=

[Record]
Name=AMOUNT
Type=NUMBER
Size=10,2
Data=SQL(SELECT * FROM (SELECT PRICE FROM PRODUCT ORDER BY DBMS_RANDOM.VALUE) WHERE ROWNUM = 1)
Master=

[Record]
Name=TRANSACTIONID
Type=VARCHAR2
Size=50
Data=Random(10, 999)
Master=

[Record]
Name=ORDERID
Type=NUMBER
Size=38
Data=SQL(SELECT * FROM (SELECT ORDERID FROM AIR_ORDER ORDER BY DBMS_RANDOM.VALUE) WHERE ROWNUM = 1)
Master=

