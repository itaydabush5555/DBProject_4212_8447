
[General]
Version=1

[Preferences]
Username=
Password=2164
Database=
DateFormat=
CommitCount=0
CommitDelay=0
InitScript=

[Table]
Owner=C##ITAY
Name=CUSTOMERS
Count=25

[Record]
Name=CUSTOMERID
Type=NUMBER
Size=38
Data=Random(10000000, 99999999)
Master=

[Record]
Name=NAME
Type=VARCHAR2
Size=255
Data=Country
Master=

[Record]
Name=CONTACTNUMBER
Type=VARCHAR2
Size=20
Data=0+5+Random(10000000, 99999999)
Master=

[Record]
Name=EMAIL
Type=VARCHAR2
Size=255
Data=Email
Master=

[Record]
Name=ADDRESS
Type=VARCHAR2
Size=4000
Data=Address1
Master=

[Record]
Name=INDUSTRYTYPE
Type=VARCHAR2
Size=255
Data=List('mossad', 'ministry of defence', 'shabak' , 'idf' , 'refael')
Master=

[Record]
Name=ACCOUNTMANAGERID
Type=NUMBER
Size=38
Data=SQL(SELECT ACCOUNTMANAGERID 
=FROM ACCOUNT_MANAGER 
=ORDER BY DBMS_RANDOM.VALUE
=FETCH FIRST 1 ROW ONLY)
Master=

