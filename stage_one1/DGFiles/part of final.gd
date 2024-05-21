
[General]
Version=1

[Preferences]
Username=
Password=2617
Database=
DateFormat=
CommitCount=0
CommitDelay=0
InitScript=

[Table]
Owner=SYS
Name=PART_OF
Count=400

[Record]
Name=ORDERID
Type=NUMBER
Size=38
Data=SQL(SELECT * FROM (SELECT ORDERID FROM AIR_ORDER ORDER BY DBMS_RANDOM.VALUE) WHERE ROWNUM = 1)
Master=

[Record]
Name=PRODUCTID
Type=NUMBER
Size=38
Data=SQL(SELECT * FROM (SELECT PRODUCTID FROM PRODUCT ORDER BY DBMS_RANDOM.VALUE) WHERE ROWNUM = 1)
Master=

