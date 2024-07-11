
[General]
Version=1

[Preferences]
Username=
Password=2115
Database=
DateFormat=
CommitCount=0
CommitDelay=0
InitScript=

[Table]
Owner=SYS
Name=ORDER_TOOL
Count=60

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
Name=TOOL_ID
Type=NUMBER
Size=
Data=SQL(SELECT TOOL_ID 
=FROM TOOLS
=ORDER BY DBMS_RANDOM.VALUE
=FETCH FIRST 1 ROW ONLY)
Master=

