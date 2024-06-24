
[General]
Version=1

[Preferences]
Username=
Password=2811
Database=
DateFormat=
CommitCount=0
CommitDelay=0
InitScript=

[Table]
Owner=C##ITAY
Name=PRODUCT
Count=25

[Record]
Name=PRODUCTID
Type=NUMBER
Size=38
Data=Random(10000000, 99999999)
Master=

[Record]
Name=NAME
Type=VARCHAR2
Size=255
Data=List('Patriot Missile System', 'THAAD (Terminal High Altitude Area Defense)', 'SM-6 (Standard Missile-6)', 'Iron Dome', 'Hellfire Missile', 'Javelin Missile', 'Stinger Missile', 'Harpoon Missile', 'Aegis Combat System', 'S-400 Missile System')
Master=

[Record]
Name=CATEGORY
Type=VARCHAR2
Size=255
Data=List('Surface-to-Air Missiles', 'Anti-Tank Missiles', 'Defense Systems')
Master=

[Record]
Name=PRICE
Type=NUMBER
Size=10,2
Data=Random(100000.00, 9999999.00)
Master=

[Record]
Name=DESCRIPTION
Type=VARCHAR2
Size=4000
Data=List('High-precision targeting for aerial threats', 'Armor-penetrating capability for ground targets', 'Comprehensive protection and surveillance')
Master=

[Record]
Name=INVENTORYCOUNT
Type=NUMBER
Size=38
Data=Random(1, 1000000)
Master=

