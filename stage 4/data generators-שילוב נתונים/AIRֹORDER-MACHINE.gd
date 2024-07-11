
[General]
Version=1

[Preferences]
Username=
Password=2163
Database=
DateFormat=
CommitCount=0
CommitDelay=0
InitScript=

[Table]
Owner=SYS
Name=ORDER_MACHINE
Count=40

[Record]
Name=ORDER_ID
Type=NUMBER
Size=
Data=SQL(SELECT ORDERID 
=FROM AIR_ORDER
=ORDER BY DBMS_RANDOM.VALUE
=FETCH FIRST 1 ROW ONLY)
Master=

[Record]
Name=MACHINE_ID
Type=NUMBER
Size=
Data=SQL(SELECT MACHINE_ID 
=FROM MACHINES
=ORDER BY DBMS_RANDOM.VALUE
=FETCH FIRST 1 ROW ONLY)
Master=

