
[General]
Version=1

[Preferences]
Username=
Password=2803
Database=
DateFormat=
CommitCount=0
CommitDelay=0
InitScript=

[Table]
Owner=SYS
Name=CUSTOMER_RAW_MATERIALS
Count=60

[Record]
Name=CUSTOMER_ID
Type=NUMBER
Size=
Data=SQL(SELECT CUSTOMERID 
=FROM CUSTOMERS
=ORDER BY DBMS_RANDOM.VALUE
=FETCH FIRST 1 ROW ONLY)
Master=

[Record]
Name=MATERIAL_ID
Type=NUMBER
Size=
Data=SQL(SELECT MATERIAL_ID 
=FROM RAW_MATERIALS
=ORDER BY DBMS_RANDOM.VALUE
=FETCH FIRST 1 ROW ONLY)
Master=

