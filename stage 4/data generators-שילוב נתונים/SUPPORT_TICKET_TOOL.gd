
[General]
Version=1

[Preferences]
Username=
Password=2398
Database=
DateFormat=
CommitCount=0
CommitDelay=0
InitScript=

[Table]
Owner=SYS
Name=SUPPORT_TICKET_TOOL
Count=60

[Record]
Name=TICKET_ID
Type=NUMBER
Size=
Data=SQL(SELECT TICKETID 
=FROM SUPPORT_TICKET
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

