
[General]
Version=1

[Preferences]
Username=
Password=2757
Database=
DateFormat=
CommitCount=0
CommitDelay=0
InitScript=

[Table]
Owner=SYS
Name=ACCOUNT_MANAGER
Count=400

[Record]
Name=ACCOUNTMANAGERID
Type=NUMBER
Size=38
Data=Random(10000000, 99999999)
Master=

[Record]
Name=NAME
Type=VARCHAR2
Size=255
Data=FirstName + LastName
Master=

[Record]
Name=EMAIL
Type=VARCHAR2
Size=255
Data=Email
Master=

[Record]
Name=PHONE
Type=VARCHAR2
Size=20
Data=0+5+Random(10000000, 99999999)
Master=

[Record]
Name=DEPARTMENT
Type=VARCHAR2
Size=255
Data=List('mossad', 'ministry of defence', 'shabak' , 'idf' , 'refael')
Master=

