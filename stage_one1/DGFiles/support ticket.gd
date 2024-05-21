
[General]
Version=1

[Preferences]
Username=
Password=2289
Database=
DateFormat=
CommitCount=0
CommitDelay=0
InitScript=

[Table]
Owner=SYS
Name=SUPPORT_TICKET
Count=400

[Record]
Name=TICKETID
Type=NUMBER
Size=38
Data=Random(10000000, 99999999)
Master=

[Record]
Name=ISSUEDESCRIPTION
Type=VARCHAR2
Size=4000
Data=List('Reliability of detection systems', 'Interception accuracy', 'Communication latency', 'Maintenance and operational costs', 'Vulnerability to cyber attacks', 'Integration with existing defense systems', 'Environmental adaptability', 'False positives and negatives', 'Supply chain security', 'Operator training and human error')
Master=

[Record]
Name=STATUS
Type=VARCHAR2
Size=50
Data=List('Open', 'Pending', 'Resolved', 'Closed', 'Escalated')
Master=

[Record]
Name=CREATEDDATE
Type=DATE
Size=
Data=Random(01/01/2022, 01/05/2023)
Master=

[Record]
Name=RESOLVEDDATE
Type=DATE
Size=
Data=Random(01/05/2023, 01/05/2024)
Master=

[Record]
Name=CUSTOMERID
Type=NUMBER
Size=38
Data=SQL(SELECT * FROM (SELECT CUSTOMERID FROM CUSTOMERS ORDER BY DBMS_RANDOM.VALUE) WHERE ROWNUM = 1)
Master=

[Record]
Name=ACCOUNTMANAGERID
Type=NUMBER
Size=38
Data=SQL(SELECT * FROM (SELECT ACCOUNTMANAGERID FROM ACCOUNT_MANAGER ORDER BY DBMS_RANDOM.VALUE) WHERE ROWNUM = 1)
Master=

