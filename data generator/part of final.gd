
[General]
Version=1

[Preferences]
Username=
Password=2651
Database=
DateFormat=
CommitCount=0
CommitDelay=0
InitScript=

[Table]
Owner=SYS
Name=PART_OF
Count=25

[Record]
Name=ORDERID
Type=NUMBER
Size=38
Data=SQL(SELECT ORDERID 
=FROM AIR_ORDER
=ORDER BY DBMS_RANDOM.VALUE
=FETCH FIRST 1 ROW ONLY)
Master=

[Record]
Name=PRODUCTID
Type=NUMBER
Size=38
Data=SQL(SELECT PRODUCTID 
=FROM PRODUCT
=ORDER BY DBMS_RANDOM.VALUE
=FETCH FIRST 1 ROW ONLY)
Master=

