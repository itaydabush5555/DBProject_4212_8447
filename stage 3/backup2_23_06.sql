prompt PL/SQL Developer Export Tables for user SYS@XE
prompt Created by Dabush on Sunday, 23 June 2024
set feedback off
set define off

prompt Dropping ACCOUNT_MANAGER...
drop table ACCOUNT_MANAGER cascade constraints;
prompt Dropping CUSTOMERS...
drop table CUSTOMERS cascade constraints;
prompt Dropping AIR_ORDER...
drop table AIR_ORDER cascade constraints;
prompt Dropping PRODUCT...
drop table PRODUCT cascade constraints;
prompt Dropping PART_OF...
drop table PART_OF cascade constraints;
prompt Dropping PAYMENT...
drop table PAYMENT cascade constraints;
prompt Dropping SUPPORT_TICKET...
drop table SUPPORT_TICKET cascade constraints;
prompt Creating ACCOUNT_MANAGER...
create table ACCOUNT_MANAGER
(
  accountmanagerid NUMBER(38) not null,
  name             VARCHAR2(255) not null,
  email            VARCHAR2(255) not null,
  phone            VARCHAR2(20) not null,
  department       VARCHAR2(255) not null
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table ACCOUNT_MANAGER
  add constraint PK_ACCOUNT_MANAGER primary key (ACCOUNTMANAGERID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
grant select, insert, update, delete, references, alter, index, debug, read on ACCOUNT_MANAGER to PUBLIC;

prompt Creating CUSTOMERS...
create table CUSTOMERS
(
  customerid       NUMBER(38) not null,
  name             VARCHAR2(255) not null,
  contactnumber    VARCHAR2(20) not null,
  email            VARCHAR2(255) not null,
  address          VARCHAR2(4000) not null,
  industrytype     VARCHAR2(255) not null,
  accountmanagerid NUMBER(38) not null
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table CUSTOMERS
  add constraint PK_CUSTOMER primary key (CUSTOMERID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table CUSTOMERS
  add constraint FK_CUSTOMER foreign key (ACCOUNTMANAGERID)
  references ACCOUNT_MANAGER (ACCOUNTMANAGERID) on delete cascade;
grant select, insert, update, delete, references, alter, index, debug, read on CUSTOMERS to PUBLIC;

prompt Creating AIR_ORDER...
create table AIR_ORDER
(
  orderid      NUMBER(38) not null,
  orderdate    DATE not null,
  deliverydate DATE not null,
  status       VARCHAR2(50) not null,
  totalamount  NUMBER(10,2) not null,
  customerid   NUMBER(38)
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table AIR_ORDER
  add constraint PK_ORDER_ primary key (ORDERID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table AIR_ORDER
  add constraint FK_ORDER_ foreign key (CUSTOMERID)
  references CUSTOMERS (CUSTOMERID);
alter table AIR_ORDER
  add constraint CHCK_TOTAL_AMOUNT
  check (TotalAmount >= 0);
grant select, insert, update, delete, references, alter, index, debug, read on AIR_ORDER to PUBLIC;

prompt Creating PRODUCT...
create table PRODUCT
(
  productid      NUMBER(38) not null,
  name           VARCHAR2(255) not null,
  category       VARCHAR2(255) not null,
  price          NUMBER(10,2) not null,
  description    VARCHAR2(4000) not null,
  inventorycount NUMBER(38) not null
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table PRODUCT
  add constraint PK_PRODUCT primary key (PRODUCTID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table PRODUCT
  add constraint CHCK_PRICEPOSITIVE
  check (Price > 0);
grant select, insert, update, delete, references, alter, index, debug, read on PRODUCT to PUBLIC;

prompt Creating PART_OF...
create table PART_OF
(
  orderid   NUMBER(38) not null,
  productid NUMBER(38) not null
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table PART_OF
  add constraint PK_PART_OF primary key (ORDERID, PRODUCTID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table PART_OF
  add constraint FK_PART_OF foreign key (ORDERID)
  references AIR_ORDER (ORDERID) on delete cascade;
alter table PART_OF
  add constraint FK_PART_OF2 foreign key (PRODUCTID)
  references PRODUCT (PRODUCTID);
grant select, insert, update, delete, references, alter, index, debug, read on PART_OF to PUBLIC;

prompt Creating PAYMENT...
create table PAYMENT
(
  paymentid     NUMBER(38) not null,
  paymentdate   DATE not null,
  paymentmethod VARCHAR2(50) default 'Credit Card' not null,
  amount        NUMBER(10,2) not null,
  transactionid VARCHAR2(50) not null,
  orderid       NUMBER(38)
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table PAYMENT
  add constraint PK_PAYMENT primary key (PAYMENTID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table PAYMENT
  add constraint FK_PAYMENT foreign key (ORDERID)
  references AIR_ORDER (ORDERID);
grant select, insert, update, delete, references, alter, index, debug, read on PAYMENT to PUBLIC;

prompt Creating SUPPORT_TICKET...
create table SUPPORT_TICKET
(
  ticketid         NUMBER(38) not null,
  issuedescription VARCHAR2(4000) not null,
  status           VARCHAR2(50) not null,
  createddate      DATE not null,
  resolveddate     DATE,
  customerid       NUMBER(38),
  accountmanagerid NUMBER(38)
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table SUPPORT_TICKET
  add constraint PK_SUPPORT_TICKET primary key (TICKETID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table SUPPORT_TICKET
  add constraint FK_SUPPORT_TICKET foreign key (CUSTOMERID)
  references CUSTOMERS (CUSTOMERID);
alter table SUPPORT_TICKET
  add constraint FK_SUPPORT_TICKET2 foreign key (ACCOUNTMANAGERID)
  references ACCOUNT_MANAGER (ACCOUNTMANAGERID);
alter table SUPPORT_TICKET
  add constraint CHEK_DATES
  check (ResolvedDate IS NULL OR ResolvedDate > CreatedDate);
grant select, insert, update, delete, references, alter, index, debug, read on SUPPORT_TICKET to PUBLIC;

prompt Disabling triggers for ACCOUNT_MANAGER...
alter table ACCOUNT_MANAGER disable all triggers;
prompt Disabling triggers for CUSTOMERS...
alter table CUSTOMERS disable all triggers;
prompt Disabling triggers for AIR_ORDER...
alter table AIR_ORDER disable all triggers;
prompt Disabling triggers for PRODUCT...
alter table PRODUCT disable all triggers;
prompt Disabling triggers for PART_OF...
alter table PART_OF disable all triggers;
prompt Disabling triggers for PAYMENT...
alter table PAYMENT disable all triggers;
prompt Disabling triggers for SUPPORT_TICKET...
alter table SUPPORT_TICKET disable all triggers;
prompt Disabling foreign key constraints for CUSTOMERS...
alter table CUSTOMERS disable constraint FK_CUSTOMER;
prompt Disabling foreign key constraints for AIR_ORDER...
alter table AIR_ORDER disable constraint FK_ORDER_;
prompt Disabling foreign key constraints for PART_OF...
alter table PART_OF disable constraint FK_PART_OF;
alter table PART_OF disable constraint FK_PART_OF2;
prompt Disabling foreign key constraints for PAYMENT...
alter table PAYMENT disable constraint FK_PAYMENT;
prompt Disabling foreign key constraints for SUPPORT_TICKET...
alter table SUPPORT_TICKET disable constraint FK_SUPPORT_TICKET;
alter table SUPPORT_TICKET disable constraint FK_SUPPORT_TICKET2;
prompt Loading ACCOUNT_MANAGER...
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (26751198, 'IsaacNuman', 'isaac.numan@gsat.br', '85652444', 'idf');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (34377258, 'GeoffreyHong', 'ghong@safehomesecurity.com', '73865899', 'refael');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (91941817, 'ColmSchreiber', 'cschreiber@ptg.id', '27384623', 'mossad');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (80135037, 'SophieWiedlin', 'sophie.wiedlin@daimlerchrysler.com', '43286882', 'shabak');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (65437831, 'JoseDavison', 'jose.davison@sony.uk', '23615151', 'refael');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (93074635, 'TyWilder', 'ty.wilder@cimalabs.de', '31850496', 'ministry of defence');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (30004002, 'VerucaDean', 'veruca.dean@bps.uk', '40879698', 'mossad');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (13662391, 'JeremyWilliams', 'jeremy@trainersoft.ch', '90586057', 'ministry of defence');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (84289834, 'PabloGagnon', 'pablo.gagnon@fra.de', '78479717', 'mossad');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (50482581, 'GeggyHingle', 'geggyh@printcafesoftware.com', '47319457', 'refael');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (12063596, 'DaveyRains', 'davey.rains@yes.com', '69432892', 'idf');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (76622103, 'GeoffGano', 'geoff.gano@anheuserbusch.com', '62145354', 'shabak');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (18582476, 'SharonBrosnan', 'sharon@proclarity.de', '16211234', 'refael');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (61952238, 'KatieTinsley', 'katie.tinsley@marketbased.uk', '13390194', 'ministry of defence');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (69600577, 'JulietteFlemyng', 'juliette.flemyng@peerlessmanufacturing.uk', '73227886', 'idf');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (84233322, 'SuziGooding', 'sgooding@worldcom.ch', '86027212', 'refael');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (77108638, 'SammyMorse', 'sammy.morse@ecopy.com', '12431619', 'ministry of defence');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (85646600, 'JasonMiles', 'jmiles@fmb.com', '34364583', 'idf');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (22378117, 'JoanSummer', 'j.summer@yes.de', '30444228', 'ministry of defence');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (26629738, 'LonnieLaSalle', 'lonnie.lasalle@gbas.de', '44538298', 'idf');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (32484933, 'SaulSaucedo', 'saul@at.com', '73446533', 'refael');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (52090085, 'PhilChandler', 'phil.chandler@ois.fr', '61880626', 'mossad');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (58240196, 'MiaMichael', 'miam@qssgroup.com', '26665715', 'mossad');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (38338043, 'JoshLawrence', 'josh.lawrence@usenergyservices.de', '46219477', 'mossad');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (34094782, 'ChloeSylvian', 'chloe.sylvian@ivorysystems.ch', '23157895', 'refael');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (69052929, 'RyanKattan', 'rkattan@providenceservice.com', '40674803', 'mossad');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (54594862, 'AnnRoy Parnell', 'ann.r@aristotle.com', '36750482', 'shabak');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (26245051, 'FredericBridges', 'frederic.b@berkshirehathaway.com', '41353211', 'idf');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (48850105, 'SonaFlemyng', 'sona.flemyng@dbprofessionals.com', '67079046', 'shabak');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (51162768, 'BenicioStatham', 'benicio.s@trc.de', '79238879', 'refael');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (15143232, 'RitchieBright', 'ritchie.bright@tripwire.com', '49923451', 'mossad');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (16747819, 'DustinRamirez', 'dustin.ramirez@unitedasset.com', '54279681', 'ministry of defence');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (81828427, 'WoodyScott', 'woody.scott@fmb.ar', '90202314', 'mossad');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (19941178, 'BridgetteCeasar', 'bridgette.ceasar@usgovernment.com', '60333221', 'refael');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (66198811, 'EdwardKramer', 'edward.kramer@terrafirma.ch', '77713039', 'idf');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (98008948, 'MilesGaines', 'miles.gaines@kiamotors.de', '44781556', 'shabak');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (91245220, 'TreatDonovan', 'treat.donovan@fmt.com', '99373161', 'shabak');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (86759135, 'JuanWalsh', 'j.walsh@keymark.com', '53603481', 'mossad');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (20535791, 'FairuzaOjeda', 'fairuza.ojeda@ceb.de', '21869108', 'mossad');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (96010688, 'SalmaTillis', 'salma@aco.com', '10220432', 'idf');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (50930370, 'DermotMargolyes', 'd.margolyes@spotfireholdings.ca', '82005676', 'ministry of defence');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (92027102, 'AngelaTaylor', 'angela@trafficmanagement.de', '59261429', 'mossad');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (89625827, 'ThoraBrown', 'thora.b@monarchcasino.com', '65130050', 'refael');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (48343603, 'DickLunch', 'dick.lunch@prosperitybancshares.com', '11733620', 'mossad');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (57079314, 'HughScorsese', 'hugh.scorsese@callhenry.com', '32927512', 'idf');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (67511575, 'RandyBailey', 'randy.bailey@tarragonrealty.nl', '14846385', 'shabak');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (17424418, 'PeterHatosy', 'peter@allegiantbancorp.au', '93783611', 'ministry of defence');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (19906683, 'BernardHeron', 'bernard.heron@mai.com', '50446636', 'mossad');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (17118876, 'NathanTah', 'ntah@ptg.au', '69379558', 'shabak');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (30988658, 'ChristianDuncan', 'christian@marlabs.com', '36545716', 'idf');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (96833634, 'MekhiAssante', 'mekhi.assante@woronocobancorp.de', '10578985', 'shabak');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (47647666, 'BonnieMcCoy', 'bonnie@horizon.com', '22204911', 'idf');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (53199981, 'JulioConners', 'julio@lifelinesystems.de', '38607806', 'idf');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (24483143, 'ChristmasBale', 'christmas.bale@hiltonhotels.es', '18865296', 'mossad');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (48037937, 'MekhiCurtis-Hall', 'mekhi.curtishall@comnetinternational.jp', '27138803', 'mossad');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (79283183, 'ClaireBrooke', 'claire@knightsbridge.de', '72778053', 'idf');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (93245618, 'CesarTisdale', 'cesart@pinnaclestaffing.uk', '33963535', 'ministry of defence');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (29650588, 'CevinHimmelman', 'cevin.himmelman@pragmatechsoftware.com', '40934736', 'refael');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (69850015, 'AshleyIrving', 'ashley.irving@nhhc.de', '48435334', 'mossad');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (89040214, 'NevePantoliano', 'neve.pantoliano@nhhc.com', '93505745', 'idf');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (68766738, 'KaseyWilliamson', 'kwilliamson@spinnakerexploration.com', '69751766', 'shabak');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (93619695, 'CliffCube', 'ccube@ssci.com', '38013661', 'mossad');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (53081260, 'Jonny LeeStatham', 'jonnylee.statham@ataservices.it', '36308819', 'ministry of defence');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (73405396, 'NilsCoburn', 'nils@ghrsystems.fr', '74932629', 'shabak');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (94834146, 'StockardGuinness', 'stockardg@kmart.hk', '92112314', 'idf');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (45171084, 'DebiKlugh', 'debi.k@gtp.com', '74993000', 'idf');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (76115146, 'KatrinCaan', 'katrin.caan@sps.ca', '22312136', 'refael');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (68943193, 'MickeyRudd', 'mickey.rudd@smartdrawcom.it', '53438583', 'idf');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (66916660, 'KellyRichter', 'kelly@jewettcameron.com', '65983080', 'refael');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (13934808, 'ToriStevens', 'tstevens@sfgo.com', '68561119', 'mossad');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (67182998, 'SonnySalonga', 'sonny.salonga@securitycheck.br', '51388186', 'mossad');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (92780851, 'DianePeet', 'dianep@gulfmarkoffshore.com', '50973309', 'idf');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (17686373, 'SylvesterCurfman', 'sylvester.curfman@taycorfinancial.com', '35848893', 'ministry of defence');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (41364390, 'ZooeyArden', 'zooey.arden@safeway.uk', '61881457', 'mossad');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (17690127, 'AliciaBurstyn', 'alicia.burstyn@httprint.com', '82705403', 'refael');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (18700397, 'ArtSpeaks', 'art.speaks@dvdt.ar', '46976483', 'mossad');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (90102278, 'CollectiveMacDonald', 'collective.macdonald@kwraf.br', '48741920', 'ministry of defence');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (28552995, 'HarrisonGere', 'harrison.gere@ezecastlesoftware.il', '75516531', 'idf');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (16941013, 'MarleyHamilton', 'marley.hamilton@veritekinternational.il', '50230964', 'ministry of defence');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (81119660, 'MartinThomson', 'martin.thomson@staffforce.id', '17195214', 'refael');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (99508568, 'LupeLeguizamo', 'lupe@technica.ca', '93753584', 'idf');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (76748185, 'RhonaMohr', 'rhona.mohr@afs.ca', '19284287', 'mossad');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (19095344, 'AimeeCopeland', 'a.copeland@aci.it', '50002815', 'refael');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (44388764, 'WallaceKershaw', 'wallace.kershaw@loreal.de', '99696336', 'mossad');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (53655705, 'TerrenceMcGill', 'terrence@americanhealthways.pt', '37232526', 'mossad');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (77991076, 'HikaruRanger', 'hikaru@pioneerdatasystems.com', '17516008', 'refael');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (55167864, 'JimEllis', 'jim@csi.com', '61122603', 'refael');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (20983251, 'AdrienTravolta', 'adrien.travolta@cyberthink.com', '30495722', 'refael');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (56834602, 'PatriciaMarie', 'patricia@americanpan.de', '69470005', 'refael');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (58395283, 'RuthMarx', 'ruth.marx@fsffinancial.il', '11675539', 'refael');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (93680962, 'IlleanaHurley', 'illeana.h@smi.com', '33065942', 'mossad');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (12360036, 'GranStuermer', 'gran.s@mss.com', '96448850', 'refael');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (90589554, 'CarolynPalmieri', 'carolynp@keymark.ca', '23307269', 'idf');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (65681397, 'JeffreyGiannini', 'jeffrey@cooktek.com', '41443381', 'ministry of defence');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (64558450, 'EwanAustin', 'e.austin@ungertechnologies.es', '95342473', 'ministry of defence');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (87449313, 'DennisTripplehorn', 'dennis.tripplehorn@atxforms.au', '77930946', 'shabak');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (31539350, 'LilaKoteas', 'lila.koteas@avr.com', '76179010', 'shabak');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (42004482, 'RalphWarburton', 'rwarburton@faef.nl', '25812182', 'idf');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (40046332, 'MelQuinlan', 'melq@profitline.ca', '24691145', 'shabak');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (91026196, 'CoreyCox', 'corey.cox@vspan.gr', '63028353', 'ministry of defence');
commit;
prompt 100 records committed...
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (31627888, 'BustaDean', 'busta.dean@socketinternet.pl', '66631403', 'mossad');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (71913410, 'TalAlexander', 'tala@cynergydata.ch', '24365553', 'idf');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (94372304, 'CarrieBelles', 'carrie.belles@ibfh.au', '79223102', 'refael');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (22027123, 'VickieOsbourne', 'vickie.osbourne@advancedneuromodulation.se', '91303395', 'shabak');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (49724388, 'MilesElizabeth', 'melizabeth@anheuserbusch.jp', '70134932', 'shabak');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (21000949, 'TobeyKeith', 'tobey.keith@cooktek.br', '74557370', 'ministry of defence');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (73124932, 'GoldieHaslam', 'goldie.haslam@connected.tw', '17407554', 'mossad');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (44970893, 'DebbieFarrell', 'dfarrell@3tsystems.com', '46758242', 'refael');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (64207060, 'KaronEldard', 'karone@questarcapital.za', '74079986', 'shabak');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (73833190, 'Jonny LeeShand', 'jshand@coldstonecreamery.be', '80469069', 'idf');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (82677291, 'Carrie-AnneBusey', 'carrieanne.busey@privatebancorp.com', '44502167', 'refael');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (30749980, 'LaraLane', 'lara.lane@ads.com', '55847016', 'idf');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (33365865, 'ElizabethRucker', 'elizabeth.rucker@volkswagen.com', '59036314', 'shabak');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (71933637, 'RichieGertner', 'r.gertner@northhighland.com', '45053558', 'ministry of defence');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (40787394, 'DenzelCarlisle', 'denzel@signalperfection.com', '64178364', 'mossad');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (63984513, 'AshtonSoul', 'ashton@typhoon.it', '63863508', 'ministry of defence');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (49017588, 'TildaGilley', 'tilda.gilley@veritekinternational.jp', '98391946', 'mossad');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (12473697, 'TrickSedaka', 'trick.sedaka@fam.uk', '82375805', 'idf');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (50084826, 'CarolineUnderwood', 'caroline.underwood@gentrasystems.ca', '47179144', 'mossad');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (12560849, 'MurrayPitney', 'm.pitney@stonetechprofessional.fr', '48234462', 'shabak');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (24162881, 'MarianneJudd', 'marianne.judd@career.com', '78358321', 'ministry of defence');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (76663286, 'DaryleOrbit', 'd.orbit@ssci.ar', '18751680', 'shabak');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (48623161, 'ThoraHumphrey', 'thora.humphrey@comglobalsystems.com', '46523838', 'ministry of defence');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (55118114, 'MinniePierce', 'minnie.pierce@lemproducts.it', '88229123', 'ministry of defence');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (55534854, 'HerbieTempest', 'herbiet@ams.it', '52608775', 'refael');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (57590546, 'JavonCulkin', 'javon@speakeasy.ch', '99824231', 'ministry of defence');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (74593174, 'MykeltiJeter', 'mykelti.jeter@eagleone.uk', '77831602', 'shabak');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (59141156, 'JulianaDanger', 'juliana@totalentertainment.it', '79831871', 'refael');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (28599808, 'OdedDanes', 'odedd@socketinternet.ch', '81724741', 'mossad');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (85517448, 'GinaWood', 'g.wood@worldcom.com', '88653234', 'idf');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (50752399, 'NikSpector', 'nik.s@max.hk', '26175596', 'ministry of defence');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (61454003, 'MegGallant', 'mgallant@ogi.com', '19002258', 'mossad');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (13643000, 'SaulLavigne', 'saul@parksite.jp', '19511733', 'ministry of defence');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (81549307, 'SimonLlewelyn', 'simon.llewelyn@wrgservices.ar', '37445045', 'mossad');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (94757310, 'SimonPhillips', 'sphillips@gcd.de', '26016058', 'refael');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (16889674, 'GrahamPerrineau', 'graham.perrineau@hiltonhotels.dk', '79224446', 'idf');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (35355829, 'JohnniePaxton', 'johnnie.paxton@sfmai.com', '74626059', 'idf');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (78052010, 'ManuMaxwell', 'manu.maxwell@oss.com', '64305704', 'ministry of defence');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (15535924, 'GeoffreyReeve', 'g.reeve@kingland.at', '64141798', 'ministry of defence');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (25059771, 'LeonHampton', 'l.hampton@fmt.au', '98065066', 'mossad');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (27273162, 'ClaireLemmon', 'clemmon@allegiantbancorp.ch', '95165094', 'idf');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (11359073, 'DougHolm', 'dough@multimedialive.ch', '20054329', 'shabak');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (88939000, 'MinnieWinwood', 'minnie.winwood@trx.com', '49168801', 'mossad');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (95797610, 'AllanWhitman', 'allan.whitman@johnkeeler.com', '22412666', 'ministry of defence');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (55407648, 'MarinaPerez', 'marinap@coridiantechnologies.ca', '48635082', 'refael');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (68164722, 'ArnoldKleinenberg', 'arnoldk@coridiantechnologies.com', '32652018', 'idf');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (71812980, 'LionelHerrmann', 'lionel@mindworks.com', '56842335', 'mossad');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (15306935, 'CeiliEvans', 'ceili.evans@typhoon.com', '21268577', 'shabak');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (65735430, 'JoelyMcFerrin', 'joely.mcferrin@seafoxboat.de', '75078707', 'shabak');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (25487781, 'CollectiveLaBelle', 'collectivel@flavorx.com', '81037952', 'shabak');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (44369962, 'QuentinJenkins', 'q.jenkins@ris.br', '99166807', 'idf');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (57384919, 'CarolynHopper', 'carolyn@mattel.com', '37973618', 'ministry of defence');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (99913540, 'RebeccaKhan', 'r.khan@pra.de', '95720223', 'mossad');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (41915928, 'MarieCrewson', 'marie.c@zoneperfectnutrition.de', '63170288', 'idf');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (48743769, 'LenaDiffie', 'lena@kitba.au', '19616344', 'mossad');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (22578416, 'DavisKeen', 'davis.keen@ads.com', '74765170', 'shabak');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (98726344, 'RhysKatt', 'rhys.k@intel.es', '65148683', 'mossad');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (65843671, 'AngelaBrolin', 'angela.b@computersource.com', '74354890', 'ministry of defence');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (52337857, 'LivSanta Rosa', 'livs@perfectorder.com', '59110720', 'shabak');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (23223019, 'JodyHyde', 'jodyh@reckittbenckiser.com', '66026740', 'shabak');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (13289169, 'MollyStiller', 'molly.s@kimberlyclark.com', '62484369', 'idf');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (59704787, 'TonyYulin', 'tony.y@sysconmedia.uk', '76025316', 'ministry of defence');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (64964952, 'JoelyHunter', 'joely.hunter@signature.de', '34983232', 'shabak');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (92923830, 'ReneeStuermer', 'renee.stuermer@sensortechnologies.za', '58872750', 'idf');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (49145613, 'SydneyOszajca', 'sydney.oszajca@owm.it', '30983786', 'ministry of defence');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (85722420, 'ChaleeHenriksen', 'chalee.henriksen@scheringplough.com', '26304664', 'idf');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (47100922, 'SpencerColman', 'spencer.colman@pra.jp', '78042080', 'refael');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (11593556, 'NightBachman', 'n.bachman@printtech.de', '45715047', 'ministry of defence');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (65106978, 'FredCox', 'fred.cox@zoneperfectnutrition.fr', '66035016', 'mossad');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (54066626, 'DennyFisher', 'denny.fisher@meritagetechnologies.com', '90157534', 'mossad');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (23327608, 'RhonaMurdock', 'r.murdock@prosum.mo', '48400852', 'ministry of defence');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (96293674, 'MichelleWhitwam', 'michelle.whitwam@gsat.com', '58998737', 'refael');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (85343331, 'ChelyDreyfuss', 'chely.dreyfuss@palmbeachtan.au', '53462841', 'ministry of defence');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (36922278, 'RobbieApple', 'robbie.apple@elmco.com', '41779779', 'idf');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (63132707, 'NileCrewson', 'nile.crewson@electricalsolutions.uk', '69917346', 'ministry of defence');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (75096207, 'MarlonRoy Parnell', 'm.royparnell@comglobalsystems.ch', '10981581', 'ministry of defence');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (47679423, 'JuddProwse', 'j.prowse@topicsentertainment.de', '26172877', 'shabak');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (19200760, 'PenelopeD''Onofrio', 'penelope.donofrio@fpf.com', '73871011', 'shabak');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (95898426, 'DarylTwilley', 'darylt@angieslist.fr', '71923054', 'mossad');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (84046587, 'NikkiGarza', 'nikki@spas.fi', '14426289', 'ministry of defence');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (43052751, 'LouiseHaslam', 'louise.haslam@bristolmyers.ee', '15730654', 'idf');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (76023266, 'NeveLynne', 'neve.lynne@unicru.es', '69144717', 'shabak');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (41096524, 'RosanneTeng', 'rosanne.teng@meridiangold.fr', '68649865', 'idf');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (30129965, 'GavinMcKean', 'gavin.mckean@virbac.com', '49123131', 'ministry of defence');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (37830269, 'ChadWhitman', 'cwhitman@bps.il', '40042068', 'idf');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (62895098, 'JonathanBlades', 'jonathan@shirtfactory.com', '58486585', 'shabak');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (26283456, 'SineadSchiavelli', 'sinead.schiavelli@greene.be', '33960099', 'mossad');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (34977905, 'JetCruise', 'jet.c@scripnet.de', '80683017', 'ministry of defence');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (33494717, 'HarrisLeigh', 'hleigh@nobrainerblindscom.ch', '37939699', 'idf');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (93907876, 'HookahWakeling', 'hookah.wakeling@lfg.au', '89729051', 'mossad');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (93097471, 'MariaCulkin', 'maria.culkin@hotmail.il', '31037506', 'shabak');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (80406231, 'JenniferBrock', 'j.brock@telesynthesis.com', '22156306', 'mossad');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (47615557, 'MintClayton', 'mint@calence.ch', '89907982', 'ministry of defence');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (75090580, 'BenicioHerrmann', 'benicio.herrmann@intel.jp', '77623130', 'mossad');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (16493046, 'KevnChaplin', 'kevn.chaplin@gha.com', '63251754', 'shabak');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (23022486, 'NoahMakowicz', 'noah.makowicz@tripwire.be', '53037916', 'shabak');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (11897171, 'IsaiahGiannini', 'igiannini@vertexsolutions.uk', '67749773', 'mossad');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (22779706, 'MickeyMeniketti', 'mickey@curagroup.it', '19143149', 'mossad');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (59108893, 'GwynethBiehn', 'gwyneth.biehn@quicksilverresources.com', '53567295', 'shabak');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (23674184, 'MaeWinans', 'mae.winans@caliber.za', '53034990', 'shabak');
commit;
prompt 200 records committed...
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (81027755, 'JessicaRawls', 'jessica.rawls@kmart.com', '11085226', 'idf');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (50583748, 'GinoMarshall', 'gino.m@appriss.jp', '77847518', 'shabak');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (40797578, 'GlenVai', 'glenv@sfb.com', '76329798', 'mossad');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (37577399, 'BetteDerringer', 'b.derringer@northhighland.tr', '16593861', 'ministry of defence');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (32573055, 'TerryWeiss', 'terry@connected.in', '87589201', 'refael');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (57651751, 'MoeCapshaw', 'moe.capshaw@lms.ca', '32497493', 'refael');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (66590336, 'IsaacBassett', 'isaac.bassett@timberlanewoodcrafters.br', '39001970', 'ministry of defence');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (31911846, 'KevnSnow', 'kevn.snow@aco.uk', '64538171', 'refael');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (32205270, 'LonnieFrancis', 'lonnie@navigatorsystems.com', '88224362', 'mossad');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (35511914, 'ElleCurtis-Hall', 'elle.curtishall@bluffcitysteel.com', '61968107', 'shabak');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (14652467, 'RhettSpector', 'rhett@curagroup.dk', '86266607', 'shabak');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (92575580, 'MarinaLoeb', 'marina.loeb@integramedamerica.com', '97183285', 'ministry of defence');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (13702788, 'Jonny LeePigott-Smith', 'jpigottsmith@doraldentalusa.au', '31294644', 'refael');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (48061480, 'KurtwoodTippe', 'kurtwood@team.com', '61512745', 'mossad');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (45196498, 'BrendaViterelli', 'brenda.viterelli@sps.com', '22472291', 'ministry of defence');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (49385556, 'WillieCotton', 'wcotton@sunstream.de', '54498327', 'refael');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (98155811, 'OmarOlin', 'o.olin@codykramerimports.com', '18875711', 'shabak');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (65345057, 'JeffreyMerchant', 'jeffrey.merchant@aldensystems.com', '57362315', 'ministry of defence');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (12293095, 'MindyDayne', 'mindy@jma.it', '89945472', 'shabak');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (62359760, 'ArturoBall', 'a.ball@investorstitle.ca', '54222008', 'idf');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (46538655, 'KennethTierney', 'kenneth.tierney@aventis.com', '62369017', 'ministry of defence');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (98442581, 'HeathJudd', 'hjudd@pds.fr', '93461391', 'ministry of defence');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (96051151, 'GladysParker', 'gladys.parker@ads.jp', '10447463', 'refael');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (20664618, 'TiaRifkin', 'trifkin@progressivedesigns.com', '68352852', 'shabak');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (40751966, 'AnnaDean', 'annad@daimlerchrysler.uk', '33345067', 'ministry of defence');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (67980173, 'SuzanneHanley', 'suzanne.hanley@envisiontelephony.au', '66213160', 'shabak');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (16442662, 'JeffWoodard', 'jeff.woodard@prp.de', '95523679', 'refael');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (95359116, 'JoyMcConaughey', 'joy.mcconaughey@mission.jp', '95775123', 'idf');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (20537979, 'EdwinMars', 'edwin.mars@glaxosmithkline.cn', '23980818', 'ministry of defence');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (46115979, 'TomHamilton', 'thamilton@staffforce.ch', '54764487', 'shabak');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (35053402, 'SophiePonty', 'sophie@acsis.ve', '80950268', 'ministry of defence');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (24746859, 'MariaLightfoot', 'mlightfoot@commworks.com', '73386148', 'shabak');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (27891387, 'KristinCohn', 'kristinc@tracertechnologies.ch', '43985800', 'idf');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (70085003, 'CevinKingsley', 'cevin@hfg.in', '84136006', 'mossad');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (38454192, 'TobeySpader', 'tobey.spader@abatix.in', '20113721', 'refael');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (81261537, 'HowieBriscoe', 'howie.briscoe@ads.jp', '51202400', 'ministry of defence');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (62958717, 'IlleanaGeldof', 'illeana.geldof@nestle.de', '21493502', 'refael');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (55720634, 'GeneEngland', 'gene.england@cascadebancorp.com', '81658249', 'idf');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (25515496, 'JimDetmer', 'jim.detmer@qssgroup.it', '25610411', 'shabak');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (58281867, 'HopeCummings', 'hope@yashtechnologies.com', '27675768', 'ministry of defence');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (27892270, 'LynnVassar', 'lynn.vassar@datawarehouse.de', '62345222', 'mossad');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (57107054, 'StephanieBreslin', 'stephanie.breslin@ipsadvisory.br', '21697322', 'mossad');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (53771409, 'DenzelCotton', 'denzel.cotton@integratelecom.com', '87001166', 'mossad');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (19677024, 'AhmadMarie', 'ahmad.marie@hardwoodwholesalers.jp', '39844814', 'idf');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (53095125, 'ErnestWesterberg', 'ernest.w@gillette.com', '16038167', 'ministry of defence');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (56332092, 'TerrenceIrving', 'terrence.i@nmr.com', '99094809', 'shabak');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (21691339, 'DougRourke', 'doug.rourke@callhenry.jp', '67986368', 'mossad');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (31733028, 'GrantFierstein', 'grant.f@typhoon.ee', '78957587', 'idf');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (37607652, 'MelbaSedgwick', 'melba.s@nat.com', '60742106', 'idf');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (26951130, 'KennethDanes', 'kenneth.danes@hiltonhotels.pk', '65353296', 'ministry of defence');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (27095403, 'MitchellWalker', 'mitchell.walker@csi.com', '80528898', 'ministry of defence');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (74086583, 'AndrePorter', 'andre.p@anheuserbusch.de', '49242542', 'idf');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (39374108, 'ElvisStevenson', 'elvis.stevenson@captechventures.com', '11758441', 'refael');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (42506479, 'NoahLoggins', 'noah.loggins@tmaresources.com', '34851147', 'idf');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (97985601, 'LindseyDushku', 'lindsey.dushku@staffforce.com', '65452810', 'ministry of defence');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (60488951, 'JeanneHewitt', 'jeanneh@ceom.com', '55494361', 'idf');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (89405048, 'AlbertinaGreene', 'albertina.greene@tarragonrealty.com', '74133727', 'refael');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (59449184, 'ShawnShaye', 'shawn.shaye@ris.de', '28667289', 'idf');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (98571854, 'ShawnSnow', 'shawn.s@shar.com', '90872349', 'mossad');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (11255649, 'KimberlyKershaw', 'kimberly.kershaw@coldstonecreamery.fr', '36283995', 'idf');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (16793442, 'SandraAzaria', 's.azaria@pacificdatadesigns.fi', '47433117', 'idf');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (44767093, 'AaronWeston', 'aaron@owm.com', '57699751', 'mossad');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (36954460, 'LoisSingh', 'lois.s@shot.mx', '87352315', 'refael');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (32155969, 'ElvisBraugher', 'elvis.b@sony.it', '68252888', 'refael');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (96883344, 'MaureenWinter', 'm.winter@staffforce.au', '92689588', 'ministry of defence');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (29949025, 'KennethLaPaglia', 'kenneth.lapaglia@ultimus.com', '10093760', 'idf');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (42287134, 'TramaineKnight', 'tramaine.knight@ams.com', '11849711', 'refael');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (23987210, 'LariPerrineau', 'lari.perrineau@cocacola.com', '26916497', 'idf');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (56171610, 'NinaParish', 'nina.p@glacierbancorp.at', '90952639', 'idf');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (93043478, 'JulieSampson', 'julie.sampson@yes.com', '43272376', 'idf');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (87215493, 'AlecWhitford', 'alec@ceb.ch', '34836301', 'mossad');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (13102386, 'IvanMagnuson', 'ivan@waltdisney.com', '14611538', 'mossad');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (55267731, 'LesleyFogerty', 'lesley@prometheuslaboratories.com', '17790002', 'idf');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (20936963, 'BarbaraSchwimmer', 'barbara.schwimmer@streetglow.de', '49985438', 'shabak');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (74037064, 'DonalMolina', 'donal.m@thinktanksystems.uk', '18669131', 'ministry of defence');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (48109402, 'IvanGoldberg', 'ivan.goldberg@authoria.com', '23020200', 'ministry of defence');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (73020463, 'StewartFeuerstein', 'stewart@priorityleasing.uk', '31613875', 'ministry of defence');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (55372821, 'IsaacDiBiasio', 'isaac.dibiasio@mqsoftware.com', '30626677', 'ministry of defence');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (30854231, 'JulianaGarr', 'j.garr@providenceservice.at', '44224758', 'mossad');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (76570214, 'WendyYoung', 'w.young@slt.de', '56049075', 'mossad');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (11912356, 'LariBerkeley', 'lari.berkeley@technica.fr', '82744009', 'shabak');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (93760431, 'IkeTah', 'iket@doraldentalusa.com', '20431683', 'idf');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (11857649, 'FrancesSnider', 'frances.snider@hfn.uk', '11609562', 'refael');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (93967382, 'MadeleineHudson', 'madeleine.hudson@cardinalcartridge.it', '86345288', 'refael');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (83468426, 'RolandoBradford', 'rbradford@conquest.com', '48449640', 'shabak');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (48534835, 'EmbethWeir', 'embeth.w@activeservices.lk', '50181030', 'idf');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (79397292, 'KylieMazar', 'kylie.mazar@cocacola.jp', '12599983', 'mossad');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (30246422, 'DeanOszajca', 'dean.oszajca@unit.fr', '26232671', 'ministry of defence');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (91482850, 'JackIsaak', 'jacki@hewlettpackard.pl', '19562217', 'idf');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (92372173, 'LeaParish', 'lea.parish@networkdisplay.com', '79030223', 'ministry of defence');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (94571566, 'KieferHauer', 'khauer@diamondgroup.br', '29629072', 'refael');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (61158533, 'KurtwoodHutch', 'kurtwood.hutch@floorgraphics.it', '96363893', 'refael');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (13265686, 'JeanneLowe', 'jlowe@formatech.br', '81377461', 'shabak');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (40125782, 'GregOates', 'greg.oates@adeasolutions.cz', '10874372', 'shabak');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (44666856, 'NormWolf', 'norm.wolf@at.ca', '77529862', 'ministry of defence');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (61348541, 'DeniseSnider', 'd.snider@flavorx.de', '66936411', 'idf');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (13750941, 'AndreRoot', 'aroot@telwares.be', '79483199', 'shabak');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (81500448, 'RutgerTisdale', 'rutger.tisdale@gagwear.com', '26401013', 'ministry of defence');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (16971947, 'NataschaMelvin', 'natascham@printtech.uk', '99729481', 'idf');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (77025009, 'RikBrooks', 'rik.brooks@campbellsoup.no', '34652723', 'idf');
commit;
prompt 300 records committed...
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (96744987, 'MiguelEaston', 'miguel@accucode.ca', '73621333', 'ministry of defence');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (83860242, 'MilesBarnett', 'milesb@solutionbuilders.ch', '91219442', 'mossad');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (94690261, 'StevenBrosnan', 'steven.b@ccb.ca', '24369649', 'shabak');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (13226499, 'SineadBoyle', 'sinead.b@aop.com', '80870640', 'refael');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (86188800, 'ThomasPatillo', 'thomas.patillo@elmco.it', '20817076', 'shabak');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (98043427, 'ViennaEpps', 'vienna.epps@sps.br', '49717996', 'shabak');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (42229227, 'WilliamStuermer', 'william.s@ositissoftware.com', '94939310', 'mossad');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (26538156, 'MaryHimmelman', 'mary.himmelman@technica.au', '84689376', 'shabak');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (75706311, 'CarolAnderson', 'carol.anderson@bis.com', '54738918', 'idf');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (46018573, 'MaggieMollard', 'maggie.mollard@air.com', '89857070', 'mossad');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (62640804, 'MekhiBrando', 'mekhi.brando@smartdrawcom.jp', '91136382', 'shabak');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (82801846, 'JaneaneMulroney', 'janeane.m@mms.at', '73508603', 'refael');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (15274111, 'EricCumming', 'eric.cumming@ccfholding.com', '17261575', 'ministry of defence');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (25528830, 'AlMcGowan', 'al.mcgowan@conquestsystems.com', '57618428', 'ministry of defence');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (25459603, 'DermotBrolin', 'dermot@floorgraphics.dk', '99563476', 'idf');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (97347933, 'NilsMorales', 'nils.morales@execuscribe.com', '99111659', 'shabak');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (88095276, 'AdamLynch', 'adam@ezecastlesoftware.ca', '93441103', 'idf');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (83947281, 'PamKeith', 'pam.keith@fnb.ch', '71662395', 'shabak');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (73424780, 'JetCaine', 'j.caine@ris.com', '25580373', 'ministry of defence');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (63285435, 'RobbieLaMond', 'robbie.lamond@nissanmotor.com', '35921303', 'shabak');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (46666412, 'MintStills', 'mint.s@flavorx.hu', '44900108', 'ministry of defence');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (53942844, 'FairuzaMollard', 'fairuza.mollard@labradanutrition.com', '63738004', 'shabak');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (82766735, 'CevinKravitz', 'ckravitz@mai.it', '82575549', 'idf');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (85123323, 'ArmandMcKellen', 'armand@primussoftware.com', '18911298', 'shabak');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (86630665, 'NancyCockburn', 'nancy.cockburn@procter.in', '66491561', 'shabak');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (39095239, 'MichelleWalsh', 'michelle.walsh@thinktanksystems.com', '69182015', 'shabak');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (78312137, 'PatLange', 'pat.l@infinity.de', '40419377', 'idf');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (31655311, 'DemiHewitt', 'demi.hewitt@generalmills.ca', '68957689', 'ministry of defence');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (93085730, 'MarlonTolkan', 'marlon.tolkan@stm.com', '41769475', 'refael');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (79085143, 'RichardHamilton', 'richard.hamilton@fra.com', '81234340', 'refael');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (72744093, 'LindseyWood', 'lindsey.w@maverick.com', '34725630', 'ministry of defence');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (57655257, 'TeriMoreno', 'teri.moreno@techbooks.com', '85892194', 'refael');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (98931415, 'LiquidMcFerrin', 'lmcferrin@usenergyservices.com', '28109061', 'ministry of defence');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (73698621, 'RitchieCrowe', 'ritchie.crowe@tarragonrealty.ch', '41890652', 'idf');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (46198272, 'TreyMcLean', 't.mclean@priorityexpress.uk', '94281441', 'ministry of defence');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (25129884, 'ErnieLevine', 'ernie.levine@labradanutrition.ch', '17202339', 'refael');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (38435240, 'LupeSainte-Marie', 'lupe@comglobalsystems.com', '74196736', 'mossad');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (72733554, 'DebraPullman', 'debra.pullman@bedfordbancshares.com', '95793633', 'refael');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (56291394, 'LoreenaWhitman', 'loreena.w@thinktanksystems.ca', '23419782', 'mossad');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (92914190, 'ReneeJessee', 'renee.jessee@volkswagen.fr', '71590489', 'idf');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (48394653, 'CharlesLang', 'clang@sourcegear.it', '90257490', 'idf');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (17202750, 'QuentinDavidtz', 'qdavidtz@cocacola.com', '88187469', 'mossad');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (17911264, 'OdedCleese', 'oded.cleese@httprint.com', '10145552', 'mossad');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (41006933, 'CliffCallow', 'cliff.callow@tilia.ca', '95733378', 'ministry of defence');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (44942109, 'JaneaneFishburne', 'j.fishburne@smi.uk', '42717923', 'ministry of defence');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (44995150, 'WendyPitney', 'wendy.pitney@myricom.com', '53623800', 'refael');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (21031690, 'JarvisLevin', 'jarvis.levin@businessplus.com', '94514028', 'idf');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (36424108, 'MariaBrolin', 'maria.brolin@alternativetechnology.au', '85123871', 'shabak');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (10341076, 'MosHoward', 'mhoward@myricom.com', '75448599', 'mossad');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (35825128, 'DonIrons', 'don.irons@waltdisney.com', '23831952', 'idf');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (89070225, 'LauraOsmond', 'laura.o@north.au', '77811171', 'ministry of defence');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (53091633, 'RhysStone', 'rhyss@lindin.com', '85597107', 'refael');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (43223357, 'MillaGuinness', 'milla.guinness@smg.com', '32086367', 'shabak');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (64827973, 'BonnieSherman', 'bonnie@medsource.de', '43211193', 'ministry of defence');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (85017650, 'CollinAllison', 'collin.allison@tilia.com', '93417340', 'ministry of defence');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (95276846, 'HollandDef', 'holland.def@mattel.de', '14183878', 'shabak');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (11855385, 'AntonioEvett', 'antonioe@spotfireholdings.com', '80007875', 'ministry of defence');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (58958811, 'MiaSkarsgard', 'mia.skarsgard@sis.it', '41786342', 'idf');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (81570562, 'MenaGordon', 'mena@mre.it', '25582397', 'ministry of defence');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (99538792, 'AlecSmurfit', 'alec.smurfit@unicru.com', '94041961', 'refael');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (34060240, 'Jean-ClaudeTodd', 'jeanclaude.todd@montpelierplastics.com', '20406657', 'mossad');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (46307928, 'BenicioLevy', 'benicio.levy@tastefullysimple.ca', '83229175', 'mossad');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (93154110, 'DarQuatro', 'dar.quatro@digitalmotorworks.com', '35376735', 'ministry of defence');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (33269799, 'DanChoice', 'dan.choice@cooktek.es', '43900150', 'refael');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (85651969, 'Mary-LouiseBusey', 'marylouise@contract.com', '92656525', 'ministry of defence');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (83583782, 'GabrielO''Sullivan', 'gabriel.o@mse.com', '85270481', 'mossad');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (27866692, 'CarlCurfman', 'carl.curfman@magnet.fr', '32741822', 'idf');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (80962037, 'ToddWahlberg', 'todd@tastefullysimple.jp', '17128929', 'refael');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (96248818, 'BelindaSellers', 'belinda.sellers@linksys.com', '51972761', 'mossad');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (18081451, 'SandraNewman', 'sandra.newman@kmart.de', '69378118', 'mossad');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (65864223, 'MikoStewart', 'miko.stewart@tilsonhr.ca', '47408829', 'ministry of defence');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (61646766, 'OzzyWahlberg', 'ozzy.wahlberg@nexxtworks.mx', '91010642', 'ministry of defence');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (92654065, 'JaneaneLucas', 'janeane.lucas@processplus.com', '68909874', 'mossad');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (84847306, 'MerilleeGoldblum', 'mgoldblum@linksys.nl', '60446389', 'idf');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (60678395, 'JoshuaMurphy', 'jmurphy@chhc.com', '49825507', 'idf');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (25601183, 'NenehKeeslar', 'neneh.k@advancedneuromodulation.com', '96001791', 'refael');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (87034260, 'RachaelRankin', 'rachael.rankin@evinco.at', '14620723', 'idf');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (62318647, 'KieranTicotin', 'kieran@randomwalk.hu', '60580154', 'refael');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (20358405, 'DanniBarry', 'danni.barry@navigatorsystems.pl', '71631069', 'refael');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (47850199, 'BernardMcLean', 'bernard@outsourcegroup.br', '25695470', 'ministry of defence');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (79426451, 'LupeAnderson', 'lupe.anderson@pragmatechsoftware.es', '53207463', 'mossad');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (29933105, 'ManuHart', 'manu.hart@coldstonecreamery.de', '61659766', 'ministry of defence');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (52622636, 'RhysHewitt', 'rhys@owm.com', '66337364', 'shabak');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (19962356, 'HoraceRuiz', 'horace@maverick.fi', '65418637', 'idf');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (72765447, 'CampbellEckhart', 'c.eckhart@tastefullysimple.il', '49673984', 'mossad');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (11976961, 'FrancesKershaw', 'frances.kershaw@tigris.it', '45782349', 'mossad');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (38244334, 'NickelCharles', 'nickel.charles@horizonorganic.fr', '99134652', 'ministry of defence');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (38717490, 'DavisMcCabe', 'davis.mccabe@wlt.com', '51208067', 'shabak');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (38385402, 'BurtonBrooks', 'burton@surmodics.de', '60429112', 'shabak');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (81643293, 'BillFraser', 'b.fraser@scooterstore.uk', '90182953', 'refael');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (65942181, 'MekhiOsment', 'mekhi@trinityhomecare.za', '69507184', 'shabak');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (35708697, 'CeliaFaithfull', 'celia.faithfull@fmi.nl', '65127643', 'idf');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (70926343, 'SigourneyPaige', 'sigourney.paige@arkidata.com', '53721010', 'ministry of defence');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (72253049, 'CyndiMichael', 'cyndim@campbellsoup.com', '59700826', 'ministry of defence');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (47149421, 'HarrisArnold', 'harris@slt.dk', '94385423', 'idf');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (26913646, 'ChadScott', 'chads@nhr.com', '12790006', 'shabak');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (81181488, 'HiltonBlossoms', 'h.blossoms@waltdisney.com', '15776603', 'shabak');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (55186758, 'StewartIglesias', 'stewart@hewlettpackard.jp', '53140788', 'mossad');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (64301667, 'BradTolkan', 'bradt@ait.ch', '31694026', 'ministry of defence');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (98672850, 'JuanGarofalo', 'juang@americanland.com', '97951245', 'mossad');
commit;
prompt 400 records committed...
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (34428347, 'Anna Johnson', 'anna.j@example.com', '555-1234', 'Sales');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (55839283, 'Bob Williams', 'bob.w@example.com', '555-5678', 'Support');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (44782930, 'Carol Lee', 'carol.l@example.com', '555-8765', 'Marketing');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (98745612, 'David Brown', 'david.b@example.com', '555-4321', 'Finance');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (23456789, 'Eva Green', 'eva.g@example.com', '555-6789', 'Operations');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (65748392, 'Frank Harris', 'frank.h@example.com', '555-3456', 'IT');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (39485721, 'Grace Kim', 'grace.k@example.com', '555-9876', 'Customer Service');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (83947563, 'Henry Turner', 'henry.t@example.com', '555-2345', 'R&D');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (49283756, 'Ivy Nelson', 'ivy.n@example.com', '555-8764', 'Legal');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (38572049, 'Jack Cooper', 'jack.c@example.com', '555-5432', 'Administration');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (1, 'Gaultiero', 'gmineghelli0@drupal.org', '7106855900', 'Finance');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (2, 'Pacorro', 'piczokvitz1@gizmodo.com', '5522789112', 'Customer Service');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (3, 'Eb', 'emellish2@lycos.com', '3061066468', 'Marketing');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (4, 'Charline', 'cmityushin3@wiley.com', '8151813289', 'Customer Service');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (5, 'Harald', 'hklausen4@ucla.edu', '7525947373', 'Finance');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (6, 'Nadeen', 'nsonley5@nba.com', '4204193581', 'Sales');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (7, 'Carolyne', 'cmcginnell6@chicagotribune.com', '1619503848', 'Finance');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (8, 'Hewie', 'hgarrat7@stanford.edu', '9003046419', 'Finance');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (9, 'Gwynne', 'gwicken8@posterous.com', '3187437450', 'Finance');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (10, 'Wenonah', 'wjagger9@is.gd', '4244340600', 'Finance');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (11, 'Niven', 'ndumingoa@gmpg.org', '3914229767', 'Sales');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (12, 'Sarge', 'speskettb@cocolog-nifty.com', '9171810775', 'Customer Service');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (13, 'Fayth', 'fgarmansc@godaddy.com', '7076413318', 'Human Resources');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (14, 'Base', 'bsaggd@jugem.jp', '7007369027', 'Finance');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (15, 'Anselma', 'abranscombe@nasa.gov', '6881098911', 'Human Resources');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (16, 'Isabelita', 'iyanukf@cpanel.net', '2362480216', 'Human Resources');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (17, 'Minny', 'mmciloryg@ow.ly', '2071508084', 'Marketing');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (18, 'Kelci', 'krylandh@cisco.com', '7495999108', 'Customer Service');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (19, 'Ag', 'ajeansi@purevolume.com', '2692512066', 'Finance');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (20, 'Caty', 'cgraundissonj@chron.com', '3926636216', 'Human Resources');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (21, 'Evvie', 'etestrok@cbc.ca', '1272111352', 'Finance');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (22, 'Cary', 'cmccorleyl@nationalgeographic.com', '1682119890', 'Sales');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (23, 'Grazia', 'gbarhemm@ameblo.jp', '9742487334', 'Finance');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (24, 'Ilsa', 'imidnern@dailymotion.com', '7605231479', 'Human Resources');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (25, 'Lorilyn', 'lsavoryo@php.net', '5487334244', 'Marketing');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (26, 'Flem', 'fbalwinp@fc2.com', '6831783101', 'Marketing');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (27, 'Sharline', 'scausticq@squidoo.com', '2986045253', 'Human Resources');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (28, 'Magdalena', 'mmaddisonr@phoca.cz', '1691542089', 'Finance');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (29, 'Moishe', 'mlorenzinis@huffingtonpost.com', '2023134098', 'Finance');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (30, 'Francene', 'fdecarterett@tinyurl.com', '9954565397', 'Marketing');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (31, 'Di', 'dsuttyu@pinterest.com', '7782745241', 'Marketing');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (32, 'Ronica', 'rahrensv@google.cn', '4179633519', 'Customer Service');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (33, 'Virgie', 'vsellerw@java.com', '4045654202', 'Sales');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (34, 'Susanne', 'smaseresx@scribd.com', '5956185605', 'Finance');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (35, 'Leora', 'lhansardy@oracle.com', '3671024597', 'Customer Service');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (36, 'Darice', 'dverrallsz@unesco.org', '1839408394', 'Human Resources');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (37, 'Beverlee', 'bterron10@geocities.jp', '4926155041', 'Sales');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (38, 'Samaria', 'sproswell11@soup.io', '3895566379', 'Customer Service');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (39, 'Gifford', 'gtapply12@admin.ch', '2567010000', 'Finance');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (40, 'Gaspar', 'gloynes13@homestead.com', '3349989087', 'Human Resources');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (41, 'Elysha', 'eroadnight14@unblog.fr', '1677432902', 'Customer Service');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (42, 'Claudius', 'cbishop15@google.de', '9898552415', 'Marketing');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (43, 'Craggy', 'cjarmyn16@bigcartel.com', '1356167443', 'Marketing');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (44, 'Delinda', 'darons17@yolasite.com', '3073589660', 'Human Resources');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (45, 'Danny', 'dgaythorpe18@wix.com', '5653869319', 'Sales');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (46, 'Eli', 'ekaasmann19@homestead.com', '7178796990', 'Marketing');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (47, 'Adi', 'adaniell1a@clickbank.net', '8463791944', 'Human Resources');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (48, 'Harriette', 'hmcintee1b@istockphoto.com', '9697810691', 'Finance');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (49, 'Matelda', 'mtremolieres1c@wordpress.org', '5539515569', 'Marketing');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (50, 'Lucretia', 'ldungate1d@oaic.gov.au', '6483259964', 'Human Resources');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (51, 'Fidelity', 'fjeeves1e@ehow.com', '8379437966', 'Customer Service');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (52, 'Martita', 'mjessup1f@eventbrite.com', '8421765949', 'Human Resources');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (53, 'Carney', 'cyeldon1g@yandex.ru', '5961394274', 'Human Resources');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (54, 'Biddie', 'bneath1h@free.fr', '9364966187', 'Customer Service');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (55, 'Nathanael', 'nflacknell1i@cafepress.com', '5048768462', 'Human Resources');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (56, 'Kingsley', 'kweth1j@goodreads.com', '5208787077', 'Human Resources');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (57, 'Reece', 'rtohill1k@eventbrite.com', '5289017600', 'Customer Service');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (58, 'Debby', 'dscudamore1l@mtv.com', '1263046826', 'Sales');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (59, 'Christina', 'cjoutapavicius1m@tripadvisor.com', '6299303464', 'Sales');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (60, 'Dunstan', 'dbrownsett1n@google.co.jp', '3708976391', 'Sales');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (61, 'Ceciley', 'cgerrietz1o@mysql.com', '7001414256', 'Customer Service');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (62, 'Correna', 'ccocker1p@is.gd', '2801994745', 'Finance');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (63, 'Stu', 'sangeli1q@vimeo.com', '1627104442', 'Sales');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (64, 'Ilise', 'itribbeck1r@bravesites.com', '7042553084', 'Marketing');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (65, 'Yolande', 'ywade1s@state.gov', '4987074603', 'Marketing');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (66, 'Deina', 'deidelman1t@yale.edu', '6091833566', 'Finance');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (67, 'Verena', 'vsheard1u@accuweather.com', '4566896595', 'Finance');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (68, 'Cherice', 'cjanssens1v@dion.ne.jp', '8393511727', 'Customer Service');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (69, 'Rosalinde', 'rmccraw1w@amazon.co.jp', '8596013953', 'Sales');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (70, 'Kain', 'khacket1x@salon.com', '2176889599', 'Human Resources');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (71, 'Michel', 'mbasden1y@wikipedia.org', '3333930511', 'Finance');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (72, 'Monika', 'mguitton1z@digg.com', '5375242654', 'Finance');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (73, 'Brock', 'bphilpault20@cocolog-nifty.com', '6587585974', 'Marketing');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (74, 'Stafani', 'smulcock21@yandex.ru', '4103789638', 'Marketing');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (75, 'Stoddard', 'spotts22@virginia.edu', '3555116785', 'Customer Service');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (76, 'Starla', 'smorrill23@usnews.com', '3849590199', 'Finance');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (77, 'Melania', 'mdodshun24@biblegateway.com', '2347327327', 'Customer Service');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (78, 'Alaster', 'ajouaneton25@cbsnews.com', '1457882313', 'Marketing');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (79, 'Teodoro', 'tkeslake26@wufoo.com', '3195550723', 'Customer Service');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (80, 'Timotheus', 'ttulloch27@amazon.co.uk', '3504946648', 'Customer Service');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (81, 'Carey', 'cbruckshaw28@irs.gov', '9246617754', 'Sales');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (82, 'Laverna', 'lmimmack29@quantcast.com', '3746275249', 'Finance');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (83, 'Viviana', 'vbedboro2a@spiegel.de', '8666413949', 'Sales');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (84, 'Jackquelin', 'jbutchers2b@wix.com', '2898569294', 'Human Resources');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (85, 'Valina', 'vdowngate2c@ebay.co.uk', '2515445858', 'Marketing');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (86, 'Arie', 'amulrenan2d@un.org', '8964675073', 'Customer Service');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (87, 'Cariotta', 'cmallender2e@pcworld.com', '8084684157', 'Human Resources');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (88, 'Virginie', 'vsmallpeace2f@imdb.com', '6433103137', 'Finance');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (89, 'Rosabelle', 'rprinett2g@nasa.gov', '7197243500', 'Marketing');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (90, 'Nap', 'nparminter2h@spiegel.de', '3425886574', 'Finance');
commit;
prompt 500 records committed...
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (91, 'Gray', 'gfewkes2i@nih.gov', '2022880344', 'Human Resources');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (92, 'Jerrome', 'jhumfrey2j@gizmodo.com', '9384497838', 'Human Resources');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (93, 'Jeremie', 'jdoyle2k@vistaprint.com', '6311694577', 'Finance');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (94, 'Binky', 'bgulliford2l@tuttocitta.it', '5153429661', 'Human Resources');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (95, 'Vail', 'vchatel2m@lulu.com', '9281455247', 'Marketing');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (96, 'Chandler', 'cgreader2n@amazonaws.com', '7727059667', 'Customer Service');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (97, 'Fremont', 'fscotchforth2o@mysql.com', '1674587757', 'Human Resources');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (98, 'Nikaniki', 'ngateshill2p@paypal.com', '5698937448', 'Finance');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (99, 'Matt', 'mtebald2q@ovh.net', '3927573064', 'Sales');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (100, 'Wylma', 'wdrewet2r@omniture.com', '4313903287', 'Marketing');
commit;
prompt 510 records loaded
prompt Loading CUSTOMERS...
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (45756835, 'United Kingdom', '41883857', 'victoria.neeson@abatix.uk', '52 Bobbi Road', 'mossad', 23022486);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (34223998, 'Germany', '15546265', 'forest@kelmooreinvestment.de', '263 Affleck Street', 'idf', 17202750);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (59288647, 'Italy', '52692974', 'terrence.chao@atlanticnet.it', '642 Mika Road', 'ministry of defence', 17690127);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (96511163, 'Japan', '24348454', 'emilio.mulroney@qls.jp', '346 Erlangen Blvd', 'shabak', 48394653);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (48894891, 'USA', '57708318', 'jessica@smg.com', '26 Douglas Drive', 'idf', 48343603);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (93430366, 'USA', '54824672', 'forest.hopkins@scripnet.com', '78 Bradenton Road', 'refael', 13265686);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (15440490, 'Germany', '99580677', 'fionnula.weiland@insurmark.de', '99 Hanks Road', 'shabak', 13289169);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (29109732, 'USA', '59368441', 'victor.wilkinson@atg.com', '4 Sandler Road', 'ministry of defence', 98442581);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (99605950, 'United Kingdom', '49832725', 'jann.makeba@novartis.uk', '276 Lynch Road', 'refael', 67182998);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (18766984, 'USA', '28591844', 'howier@marsinc.com', '98 Worrell Street', 'idf', 12560849);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (27611169, 'USA', '55753098', 'mirandah@activeservices.com', '14 Phoenix Street', 'mossad', 20664618);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (60533897, 'USA', '86735204', 'jody.mollard@mastercardinternational.com', '78 Milsap Drive', 'ministry of defence', 64301667);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (67571819, 'Germany', '28068721', 'earl.maclachlan@ogiointernational.de', '18 Cuba Blvd', 'shabak', 33365865);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (40182593, 'USA', '62500962', 'clay.madsen@cyberthink.com', '1 Moraz Ave', 'refael', 20537979);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (39208685, 'Canada', '43387901', 'nikki.dealmeida@servicelink.ca', '98 Calgary Drive', 'idf', 46198272);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (20516305, 'USA', '46621457', 'frank.plimpton@pinnaclestaffing.com', '386 Yankovic Road', 'idf', 34060240);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (13661684, 'Switzerland', '49103391', 'tia@tlsservicebureau.ch', '66 Stafford Drive', 'idf', 26951130);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (89335717, 'Haiti', '77714657', 'g.loring@coridiantechnologies.ht', '32nd Street', 'refael', 11593556);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (82732528, 'USA', '45129580', 'j.kimball@tmt.com', '65 Lindo Drive', 'refael', 95797610);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (49891570, 'United Kingdom', '48302487', 'o.azaria@hewlettpackard.uk', '2 Oakenfold Blvd', 'mossad', 96833634);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (23388359, 'USA', '93163797', 'l.makowicz@pulaskifinancial.com', '917 Rich Road', 'mossad', 64827973);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (84798436, 'Germany', '77022950', 'lucinda@computersource.de', '21st Street', 'mossad', 59704787);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (35948729, 'USA', '49650909', 'marie@avr.com', '99 Newman Drive', 'ministry of defence', 44970893);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (18176375, 'Spain', '55557953', 'flonsdale@democracydata.es', '26 Stewart Road', 'idf', 57655257);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (94224302, 'USA', '37992590', 'ashton.kahn@prp.com', '57 Winwood Street', 'refael', 87215493);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (64825226, 'France', '20879074', 'stripplehorn@profitline.fr', '24 Christine Street', 'idf', 56332092);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (24659641, 'Canada', '19550336', 'nick.parsons@privatebancorp.ca', '650 Polito Street', 'ministry of defence', 68943193);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (68635839, 'USA', '64780487', 'sarah.s@acsis.com', '2 Dale Drive', 'mossad', 49385556);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (23764681, 'Denmark', '38104202', 'remys@pharmafab.dk', '59 Saxon', 'idf', 50583748);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (97385354, 'New Zealand', '20363338', 'patrick@blueoceansoftware.nz', '67 Berenger Street', 'refael', 57079314);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (77401018, 'United Kingdom', '72400124', 'kevn.james@accuship.uk', '7 Caine', 'shabak', 42506479);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (18228257, 'Italy', '14996873', 'kim.rodgers@randomwalk.it', '415 Mandy Drive', 'ministry of defence', 86630665);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (57518681, 'Norway', '15486336', 'cheech.getty@medamicus.no', '67 Diehl Street', 'idf', 53081260);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (76614195, 'Germany', '90774003', 'famke.lerner@tarragonrealty.de', '47 Callow Road', 'shabak', 56291394);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (76562622, 'USA', '52524645', 'jean.s@capellaeducation.com', '76 Ossie Drive', 'ministry of defence', 62958717);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (67681216, 'Switzerland', '89371058', 'lorraine.rickman@meritagetechnologies.ch', '60 Shawn', 'shabak', 57384919);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (85554185, 'USA', '76260825', 'ed.melvin@enterprise.com', '80 Robards Ave', 'ministry of defence', 35825128);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (19239287, 'Netherlands', '26476847', 'mekhi.snipes@prometheuslaboratories.nl', '45 Maidenhead Road', 'refael', 27095403);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (73276753, 'Iceland', '33332780', 'timr@bat.is', '76 Fionnula Street', 'shabak', 19095344);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (67967662, 'Hungary', '45413013', 'emily.m@newviewgifts.hu', '93rd Street', 'ministry of defence', 26751198);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (72812608, 'Brazil', '14505309', 'danny.logue@bioreference.br', '93 Madison Street', 'refael', 11976961);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (46121501, 'USA', '11029515', 'mickey.g@cocacola.com', '86 Nikki Street', 'shabak', 27891387);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (85923657, 'United Kingdom', '91812539', 'tyrone.waite@solipsys.uk', '68 Postlethwaite Drive', 'refael', 19962356);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (11386390, 'Netherlands', '35193763', 'carole.holiday@homedepot.nl', '45 Carole Road', 'mossad', 67511575);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (99278701, 'Indonesia', '96923855', 'kirsten@dancor.id', '38 Tlalpan Road', 'refael', 55534854);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (58307063, 'USA', '22628976', 'rlevy@wendysinternational.com', '44 Vai Road', 'ministry of defence', 82766735);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (17009998, 'Israel', '39652981', 'hughl@processplus.il', '45 Worrell Street', 'mossad', 67182998);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (64347421, 'USA', '18386232', 'fred.tilly@fra.com', '25 McDormand Road', 'shabak', 84233322);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (87142600, 'USA', '98107438', 'l.mccain@bedfordbancshares.com', '84 Cleese Drive', 'mossad', 59449184);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (41933583, 'Japan', '88948011', 'selma@carteretmortgage.jp', '2 Hermitage Street', 'mossad', 91245220);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (12834085, 'South Korea', '69834565', 'carolyn@pis.com', '8 Mito Street', 'ministry of defence', 31627888);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (96607176, 'USA', '31353217', 'darius.ricci@travizon.com', '806 Dillon Road', 'ministry of defence', 22578416);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (12197075, 'USA', '98778634', 'kasey.aniston@onstaff.com', '32nd Street', 'refael', 16941013);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (50095158, 'Belgium', '18751489', 'carlos.hart@bps.be', '8 Braugher Ave', 'idf', 47149421);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (52789268, 'United Kingdom', '40512295', 'dermot.loeb@viacell.uk', '23 Caguas Street', 'shabak', 35511914);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (73741015, 'Germany', '68864674', 'earl.sartain@healthscribe.de', '33 Wayans Street', 'idf', 59141156);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (83896964, 'Germany', '28496369', 'tia.kapanka@qestrel.de', '39 Toni Drive', 'shabak', 84847306);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (74158462, 'USA', '19308909', 'illeana.greenwood@printtech.com', '92 Daejeon Street', 'idf', 27273162);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (96703276, 'USA', '13490628', 'delbert.caine@sfmai.com', '51st Street', 'ministry of defence', 48394653);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (73195846, 'Denmark', '52429027', 'lionel.rooker@mls.dk', '26 Polito Drive', 'idf', 19962356);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (84322428, 'Canada', '60897974', 'sarahk@pulaskifinancial.ca', '86 Geggy Street', 'refael', 93967382);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (10909808, 'Germany', '87027504', 'julio.c@hiltonhotels.de', '98 Oak Park Drive', 'ministry of defence', 19095344);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (65260797, 'Australia', '54582683', 'russell.jones@scheringplough.au', '75 Neuquen Drive', 'mossad', 47647666);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (27753546, 'USA', '16574869', 'lorraine.whitaker@elite.com', '41 Hyderabad Street', 'idf', 16493046);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (47554498, 'Canada', '16772856', 'goldie.sevigny@spd.ca', '82 Caguas Road', 'mossad', 47615557);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (31674879, 'Belgium', '71911874', 'sal@capitolbancorp.be', '54 Bugnon', 'mossad', 53091633);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (17115038, 'Brazil', '97438976', 'm.mccain@technica.br', '41 Eric Street', 'ministry of defence', 84289834);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (77241474, 'USA', '57490263', 'famke.hart@pioneermortgage.com', '76 Domingo Road', 'mossad', 42229227);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (86160304, 'Germany', '31277814', 'selma.sweet@learningvoyage.de', '6 Shepherd', 'shabak', 86630665);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (86377675, 'USA', '96700196', 'courtney.voight@questarcapital.com', '429 Chely Street', 'shabak', 73124932);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (49963553, 'USA', '14616592', 'roscoe.lennix@cynergydata.com', '27 Iglesias Street', 'ministry of defence', 91941817);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (80277347, 'Israel', '83666970', 'jackie.irons@mindworks.il', '73rd Street', 'refael', 69600577);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (86330317, 'USA', '95693689', 'tobey.joli@balchem.com', '2 Emmett Drive', 'refael', 20936963);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (57460985, 'Canada', '54367916', 'kenneth.franks@hiltonhotels.ca', '36 Stoltz Drive', 'shabak', 50752399);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (65329400, 'Japan', '16156730', 'pablo.snider@atlanticnet.jp', '24 Thame Street', 'idf', 53091633);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (95677272, 'USA', '14646728', 'l.malkovich@usgovernment.com', '57 Leslie', 'mossad', 21000949);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (34880263, 'Germany', '82654089', 'andrea.dafoe@sandyspringbancorp.de', '11 Short Road', 'ministry of defence', 88095276);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (91778343, 'United Kingdom', '13229096', 'l.brolin@advancedneuromodulation.uk', '37 Towson', 'idf', 94690261);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (99685326, 'Switzerland', '37556068', 'c.blige@ptg.ch', '52 Biella Street', 'refael', 21691339);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (94453033, 'USA', '94038318', 'tea.orton@carteretmortgage.com', '13 Lipnicki Street', 'ministry of defence', 98043427);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (78901938, 'USA', '35594208', 'ozzy@whitewave.com', '23 Prinze Road', 'refael', 54594862);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (69009658, 'Brazil', '20793937', 'jude.savage@avs.br', '3 Botti Road', 'refael', 94757310);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (39604366, 'USA', '31668712', 'sean.m@microsoft.com', '75 Kingsley Street', 'idf', 65864223);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (96837631, 'USA', '63980255', 'taryn.s@quicksilverresources.com', '20 Conway Street', 'ministry of defence', 41915928);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (47129256, 'USA', '81364093', 'davy.masur@cocacola.com', '49 Marie Road', 'idf', 35355829);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (25271570, 'China', '52449840', 'angela.birch@vitacostcom.cn', '979 Griffin Street', 'mossad', 44942109);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (89798029, 'USA', '67188237', 'kiefer.giraldo@studiobproductions.com', '441 Weller Drive', 'ministry of defence', 45171084);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (91996325, 'USA', '28846007', 'scarlett.n@sandyspringbancorp.com', '18 Lea Street', 'shabak', 13226499);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (43771065, 'Italy', '80802382', 'rowan.f@gsat.it', '53 Highton Road', 'idf', 64301667);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (61251646, 'Israel', '64632517', 'rferry@clubone.il', '21 Buffalo Grove Drive', 'mossad', 33365865);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (75852122, 'USA', '56044261', 'natacha.b@progressivemedical.com', '18 Carradine Road', 'refael', 26913646);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (67803385, 'Denmark', '12843281', 'cheryl@ultimus.dk', '2 Vaughn', 'idf', 18081451);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (49095860, 'Germany', '30814807', 'martha.neil@apexsystems.de', '821 Horizon Road', 'ministry of defence', 58281867);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (27286133, 'USA', '70420211', 'roberta.lucien@gra.com', '42nd Street', 'ministry of defence', 11897171);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (96795373, 'France', '60808807', 'kirk.coe@entelligence.fr', '950 Gibson', 'ministry of defence', 77991076);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (32363155, 'Germany', '54178344', 'forest.r@safeway.de', '52nd Street', 'refael', 99913540);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (54563648, 'USA', '36523597', 'esutherland@fmt.com', '60 Roth Street', 'refael', 46198272);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (10510143, 'USA', '86292846', 'cesar.benson@entelligence.com', '13rd Street', 'shabak', 93085730);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (71718606, 'USA', '72190864', 'rod@glmt.com', '41 Marburg Street', 'shabak', 48394653);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (12569124, 'USA', '12817229', 'm.zevon@floorgraphics.com', '350 Tisdale Road', 'mossad', 40751966);
commit;
prompt 100 records committed...
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (91021750, 'USA', '64634453', 'frances.lapointe@ait.com', '41 Badalucco Road', 'mossad', 27866692);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (11250240, 'United Kingdom', '76436543', 'gino.tobolowsky@sm.uk', '21st Street', 'ministry of defence', 81027755);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (40038212, 'USA', '83885767', 'delbert.phoenix@invisioncom.com', '777 Biella Street', 'ministry of defence', 89405048);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (91960911, 'France', '93202551', 'loretta.stone@ivci.fr', '34 Craddock Street', 'idf', 42004482);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (73975830, 'Iceland', '24136540', 'llaurie@credopetroleum.is', '613 Plummer Ave', 'mossad', 31733028);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (10894359, 'Canada', '87187725', 'kelli.rickles@investmentscorecard.ca', '50 Campinas', 'mossad', 42287134);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (78606227, 'USA', '69317894', 'c.mifune@horizon.com', '10 Brown Street', 'mossad', 24162881);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (69354807, 'USA', '30620232', 'owen.muellerstahl@bioreference.com', '226 Hauer Drive', 'shabak', 65864223);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (54762501, 'China', '97844015', 'claude@venoco.cn', '1 Palmieri Road', 'idf', 76663286);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (23792090, 'Japan', '53226702', 'sonny.nash@shirtfactory.jp', '685 Chirignago Street', 'mossad', 39095239);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (94432158, 'USA', '80426318', 'n.hobson@diversitech.com', '76 McBride Street', 'refael', 67182998);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (90962552, 'Brazil', '79099007', 'lindsay.brock@jollyenterprises.br', '24 McBride Ave', 'shabak', 65106978);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (19369145, 'USA', '53047616', 'tracy@servicelink.com', '53 Wahlberg Drive', 'refael', 67182998);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (20271232, 'South Africa', '24612417', 'm.dillane@sbc.za', '723 Hubbard Drive', 'mossad', 73698621);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (88771505, 'USA', '70034862', 'mika.paymer@cascadebancorp.com', '73 Art Road', 'idf', 55186758);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (57735974, 'South Africa', '32781345', 'jill@alohanysystems.za', '27 Geoffrey Road', 'idf', 75096207);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (82181844, 'USA', '74830897', 'tzi.s@mqsoftware.com', '13rd Street', 'idf', 50084826);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (48004855, 'United Kingdom', '54883967', 'a.difranco@nha.uk', '50 Princeton', 'refael', 48743769);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (24308577, 'USA', '45819012', 'cadams@kingland.com', '43 Lupe Street', 'idf', 94757310);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (42458539, 'United Kingdom', '59416085', 'boyd.payne@magnet.uk', '68 Kane Ave', 'ministry of defence', 98672850);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (66586949, 'USA', '67092903', 'brothers.stowe@pearllawgroup.com', '27 Moorer Street', 'ministry of defence', 94834146);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (35270389, 'Austria', '62150934', 'k.stevenson@asa.at', '56 Peterborough Street', 'refael', 88095276);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (71206475, 'Brazil', '32156348', 'gin.avalon@allstar.br', '239 Black Blvd', 'shabak', 44388764);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (26250050, 'Finland', '14949287', 'ronny@prosperitybancshares.fi', '844 Young Street', 'shabak', 80135037);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (22431263, 'Germany', '68458797', 'kbranch@gltg.de', '401 Bretzfeld-Waldbach Street', 'mossad', 27891387);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (29321329, 'Australia', '51368359', 'campbell.chestnut@peerlessmanufacturing.au', '13 McConaughey Drive', 'ministry of defence', 12293095);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (78035994, 'Pakistan', '80386010', 'jodie.hauer@totalentertainment.pk', '51 Loring Street', 'shabak', 79397292);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (61180240, 'Italy', '80026842', 'raymond.savage@smartdrawcom.it', '169 Dunst Street', 'mossad', 66590336);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (13376107, 'Canada', '54060087', 'nastassja@dearbornbancorp.ca', '53 Gavin', 'mossad', 48743769);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (42819356, 'Germany', '43986403', 'willem.h@sourcegear.de', '97 Brooks Street', 'mossad', 70926343);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (26655402, 'USA', '11437329', 'grace.mitchell@conquestsystems.com', '98 Juice', 'idf', 93907876);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (19745492, 'Japan', '51129004', 'jimn@questarcapital.jp', '101 McDormand Street', 'mossad', 74086583);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (50354801, 'United Kingdom', '58340670', 'spayton@connected.uk', '51 Sherman Drive', 'refael', 65345057);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (56908720, 'Greece', '28834487', 'sdomino@telecheminternational.gr', '888 Goran Street', 'mossad', 33494717);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (26465702, 'USA', '33315097', 'gvanshelton@noodles.com', '43 Shannon Street', 'refael', 19941178);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (83407796, 'Belgium', '56246934', 'wayne.lemmon@usenergyservices.be', '52 Brooke Street', 'mossad', 69052929);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (94809507, 'USA', '18125756', 'cliff.thewlis@pacificdatadesigns.com', '35 Sizemore Drive', 'idf', 20358405);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (33337208, 'Canada', '94831811', 'debra.heslov@gdatechnologies.ca', '11 Maury Blvd', 'idf', 98155811);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (81191202, 'USA', '29440869', 'carolyn@faef.com', '4 Lindley Blvd', 'mossad', 19941178);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (27778669, 'USA', '63509815', 'rvicious@tastefullysimple.com', '78 Nicholson Street', 'ministry of defence', 30749980);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (79177370, 'USA', '80206898', 'gavin.michaels@telecheminternational.com', '50 Kattan Drive', 'refael', 83468426);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (48270369, 'USA', '48346610', 'w.leachman@manhattanassociates.com', '95 Debbie Street', 'mossad', 71812980);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (88079734, 'USA', '46183517', 'brooke.murphy@grs.com', '57 Steagall Blvd', 'ministry of defence', 73833190);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (72074362, 'USA', '61128317', 'albertina.neil@refinery.com', '5 Fats Street', 'refael', 34977905);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (95357416, 'Brazil', '31652506', 'first.craig@vivendiuniversal.br', '17 Hiroshima Street', 'idf', 98571854);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (66947950, 'USA', '58846980', 'delbert.d@healthscribe.com', '93 Jordan', 'shabak', 52090085);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (79123923, 'Norway', '16281898', 'akristofferson@ivorysystems.no', '72nd Street', 'refael', 44369962);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (93841124, 'South Africa', '16394176', 'joe.c@glaxosmithkline.za', '3 Carlyle Ave', 'mossad', 76663286);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (28938449, 'USA', '95707712', 'christmas.shaw@msdw.com', '11 Lecanto Street', 'shabak', 91941817);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (15383022, 'United Kingdom', '33740940', 't.griffiths@digitalmotorworks.uk', '51 Griggs Drive', 'ministry of defence', 92372173);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (94619363, 'Austria', '31948535', 'clintk@smi.at', '69 Lari Street', 'shabak', 93619695);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (75348785, 'USA', '99354401', 'javon.mills@tropicaloasis.com', '52 Talvin Drive', 'refael', 71913410);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (78004881, 'France', '73538529', 'chubby@qas.fr', '56 Fairbanks Street', 'shabak', 26538156);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (51103426, 'Brazil', '34398048', 'shawkins@base.br', '35 Nelligan Road', 'shabak', 33365865);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (40839706, 'USA', '41188748', 'goran.lewin@sms.com', '20 Wainwright Drive', 'shabak', 46115979);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (34569689, 'Germany', '77607387', 'johnette.williamson@americanvanguard.de', '967 Selma Road', 'idf', 98726344);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (63191099, 'Netherlands', '63098879', 'brauhofer@mission.nl', '117 Knutsford Street', 'shabak', 82801846);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (49703969, 'Germany', '10390150', 'lcarnes@americanhealthways.de', '74 Lili Road', 'shabak', 74593174);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (10293566, 'Malaysia', '47236262', 'n.brosnan@gateway.my', '67 Burrows Drive', 'shabak', 74593174);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (24574132, 'USA', '45472523', 'jody.farris@angieslist.com', '100 Kline Street', 'mossad', 51162768);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (30047947, 'Cameroun', '74796328', 'dick.sirtis@mission.com', '21 Garza Road', 'mossad', 84233322);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (76603440, 'USA', '79504053', 'hallen@fflcbancorp.com', '87 Trieste Drive', 'refael', 90589554);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (50109125, 'Germany', '84440054', 'geena@marlabs.de', '95 Bonham Drive', 'ministry of defence', 32155969);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (73029532, 'USA', '64780106', 'guy.j@owm.com', '68 Neeson', 'ministry of defence', 25528830);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (72748895, 'Belgium', '97306096', 'kwopat@integratelecom.be', '29 Reinhold Blvd', 'refael', 73124932);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (63207641, 'USA', '64919430', 'vickie.imbruglia@cardtronics.com', '100 MacNeil Ave', 'refael', 67980173);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (13675493, 'Germany', '41604907', 'tenglish@pinnaclestaffing.de', '769 Christine Blvd', 'ministry of defence', 37830269);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (73609023, 'Cameroun', '49672902', 'vienna.price@aristotle.com', '424 Cherry Road', 'refael', 73405396);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (75706743, 'Netherlands', '93622200', 'allison.bachman@wendysinternational.nl', '42 Milsap Drive', 'refael', 53199981);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (79223054, 'Belgium', '98265038', 'chris.caviezel@alternativetechnology.be', '95 Bergara Blvd', 'shabak', 19095344);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (58322197, 'Japan', '99875586', 'shannyn.gold@unilever.jp', '736 Breckin Street', 'mossad', 85123323);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (57730914, 'USA', '70431114', 'denzel.dibiasio@hersheyfoods.com', '738 HÃ¤ssleholm Road', 'shabak', 98726344);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (10222203, 'Germany', '68066085', 'vondie.eastwood@kelmooreinvestment.de', '23rd Street', 'ministry of defence', 76622103);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (43645466, 'Japan', '95136015', 'madelineg@generalelectric.jp', '1 Payne Drive', 'refael', 85517448);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (66802431, 'Austria', '28997820', 'd.underwood@accesssystems.at', '85 Corey Ave', 'idf', 20358405);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (89289435, 'Brazil', '42416320', 'blair.liu@isd.br', '32nd Street', 'shabak', 17202750);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (78139447, 'Sweden', '17524632', 'r.turturro@hfn.se', '56 Sam', 'ministry of defence', 86630665);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (97932782, 'USA', '33894180', 'c.armstrong@ogiointernational.com', '48 Foster Road', 'ministry of defence', 82801846);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (57436382, 'Netherlands', '12512189', 'kazem.s@saralee.nl', '768 Jean Street', 'ministry of defence', 14652467);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (73085333, 'Germany', '43598675', 'joan.c@saralee.de', '126 Trini', 'refael', 44666856);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (21014885, 'Czech republic', '66553201', 'terence.stanton@kramontrealty.cz', '98 Neill Road', 'mossad', 58240196);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (98149767, 'USA', '73138064', 'cnortham@wellsfinancial.com', '11 Roberta Road', 'mossad', 23223019);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (50140697, 'USA', '49613762', 'marina.houston@arkidata.com', '89 Ruiz Road', 'ministry of defence', 61952238);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (55234278, 'Germany', '53106788', 'nicky.banderas@woronocobancorp.de', '605 Williamstown Road', 'idf', 62895098);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (85948925, 'France', '86360013', 'dylan.mcginley@pacificdatadesigns.fr', '52 Gilberto Street', 'idf', 94834146);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (91831066, 'Sweden', '17536608', 'meryl.mason@mavericktechnologies.se', '42 Ranger Road', 'idf', 19906683);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (24030481, 'Italy', '90733659', 'adina.wilkinson@horizonorganic.it', '16 Northam Street', 'refael', 15306935);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (13596747, 'USA', '84968970', 'stewart.osment@kwraf.com', '22nd Street', 'refael', 45171084);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (94691263, 'Canada', '36152461', 'loren.plimpton@hudsonriverbancorp.ca', '35 Tilst Drive', 'refael', 79085143);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (66163595, 'Australia', '36883649', 'awatson@techrx.au', '536 Tyrone Road', 'idf', 89070225);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (33387429, 'USA', '93123499', 'nickel.peniston@extremepizza.com', '23rd Street', 'mossad', 57384919);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (90147871, 'Brazil', '81253210', 'saul@epamsystems.br', '31st Street', 'refael', 77108638);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (45578032, 'Denmark', '61989612', 'richard.wiedlin@appriss.dk', '20 Aimee Blvd', 'mossad', 15306935);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (47222423, 'Canada', '15676325', 'j.joli@telecheminternational.ca', '39 Furtado Street', 'mossad', 35825128);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (89085003, 'USA', '73367358', 'frankie@newtoninteractive.com', '58 Wells Drive', 'idf', 31655311);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (97066259, 'Italy', '21709553', 'bblackwell@carboceramics.it', '88 Coslada Road', 'idf', 55720634);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (38831861, 'Poland', '18738021', 'mel@vfs.pl', '65 Ferraz  vasconcelos Street', 'shabak', 95276846);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (52971711, 'Brazil', '72216420', 'miki.d@formatech.br', '95 Peine Drive', 'refael', 57107054);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (66406975, 'USA', '51502613', 'loretta.kennedy@vspan.com', '54 Midler Street', 'idf', 46666412);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (88623229, 'Austria', '37439611', 'cornell@kingston.at', '823 Bullock Street', 'idf', 75090580);
commit;
prompt 200 records committed...
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (97106558, 'Germany', '78330794', 'geoffrey.f@pis.de', '39 Oro Street', 'idf', 81500448);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (46565539, 'Belgium', '27928218', 'cathy.v@visionarysystems.be', '80 Cesar Street', 'mossad', 12473697);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (51169382, 'Canada', '49619244', 'derek.fisher@base.ca', '18 Chan Street', 'refael', 23022486);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (35557001, 'Canada', '41958293', 'millie@esteelauder.ca', '15 Augst Road', 'mossad', 25528830);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (61648409, 'Brazil', '96885107', 'vcamp@sms.br', '808 Yucca Drive', 'idf', 33494717);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (56069320, 'Israel', '30460365', 'f.simpson@tropicaloasis.il', '36 Lawrence Street', 'refael', 71933637);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (42768514, 'Canada', '19763492', 'penelope.clooney@globalwireless.ca', '62 Shizuoka', 'ministry of defence', 86759135);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (87836917, 'Israel', '45192748', 'michael.cummings@quakercitybancorp.il', '62 Carrere Street', 'ministry of defence', 53942844);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (87401392, 'Germany', '32678182', 'lenny@capstone.de', '90 Holts Summit Drive', 'mossad', 79397292);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (20147733, 'China', '18126219', 'b.schiff@hardwoodwholesalers.cn', '59 South Weber Blvd', 'ministry of defence', 33494717);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (99026347, 'Netherlands', '46062881', 'alex@sandyspringbancorp.nl', '59 Garfunkel Ave', 'idf', 64558450);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (90755223, 'Germany', '65122516', 'miles.potter@atlanticnet.de', '21 Garcia Road', 'refael', 20664618);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (30088287, 'Kazakstan', '83843240', 'gene.dean@dbprofessionals.com', '557 Carrere Ave', 'refael', 91941817);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (60257878, 'USA', '13496660', 'marylouise@atlanticnet.com', '465 Dalmine Street', 'idf', 59141156);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (45046039, 'France', '59180481', 'carl.madsen@biosite.fr', '24 Fraser Street', 'refael', 22578416);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (58740743, 'USA', '67978347', 'josh.tarantino@mse.com', '69 LÃ¼beck Drive', 'refael', 94571566);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (85366873, 'United Kingdom', '99681165', 'c.gellar@scheringplough.uk', '411 Tah Drive', 'shabak', 74593174);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (83705341, 'USA', '46940301', 'jonny.manning@vivendiuniversal.com', '7 Sainte-Marie Road', 'mossad', 69850015);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (28451383, 'United Kingdom', '74323936', 'c.dillon@target.uk', '56 Hanover Drive', 'idf', 93245618);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (95730733, 'Paraguay', '76846145', 'ceili.s@sysconmedia.py', '73 Eliza Drive', 'ministry of defence', 98442581);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (93319530, 'Canada', '96723626', 'dabneyg@americanmegacom.ca', '267 Carrie Road', 'shabak', 59449184);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (82838120, 'USA', '74581349', 'laurence@alternativetechnology.com', '34 Noah Street', 'mossad', 60678395);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (25945415, 'Macau', '35510042', 'pam.leoni@sprint.mo', '55 Olympia Road', 'refael', 95797610);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (70133352, 'Australia', '11927414', 'courtney.c@wyeth.au', '24 Saint Paul Street', 'mossad', 55534854);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (99420157, 'Germany', '61853132', 'melanie.i@nha.de', '25 Stamp Drive', 'ministry of defence', 55167864);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (43866817, 'Finland', '29873479', 'ashton.santarosa@prometheuslaboratories.fi', '689 Wine Road', 'mossad', 59141156);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (46570933, 'USA', '38032234', 'lauren.lucien@ams.com', '11 Manning Road', 'ministry of defence', 32205270);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (19112192, 'Germany', '36386409', 'emmylou.smurfit@meritagetechnologies.de', '102 Dean Street', 'shabak', 46307928);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (92655517, 'USA', '90866567', 'harriet.redgrave@refinery.com', '61st Street', 'shabak', 83583782);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (40050758, 'USA', '10344301', 'ray.lamond@prosum.com', '27 Krumholtz Road', 'ministry of defence', 19962356);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (54666303, 'Italy', '35722793', 'stewart@speakeasy.it', '71 Sinatra Road', 'mossad', 91482850);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (75312264, 'USA', '81627947', 'shannon@keith.com', '23 Costello', 'shabak', 60678395);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (93588437, 'USA', '20514068', 'harold@genextechnologies.com', '90 Spacek Road', 'ministry of defence', 11359073);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (61074545, 'USA', '74302146', 'miliv@fns.com', '37 Harper Blvd', 'mossad', 30246422);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (98422837, 'Australia', '71210972', 'ruth.urban@sds.au', '761 Mito Drive', 'shabak', 59704787);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (97482787, 'USA', '37828653', 'joely.leary@gateway.com', '30 Bad Oeynhausen Street', 'idf', 25059771);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (12358352, 'USA', '55792017', 'matt.dayne@entelligence.com', '135 Soul Street', 'ministry of defence', 12473697);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (50540966, 'Germany', '43163302', 'claire.pigottsmith@clorox.de', '50 Marx Blvd', 'refael', 65437831);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (38283166, 'USA', '90493280', 'rrandal@refinery.com', '44 Aaron Road', 'mossad', 30749980);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (77036495, 'Japan', '32704754', 'dabney.weston@spectrum.jp', '179 Sissy Road', 'refael', 47850199);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (68406461, 'USA', '97977843', 'karon.c@yes.com', '66 Mahoney Ave', 'ministry of defence', 26751198);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (66402088, 'USA', '80170062', 'mike@gcd.com', '60 Dianne Road', 'refael', 74086583);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (33410647, 'Russia', '29717553', 'wsledge@officedepot.com', '22 Dupree', 'refael', 16793442);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (87858363, 'USA', '90789949', 'alex.vanhelden@actechnologies.com', '82nd Street', 'shabak', 59449184);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (70094374, 'Germany', '42533527', 'emily.difranco@pfizer.de', '80 Suzy Road', 'idf', 95359116);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (24434420, 'France', '18574473', 'ricky.kleinenberg@flavorx.fr', '55 Kristin Road', 'mossad', 13226499);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (22152428, 'Hong Kong', '82193077', 'megs@isd.hk', '86 Bedford Street', 'mossad', 96051151);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (49655393, 'United Kingdom', '30860053', 'colleen.vai@portageenvironmental.uk', '41 Horsens Street', 'refael', 17686373);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (24768061, 'Japan', '45857735', 'judge.checker@gateway.jp', '49 Black Road', 'refael', 16493046);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (71382022, 'South Korea', '55644170', 'sylvester.jackson@bestbuy.com', '51st Street', 'shabak', 49385556);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (62691476, 'Malaysia', '76827259', 'gilberto@gbas.my', '44 Jimmie Street', 'idf', 83468426);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (27104007, 'Germany', '11306766', 'vincent.patillo@callhenry.de', '92nd Street', 'idf', 46198272);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (89633192, 'Canada', '84925867', 'jimmy.mac@efcbancorp.ca', '91 Rourke', 'refael', 94372304);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (80345156, 'Finland', '15140106', 'mgoldblum@linksys.fi', '52 Americana Road', 'ministry of defence', 50583748);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (53805635, 'United Kingdom', '57845596', 'denis@sis.uk', '95 Biggs Ave', 'mossad', 81570562);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (54804747, 'United Kingdom', '44149068', 'rhona.brando@campbellsoup.uk', '76 Cary Drive', 'mossad', 48394653);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (71520279, 'USA', '15884456', 'elvis.campbell@acsis.com', '127 Southampton Street', 'ministry of defence', 20936963);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (54054025, 'Russia', '65247418', 'r.donofrio@keith.com', '40 Ruffalo Blvd', 'idf', 11593556);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (44993322, 'Japan', '45919372', 'kathleen.g@mathis.jp', '41 Irati Drive', 'mossad', 42229227);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (71044320, 'United Kingdom', '38561454', 'mowen@team.uk', '85 Will Road', 'refael', 87215493);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (93329004, 'Netherlands', '45323367', 'meredith.utada@qssgroup.nl', '59 Luzern Road', 'ministry of defence', 24483143);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (54535594, 'Portugal', '14480885', 'mcarmen@surmodics.pt', '13 Morse Blvd', 'shabak', 44388764);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (58196781, 'USA', '33312793', 'bobbib@dillards.com', '90 Reynolds Ave', 'shabak', 49385556);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (58511392, 'USA', '95804097', 'mcarrack@mosaic.com', '20 Chao Road', 'shabak', 16793442);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (60556468, 'USA', '80179782', 'paul.brock@bestbuy.com', '98 Blaine Drive', 'shabak', 92372173);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (65957004, 'USA', '94539054', 'a.marie@powerlight.com', '81 Baranski Street', 'mossad', 13750941);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (55066619, 'United Kingdom', '66708588', 'dionne.holm@data.uk', '78 Vienna Ave', 'refael', 89070225);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (41524549, 'USA', '46298431', 'elle.weaving@proclarity.com', '92 Ray Ave', 'ministry of defence', 88095276);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (97052515, 'Italy', '69118855', 'shannon@bedfordbancshares.it', '756 Cypress Drive', 'shabak', 17686373);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (46684695, 'USA', '75682750', 'tal.d@abs.com', '17 Ismaning Road', 'idf', 16971947);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (80257977, 'USA', '71755052', 'morgan.crosby@greene.com', '32 Union Drive', 'shabak', 85017650);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (76734097, 'USA', '67491175', 'burton.p@elite.com', '50 Leguizamo Road', 'idf', 16493046);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (17024629, 'USA', '40022494', 'deborah.bean@ogiointernational.com', '14 Julianne Road', 'refael', 88095276);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (60147305, 'Italy', '11330634', 'peter@johnson.it', '48 Diamond Street', 'shabak', 64827973);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (65486123, 'Australia', '48656140', 'gates@prosperitybancshares.au', '90 Lin Street', 'ministry of defence', 60678395);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (84924184, 'USA', '63524229', 'darrenw@tlsservicebureau.com', '19 Berlin Street', 'shabak', 47149421);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (85026044, 'France', '23783827', 'lesley.whitford@fds.fr', '19 Thin Road', 'refael', 39374108);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (60290940, 'USA', '84683931', 'karon@granitesystems.com', '11 Armand Street', 'shabak', 68164722);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (21479883, 'Germany', '60872047', 'diamond.tate@morganresearch.de', '895 Hanley Blvd', 'mossad', 98672850);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (15252713, 'Italy', '46951296', 'toshiro.w@gapinc.it', '796 Oates Blvd', 'shabak', 19095344);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (96586622, 'USA', '75107011', 'g.carrington@lms.com', '78 Melba Ave', 'shabak', 94690261);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (94652622, 'USA', '61977918', 'tony.winter@ogiointernational.com', '68 Alice Street', 'shabak', 16941013);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (70721780, 'Germany', '37570873', 'mnorton@wrgservices.de', '90 Richardson Street', 'refael', 61454003);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (16292512, 'Japan', '17820115', 'temuera.stills@drinkmorewater.jp', '97 Cross Drive', 'idf', 46115979);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (11519494, 'USA', '68229724', 's.tankard@kellogg.com', '51 Mili Street', 'idf', 17686373);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (38685099, 'Poland', '65627931', 'humberto@unica.pl', '206 Springfield Street', 'shabak', 23674184);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (60406218, 'Netherlands', '38320404', 'adina@trinityhomecare.nl', '70 Lindley Road', 'mossad', 76622103);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (51458759, 'United Kingdom', '15404823', 'maceo.bryson@portageenvironmental.uk', '449 Vern Road', 'idf', 11912356);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (55036429, 'USA', '90108937', 'lin.leachman@lms.com', '11 Sean Street', 'refael', 35511914);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (10011040, 'Australia', '82804960', 'kelli.cube@allstar.au', '37 Dale Drive', 'ministry of defence', 13289169);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (48432072, 'Germany', '85567731', 'jody.meyer@hfn.de', '72nd Street', 'idf', 49385556);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (22848358, 'Mexico', '67792381', 'aida.tucci@target.mx', '54 Cobbs Road', 'idf', 48061480);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (36254297, 'Japan', '53192457', 'saffron.ingram@captechventures.jp', '835 Taye Road', 'shabak', 20983251);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (91233616, 'Sweden', '68462023', 'benm@pharmafab.se', '17 Merchant Drive', 'ministry of defence', 81119660);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (95916928, 'Netherlands', '50749987', 'sophiea@navigatorsystems.nl', '61st Street', 'idf', 98931415);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (49541412, 'Germany', '47023167', 'ty.mcanally@inzone.de', '29 Redwood Shores Road', 'shabak', 77991076);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (54656646, 'United Kingdom', '79122312', 'elizabeth.day@maverick.uk', '46 Salt Lake City Street', 'refael', 62318647);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (54302716, 'USA', '96713734', 'dan.favreau@lms.com', '8 Moorer Street', 'refael', 48061480);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (64236525, 'Switzerland', '62841525', 'alfred.ryan@gillani.ch', '10 Coverdale Road', 'refael', 94757310);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (95588116, 'Canada', '21100724', 'millar@capitalautomotive.ca', '52 Holbrook Road', 'ministry of defence', 27891387);
commit;
prompt 300 records committed...
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (73929631, 'Greece', '20889578', 'beth@ufs.gr', '75 Gray Road', 'ministry of defence', 91941817);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (78818005, 'Germany', '96078729', 'wayman@lemproducts.de', '53 Rosas', 'idf', 22578416);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (42403279, 'United Kingdom', '30096739', 't.dealmeida@americanhealthways.uk', '51 Santiago Ave', 'shabak', 44970893);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (38045869, 'Netherlands', '44848156', 'stewarth@abatix.nl', '76 Duke Street', 'ministry of defence', 31911846);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (32258996, 'USA', '23551814', 'g.elizondo@avr.com', '26 Leelee Street', 'idf', 84847306);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (73016023, 'Brazil', '15405933', 'mira@smartdrawcom.br', '42nd Street', 'shabak', 48394653);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (69351765, 'Spain', '57049203', 'tony@virbac.es', '50 Payton', 'refael', 17690127);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (19052428, 'USA', '75765391', 'christina.bogguss@telecheminternational.com', '606 Miyazaki Road', 'ministry of defence', 15274111);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (28942154, 'USA', '36024876', 'tommy.abraham@vfs.com', '8 Rockwell Street', 'idf', 94757310);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (56325911, 'United Kingdom', '25664692', 'nyoung@novartis.uk', '43rd Street', 'refael', 98726344);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (69955862, 'USA', '96624352', 'rowan.nicks@investorstitle.com', '49 Sampson Road', 'mossad', 52337857);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (22793386, 'Mexico', '18655269', 'kurt.allen@astute.mx', '100 West Point Ave', 'ministry of defence', 80962037);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (53097853, 'USA', '41714097', 'garry.whitman@execuscribe.com', '37 Jessica', 'idf', 13265686);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (71430184, 'USA', '71733875', 'ricky.swinton@trekequipment.com', '59 Allison Drive', 'refael', 11855385);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (84514288, 'Germany', '98899889', 'dionne.m@advertisingventures.de', '489 Cox Drive', 'mossad', 12293095);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (98048623, 'Germany', '77826939', 'tim.arnold@enterprise.de', '35 LeVar Road', 'refael', 41364390);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (13456767, 'USA', '69121032', 'liv@bioreference.com', '64 English Road', 'mossad', 26283456);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (30537276, 'India', '80715633', 'm.hughes@lloydgroup.in', '71st Street', 'idf', 20936963);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (78035150, 'Spain', '21517575', 'lupe.c@oss.es', '8 Westerberg Street', 'ministry of defence', 61454003);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (86143960, 'USA', '61507592', 't.clarkson@stiknowledge.com', '66 White Drive', 'idf', 76023266);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (59252850, 'Brazil', '83356011', 'graham.c@sfmai.br', '98 Ermey Street', 'idf', 27892270);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (50455678, 'Germany', '67304526', 'david@fordmotor.de', '45 Macht', 'refael', 53081260);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (79653532, 'Netherlands', '38089666', 'nikkif@greene.nl', '76 Angelina Street', 'shabak', 11897171);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (87260394, 'New Caledonia', '97266670', 'hugoa@advertisingventures.nc', '16 Thelma Road', 'refael', 11897171);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (95826413, 'USA', '83196420', 'tony.conroy@sfmai.com', '61 Bonn Road', 'shabak', 72253049);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (66648742, 'USA', '41724469', 'chuckl@grt.com', '48 Biehn Street', 'ministry of defence', 79426451);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (67376236, 'Switzerland', '53033606', 'adam@serentec.ch', '22nd Street', 'idf', 66590336);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (29698601, 'Denmark', '94665063', 'steven.niven@commworks.dk', '93 Carlton Street', 'idf', 93680962);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (39817959, 'Italy', '67101019', 'jeff.prowse@speakeasy.it', '47 Springfield Road', 'refael', 53771409);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (79372519, 'USA', '10754558', 'jennifer.cruz@typhoon.com', '66 Darius Street', 'refael', 93967382);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (19789464, 'Germany', '62140147', 'cbenet@comglobalsystems.de', '989 Redford', 'idf', 85017650);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (85742567, 'Brazil', '43638844', 'christmas.m@mwp.br', '58 Thurman Street', 'mossad', 88939000);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (12007619, 'USA', '42603280', 'barry@kellogg.com', '12 Fort Collins Drive', 'ministry of defence', 40751966);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (38628579, 'USA', '50026062', 'keith.lewis@kroger.com', '20 Rtp Road', 'shabak', 65106978);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (76405380, 'Germany', '34143748', 'rosco.b@asapstaffing.de', '31st Street', 'idf', 24483143);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (78781959, 'USA', '86297810', 'rachael.lewis@abs.com', '43rd Street', 'refael', 55267731);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (26885794, 'Portugal', '20323545', 'kcruz@ecopy.pt', '33 Shaye', 'idf', 56171610);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (54289748, 'USA', '43554073', 'lynn@jcpenney.com', '39 Berkeley Road', 'idf', 30988658);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (27450835, 'United Kingdom', '14600763', 'jimr@kimberlyclark.uk', '75 Leslie Drive', 'idf', 34060240);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (92210982, 'Japan', '38347140', 'hikaru.smurfit@bioreference.jp', '26 Haslam Street', 'shabak', 98726344);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (45455137, 'South Africa', '77430365', 'r.hannah@glmt.za', '6 Purefoy Street', 'refael', 93154110);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (23001271, 'Croatia', '83934106', 'debi.williams@sfb.com', '83 Hawn', 'shabak', 64827973);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (14591687, 'France', '76091265', 'nicholas.weaving@mre.fr', '45 Tucker Road', 'ministry of defence', 47149421);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (95061519, 'USA', '78482537', 'caroline.avital@granitesystems.com', '7 Carl Blvd', 'shabak', 26629738);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (84111141, 'USA', '89346190', 'jessen@capitolbancorp.com', '38 Laura Street', 'idf', 73020463);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (37174955, 'USA', '30466200', 'elisabeth.smith@spenser.com', '53 Lari Road', 'shabak', 65345057);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (99946989, 'USA', '66361838', 'mperry@jlphor.com', '21 Lennox Road', 'shabak', 56332092);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (45629416, 'USA', '40043793', 'jimmy.marin@telesynthesis.com', '500 Bielefeld Drive', 'shabak', 73833190);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (46170628, 'Germany', '50037966', 'laurence.peterson@onstaff.de', '31 Hilton Street', 'refael', 81570562);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (38339252, 'Finland', '35697467', 'isaiah.c@asa.fi', '42 Posener Road', 'shabak', 73405396);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (67787013, 'Brazil', '57733432', 'fayel@nbs.br', '84 Cocker Street', 'mossad', 11255649);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (88520361, 'USA', '36216736', 'ryan.turturro@pepsico.com', '447 Chalee Blvd', 'ministry of defence', 95276846);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (46767112, 'USA', '15315083', 'giovanni.okeefe@blueoceansoftware.com', '16 Braugher Street', 'refael', 41364390);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (89777368, 'Japan', '34942247', 'bo.l@navigatorsystems.jp', '19 Sapulpa Drive', 'refael', 92575580);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (49104747, 'Canada', '72734525', 'lenny@seiaarons.ca', '972 Brothers Drive', 'refael', 40125782);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (31935182, 'Netherlands', '87874189', 'geoff.deltoro@lfg.nl', '68 Michaels Street', 'mossad', 46198272);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (90035696, 'Finland', '39476107', 'fowen@gillani.fi', '7 Daniel Road', 'ministry of defence', 36922278);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (26318843, 'USA', '45059056', 'owen.voight@trusecure.com', '386 Judi Street', 'mossad', 16442662);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (97902204, 'USA', '36223453', 'a.matarazzo@topicsentertainment.com', '62 Saudarkrokur', 'refael', 20664618);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (25554128, 'New Zealand', '97891413', 'chalee@nestle.nz', '72nd Street', 'refael', 46198272);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (18905876, 'Brazil', '17749928', 'elvis.mccormack@acsis.br', '88 Stowe Ave', 'refael', 81549307);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (80634418, 'USA', '69031320', 'maryk@ait.com', '91st Street', 'mossad', 93245618);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (68571163, 'USA', '86656206', 'emma.g@lydiantrust.com', '34 Fiorentino Blvd', 'shabak', 13702788);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (81071740, 'USA', '66477047', 'fred.tisdale@newtoninteractive.com', '50 Ronnie Drive', 'mossad', 73405396);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (73825771, 'USA', '85640975', 'jane.i@nike.com', '86 Guadalajara Drive', 'mossad', 19941178);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (97921756, 'Japan', '77759437', 'chris.fonda@grt.jp', '75 Ratzenberger Road', 'idf', 19906683);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (88610801, 'Germany', '52494008', 'celia.evett@americanpan.de', '407 Farrell Street', 'mossad', 71812980);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (24833687, 'Israel', '77500370', 'judge.ojeda@ams.il', '43rd Street', 'refael', 30988658);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (76522038, 'Portugal', '78304123', 'rich.berkoff@fds.pt', '91 Geraldine', 'refael', 77108638);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (79481773, 'Switzerland', '92519649', 'wayman.n@gillani.ch', '86 Weisz', 'mossad', 44767093);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (37475053, 'Chile', '98934970', 'martha.k@gha.cl', '17 Morse Road', 'mossad', 50482581);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (61312845, 'USA', '72794764', 's.thornton@jma.com', '84 Osmond Road', 'ministry of defence', 84847306);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (99272709, 'Brazil', '27314003', 'bill.drive@unit.br', '908 Santana do parnaÃ­ba Street', 'shabak', 31655311);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (31768349, 'United Kingdom', '68827961', 'benjamin.hynde@capitolbancorp.uk', '72 Alexandria Street', 'shabak', 77108638);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (33020826, 'Israel', '28352035', 'e.holly@proclarity.il', '676 Telford Road', 'idf', 75090580);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (44018658, 'Switzerland', '69846749', 'awolf@qas.ch', '95 Michael Road', 'mossad', 86759135);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (12884915, 'Liechtenstein', '87968603', 'christine.pitney@bioanalytical.li', '51st Street', 'mossad', 22378117);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (90691080, 'USA', '71392685', 'olympia@trainersoft.com', '23rd Street', 'shabak', 96293674);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (34560332, 'USA', '57384451', 'helen.briscoe@unica.com', '87 Harry Street', 'shabak', 46307928);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (54569464, 'Canada', '66571675', 'heath.perrineau@team.ca', '61 Banderas Street', 'refael', 33494717);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (48944513, 'USA', '73888441', 'avisnjic@usgovernment.com', '26 Leonardo Blvd', 'shabak', 53771409);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (79191153, 'USA', '41916206', 'ashleyp@alogent.com', '577 Hyde Street', 'shabak', 92780851);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (17698770, 'USA', '98242561', 'harrison@campbellsoup.com', '93 Gatlin Road', 'shabak', 17911264);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (23001628, 'USA', '30292243', 'millie@marriottinternational.com', '61 Horsham Ave', 'shabak', 13265686);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (61834965, 'USA', '32278405', 'nancy@tripwire.com', '549 Yokohama Drive', 'mossad', 50084826);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (31733408, 'USA', '14633632', 'shannyn.breslin@team.com', '52 Hamburg', 'idf', 57079314);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (87042220, 'Greece', '90133907', 'emily@canterburypark.gr', '6 Saint Paul', 'refael', 92923830);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (18828530, 'New Zealand', '47660401', 'candice@accessus.nz', '57 Delbert Street', 'mossad', 53771409);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (10615587, 'Japan', '42552194', 'lupe.morton@servicesource.jp', '51 Melba Road', 'refael', 19200760);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (89443524, 'Germany', '37922539', 'sheryl.almond@navigatorsystems.de', '2 Brando Drive', 'idf', 64301667);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (57464776, 'Germany', '53409746', 'nigel.tierney@nuinfosystems.de', '40 Holland Road', 'refael', 75706311);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (48558953, 'Sweden', '31365258', 'norab@socketinternet.se', '64 Essen Road', 'mossad', 47615557);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (97393992, 'USA', '56836000', 'bonnie.c@trafficmanagement.com', '60 Dolenz Street', 'idf', 50084826);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (88666616, 'Japan', '89530463', 'judi.mcpherson@directdata.jp', '10 Kristofferson Road', 'refael', 31911846);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (83979292, 'Brazil', '83823084', 'solomon.mcclinton@ccb.br', '37 Dabney Blvd', 'ministry of defence', 16793442);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (88196004, 'Malaysia', '67167916', 'm.koyana@fra.my', '38 Huston Drive', 'ministry of defence', 44767093);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (96293589, 'Germany', '19306958', 'gerald.judd@pioneermortgage.de', '2 Nashua Street', 'mossad', 44388764);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (58482759, 'USA', '84186089', 'hmorales@iss.com', '10 BÃ¸nes Road', 'shabak', 72765447);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (38015390, 'South Korea', '37226569', 'heath.dutton@sandyspringbancorp.com', '87 Rachael Ave', 'ministry of defence', 87215493);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (90734472, 'South Korea', '79339935', 'kim.avital@heartlab.com', '82 Apple Road', 'refael', 63285435);
commit;
prompt 400 records committed...
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (12134353, 'England', '056767968', 'aad@gmail.com', '32 Farrow Street', 'Ministry of Defence', 34428347);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (23894729, 'USA', '1234567890', 'john.doe@example.com', '123 Main St', 'Tech Solutions', 55839283);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (87432904, 'Canada', '0987654321', 'jane.smith@domain.com', '456 Elm St', 'Health Services', 44782930);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (56290837, 'Australia', '1122334455', 'bruce.wayne@batmail.com', '789 Pine St', 'Finance Corp', 98745612);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (34789012, 'Germany', '9988776655', 'hans.gruber@villains.com', '321 Oak St', 'Industrial Inc', 23456789);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (90875634, 'France', '5566778899', 'michel.dubois@exemple.fr', '654 Maple St', 'Energy Systems', 65748392);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (67983245, 'Japan', '4433221100', 'sakura.tanaka@jpmail.com', '987 Cedar St', 'Automotive', 39485721);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (45329087, 'India', '6677889900', 'rahul.sharma@india.co', '159 Spruce St', 'IT Solutions', 83947563);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (12983475, 'Brazil', '7788996655', 'marcelo.santos@brmail.com', '753 Palm St', 'Telecom Services', 49283756);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (76348219, 'Italy', '3344556677', 'giovanni.rossi@itmail.it', '852 Olive St', 'Construction', 38572049);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (1, 'France', '8726690092', 'fbollam0@hp.com', 'Vernon', 'Defense', 1);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (2, 'Japan', '2392368227', 'bpicknett1@soundcloud.com', 'Kitakami', 'Exploration', 2);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (3, 'China', '6418846452', 'zstoller2@dmoz.org', 'Magang', 'Commercial', 3);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (4, 'Philippines', '2715459897', 'bkemsley3@lulu.com', 'Anopog', 'Defense', 4);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (5, 'United States', '5207781121', 'afarrears4@discovery.com', 'Tucson', 'Research', 5);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (6, 'China', '8096711589', 'agosalvez5@google.com', 'Huanfeng', 'Exploration', 6);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (7, 'Indonesia', '4148261634', 'ktaplin6@goo.ne.jp', 'Bongsri', 'Exploration', 7);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (8, 'Poland', '6487555136', 'gjoist7@house.gov', 'OÅ‚piny', 'Defense', 8);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (9, 'China', '6191652675', 'aiverson8@paypal.com', 'Baisha', 'Aerospace', 9);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (10, 'Greece', '6185293547', 'mfolland9@webnode.com', 'KallithÃ©a', 'Aerospace', 10);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (11, 'China', '3561250991', 'cgrescha@mayoclinic.com', 'Daliu', 'Exploration', 11);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (12, 'Cameroon', '9505171116', 'loruaneb@smh.com.au', 'YaoundÃ©', 'Commercial', 12);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (13, 'Cyprus', '4976182557', 'gmumbyc@nyu.edu', 'Paphos', 'Research', 13);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (14, 'Russia', '5637549180', 'gcottled@yahoo.co.jp', 'Popova', 'Commercial', 14);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (15, 'Uganda', '4169264657', 'senderleine@prnewswire.com', 'Namasuba', 'Research', 15);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (16, 'China', '4099906580', 'ldewf@xrea.com', 'Longyuanba', 'Defense', 16);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (17, 'Mauritius', '5629500712', 'bchilversg@yahoo.com', 'Centre de Flacq', 'Defense', 17);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (18, 'China', '8049983596', 'kraith@about.com', 'Shangjing', 'Exploration', 18);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (19, 'Indonesia', '7249851707', 'apadsoni@csmonitor.com', 'Rancaerang', 'Defense', 19);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (20, 'Brazil', '1832532374', 'mmcillroyj@shutterfly.com', 'Pacaembu', 'Aerospace', 20);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (21, 'Indonesia', '1078473017', 'lpeirazzik@ucsd.edu', 'Karangnunggal', 'Exploration', 21);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (22, 'Ukraine', '1163596569', 'jdoryl@gov.uk', 'Shpola', 'Commercial', 22);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (23, 'Burkina Faso', '6423372066', 'bshawem@sfgate.com', 'Gaoua', 'Exploration', 23);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (24, 'Palestinian Territory', '7005940411', 'krousn@unblog.fr', 'Jabaâ€˜', 'Commercial', 24);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (25, 'Brazil', '4844143366', 'gmenhcio@ehow.com', 'Boa Vista', 'Defense', 25);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (26, 'United States', '5855906200', 'givanaevp@shop-pro.jp', 'Rochester', 'Defense', 26);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (27, 'China', '1975971307', 'severettq@wikimedia.org', 'Leyuan', 'Aerospace', 27);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (28, 'China', '8868414816', 'kakessr@joomla.org', 'Fengcheng', 'Exploration', 28);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (29, 'Philippines', '7665381450', 'sciottois@discovery.com', 'Calaba', 'Exploration', 29);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (30, 'Brazil', '9288839191', 'ghamiltont@auda.org.au', 'Presidente Dutra', 'Commercial', 30);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (31, 'Poland', '3165939410', 'bmalletrattu@spiegel.de', 'Potok ZÅ‚oty', 'Commercial', 31);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (32, 'China', '5865560493', 'jwooddissev@wiley.com', 'Zhulan', 'Defense', 32);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (33, 'Indonesia', '6404037933', 'adevitaw@simplemachines.org', 'Baing', 'Defense', 33);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (34, 'Guatemala', '7276641555', 'psainterx@is.gd', 'San Pedro Ayampuc', 'Aerospace', 34);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (35, 'Ukraine', '8559558596', 'isauray@weebly.com', 'Bryukhovychi', 'Research', 35);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (36, 'Finland', '2992600420', 'jwigglesworthz@epa.gov', 'Vihti', 'Aerospace', 36);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (37, 'Philippines', '2134077456', 'evandrill10@google.co.jp', 'Dapitan', 'Research', 37);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (38, 'Sweden', '1669418632', 'espraggon11@gizmodo.com', 'LinkÃ¶ping', 'Research', 38);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (39, 'Albania', '9607495505', 'kgallyon12@sbwire.com', 'Remas', 'Defense', 39);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (40, 'China', '1213871652', 'kcapozzi13@wikimedia.org', 'Xiaochuan', 'Defense', 40);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (41, 'Nigeria', '6301905423', 'kjeanenet14@smugmug.com', 'Madara', 'Aerospace', 41);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (42, 'Sweden', '6755112027', 'spadden15@yellowpages.com', 'Stockholm', 'Exploration', 42);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (43, 'China', '1803252067', 'wmadgewick16@engadget.com', 'Xinâ€™an', 'Exploration', 43);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (44, 'China', '4871979415', 'stolliday17@hexun.com', 'Tufang', 'Exploration', 44);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (45, 'Russia', '2149438170', 'jkarpov18@a8.net', 'Prokhladnyy', 'Exploration', 45);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (46, 'South Africa', '2562747890', 'sfidal19@weather.com', 'Ceres', 'Exploration', 46);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (47, 'Sweden', '1497246103', 'rjime1a@unesco.org', 'MjÃ¶lby', 'Aerospace', 47);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (48, 'Indonesia', '3373309473', 'gjankovsky1b@google.nl', 'Krajan', 'Aerospace', 48);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (49, 'Burundi', '4081577780', 'narpin1c@1und1.de', 'Muyinga', 'Defense', 49);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (50, 'Poland', '8601531328', 'nsowten1d@cmu.edu', 'BeÅ‚k', 'Research', 50);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (51, 'China', '5208208770', 'nbennie1e@admin.ch', 'Xinhe', 'Research', 51);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (52, 'Russia', '3007817350', 'hadrianello1f@ucoz.com', 'Ryazhsk', 'Aerospace', 52);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (53, 'Indonesia', '7589679565', 'oobal1g@shinystat.com', 'Biito', 'Research', 53);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (54, 'Malawi', '6225650047', 'mbemment1h@boston.com', 'Blantyre', 'Commercial', 54);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (55, 'Cuba', '2965520129', 'ddaskiewicz1i@statcounter.com', 'Boyeros', 'Research', 55);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (56, 'Thailand', '1501202890', 'alavell1j@youku.com', 'Watthana Nakhon', 'Research', 56);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (57, 'China', '2251597531', 'iwhebell1k@mayoclinic.com', 'Xingyuan', 'Defense', 57);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (58, 'South Korea', '6959727873', 'olangthorne1l@exblog.jp', 'Kyosai', 'Defense', 58);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (59, 'Costa Rica', '6185576631', 'fchoak1m@ask.com', 'La AsunciÃ³n', 'Defense', 59);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (60, 'France', '8326842295', 'qcutler1n@csmonitor.com', 'Bar-le-Duc', 'Aerospace', 60);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (61, 'Sweden', '7005337644', 'vpruce1o@sphinn.com', 'Leksand', 'Commercial', 61);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (62, 'Japan', '3814793307', 'gpezey1p@discovery.com', 'Sapporo', 'Commercial', 62);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (63, 'Poland', '5694798586', 'ldragoe1q@nymag.com', 'Knyszyn', 'Aerospace', 63);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (64, 'Greece', '2892921936', 'dtemperley1r@psu.edu', 'NÃ©a PalÃ¡tia', 'Exploration', 64);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (65, 'Indonesia', '1527491918', 'atakis1s@studiopress.com', 'Kolbano', 'Exploration', 65);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (66, 'Indonesia', '1569649960', 'cshuttlewood1t@hatena.ne.jp', 'Kalipare', 'Defense', 66);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (67, 'Brazil', '6957072606', 'odoxsey1u@gmpg.org', 'IbiÃºna', 'Exploration', 67);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (68, 'France', '4948947326', 'pbrizland1v@usa.gov', 'PÃ©rigny', 'Defense', 68);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (69, 'Macedonia', '8345684212', 'wbravington1w@bbc.co.uk', 'Ð Ð°Ð´Ð¾Ð²Ð¸Ñˆ', 'Aerospace', 69);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (70, 'Morocco', '7486126846', 'cblemen1x@hatena.ne.jp', 'Tanalt', 'Defense', 70);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (71, 'Indonesia', '7391608498', 'amorby1y@spotify.com', 'Banjar Sengguan', 'Defense', 71);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (72, 'China', '5091766411', 'lbeelby1z@apache.org', 'Haolaishan', 'Commercial', 72);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (73, 'Malta', '8064964513', 'efeehely20@mapquest.com', 'Taâ€™ Xbiex', 'Defense', 73);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (74, 'Indonesia', '2559357073', 'mcope21@marriott.com', 'Krajan Pundungsari', 'Exploration', 74);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (75, 'China', '3452242096', 'hbugg22@networkadvertising.org', 'Liangshui', 'Research', 75);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (76, 'Indonesia', '5956795448', 'lbareford23@apple.com', 'Pomahan', 'Aerospace', 76);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (77, 'Indonesia', '2429148155', 'ikeddy24@businessweek.com', 'Butungan', 'Commercial', 77);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (78, 'Greece', '1211535833', 'imatterface25@google.com.au', 'NÃ©a FlogitÃ¡', 'Defense', 78);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (79, 'Thailand', '7032628576', 'fkealey26@ebay.co.uk', 'Non Sung', 'Defense', 79);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (80, 'Indonesia', '2632307460', 'ksteinor27@cmu.edu', 'Rejoyoso', 'Aerospace', 80);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (81, 'Greece', '5131319609', 'fhaberfield28@livejournal.com', 'KrousÃ³n', 'Research', 81);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (82, 'Costa Rica', '9334725789', 'skeay29@purevolume.com', 'Curridabat', 'Commercial', 82);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (83, 'China', '4212531872', 'rsweynson2a@artisteer.com', 'Gangmian', 'Research', 83);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (84, 'Mauritania', '8772955793', 'rszymon2b@geocities.com', 'ZouÃ©rat', 'Aerospace', 84);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (85, 'Sweden', '4963597184', 'bschimank2c@nyu.edu', 'OxelÃ¶sund', 'Research', 85);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (86, 'Indonesia', '6449447899', 'sbohlsen2d@uiuc.edu', 'Gununganyar', 'Commercial', 86);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (87, 'Burkina Faso', '6823021165', 'jpreece2e@earthlink.net', 'Fada N''gourma', 'Research', 87);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (88, 'Colombia', '9771224013', 'wfarrance2f@hatena.ne.jp', 'MÃ¡laga', 'Commercial', 88);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (89, 'Vietnam', '6429511279', 'mtownley2g@blogspot.com', 'LÃ o Cai', 'Exploration', 89);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (90, 'Philippines', '9661607141', 'anickerson2h@themeforest.net', 'Navatat', 'Aerospace', 90);
commit;
prompt 500 records committed...
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (91, 'China', '8275511171', 'rklima2i@oracle.com', 'Yuxi', 'Defense', 91);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (92, 'Luxembourg', '2198150650', 'dgarfield2j@elegantthemes.com', 'Strassen', 'Exploration', 92);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (93, 'China', '6019587618', 'swilloughley2k@cdbaby.com', 'Niandui', 'Commercial', 93);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (94, 'Kazakhstan', '3999442148', 'jstandbridge2l@shop-pro.jp', 'Sayaq', 'Exploration', 94);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (95, 'Ireland', '1028813174', 'vbriffett2m@weebly.com', 'Greenhills', 'Aerospace', 95);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (96, 'United States', '6011460307', 'tgiorgi2n@yellowpages.com', 'Jackson', 'Commercial', 96);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (97, 'Malaysia', '6658964584', 'mknevit2o@cnet.com', 'Alor Setar', 'Commercial', 97);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (98, 'China', '5962812106', 'padamec2p@fda.gov', 'Yeshan', 'Aerospace', 98);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (99, 'Armenia', '6366183964', 'estanistrete2q@friendfeed.com', 'Gogaran', 'Research', 99);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (100, 'Poland', '9664309123', 'bmetzke2r@yellowbook.com', 'Koszarawa', 'Research', 100);
commit;
prompt 510 records loaded
prompt Loading AIR_ORDER...
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (61102235, to_date('28-09-2022', 'dd-mm-yyyy'), to_date('26-02-2024', 'dd-mm-yyyy'), 'Completed', 7117823.7, 85366873);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (41999580, to_date('30-06-2022', 'dd-mm-yyyy'), to_date('20-03-2024', 'dd-mm-yyyy'), 'Pending', 4902549, 13456767);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (67319922, to_date('13-02-2022', 'dd-mm-yyyy'), to_date('21-07-2023', 'dd-mm-yyyy'), 'Pending', 1780821, 87142600);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (34346186, to_date('02-09-2022', 'dd-mm-yyyy'), to_date('01-11-2023', 'dd-mm-yyyy'), 'Processed', 445421, 38045869);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (41182271, to_date('18-04-2023', 'dd-mm-yyyy'), to_date('16-06-2023', 'dd-mm-yyyy'), 'Pending', 8236561, 72748895);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (43980980, to_date('25-03-2023', 'dd-mm-yyyy'), to_date('03-03-2024', 'dd-mm-yyyy'), 'Completed', 278677, 64825226);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (10168824, to_date('30-07-2022', 'dd-mm-yyyy'), to_date('24-05-2023', 'dd-mm-yyyy'), 'Shipped', 4026463, 31733408);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (16478044, to_date('12-04-2023', 'dd-mm-yyyy'), to_date('09-05-2023', 'dd-mm-yyyy'), 'Processed', 5224794, 34560332);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (26070875, to_date('21-02-2022', 'dd-mm-yyyy'), to_date('22-06-2023', 'dd-mm-yyyy'), 'Completed', 7053548, 86143960);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (80699646, to_date('09-03-2023', 'dd-mm-yyyy'), to_date('15-05-2023', 'dd-mm-yyyy'), 'Completed', 6205536, 73016023);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (22717205, to_date('16-07-2022', 'dd-mm-yyyy'), to_date('03-06-2023', 'dd-mm-yyyy'), 'Completed', 4615085, 27450835);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (99998367, to_date('03-03-2022', 'dd-mm-yyyy'), to_date('24-03-2024', 'dd-mm-yyyy'), 'Processed', 1457347, 89289435);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (65574736, to_date('05-05-2022', 'dd-mm-yyyy'), to_date('20-04-2024', 'dd-mm-yyyy'), 'Pending', 2492971, 88623229);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (52409037, to_date('10-01-2023', 'dd-mm-yyyy'), to_date('03-10-2023', 'dd-mm-yyyy'), 'Pending', 7948446, 79653532);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (30916140, to_date('23-07-2022', 'dd-mm-yyyy'), to_date('28-09-2023', 'dd-mm-yyyy'), 'Completed', 1092477, 66947950);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (27950677, to_date('01-06-2022', 'dd-mm-yyyy'), to_date('19-02-2024', 'dd-mm-yyyy'), 'Processed', 5661576, 12007619);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (86932521, to_date('08-03-2022', 'dd-mm-yyyy'), to_date('15-08-2023', 'dd-mm-yyyy'), 'Pending', 2523265, 83407796);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (71961058, to_date('10-04-2023', 'dd-mm-yyyy'), to_date('24-04-2024', 'dd-mm-yyyy'), 'Shipped', 5542070, 84924184);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (10305725, to_date('18-10-2022', 'dd-mm-yyyy'), to_date('19-08-2023', 'dd-mm-yyyy'), 'Completed', 4906126, 98149767);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (91555345, to_date('06-07-2022', 'dd-mm-yyyy'), to_date('21-10-2023', 'dd-mm-yyyy'), 'Delivered', 5600917, 22848358);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (65466270, to_date('05-02-2022', 'dd-mm-yyyy'), to_date('29-06-2023', 'dd-mm-yyyy'), 'Delivered', 5033115, 95826413);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (89973187, to_date('05-09-2022', 'dd-mm-yyyy'), to_date('12-07-2023', 'dd-mm-yyyy'), 'Completed', 7304625, 79191153);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (58981176, to_date('28-05-2022', 'dd-mm-yyyy'), to_date('30-03-2024', 'dd-mm-yyyy'), 'Processed', 3459878, 19239287);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (28646486, to_date('08-09-2022', 'dd-mm-yyyy'), to_date('04-01-2024', 'dd-mm-yyyy'), 'Processed', 549076, 79177370);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (16212701, to_date('27-10-2022', 'dd-mm-yyyy'), to_date('09-01-2024', 'dd-mm-yyyy'), 'Pending', 5224794, 73609023);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (40468327, to_date('18-04-2022', 'dd-mm-yyyy'), to_date('06-10-2023', 'dd-mm-yyyy'), 'Pending', 7273772, 85948925);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (13894585, to_date('09-06-2022', 'dd-mm-yyyy'), to_date('20-11-2023', 'dd-mm-yyyy'), 'Processed', 2015258, 30047947);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (11952928, to_date('14-01-2023', 'dd-mm-yyyy'), to_date('14-04-2024', 'dd-mm-yyyy'), 'Pending', 5626041, 21014885);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (76528537, to_date('23-04-2022', 'dd-mm-yyyy'), to_date('24-01-2024', 'dd-mm-yyyy'), 'Processed', 6318045, 25554128);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (24588483, to_date('16-01-2022', 'dd-mm-yyyy'), to_date('13-02-2024', 'dd-mm-yyyy'), 'Processed', 1488700, 61312845);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (93720830, to_date('31-03-2023', 'dd-mm-yyyy'), to_date('18-03-2024', 'dd-mm-yyyy'), 'Processed', 5961208, 70094374);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (99349870, to_date('12-03-2023', 'dd-mm-yyyy'), to_date('19-08-2023', 'dd-mm-yyyy'), 'Pending', 5456844, 87858363);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (97151747, to_date('25-11-2022', 'dd-mm-yyyy'), to_date('26-02-2024', 'dd-mm-yyyy'), 'Processed', 1558708, 42768514);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (59543351, to_date('04-03-2023', 'dd-mm-yyyy'), to_date('09-06-2023', 'dd-mm-yyyy'), 'Processed', 8933370, 55036429);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (89941451, to_date('17-04-2022', 'dd-mm-yyyy'), to_date('20-02-2024', 'dd-mm-yyyy'), 'Delivered', 8148685, 51103426);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (43278317, to_date('16-05-2022', 'dd-mm-yyyy'), to_date('23-01-2024', 'dd-mm-yyyy'), 'Completed', 1511440, 39208685);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (58587967, to_date('03-11-2022', 'dd-mm-yyyy'), to_date('20-03-2024', 'dd-mm-yyyy'), 'Shipped', 9876149, 91021750);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (15776963, to_date('18-05-2022', 'dd-mm-yyyy'), to_date('30-05-2023', 'dd-mm-yyyy'), 'Delivered', 5837773, 50095158);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (54193889, to_date('05-04-2023', 'dd-mm-yyyy'), to_date('30-09-2023', 'dd-mm-yyyy'), 'Delivered', 7028864, 94432158);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (46131079, to_date('17-08-2022', 'dd-mm-yyyy'), to_date('12-06-2023', 'dd-mm-yyyy'), 'Processed', 9845795, 90147871);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (54976001, to_date('30-10-2022', 'dd-mm-yyyy'), to_date('24-12-2023', 'dd-mm-yyyy'), 'Processed', 4871444, 33387429);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (73218368, to_date('12-02-2023', 'dd-mm-yyyy'), to_date('16-09-2023', 'dd-mm-yyyy'), 'Completed', 3774865, 78901938);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (92828941, to_date('18-12-2022', 'dd-mm-yyyy'), to_date('01-10-2023', 'dd-mm-yyyy'), 'Completed', 845273, 76734097);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (14557742, to_date('13-01-2023', 'dd-mm-yyyy'), to_date('27-02-2024', 'dd-mm-yyyy'), 'Shipped', 3447803, 19369145);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (18215069, to_date('16-04-2022', 'dd-mm-yyyy'), to_date('09-10-2023', 'dd-mm-yyyy'), 'Processed', 6468186, 40839706);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (24073410, to_date('01-05-2022', 'dd-mm-yyyy'), to_date('18-06-2023', 'dd-mm-yyyy'), 'Delivered', 9986309, 23001628);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (87114192, to_date('06-03-2022', 'dd-mm-yyyy'), to_date('19-11-2023', 'dd-mm-yyyy'), 'Processed', 4454137, 54569464);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (67149382, to_date('22-02-2023', 'dd-mm-yyyy'), to_date('10-01-2024', 'dd-mm-yyyy'), 'Processed', 2348108, 54302716);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (40078701, to_date('05-11-2022', 'dd-mm-yyyy'), to_date('10-04-2024', 'dd-mm-yyyy'), 'Completed', 6988264, 27753546);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (17501794, to_date('28-09-2022', 'dd-mm-yyyy'), to_date('06-04-2024', 'dd-mm-yyyy'), 'Delivered', 3411908, 93430366);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (60774397, to_date('14-10-2022', 'dd-mm-yyyy'), to_date('20-06-2023', 'dd-mm-yyyy'), 'Shipped', 1536028, 73825771);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (87500873, to_date('09-11-2022', 'dd-mm-yyyy'), to_date('01-06-2023', 'dd-mm-yyyy'), 'Processed', 3411908, 50109125);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (52363187, to_date('10-10-2022', 'dd-mm-yyyy'), to_date('27-03-2024', 'dd-mm-yyyy'), 'Shipped', 568592, 80634418);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (24828386, to_date('01-03-2022', 'dd-mm-yyyy'), to_date('04-10-2023', 'dd-mm-yyyy'), 'Pending', 4207638, 72074362);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (77721805, to_date('15-02-2022', 'dd-mm-yyyy'), to_date('07-03-2024', 'dd-mm-yyyy'), 'Delivered', 6287363, 52971711);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (31145877, to_date('18-11-2022', 'dd-mm-yyyy'), to_date('25-07-2023', 'dd-mm-yyyy'), 'Shipped', 3520814, 60147305);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (73501747, to_date('16-04-2022', 'dd-mm-yyyy'), to_date('03-08-2023', 'dd-mm-yyyy'), 'Processed', 9271350, 27753546);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (17246868, to_date('26-02-2022', 'dd-mm-yyyy'), to_date('01-07-2023', 'dd-mm-yyyy'), 'Delivered', 9861282, 54535594);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (29573304, to_date('01-10-2022', 'dd-mm-yyyy'), to_date('20-11-2023', 'dd-mm-yyyy'), 'Processed', 2995527, 99946989);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (18863880, to_date('11-10-2022', 'dd-mm-yyyy'), to_date('05-01-2024', 'dd-mm-yyyy'), 'Processed', 278677, 27104007);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (15353698, to_date('26-07-2022', 'dd-mm-yyyy'), to_date('22-06-2023', 'dd-mm-yyyy'), 'Shipped', 577322, 57460985);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (78780176, to_date('25-03-2023', 'dd-mm-yyyy'), to_date('30-01-2024', 'dd-mm-yyyy'), 'Delivered', 191294, 18176375);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (62363006, to_date('16-01-2023', 'dd-mm-yyyy'), to_date('30-09-2023', 'dd-mm-yyyy'), 'Pending', 9475377, 45578032);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (62484334, to_date('18-01-2022', 'dd-mm-yyyy'), to_date('04-10-2023', 'dd-mm-yyyy'), 'Delivered', 1163402, 50455678);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (11764838, to_date('03-02-2023', 'dd-mm-yyyy'), to_date('15-07-2023', 'dd-mm-yyyy'), 'Shipped', 4661814, 40050758);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (19961420, to_date('29-01-2023', 'dd-mm-yyyy'), to_date('21-12-2023', 'dd-mm-yyyy'), 'Delivered', 4207638, 27286133);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (54297355, to_date('18-04-2022', 'dd-mm-yyyy'), to_date('10-10-2023', 'dd-mm-yyyy'), 'Pending', 8138311, 94652622);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (76342968, to_date('16-03-2023', 'dd-mm-yyyy'), to_date('12-01-2024', 'dd-mm-yyyy'), 'Delivered', 4319962, 39208685);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (21060377, to_date('16-11-2022', 'dd-mm-yyyy'), to_date('20-07-2023', 'dd-mm-yyyy'), 'Delivered', 3791430, 48270369);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (10192467, to_date('24-03-2022', 'dd-mm-yyyy'), to_date('03-10-2023', 'dd-mm-yyyy'), 'Completed', 2415756, 19052428);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (17920164, to_date('30-06-2022', 'dd-mm-yyyy'), to_date('06-12-2023', 'dd-mm-yyyy'), 'Shipped', 8591515, 17698770);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (24432556, to_date('22-03-2022', 'dd-mm-yyyy'), to_date('28-04-2024', 'dd-mm-yyyy'), 'Processed', 5033115, 78004881);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (14765097, to_date('06-12-2022', 'dd-mm-yyyy'), to_date('28-03-2024', 'dd-mm-yyyy'), 'Completed', 4207638, 13376107);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (48762701, to_date('07-09-2022', 'dd-mm-yyyy'), to_date('08-07-2023', 'dd-mm-yyyy'), 'Delivered', 8541660, 12197075);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (69751252, to_date('06-04-2022', 'dd-mm-yyyy'), to_date('11-04-2024', 'dd-mm-yyyy'), 'Completed', 6624272, 93430366);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (73543101, to_date('13-07-2022', 'dd-mm-yyyy'), to_date('23-07-2023', 'dd-mm-yyyy'), 'Shipped', 639714, 94691263);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (10382740, to_date('18-01-2023', 'dd-mm-yyyy'), to_date('05-02-2024', 'dd-mm-yyyy'), 'Completed', 3791430, 76734097);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (48400394, to_date('29-01-2022', 'dd-mm-yyyy'), to_date('23-06-2023', 'dd-mm-yyyy'), 'Processed', 1092477, 94453033);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (69056450, to_date('11-06-2022', 'dd-mm-yyyy'), to_date('30-01-2024', 'dd-mm-yyyy'), 'Processed', 2766607, 67967662);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (28467705, to_date('29-04-2023', 'dd-mm-yyyy'), to_date('19-06-2023', 'dd-mm-yyyy'), 'Shipped', 6314307, 70133352);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (21681616, to_date('28-10-2022', 'dd-mm-yyyy'), to_date('15-10-2023', 'dd-mm-yyyy'), 'Shipped', 1460595, 38685099);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (76030186, to_date('26-08-2022', 'dd-mm-yyyy'), to_date('03-11-2023', 'dd-mm-yyyy'), 'Delivered', 6113810, 28938449);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (75934121, to_date('24-05-2022', 'dd-mm-yyyy'), to_date('11-06-2023', 'dd-mm-yyyy'), 'Pending', 9617153, 11250240);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (66319658, to_date('20-02-2022', 'dd-mm-yyyy'), to_date('06-11-2023', 'dd-mm-yyyy'), 'Completed', 639714, 51103426);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (27776987, to_date('26-03-2023', 'dd-mm-yyyy'), to_date('08-07-2023', 'dd-mm-yyyy'), 'Completed', 5600917, 83407796);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (51879867, to_date('07-04-2023', 'dd-mm-yyyy'), to_date('02-03-2024', 'dd-mm-yyyy'), 'Shipped', 9419803, 21014885);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (76798063, to_date('08-02-2023', 'dd-mm-yyyy'), to_date('09-05-2023', 'dd-mm-yyyy'), 'Pending', 8199494, 83896964);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (45093026, to_date('01-02-2023', 'dd-mm-yyyy'), to_date('17-02-2024', 'dd-mm-yyyy'), 'Pending', 6307622, 85923657);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (77405651, to_date('20-11-2022', 'dd-mm-yyyy'), to_date('21-01-2024', 'dd-mm-yyyy'), 'Shipped', 9648034, 27450835);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (58100144, to_date('23-08-2022', 'dd-mm-yyyy'), to_date('17-03-2024', 'dd-mm-yyyy'), 'Shipped', 3447803, 60406218);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (61623388, to_date('09-04-2022', 'dd-mm-yyyy'), to_date('09-11-2023', 'dd-mm-yyyy'), 'Pending', 6318045, 38685099);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (69935948, to_date('08-02-2023', 'dd-mm-yyyy'), to_date('18-08-2023', 'dd-mm-yyyy'), 'Shipped', 9817885, 77401018);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (15859164, to_date('20-12-2022', 'dd-mm-yyyy'), to_date('02-12-2023', 'dd-mm-yyyy'), 'Delivered', 747810, 78035994);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (65439870, to_date('12-09-2022', 'dd-mm-yyyy'), to_date('29-06-2023', 'dd-mm-yyyy'), 'Processed', 664031, 85923657);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (19420366, to_date('23-11-2022', 'dd-mm-yyyy'), to_date('13-06-2023', 'dd-mm-yyyy'), 'Completed', 8430312, 50140697);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (50995796, to_date('01-06-2022', 'dd-mm-yyyy'), to_date('25-07-2023', 'dd-mm-yyyy'), 'Delivered', 6779644, 14591687);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (43656591, to_date('14-10-2022', 'dd-mm-yyyy'), to_date('06-02-2024', 'dd-mm-yyyy'), 'Completed', 191294, 48558953);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (88611236, to_date('01-01-2023', 'dd-mm-yyyy'), to_date('10-04-2024', 'dd-mm-yyyy'), 'Completed', 6870685, 19112192);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (69181376, to_date('26-05-2022', 'dd-mm-yyyy'), to_date('15-05-2023', 'dd-mm-yyyy'), 'Delivered', 7228926, 47222423);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (18303653, to_date('14-07-2022', 'dd-mm-yyyy'), to_date('06-02-2024', 'dd-mm-yyyy'), 'Delivered', 5131765, 27778669);
commit;
prompt 100 records committed...
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (83206369, to_date('01-02-2023', 'dd-mm-yyyy'), to_date('31-10-2023', 'dd-mm-yyyy'), 'Delivered', 1741848, 95677272);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (93315303, to_date('18-11-2022', 'dd-mm-yyyy'), to_date('12-01-2024', 'dd-mm-yyyy'), 'Delivered', 5456844, 78901938);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (61075688, to_date('21-03-2022', 'dd-mm-yyyy'), to_date('18-01-2024', 'dd-mm-yyyy'), 'Pending', 4038390, 83896964);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (20734597, to_date('24-06-2022', 'dd-mm-yyyy'), to_date('18-06-2023', 'dd-mm-yyyy'), 'Pending', 1511440, 87142600);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (45957679, to_date('19-02-2023', 'dd-mm-yyyy'), to_date('20-11-2023', 'dd-mm-yyyy'), 'Completed', 8567855, 33410647);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (23628665, to_date('17-11-2022', 'dd-mm-yyyy'), to_date('02-03-2024', 'dd-mm-yyyy'), 'Completed', 3823965, 54563648);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (47744726, to_date('23-07-2022', 'dd-mm-yyyy'), to_date('26-03-2024', 'dd-mm-yyyy'), 'Delivered', 7450236, 72074362);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (56252092, to_date('15-11-2022', 'dd-mm-yyyy'), to_date('10-01-2024', 'dd-mm-yyyy'), 'Delivered', 8285184, 94432158);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (77859088, to_date('31-03-2023', 'dd-mm-yyyy'), to_date('27-04-2024', 'dd-mm-yyyy'), 'Pending', 9491417, 88520361);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (12467208, to_date('11-06-2022', 'dd-mm-yyyy'), to_date('18-09-2023', 'dd-mm-yyyy'), 'Pending', 9590539, 61834965);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (32377066, to_date('03-10-2022', 'dd-mm-yyyy'), to_date('11-05-2023', 'dd-mm-yyyy'), 'Processed', 171592, 98048623);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (99591249, to_date('08-11-2022', 'dd-mm-yyyy'), to_date('04-10-2023', 'dd-mm-yyyy'), 'Processed', 7419752, 45629416);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (94271016, to_date('07-04-2023', 'dd-mm-yyyy'), to_date('02-01-2024', 'dd-mm-yyyy'), 'Delivered', 8457109, 61074545);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (12071508, to_date('14-06-2022', 'dd-mm-yyyy'), to_date('05-01-2024', 'dd-mm-yyyy'), 'Processed', 1842955, 20271232);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (71959629, to_date('17-01-2022', 'dd-mm-yyyy'), to_date('24-11-2023', 'dd-mm-yyyy'), 'Completed', 8381903, 98422837);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (69678002, to_date('22-04-2022', 'dd-mm-yyyy'), to_date('02-05-2023', 'dd-mm-yyyy'), 'Pending', 973508, 21014885);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (79244161, to_date('07-03-2022', 'dd-mm-yyyy'), to_date('26-05-2023', 'dd-mm-yyyy'), 'Completed', 8541660, 40182593);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (69353175, to_date('29-04-2023', 'dd-mm-yyyy'), to_date('30-01-2024', 'dd-mm-yyyy'), 'Processed', 8220901, 66163595);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (81749197, to_date('19-09-2022', 'dd-mm-yyyy'), to_date('06-12-2023', 'dd-mm-yyyy'), 'Delivered', 6252751, 31768349);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (85318412, to_date('21-09-2022', 'dd-mm-yyyy'), to_date('10-02-2024', 'dd-mm-yyyy'), 'Completed', 6926382.25, 78139447);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (83343457, to_date('09-01-2023', 'dd-mm-yyyy'), to_date('11-12-2023', 'dd-mm-yyyy'), 'Pending', 6533168, 27778669);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (57859448, to_date('17-03-2022', 'dd-mm-yyyy'), to_date('17-10-2023', 'dd-mm-yyyy'), 'Pending', 1365922, 22848358);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (26488051, to_date('28-05-2022', 'dd-mm-yyyy'), to_date('18-12-2023', 'dd-mm-yyyy'), 'Processed', 2492971, 25271570);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (92450308, to_date('02-01-2022', 'dd-mm-yyyy'), to_date('23-10-2023', 'dd-mm-yyyy'), 'Delivered', 5070778, 39208685);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (27950422, to_date('22-06-2022', 'dd-mm-yyyy'), to_date('30-05-2023', 'dd-mm-yyyy'), 'Pending', 6314307, 67803385);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (28312002, to_date('13-05-2022', 'dd-mm-yyyy'), to_date('30-01-2024', 'dd-mm-yyyy'), 'Pending', 9167629, 71718606);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (92920365, to_date('09-08-2022', 'dd-mm-yyyy'), to_date('05-02-2024', 'dd-mm-yyyy'), 'Completed', 4026854, 33387429);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (23054747, to_date('08-08-2022', 'dd-mm-yyyy'), to_date('07-06-2023', 'dd-mm-yyyy'), 'Delivered', 8381056, 79223054);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (69465420, to_date('07-01-2023', 'dd-mm-yyyy'), to_date('13-11-2023', 'dd-mm-yyyy'), 'Shipped', 3624043, 54666303);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (53034043, to_date('28-03-2022', 'dd-mm-yyyy'), to_date('15-11-2023', 'dd-mm-yyyy'), 'Delivered', 9491417, 13376107);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (22095269, to_date('15-02-2022', 'dd-mm-yyyy'), to_date('15-07-2023', 'dd-mm-yyyy'), 'Processed', 4038390, 38831861);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (49275903, to_date('04-09-2022', 'dd-mm-yyyy'), to_date('23-05-2023', 'dd-mm-yyyy'), 'Pending', 8133225, 69354807);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (93188547, to_date('28-11-2022', 'dd-mm-yyyy'), to_date('22-06-2023', 'dd-mm-yyyy'), 'Completed', 971253, 28938449);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (46702526, to_date('23-02-2022', 'dd-mm-yyyy'), to_date('31-07-2023', 'dd-mm-yyyy'), 'Pending', 6982410, 97482787);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (18530627, to_date('04-09-2022', 'dd-mm-yyyy'), to_date('15-11-2023', 'dd-mm-yyyy'), 'Delivered', 2995527, 74158462);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (13453977, to_date('21-01-2023', 'dd-mm-yyyy'), to_date('13-01-2024', 'dd-mm-yyyy'), 'Pending', 7146382, 23001271);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (52704646, to_date('07-12-2022', 'dd-mm-yyyy'), to_date('29-12-2023', 'dd-mm-yyyy'), 'Shipped', 6791155, 58307063);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (77937364, to_date('06-10-2022', 'dd-mm-yyyy'), to_date('15-10-2023', 'dd-mm-yyyy'), 'Shipped', 4979177, 99026347);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (78914886, to_date('21-05-2022', 'dd-mm-yyyy'), to_date('11-03-2024', 'dd-mm-yyyy'), 'Shipped', 9085784, 48558953);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (59190855, to_date('07-04-2023', 'dd-mm-yyyy'), to_date('26-10-2023', 'dd-mm-yyyy'), 'Pending', 6314307, 12834085);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (19184254, to_date('24-09-2022', 'dd-mm-yyyy'), to_date('16-11-2023', 'dd-mm-yyyy'), 'Pending', 8222269, 49095860);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (49252991, to_date('30-03-2023', 'dd-mm-yyyy'), to_date('17-06-2023', 'dd-mm-yyyy'), 'Processed', 9797086, 46565539);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (49237883, to_date('29-09-2022', 'dd-mm-yyyy'), to_date('02-11-2023', 'dd-mm-yyyy'), 'Shipped', 2015258, 80257977);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (32141175, to_date('04-11-2022', 'dd-mm-yyyy'), to_date('27-08-2023', 'dd-mm-yyyy'), 'Completed', 3954421, 80257977);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (88078973, to_date('17-12-2022', 'dd-mm-yyyy'), to_date('21-01-2024', 'dd-mm-yyyy'), 'Processed', 4026854, 79123923);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (67618229, to_date('30-01-2023', 'dd-mm-yyyy'), to_date('16-03-2024', 'dd-mm-yyyy'), 'Shipped', 6509979, 87858363);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (84172948, to_date('26-06-2022', 'dd-mm-yyyy'), to_date('25-05-2023', 'dd-mm-yyyy'), 'Processed', 3731605, 85923657);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (61751721, to_date('09-11-2022', 'dd-mm-yyyy'), to_date('26-09-2023', 'dd-mm-yyyy'), 'Delivered', 4884410, 33387429);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (30977297, to_date('28-04-2022', 'dd-mm-yyyy'), to_date('14-10-2023', 'dd-mm-yyyy'), 'Delivered', 7570549, 65486123);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (99436889, to_date('27-11-2022', 'dd-mm-yyyy'), to_date('15-11-2023', 'dd-mm-yyyy'), 'Delivered', 2036427, 78901938);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (80441743, to_date('27-04-2023', 'dd-mm-yyyy'), to_date('07-11-2023', 'dd-mm-yyyy'), 'Delivered', 3990552, 27778669);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (40247234, to_date('24-06-2022', 'dd-mm-yyyy'), to_date('10-05-2023', 'dd-mm-yyyy'), 'Processed', 697701, 71520279);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (78117587, to_date('01-08-2022', 'dd-mm-yyyy'), to_date('05-10-2023', 'dd-mm-yyyy'), 'Pending', 7304180, 95730733);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (46317105, to_date('04-02-2023', 'dd-mm-yyyy'), to_date('10-09-2023', 'dd-mm-yyyy'), 'Processed', 564426.35, 98422837);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (66220926, to_date('12-02-2023', 'dd-mm-yyyy'), to_date('30-05-2023', 'dd-mm-yyyy'), 'Delivered', 334251, 29109732);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (55489053, to_date('01-05-2022', 'dd-mm-yyyy'), to_date('04-03-2024', 'dd-mm-yyyy'), 'Completed', 3926699, 57518681);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (45137073, to_date('05-05-2022', 'dd-mm-yyyy'), to_date('06-11-2023', 'dd-mm-yyyy'), 'Shipped', 5146992, 60147305);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (77631320, to_date('14-02-2023', 'dd-mm-yyyy'), to_date('29-05-2023', 'dd-mm-yyyy'), 'Shipped', 5778795, 88196004);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (84778308, to_date('22-04-2023', 'dd-mm-yyyy'), to_date('12-10-2023', 'dd-mm-yyyy'), 'Pending', 6303806, 19052428);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (33880439, to_date('17-03-2022', 'dd-mm-yyyy'), to_date('01-01-2024', 'dd-mm-yyyy'), 'Pending', 5102227, 78781959);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (24467919, to_date('25-05-2022', 'dd-mm-yyyy'), to_date('22-01-2024', 'dd-mm-yyyy'), 'Processed', 171592, 72812608);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (67838607, to_date('13-04-2022', 'dd-mm-yyyy'), to_date('17-02-2024', 'dd-mm-yyyy'), 'Delivered', 5358235.1, 39817959);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (27077982, to_date('15-07-2022', 'dd-mm-yyyy'), to_date('18-12-2023', 'dd-mm-yyyy'), 'Shipped', 6271337, 95730733);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (77035256, to_date('14-08-2022', 'dd-mm-yyyy'), to_date('08-01-2024', 'dd-mm-yyyy'), 'Shipped', 8607218, 47129256);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (88476204, to_date('27-09-2022', 'dd-mm-yyyy'), to_date('24-02-2024', 'dd-mm-yyyy'), 'Completed', 9476075, 48004855);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (26966572, to_date('30-05-2022', 'dd-mm-yyyy'), to_date('23-11-2023', 'dd-mm-yyyy'), 'Shipped', 9670086, 67787013);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (79927690, to_date('04-06-2022', 'dd-mm-yyyy'), to_date('24-07-2023', 'dd-mm-yyyy'), 'Completed', 9657341, 75852122);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (13865454, to_date('01-11-2022', 'dd-mm-yyyy'), to_date('14-12-2023', 'dd-mm-yyyy'), 'Processed', 4207638, 24574132);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (71722461, to_date('12-03-2022', 'dd-mm-yyyy'), to_date('09-10-2023', 'dd-mm-yyyy'), 'Shipped', 1092477, 54563648);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (77393215, to_date('13-05-2022', 'dd-mm-yyyy'), to_date('05-02-2024', 'dd-mm-yyyy'), 'Shipped', 8567855, 91831066);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (26773815, to_date('16-03-2023', 'dd-mm-yyyy'), to_date('05-02-2024', 'dd-mm-yyyy'), 'Processed', 2224163, 98048623);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (33029912, to_date('11-03-2023', 'dd-mm-yyyy'), to_date('09-03-2024', 'dd-mm-yyyy'), 'Shipped', 6272698, 79123923);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (70992013, to_date('26-08-2022', 'dd-mm-yyyy'), to_date('26-06-2023', 'dd-mm-yyyy'), 'Completed', 1149469, 92655517);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (41255137, to_date('12-01-2022', 'dd-mm-yyyy'), to_date('29-06-2023', 'dd-mm-yyyy'), 'Delivered', 1842955, 72074362);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (37058869, to_date('23-08-2022', 'dd-mm-yyyy'), to_date('31-10-2023', 'dd-mm-yyyy'), 'Delivered', 6271337, 82838120);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (76040902, to_date('01-04-2022', 'dd-mm-yyyy'), to_date('11-10-2023', 'dd-mm-yyyy'), 'Shipped', 4639951, 52971711);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (41605154, to_date('14-04-2023', 'dd-mm-yyyy'), to_date('24-01-2024', 'dd-mm-yyyy'), 'Pending', 3259415, 79123923);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (15702316, to_date('15-04-2023', 'dd-mm-yyyy'), to_date('19-05-2023', 'dd-mm-yyyy'), 'Pending', 1751361, 82838120);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (71881036, to_date('13-01-2022', 'dd-mm-yyyy'), to_date('01-05-2023', 'dd-mm-yyyy'), 'Delivered', 6118490, 95826413);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (79108858, to_date('03-11-2022', 'dd-mm-yyyy'), to_date('11-04-2024', 'dd-mm-yyyy'), 'Delivered', 3954421, 80634418);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (91524473, to_date('22-10-2022', 'dd-mm-yyyy'), to_date('06-03-2024', 'dd-mm-yyyy'), 'Completed', 4639951, 26318843);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (74983375, to_date('25-04-2023', 'dd-mm-yyyy'), to_date('01-04-2024', 'dd-mm-yyyy'), 'Delivered', 8631320, 69351765);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (69937107, to_date('23-11-2022', 'dd-mm-yyyy'), to_date('08-11-2023', 'dd-mm-yyyy'), 'Pending', 6271337, 49095860);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (34940037, to_date('04-04-2023', 'dd-mm-yyyy'), to_date('19-12-2023', 'dd-mm-yyyy'), 'Completed', 549076, 81071740);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (43272453, to_date('04-02-2022', 'dd-mm-yyyy'), to_date('21-03-2024', 'dd-mm-yyyy'), 'Pending', 9501093, 73609023);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (19499955, to_date('03-08-2022', 'dd-mm-yyyy'), to_date('12-07-2023', 'dd-mm-yyyy'), 'Processed', 1365922, 35948729);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (27971106, to_date('09-12-2022', 'dd-mm-yyyy'), to_date('04-12-2023', 'dd-mm-yyyy'), 'Processed', 2995527, 75312264);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (75160017, to_date('27-03-2022', 'dd-mm-yyyy'), to_date('08-01-2024', 'dd-mm-yyyy'), 'Processed', 5526336, 65260797);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (79512672, to_date('03-04-2022', 'dd-mm-yyyy'), to_date('09-04-2024', 'dd-mm-yyyy'), 'Shipped', 7146382, 22848358);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (11030061, to_date('20-01-2023', 'dd-mm-yyyy'), to_date('25-10-2023', 'dd-mm-yyyy'), 'Pending', 6967588, 68635839);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (39939533, to_date('19-09-2022', 'dd-mm-yyyy'), to_date('09-11-2023', 'dd-mm-yyyy'), 'Delivered', 8133225, 78606227);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (49639306, to_date('06-10-2022', 'dd-mm-yyyy'), to_date('18-09-2023', 'dd-mm-yyyy'), 'Shipped', 9227856, 67681216);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (81934454, to_date('14-03-2023', 'dd-mm-yyyy'), to_date('18-03-2024', 'dd-mm-yyyy'), 'Delivered', 6870685, 20147733);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (20819418, to_date('09-09-2022', 'dd-mm-yyyy'), to_date('05-05-2023', 'dd-mm-yyyy'), 'Pending', 8927771, 80257977);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (67606267, to_date('22-04-2022', 'dd-mm-yyyy'), to_date('20-10-2023', 'dd-mm-yyyy'), 'Completed', 1842955, 45756835);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (21800008, to_date('21-12-2022', 'dd-mm-yyyy'), to_date('20-03-2024', 'dd-mm-yyyy'), 'Shipped', 9476075, 89633192);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (21478126, to_date('03-02-2023', 'dd-mm-yyyy'), to_date('22-07-2023', 'dd-mm-yyyy'), 'Completed', 9271350, 12834085);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (26451191, to_date('11-08-2022', 'dd-mm-yyyy'), to_date('01-12-2023', 'dd-mm-yyyy'), 'Completed', 9227856, 85948925);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (38999451, to_date('28-05-2022', 'dd-mm-yyyy'), to_date('06-02-2024', 'dd-mm-yyyy'), 'Completed', 171592, 21479883);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (39543197, to_date('18-09-2022', 'dd-mm-yyyy'), to_date('13-02-2024', 'dd-mm-yyyy'), 'Shipped', 1230741, 66402088);
commit;
prompt 200 records committed...
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (62827313, to_date('25-08-2022', 'dd-mm-yyyy'), to_date('02-07-2023', 'dd-mm-yyyy'), 'Delivered', 1061509, 48558953);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (65014818, to_date('11-01-2022', 'dd-mm-yyyy'), to_date('28-06-2023', 'dd-mm-yyyy'), 'Pending', 5308655, 57460985);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (23589087, to_date('23-11-2022', 'dd-mm-yyyy'), to_date('02-06-2023', 'dd-mm-yyyy'), 'Pending', 1751361, 83896964);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (28781639, to_date('16-04-2022', 'dd-mm-yyyy'), to_date('09-12-2023', 'dd-mm-yyyy'), 'Delivered', 6318045, 38015390);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (64077472, to_date('02-03-2022', 'dd-mm-yyyy'), to_date('30-08-2023', 'dd-mm-yyyy'), 'Completed', 6791155, 73825771);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (98469707, to_date('26-04-2023', 'dd-mm-yyyy'), to_date('13-08-2023', 'dd-mm-yyyy'), 'Processed', 6272698, 34560332);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (25571560, to_date('18-01-2023', 'dd-mm-yyyy'), to_date('17-06-2023', 'dd-mm-yyyy'), 'Pending', 4299384, 78818005);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (62529227, to_date('04-09-2022', 'dd-mm-yyyy'), to_date('21-07-2023', 'dd-mm-yyyy'), 'Pending', 1615719, 88079734);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (39867776, to_date('25-07-2022', 'dd-mm-yyyy'), to_date('17-08-2023', 'dd-mm-yyyy'), 'Shipped', 2278177, 59288647);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (31900293, to_date('03-06-2022', 'dd-mm-yyyy'), to_date('03-10-2023', 'dd-mm-yyyy'), 'Completed', 1780821, 64825226);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (28857091, to_date('14-03-2023', 'dd-mm-yyyy'), to_date('29-09-2023', 'dd-mm-yyyy'), 'Pending', 1760875, 91778343);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (25729191, to_date('13-01-2023', 'dd-mm-yyyy'), to_date('05-02-2024', 'dd-mm-yyyy'), 'Completed', 8631320, 46767112);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (47109265, to_date('26-12-2022', 'dd-mm-yyyy'), to_date('14-05-2023', 'dd-mm-yyyy'), 'Completed', 9209785, 26885794);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (23125267, to_date('25-02-2022', 'dd-mm-yyyy'), to_date('04-11-2023', 'dd-mm-yyyy'), 'Pending', 7472682, 50540966);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (50633001, to_date('23-06-2022', 'dd-mm-yyyy'), to_date('13-02-2024', 'dd-mm-yyyy'), 'Completed', 3654476.4, 78606227);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (80271654, to_date('31-03-2023', 'dd-mm-yyyy'), to_date('21-06-2023', 'dd-mm-yyyy'), 'Processed', 173726, 69009658);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (58683634, to_date('10-03-2022', 'dd-mm-yyyy'), to_date('07-01-2024', 'dd-mm-yyyy'), 'Delivered', 7908693, 91233616);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (53423705, to_date('24-09-2022', 'dd-mm-yyyy'), to_date('31-05-2023', 'dd-mm-yyyy'), 'Processed', 549076, 95826413);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (61012473, to_date('22-08-2022', 'dd-mm-yyyy'), to_date('17-11-2023', 'dd-mm-yyyy'), 'Pending', 3624043, 72812608);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (86194909, to_date('13-03-2023', 'dd-mm-yyyy'), to_date('22-06-2023', 'dd-mm-yyyy'), 'Completed', 5466780, 17698770);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (60698811, to_date('06-02-2023', 'dd-mm-yyyy'), to_date('10-09-2023', 'dd-mm-yyyy'), 'Shipped', 9590539, 99420157);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (53884663, to_date('08-02-2022', 'dd-mm-yyyy'), to_date('17-09-2023', 'dd-mm-yyyy'), 'Completed', 6469584, 67787013);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (91614446, to_date('28-03-2023', 'dd-mm-yyyy'), to_date('08-11-2023', 'dd-mm-yyyy'), 'Pending', 973508, 97932782);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (95338906, to_date('20-03-2022', 'dd-mm-yyyy'), to_date('05-10-2023', 'dd-mm-yyyy'), 'Pending', 2747291, 86377675);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (73993322, to_date('19-07-2022', 'dd-mm-yyyy'), to_date('22-08-2023', 'dd-mm-yyyy'), 'Pending', 7909283, 60533897);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (34070155, to_date('07-03-2023', 'dd-mm-yyyy'), to_date('13-04-2024', 'dd-mm-yyyy'), 'Pending', 7953907, 73825771);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (19605806, to_date('06-10-2022', 'dd-mm-yyyy'), to_date('14-12-2023', 'dd-mm-yyyy'), 'Completed', 3705311, 13661684);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (53731358, to_date('20-01-2022', 'dd-mm-yyyy'), to_date('12-07-2023', 'dd-mm-yyyy'), 'Delivered', 7053548, 94619363);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (64782384, to_date('14-03-2022', 'dd-mm-yyyy'), to_date('01-07-2023', 'dd-mm-yyyy'), 'Delivered', 2551959, 38628579);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (43369964, to_date('23-12-2022', 'dd-mm-yyyy'), to_date('07-12-2023', 'dd-mm-yyyy'), 'Pending', 971253, 86160304);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (16472279, to_date('12-10-2022', 'dd-mm-yyyy'), to_date('18-08-2023', 'dd-mm-yyyy'), 'Shipped', 3823965, 26250050);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (33349410, to_date('09-01-2023', 'dd-mm-yyyy'), to_date('13-02-2024', 'dd-mm-yyyy'), 'Completed', 7411990, 13456767);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (87428147, to_date('07-02-2023', 'dd-mm-yyyy'), to_date('23-01-2024', 'dd-mm-yyyy'), 'Pending', 2681689, 40038212);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (90709127, to_date('02-06-2022', 'dd-mm-yyyy'), to_date('31-10-2023', 'dd-mm-yyyy'), 'Processed', 9861282, 41524549);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (72948531, to_date('16-11-2022', 'dd-mm-yyyy'), to_date('06-03-2024', 'dd-mm-yyyy'), 'Shipped', 5826817, 89085003);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (65921313, to_date('26-11-2022', 'dd-mm-yyyy'), to_date('05-07-2023', 'dd-mm-yyyy'), 'Shipped', 8835277, 73276753);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (57794058, to_date('11-04-2023', 'dd-mm-yyyy'), to_date('30-08-2023', 'dd-mm-yyyy'), 'Completed', 6276980, 97932782);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (29123352, to_date('17-01-2023', 'dd-mm-yyyy'), to_date('06-08-2023', 'dd-mm-yyyy'), 'Shipped', 2103735, 81191202);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (18957521, to_date('16-06-2022', 'dd-mm-yyyy'), to_date('13-02-2024', 'dd-mm-yyyy'), 'Completed', 9167629, 95826413);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (49410269, to_date('09-04-2023', 'dd-mm-yyyy'), to_date('04-12-2023', 'dd-mm-yyyy'), 'Completed', 741097, 71044320);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (87555652, to_date('20-10-2022', 'dd-mm-yyyy'), to_date('03-05-2023', 'dd-mm-yyyy'), 'Shipped', 8364760, 53097853);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (73323057, to_date('08-04-2022', 'dd-mm-yyyy'), to_date('07-02-2024', 'dd-mm-yyyy'), 'Processed', 4639951, 48944513);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (10430257, to_date('01-11-2022', 'dd-mm-yyyy'), to_date('14-09-2023', 'dd-mm-yyyy'), 'Shipped', 9476075, 12834085);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (88859076, to_date('16-01-2022', 'dd-mm-yyyy'), to_date('31-03-2024', 'dd-mm-yyyy'), 'Shipped', 2173820, 59252850);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (35376470, to_date('26-07-2022', 'dd-mm-yyyy'), to_date('19-01-2024', 'dd-mm-yyyy'), 'Processed', 2224163, 60290940);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (55109827, to_date('03-08-2022', 'dd-mm-yyyy'), to_date('14-10-2023', 'dd-mm-yyyy'), 'Completed', 6834952, 12358352);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (30300518, to_date('08-10-2022', 'dd-mm-yyyy'), to_date('14-10-2023', 'dd-mm-yyyy'), 'Shipped', 6424098, 97052515);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (81944586, to_date('05-03-2023', 'dd-mm-yyyy'), to_date('20-02-2024', 'dd-mm-yyyy'), 'Processed', 4469062, 23001628);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (56876593, to_date('30-03-2022', 'dd-mm-yyyy'), to_date('01-02-2024', 'dd-mm-yyyy'), 'Processed', 6212834, 46684695);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (27142082, to_date('05-04-2022', 'dd-mm-yyyy'), to_date('28-10-2023', 'dd-mm-yyyy'), 'Delivered', 7450236, 48004855);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (50211776, to_date('25-02-2022', 'dd-mm-yyyy'), to_date('21-01-2024', 'dd-mm-yyyy'), 'Shipped', 7959163, 24030481);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (61120744, to_date('09-02-2023', 'dd-mm-yyyy'), to_date('27-04-2024', 'dd-mm-yyyy'), 'Pending', 9173436, 89085003);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (70868045, to_date('29-10-2022', 'dd-mm-yyyy'), to_date('05-06-2023', 'dd-mm-yyyy'), 'Delivered', 5381443, 11519494);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (79282436, to_date('03-04-2023', 'dd-mm-yyyy'), to_date('23-08-2023', 'dd-mm-yyyy'), 'Delivered', 1780821, 58482759);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (28261423, to_date('04-01-2023', 'dd-mm-yyyy'), to_date('30-03-2024', 'dd-mm-yyyy'), 'Completed', 9227856, 87836917);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (82791924, to_date('24-01-2023', 'dd-mm-yyyy'), to_date('09-02-2024', 'dd-mm-yyyy'), 'Pending', 3712427, 39208685);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (25669470, to_date('11-03-2022', 'dd-mm-yyyy'), to_date('27-04-2024', 'dd-mm-yyyy'), 'Processed', 7256650, 44018658);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (81948881, to_date('10-08-2022', 'dd-mm-yyyy'), to_date('21-11-2023', 'dd-mm-yyyy'), 'Completed', 4709447, 42768514);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (33104440, to_date('18-02-2022', 'dd-mm-yyyy'), to_date('26-07-2023', 'dd-mm-yyyy'), 'Shipped', 1061509, 14591687);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (99782262, to_date('20-01-2022', 'dd-mm-yyyy'), to_date('10-08-2023', 'dd-mm-yyyy'), 'Completed', 6913241.25, 65957004);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (77870256, to_date('02-06-2022', 'dd-mm-yyyy'), to_date('11-10-2023', 'dd-mm-yyyy'), 'Delivered', 5443971, 18905876);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (69298889, to_date('28-07-2022', 'dd-mm-yyyy'), to_date('28-12-2023', 'dd-mm-yyyy'), 'Completed', 2801471.65, 48432072);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (45168516, to_date('09-11-2022', 'dd-mm-yyyy'), to_date('07-10-2023', 'dd-mm-yyyy'), 'Shipped', 6212834, 78035150);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (60459056, to_date('27-06-2022', 'dd-mm-yyyy'), to_date('26-11-2023', 'dd-mm-yyyy'), 'Pending', 2492971, 82838120);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (63703457, to_date('03-03-2022', 'dd-mm-yyyy'), to_date('30-04-2024', 'dd-mm-yyyy'), 'Processed', 6212834, 80277347);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (52038292, to_date('10-11-2022', 'dd-mm-yyyy'), to_date('10-01-2024', 'dd-mm-yyyy'), 'Completed', 8222269, 33410647);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (91746327, to_date('13-11-2022', 'dd-mm-yyyy'), to_date('15-01-2024', 'dd-mm-yyyy'), 'Processed', 4979177, 66406975);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (53526720, to_date('26-09-2022', 'dd-mm-yyyy'), to_date('02-04-2024', 'dd-mm-yyyy'), 'Processed', 8806216, 27778669);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (26407563, to_date('08-04-2023', 'dd-mm-yyyy'), to_date('06-08-2023', 'dd-mm-yyyy'), 'Pending', 9590539, 12569124);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (18689125, to_date('16-11-2022', 'dd-mm-yyyy'), to_date('13-08-2023', 'dd-mm-yyyy'), 'Processed', 3000498, 48944513);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (49791831, to_date('17-07-2022', 'dd-mm-yyyy'), to_date('19-07-2023', 'dd-mm-yyyy'), 'Pending', 6988264, 91960911);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (51814617, to_date('27-02-2022', 'dd-mm-yyyy'), to_date('14-01-2024', 'dd-mm-yyyy'), 'Pending', 4336892.95, 67376236);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (50988611, to_date('07-05-2022', 'dd-mm-yyyy'), to_date('04-02-2024', 'dd-mm-yyyy'), 'Shipped', 9109015, 37174955);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (40766213, to_date('08-01-2022', 'dd-mm-yyyy'), to_date('21-07-2023', 'dd-mm-yyyy'), 'Delivered', 1149469, 78035150);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (73627790, to_date('24-12-2022', 'dd-mm-yyyy'), to_date('18-03-2024', 'dd-mm-yyyy'), 'Shipped', 5414938, 33410647);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (96173469, to_date('13-05-2022', 'dd-mm-yyyy'), to_date('13-01-2024', 'dd-mm-yyyy'), 'Pending', 9986309, 57518681);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (60265062, to_date('10-03-2023', 'dd-mm-yyyy'), to_date('15-10-2023', 'dd-mm-yyyy'), 'Processed', 277334, 83705341);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (25284368, to_date('12-06-2022', 'dd-mm-yyyy'), to_date('01-09-2023', 'dd-mm-yyyy'), 'Pending', 3085044, 12007619);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (33424856, to_date('08-08-2022', 'dd-mm-yyyy'), to_date('12-05-2023', 'dd-mm-yyyy'), 'Pending', 1741848, 61074545);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (54478764, to_date('18-02-2022', 'dd-mm-yyyy'), to_date('18-01-2024', 'dd-mm-yyyy'), 'Shipped', 5443971, 84924184);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (59405013, to_date('11-11-2022', 'dd-mm-yyyy'), to_date('14-09-2023', 'dd-mm-yyyy'), 'Pending', 4273220.3, 67967662);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (93279035, to_date('08-04-2022', 'dd-mm-yyyy'), to_date('31-01-2024', 'dd-mm-yyyy'), 'Shipped', 5455001, 20147733);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (43457317, to_date('16-05-2022', 'dd-mm-yyyy'), to_date('10-01-2024', 'dd-mm-yyyy'), 'Completed', 6838649, 71520279);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (20358216, to_date('20-06-2022', 'dd-mm-yyyy'), to_date('18-04-2024', 'dd-mm-yyyy'), 'Completed', 5131765, 97932782);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (76425222, to_date('10-06-2022', 'dd-mm-yyyy'), to_date('07-04-2024', 'dd-mm-yyyy'), 'Shipped', 7034776, 78035994);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (17364972, to_date('16-09-2022', 'dd-mm-yyyy'), to_date('06-03-2024', 'dd-mm-yyyy'), 'Processed', 3460438, 83407796);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (41255654, to_date('09-05-2022', 'dd-mm-yyyy'), to_date('15-06-2023', 'dd-mm-yyyy'), 'Processed', 9363143, 50540966);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (89381130, to_date('22-10-2022', 'dd-mm-yyyy'), to_date('28-11-2023', 'dd-mm-yyyy'), 'Delivered', 9204972, 15440490);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (38379788, to_date('26-03-2023', 'dd-mm-yyyy'), to_date('16-12-2023', 'dd-mm-yyyy'), 'Processed', 1558667, 67803385);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (42291147, to_date('23-06-2022', 'dd-mm-yyyy'), to_date('26-06-2023', 'dd-mm-yyyy'), 'Delivered', 3024517, 76734097);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (18090981, to_date('22-05-2022', 'dd-mm-yyyy'), to_date('28-01-2024', 'dd-mm-yyyy'), 'Shipped', 6779644, 17009998);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (12542125, to_date('24-09-2022', 'dd-mm-yyyy'), to_date('22-01-2024', 'dd-mm-yyyy'), 'Processed', 7773492, 78818005);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (23841240, to_date('23-05-2022', 'dd-mm-yyyy'), to_date('07-11-2023', 'dd-mm-yyyy'), 'Delivered', 8133225, 19239287);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (10594141, to_date('09-02-2023', 'dd-mm-yyyy'), to_date('05-08-2023', 'dd-mm-yyyy'), 'Processed', 4026463, 94619363);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (23544731, to_date('31-12-2022', 'dd-mm-yyyy'), to_date('30-06-2023', 'dd-mm-yyyy'), 'Processed', 6113810, 62691476);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (29508837, to_date('31-08-2022', 'dd-mm-yyyy'), to_date('04-07-2023', 'dd-mm-yyyy'), 'Completed', 3801959, 28938449);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (41624014, to_date('18-02-2022', 'dd-mm-yyyy'), to_date('19-09-2023', 'dd-mm-yyyy'), 'Processed', 8138311, 94809507);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (85864060, to_date('06-04-2022', 'dd-mm-yyyy'), to_date('21-10-2023', 'dd-mm-yyyy'), 'Pending', 6369025, 87042220);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (27781281, to_date('26-03-2023', 'dd-mm-yyyy'), to_date('27-03-2024', 'dd-mm-yyyy'), 'Delivered', 2911813, 94224302);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (14099702, to_date('01-03-2022', 'dd-mm-yyyy'), to_date('03-01-2024', 'dd-mm-yyyy'), 'Delivered', 5275657, 73609023);
commit;
prompt 300 records committed...
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (83569400, to_date('23-07-2022', 'dd-mm-yyyy'), to_date('03-02-2024', 'dd-mm-yyyy'), 'Delivered', 7028864, 86160304);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (19295486, to_date('09-03-2022', 'dd-mm-yyyy'), to_date('12-02-2024', 'dd-mm-yyyy'), 'Processed', 5778795, 10909808);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (20558212, to_date('10-05-2022', 'dd-mm-yyyy'), to_date('20-05-2023', 'dd-mm-yyyy'), 'Completed', 341112, 17009998);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (23725096, to_date('14-10-2022', 'dd-mm-yyyy'), to_date('06-06-2023', 'dd-mm-yyyy'), 'Completed', 8401081, 30088287);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (55204216, to_date('28-03-2023', 'dd-mm-yyyy'), to_date('15-12-2023', 'dd-mm-yyyy'), 'Shipped', 1150843, 75706743);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (56814186, to_date('06-02-2023', 'dd-mm-yyyy'), to_date('13-10-2023', 'dd-mm-yyyy'), 'Processed', 1419835, 35270389);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (19515460, to_date('15-01-2023', 'dd-mm-yyyy'), to_date('01-09-2023', 'dd-mm-yyyy'), 'Shipped', 2492971, 94224302);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (11621396, to_date('17-01-2022', 'dd-mm-yyyy'), to_date('24-04-2024', 'dd-mm-yyyy'), 'Shipped', 7570549, 54054025);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (99481067, to_date('02-04-2022', 'dd-mm-yyyy'), to_date('28-11-2023', 'dd-mm-yyyy'), 'Delivered', 1892197, 14591687);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (52924480, to_date('02-10-2022', 'dd-mm-yyyy'), to_date('30-08-2023', 'dd-mm-yyyy'), 'Shipped', 2905250, 32258996);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (10987595, to_date('28-12-2022', 'dd-mm-yyyy'), to_date('25-03-2024', 'dd-mm-yyyy'), 'Pending', 7815036, 31768349);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (48634180, to_date('01-06-2022', 'dd-mm-yyyy'), to_date('16-01-2024', 'dd-mm-yyyy'), 'Shipped', 5726675, 79653532);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (81952885, to_date('30-01-2023', 'dd-mm-yyyy'), to_date('14-11-2023', 'dd-mm-yyyy'), 'Pending', 8222269, 60556468);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (22234324, to_date('24-02-2023', 'dd-mm-yyyy'), to_date('23-01-2024', 'dd-mm-yyyy'), 'Shipped', 8138311, 34560332);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (24348217, to_date('30-03-2023', 'dd-mm-yyyy'), to_date('18-10-2023', 'dd-mm-yyyy'), 'Delivered', 8133225, 52789268);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (79958108, to_date('17-02-2022', 'dd-mm-yyyy'), to_date('26-10-2023', 'dd-mm-yyyy'), 'Delivered', 4661814, 10894359);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (13678080, to_date('08-03-2022', 'dd-mm-yyyy'), to_date('27-03-2024', 'dd-mm-yyyy'), 'Processed', 8844664, 33387429);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (68682772, to_date('26-08-2022', 'dd-mm-yyyy'), to_date('02-10-2023', 'dd-mm-yyyy'), 'Shipped', 3990552, 68406461);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (73879529, to_date('03-04-2023', 'dd-mm-yyyy'), to_date('07-04-2024', 'dd-mm-yyyy'), 'Delivered', 1149469, 24659641);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (81653079, to_date('25-06-2022', 'dd-mm-yyyy'), to_date('03-04-2024', 'dd-mm-yyyy'), 'Shipped', 3584148, 64347421);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (59072138, to_date('21-04-2022', 'dd-mm-yyyy'), to_date('02-03-2024', 'dd-mm-yyyy'), 'Pending', 9429225, 69009658);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (13175349, to_date('05-08-2022', 'dd-mm-yyyy'), to_date('02-02-2024', 'dd-mm-yyyy'), 'Completed', 7953907, 19369145);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (57631041, to_date('16-01-2023', 'dd-mm-yyyy'), to_date('05-01-2024', 'dd-mm-yyyy'), 'Shipped', 768425, 95826413);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (65395727, to_date('24-12-2022', 'dd-mm-yyyy'), to_date('19-04-2024', 'dd-mm-yyyy'), 'Completed', 6276980, 73929631);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (60607678, to_date('27-04-2023', 'dd-mm-yyyy'), to_date('21-09-2023', 'dd-mm-yyyy'), 'Delivered', 1149469, 58196781);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (74352681, to_date('14-01-2022', 'dd-mm-yyyy'), to_date('02-03-2024', 'dd-mm-yyyy'), 'Pending', 7304625, 90755223);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (92248639, to_date('31-05-2022', 'dd-mm-yyyy'), to_date('01-10-2023', 'dd-mm-yyyy'), 'Processed', 7934472, 54804747);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (48632896, to_date('04-12-2022', 'dd-mm-yyyy'), to_date('31-01-2024', 'dd-mm-yyyy'), 'Pending', 3712427, 66586949);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (87913132, to_date('03-02-2022', 'dd-mm-yyyy'), to_date('27-09-2023', 'dd-mm-yyyy'), 'Completed', 4836886, 86160304);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (74624489, to_date('28-04-2022', 'dd-mm-yyyy'), to_date('21-05-2023', 'dd-mm-yyyy'), 'Completed', 1760875, 64347421);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (52737198, to_date('30-05-2022', 'dd-mm-yyyy'), to_date('08-03-2024', 'dd-mm-yyyy'), 'Completed', 8332462, 98048623);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (92626590, to_date('11-09-2022', 'dd-mm-yyyy'), to_date('28-06-2023', 'dd-mm-yyyy'), 'Shipped', 4454137, 58740743);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (87372983, to_date('04-01-2022', 'dd-mm-yyyy'), to_date('30-03-2024', 'dd-mm-yyyy'), 'Shipped', 664031, 11250240);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (33865478, to_date('04-05-2022', 'dd-mm-yyyy'), to_date('18-08-2023', 'dd-mm-yyyy'), 'Completed', 6838649, 73609023);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (85552036, to_date('06-03-2023', 'dd-mm-yyyy'), to_date('18-03-2024', 'dd-mm-yyyy'), 'Processed', 2766097, 53805635);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (25058168, to_date('26-01-2022', 'dd-mm-yyyy'), to_date('05-03-2024', 'dd-mm-yyyy'), 'Shipped', 2015258, 38628579);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (88543737, to_date('19-02-2023', 'dd-mm-yyyy'), to_date('17-09-2023', 'dd-mm-yyyy'), 'Pending', 1163402, 71044320);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (80116471, to_date('30-04-2023', 'dd-mm-yyyy'), to_date('19-10-2023', 'dd-mm-yyyy'), 'Pending', 8364760, 79653532);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (77853247, to_date('31-03-2023', 'dd-mm-yyyy'), to_date('14-05-2023', 'dd-mm-yyyy'), 'Delivered', 8332462, 30088287);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (24851597, to_date('13-04-2022', 'dd-mm-yyyy'), to_date('21-02-2024', 'dd-mm-yyyy'), 'Shipped', 8148685, 71430184);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (59217071, to_date('20-11-2022', 'dd-mm-yyyy'), to_date('24-06-2023', 'dd-mm-yyyy'), 'Delivered', 1760875, 98149767);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (79800701, to_date('25-09-2022', 'dd-mm-yyyy'), to_date('28-03-2024', 'dd-mm-yyyy'), 'Completed', 6424098, 19369145);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (95101529, to_date('05-10-2022', 'dd-mm-yyyy'), to_date('27-12-2023', 'dd-mm-yyyy'), 'Processed', 8420976, 48270369);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (93966237, to_date('04-05-2022', 'dd-mm-yyyy'), to_date('22-04-2024', 'dd-mm-yyyy'), 'Delivered', 6834952, 83979292);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (56270335, to_date('28-12-2022', 'dd-mm-yyyy'), to_date('06-06-2023', 'dd-mm-yyyy'), 'Completed', 500401, 50095158);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (70103784, to_date('19-12-2022', 'dd-mm-yyyy'), to_date('09-07-2023', 'dd-mm-yyyy'), 'Processed', 171592, 89289435);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (41470462, to_date('14-03-2023', 'dd-mm-yyyy'), to_date('05-10-2023', 'dd-mm-yyyy'), 'Shipped', 7545422, 83407796);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (19923947, to_date('18-08-2022', 'dd-mm-yyyy'), to_date('12-07-2023', 'dd-mm-yyyy'), 'Delivered', 7472682, 67967662);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (13655348, to_date('24-03-2023', 'dd-mm-yyyy'), to_date('18-08-2023', 'dd-mm-yyyy'), 'Processed', 1536028, 88079734);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (48323552, to_date('01-04-2023', 'dd-mm-yyyy'), to_date('16-03-2024', 'dd-mm-yyyy'), 'Pending', 9670086, 69009658);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (22908574, to_date('19-10-2022', 'dd-mm-yyyy'), to_date('18-03-2024', 'dd-mm-yyyy'), 'Processed', 2729307, 97106558);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (78226785, to_date('20-03-2023', 'dd-mm-yyyy'), to_date('03-06-2023', 'dd-mm-yyyy'), 'Processed', 7273772, 12884915);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (38411452, to_date('12-09-2022', 'dd-mm-yyyy'), to_date('23-06-2023', 'dd-mm-yyyy'), 'Pending', 9204972, 96703276);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (29679569, to_date('19-01-2023', 'dd-mm-yyyy'), to_date('04-11-2023', 'dd-mm-yyyy'), 'Pending', 1577529, 35270389);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (46120475, to_date('16-10-2022', 'dd-mm-yyyy'), to_date('30-07-2023', 'dd-mm-yyyy'), 'Completed', 4857774, 54563648);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (76272049, to_date('10-05-2022', 'dd-mm-yyyy'), to_date('17-06-2023', 'dd-mm-yyyy'), 'Pending', 3625906, 79223054);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (65842394, to_date('11-02-2022', 'dd-mm-yyyy'), to_date('02-01-2024', 'dd-mm-yyyy'), 'Delivered', 4934985, 22848358);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (68774075, to_date('13-02-2022', 'dd-mm-yyyy'), to_date('14-09-2023', 'dd-mm-yyyy'), 'Processed', 3553936, 83896964);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (21598115, to_date('26-04-2023', 'dd-mm-yyyy'), to_date('28-03-2024', 'dd-mm-yyyy'), 'Delivered', 8276179, 60533897);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (14955002, to_date('19-06-2022', 'dd-mm-yyyy'), to_date('05-04-2024', 'dd-mm-yyyy'), 'Processed', 7586434, 79653532);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (61010625, to_date('11-01-2023', 'dd-mm-yyyy'), to_date('31-08-2023', 'dd-mm-yyyy'), 'Completed', 5560516, 11519494);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (41455423, to_date('12-10-2022', 'dd-mm-yyyy'), to_date('13-11-2023', 'dd-mm-yyyy'), 'Pending', 6252751, 78139447);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (72675369, to_date('24-09-2022', 'dd-mm-yyyy'), to_date('17-06-2023', 'dd-mm-yyyy'), 'Delivered', 7472682, 99272709);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (23850560, to_date('09-02-2023', 'dd-mm-yyyy'), to_date('23-03-2024', 'dd-mm-yyyy'), 'Delivered', 7867408, 73016023);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (58495697, to_date('15-08-2022', 'dd-mm-yyyy'), to_date('23-07-2023', 'dd-mm-yyyy'), 'Completed', 6307622, 15383022);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (61050698, to_date('22-03-2023', 'dd-mm-yyyy'), to_date('22-10-2023', 'dd-mm-yyyy'), 'Shipped', 824473, 72074362);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (22310745, to_date('16-05-2022', 'dd-mm-yyyy'), to_date('28-10-2023', 'dd-mm-yyyy'), 'Processed', 4835096, 62691476);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (59313687, to_date('15-09-2022', 'dd-mm-yyyy'), to_date('12-02-2024', 'dd-mm-yyyy'), 'Delivered', 1013455, 60533897);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (71575648, to_date('08-02-2023', 'dd-mm-yyyy'), to_date('14-09-2023', 'dd-mm-yyyy'), 'Processed', 6837365, 97932782);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (28556162, to_date('06-08-2022', 'dd-mm-yyyy'), to_date('09-07-2023', 'dd-mm-yyyy'), 'Pending', 9356189, 47129256);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (41035537, to_date('10-03-2023', 'dd-mm-yyyy'), to_date('12-01-2024', 'dd-mm-yyyy'), 'Completed', 6369025, 72074362);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (83336594, to_date('12-06-2022', 'dd-mm-yyyy'), to_date('04-09-2023', 'dd-mm-yyyy'), 'Completed', 7815036, 48944513);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (24987475, to_date('02-01-2022', 'dd-mm-yyyy'), to_date('22-09-2023', 'dd-mm-yyyy'), 'Completed', 9491417, 47222423);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (41757137, to_date('15-03-2023', 'dd-mm-yyyy'), to_date('19-11-2023', 'dd-mm-yyyy'), 'Processed', 9167629, 15383022);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (73528794, to_date('13-08-2022', 'dd-mm-yyyy'), to_date('27-11-2023', 'dd-mm-yyyy'), 'Pending', 9080071, 55036429);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (92484792, to_date('13-08-2022', 'dd-mm-yyyy'), to_date('25-06-2023', 'dd-mm-yyyy'), 'Processed', 9172030, 97385354);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (75117457, to_date('09-03-2022', 'dd-mm-yyyy'), to_date('26-09-2023', 'dd-mm-yyyy'), 'Delivered', 4661814, 62691476);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (32605534, to_date('06-03-2022', 'dd-mm-yyyy'), to_date('15-09-2023', 'dd-mm-yyyy'), 'Processed', 4479408, 41524549);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (74899684, to_date('30-06-2022', 'dd-mm-yyyy'), to_date('14-03-2024', 'dd-mm-yyyy'), 'Completed', 4606594, 66802431);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (98476811, to_date('21-10-2022', 'dd-mm-yyyy'), to_date('26-10-2023', 'dd-mm-yyyy'), 'Delivered', 9168209, 38685099);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (88216978, to_date('22-03-2022', 'dd-mm-yyyy'), to_date('30-08-2023', 'dd-mm-yyyy'), 'Delivered', 6314307, 98422837);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (64591321, to_date('14-02-2023', 'dd-mm-yyyy'), to_date('06-09-2023', 'dd-mm-yyyy'), 'Completed', 6424098, 66648742);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (41832458, to_date('29-08-2022', 'dd-mm-yyyy'), to_date('04-02-2024', 'dd-mm-yyyy'), 'Processed', 2905250, 73195846);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (30694864, to_date('21-01-2023', 'dd-mm-yyyy'), to_date('04-10-2023', 'dd-mm-yyyy'), 'Delivered', 3986085, 26655402);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (46777945, to_date('14-12-2022', 'dd-mm-yyyy'), to_date('15-10-2023', 'dd-mm-yyyy'), 'Processed', 4661814, 15440490);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (46411065, to_date('01-05-2022', 'dd-mm-yyyy'), to_date('05-01-2024', 'dd-mm-yyyy'), 'Delivered', 4857774, 57730914);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (1001, to_date('01-05-2024', 'dd-mm-yyyy'), to_date('05-05-2024', 'dd-mm-yyyy'), 'Shipped', 150, 12134353);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (1002, to_date('03-05-2024', 'dd-mm-yyyy'), to_date('10-05-2024', 'dd-mm-yyyy'), 'Processing', 200, 23894729);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (1003, to_date('05-05-2024', 'dd-mm-yyyy'), to_date('12-05-2024', 'dd-mm-yyyy'), 'Delivered', 300, 87432904);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (1004, to_date('07-05-2024', 'dd-mm-yyyy'), to_date('15-05-2024', 'dd-mm-yyyy'), 'Canceled', 400, 56290837);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (1005, to_date('09-05-2024', 'dd-mm-yyyy'), to_date('17-05-2024', 'dd-mm-yyyy'), 'Returned', 250, 34789012);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (1006, to_date('11-05-2024', 'dd-mm-yyyy'), to_date('18-05-2024', 'dd-mm-yyyy'), 'Shipped', 350, 90875634);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (1008, to_date('15-05-2024', 'dd-mm-yyyy'), to_date('22-05-2024', 'dd-mm-yyyy'), 'Delivered', 500, 45329087);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (1009, to_date('17-05-2024', 'dd-mm-yyyy'), to_date('24-05-2024', 'dd-mm-yyyy'), 'Shipped', 600, 12983475);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (1010, to_date('19-05-2024', 'dd-mm-yyyy'), to_date('26-05-2024', 'dd-mm-yyyy'), 'Processing', 700, 76348219);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (1, to_date('29-03-2023', 'dd-mm-yyyy'), to_date('08-06-2023', 'dd-mm-yyyy'), 'delivered', 8408, 1);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (3, to_date('12-02-2023', 'dd-mm-yyyy'), to_date('20-12-2023', 'dd-mm-yyyy'), 'pending', 3439, 3);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (4, to_date('19-02-2023', 'dd-mm-yyyy'), to_date('10-03-2024', 'dd-mm-yyyy'), 'delayed', 2097, 4);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (5, to_date('17-08-2022', 'dd-mm-yyyy'), to_date('16-12-2023', 'dd-mm-yyyy'), 'delayed', 6678, 5);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (6, to_date('15-01-2023', 'dd-mm-yyyy'), to_date('20-07-2023', 'dd-mm-yyyy'), 'delivered', 2922, 6);
commit;
prompt 400 records committed...
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (7, to_date('16-12-2022', 'dd-mm-yyyy'), to_date('03-04-2024', 'dd-mm-yyyy'), 'pending', 2395, 7);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (8, to_date('25-12-2022', 'dd-mm-yyyy'), to_date('31-10-2023', 'dd-mm-yyyy'), 'delayed', 8115, 8);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (9, to_date('24-11-2022', 'dd-mm-yyyy'), to_date('02-06-2023', 'dd-mm-yyyy'), 'pending', 4292, 9);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (10, to_date('03-12-2022', 'dd-mm-yyyy'), to_date('14-04-2024', 'dd-mm-yyyy'), 'out for delivery', 3607, 10);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (11, to_date('22-12-2022', 'dd-mm-yyyy'), to_date('23-01-2024', 'dd-mm-yyyy'), 'delayed', 1446, 11);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (12, to_date('14-05-2023', 'dd-mm-yyyy'), to_date('06-07-2023', 'dd-mm-yyyy'), 'delayed', 3308, 12);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (13, to_date('24-10-2022', 'dd-mm-yyyy'), to_date('23-10-2023', 'dd-mm-yyyy'), 'out for delivery', 4279, 13);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (14, to_date('22-05-2022', 'dd-mm-yyyy'), to_date('05-11-2023', 'dd-mm-yyyy'), 'delivered', 3223, 14);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (15, to_date('23-12-2022', 'dd-mm-yyyy'), to_date('10-11-2023', 'dd-mm-yyyy'), 'delayed', 7729, 15);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (16, to_date('10-02-2023', 'dd-mm-yyyy'), to_date('22-01-2024', 'dd-mm-yyyy'), 'out for delivery', 9979, 16);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (17, to_date('04-09-2022', 'dd-mm-yyyy'), to_date('18-08-2023', 'dd-mm-yyyy'), 'out for delivery', 4579, 17);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (18, to_date('19-04-2023', 'dd-mm-yyyy'), to_date('19-09-2023', 'dd-mm-yyyy'), 'out for delivery', 7662, 18);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (19, to_date('18-04-2023', 'dd-mm-yyyy'), to_date('27-12-2023', 'dd-mm-yyyy'), 'delivered', 3951, 19);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (20, to_date('31-12-2022', 'dd-mm-yyyy'), to_date('18-08-2023', 'dd-mm-yyyy'), 'delivered', 8747, 20);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (21, to_date('01-11-2022', 'dd-mm-yyyy'), to_date('09-03-2024', 'dd-mm-yyyy'), 'delivered', 5261, 21);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (22, to_date('21-07-2022', 'dd-mm-yyyy'), to_date('19-09-2023', 'dd-mm-yyyy'), 'delayed', 8424, 22);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (23, to_date('05-03-2023', 'dd-mm-yyyy'), to_date('20-01-2024', 'dd-mm-yyyy'), 'pending', 7792, 23);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (24, to_date('04-03-2023', 'dd-mm-yyyy'), to_date('15-05-2024', 'dd-mm-yyyy'), 'delivered', 9364, 24);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (25, to_date('07-06-2022', 'dd-mm-yyyy'), to_date('03-10-2023', 'dd-mm-yyyy'), 'out for delivery', 6192, 25);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (26, to_date('04-09-2022', 'dd-mm-yyyy'), to_date('12-08-2023', 'dd-mm-yyyy'), 'delayed', 5355, 26);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (27, to_date('18-01-2023', 'dd-mm-yyyy'), to_date('03-12-2023', 'dd-mm-yyyy'), 'delivered', 5552, 27);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (28, to_date('13-12-2022', 'dd-mm-yyyy'), to_date('25-09-2023', 'dd-mm-yyyy'), 'out for delivery', 1164, 28);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (29, to_date('14-02-2023', 'dd-mm-yyyy'), to_date('14-03-2024', 'dd-mm-yyyy'), 'pending', 9153, 29);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (30, to_date('02-04-2023', 'dd-mm-yyyy'), to_date('16-08-2023', 'dd-mm-yyyy'), 'out for delivery', 5459, 30);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (31, to_date('14-08-2022', 'dd-mm-yyyy'), to_date('06-03-2024', 'dd-mm-yyyy'), 'pending', 7143, 31);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (32, to_date('03-12-2022', 'dd-mm-yyyy'), to_date('20-02-2024', 'dd-mm-yyyy'), 'delayed', 8174, 32);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (33, to_date('04-05-2023', 'dd-mm-yyyy'), to_date('03-08-2023', 'dd-mm-yyyy'), 'delayed', 4239, 33);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (34, to_date('26-10-2022', 'dd-mm-yyyy'), to_date('23-08-2023', 'dd-mm-yyyy'), 'out for delivery', 7967, 34);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (35, to_date('23-09-2022', 'dd-mm-yyyy'), to_date('25-06-2023', 'dd-mm-yyyy'), 'pending', 5335, 35);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (36, to_date('22-02-2023', 'dd-mm-yyyy'), to_date('12-09-2023', 'dd-mm-yyyy'), 'delayed', 6352, 36);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (37, to_date('10-09-2022', 'dd-mm-yyyy'), to_date('12-01-2024', 'dd-mm-yyyy'), 'pending', 4611, 37);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (38, to_date('23-08-2022', 'dd-mm-yyyy'), to_date('27-06-2023', 'dd-mm-yyyy'), 'out for delivery', 1703, 38);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (39, to_date('30-10-2022', 'dd-mm-yyyy'), to_date('23-06-2023', 'dd-mm-yyyy'), 'delayed', 5368, 39);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (40, to_date('05-02-2023', 'dd-mm-yyyy'), to_date('16-05-2024', 'dd-mm-yyyy'), 'out for delivery', 3238, 40);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (41, to_date('05-10-2022', 'dd-mm-yyyy'), to_date('05-05-2024', 'dd-mm-yyyy'), 'pending', 1479, 41);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (42, to_date('29-08-2022', 'dd-mm-yyyy'), to_date('04-09-2023', 'dd-mm-yyyy'), 'pending', 6457, 42);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (43, to_date('14-06-2022', 'dd-mm-yyyy'), to_date('26-09-2023', 'dd-mm-yyyy'), 'pending', 1784, 43);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (44, to_date('01-08-2022', 'dd-mm-yyyy'), to_date('23-10-2023', 'dd-mm-yyyy'), 'delivered', 2823, 44);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (45, to_date('04-01-2023', 'dd-mm-yyyy'), to_date('02-03-2024', 'dd-mm-yyyy'), 'delayed', 6936, 45);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (46, to_date('28-08-2022', 'dd-mm-yyyy'), to_date('03-12-2023', 'dd-mm-yyyy'), 'delayed', 4774, 46);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (47, to_date('07-05-2023', 'dd-mm-yyyy'), to_date('20-04-2024', 'dd-mm-yyyy'), 'delivered', 3432, 47);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (48, to_date('09-08-2022', 'dd-mm-yyyy'), to_date('06-11-2023', 'dd-mm-yyyy'), 'delivered', 1804, 48);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (49, to_date('19-09-2022', 'dd-mm-yyyy'), to_date('25-07-2023', 'dd-mm-yyyy'), 'pending', 2983, 49);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (50, to_date('26-09-2022', 'dd-mm-yyyy'), to_date('17-01-2024', 'dd-mm-yyyy'), 'pending', 7677, 50);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (51, to_date('13-04-2023', 'dd-mm-yyyy'), to_date('07-11-2023', 'dd-mm-yyyy'), 'pending', 6564, 51);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (52, to_date('27-11-2022', 'dd-mm-yyyy'), to_date('26-11-2023', 'dd-mm-yyyy'), 'delayed', 5813, 52);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (53, to_date('12-07-2022', 'dd-mm-yyyy'), to_date('29-01-2024', 'dd-mm-yyyy'), 'delivered', 7082, 53);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (54, to_date('14-10-2022', 'dd-mm-yyyy'), to_date('08-09-2023', 'dd-mm-yyyy'), 'delayed', 5105, 54);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (55, to_date('08-11-2022', 'dd-mm-yyyy'), to_date('13-09-2023', 'dd-mm-yyyy'), 'delayed', 1962, 55);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (56, to_date('12-10-2022', 'dd-mm-yyyy'), to_date('21-05-2023', 'dd-mm-yyyy'), 'out for delivery', 7788, 56);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (57, to_date('02-02-2023', 'dd-mm-yyyy'), to_date('26-12-2023', 'dd-mm-yyyy'), 'delivered', 1246, 57);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (58, to_date('07-06-2022', 'dd-mm-yyyy'), to_date('23-09-2023', 'dd-mm-yyyy'), 'delivered', 1194, 58);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (59, to_date('25-09-2022', 'dd-mm-yyyy'), to_date('03-11-2023', 'dd-mm-yyyy'), 'delivered', 2404, 59);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (60, to_date('30-08-2022', 'dd-mm-yyyy'), to_date('21-04-2024', 'dd-mm-yyyy'), 'pending', 7968, 60);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (61, to_date('23-09-2022', 'dd-mm-yyyy'), to_date('05-02-2024', 'dd-mm-yyyy'), 'out for delivery', 7840, 61);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (63, to_date('21-05-2022', 'dd-mm-yyyy'), to_date('13-08-2023', 'dd-mm-yyyy'), 'out for delivery', 6069, 63);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (64, to_date('04-05-2023', 'dd-mm-yyyy'), to_date('11-02-2024', 'dd-mm-yyyy'), 'pending', 2075, 64);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (65, to_date('11-06-2022', 'dd-mm-yyyy'), to_date('03-12-2023', 'dd-mm-yyyy'), 'delayed', 6769, 65);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (66, to_date('04-09-2022', 'dd-mm-yyyy'), to_date('27-07-2023', 'dd-mm-yyyy'), 'delayed', 1696, 66);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (67, to_date('05-11-2022', 'dd-mm-yyyy'), to_date('16-11-2023', 'dd-mm-yyyy'), 'delivered', 9502, 67);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (68, to_date('06-04-2023', 'dd-mm-yyyy'), to_date('01-05-2024', 'dd-mm-yyyy'), 'delivered', 1797, 68);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (69, to_date('07-04-2023', 'dd-mm-yyyy'), to_date('22-07-2023', 'dd-mm-yyyy'), 'delivered', 4134, 69);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (70, to_date('16-04-2023', 'dd-mm-yyyy'), to_date('02-02-2024', 'dd-mm-yyyy'), 'out for delivery', 7679, 70);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (71, to_date('08-10-2022', 'dd-mm-yyyy'), to_date('09-03-2024', 'dd-mm-yyyy'), 'pending', 3504, 71);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (72, to_date('27-06-2022', 'dd-mm-yyyy'), to_date('13-09-2023', 'dd-mm-yyyy'), 'pending', 2593, 72);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (73, to_date('17-09-2022', 'dd-mm-yyyy'), to_date('16-12-2023', 'dd-mm-yyyy'), 'out for delivery', 8695, 73);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (74, to_date('15-09-2022', 'dd-mm-yyyy'), to_date('01-01-2024', 'dd-mm-yyyy'), 'delivered', 6731, 74);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (75, to_date('22-05-2022', 'dd-mm-yyyy'), to_date('09-11-2023', 'dd-mm-yyyy'), 'delayed', 2067, 75);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (76, to_date('04-07-2022', 'dd-mm-yyyy'), to_date('08-01-2024', 'dd-mm-yyyy'), 'out for delivery', 5309, 76);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (77, to_date('31-10-2022', 'dd-mm-yyyy'), to_date('26-08-2023', 'dd-mm-yyyy'), 'pending', 6957, 77);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (78, to_date('11-09-2022', 'dd-mm-yyyy'), to_date('14-08-2023', 'dd-mm-yyyy'), 'delayed', 5853, 78);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (79, to_date('18-09-2022', 'dd-mm-yyyy'), to_date('05-11-2023', 'dd-mm-yyyy'), 'delayed', 1477, 79);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (80, to_date('12-10-2022', 'dd-mm-yyyy'), to_date('05-11-2023', 'dd-mm-yyyy'), 'delayed', 2712, 80);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (81, to_date('17-04-2023', 'dd-mm-yyyy'), to_date('24-11-2023', 'dd-mm-yyyy'), 'delivered', 3186, 81);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (82, to_date('29-10-2022', 'dd-mm-yyyy'), to_date('11-11-2023', 'dd-mm-yyyy'), 'delayed', 7955, 82);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (83, to_date('28-02-2023', 'dd-mm-yyyy'), to_date('11-12-2023', 'dd-mm-yyyy'), 'delivered', 2382, 83);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (84, to_date('19-09-2022', 'dd-mm-yyyy'), to_date('17-08-2023', 'dd-mm-yyyy'), 'pending', 4617, 84);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (85, to_date('17-07-2022', 'dd-mm-yyyy'), to_date('12-09-2023', 'dd-mm-yyyy'), 'delivered', 6402, 85);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (86, to_date('30-07-2022', 'dd-mm-yyyy'), to_date('13-04-2024', 'dd-mm-yyyy'), 'pending', 1172, 86);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (87, to_date('23-05-2022', 'dd-mm-yyyy'), to_date('07-04-2024', 'dd-mm-yyyy'), 'delivered', 5272, 87);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (88, to_date('02-06-2022', 'dd-mm-yyyy'), to_date('20-02-2024', 'dd-mm-yyyy'), 'out for delivery', 2984, 88);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (89, to_date('07-08-2022', 'dd-mm-yyyy'), to_date('18-07-2023', 'dd-mm-yyyy'), 'delivered', 5215, 89);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (90, to_date('04-06-2022', 'dd-mm-yyyy'), to_date('25-10-2023', 'dd-mm-yyyy'), 'delayed', 1104, 90);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (91, to_date('11-11-2022', 'dd-mm-yyyy'), to_date('11-11-2023', 'dd-mm-yyyy'), 'delayed', 3036, 91);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (92, to_date('13-09-2022', 'dd-mm-yyyy'), to_date('31-01-2024', 'dd-mm-yyyy'), 'delayed', 4459, 92);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (93, to_date('28-07-2022', 'dd-mm-yyyy'), to_date('03-09-2023', 'dd-mm-yyyy'), 'delivered', 4018, 93);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (94, to_date('21-02-2023', 'dd-mm-yyyy'), to_date('03-08-2023', 'dd-mm-yyyy'), 'delayed', 3786, 94);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (95, to_date('29-03-2023', 'dd-mm-yyyy'), to_date('29-11-2023', 'dd-mm-yyyy'), 'delayed', 5324, 95);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (96, to_date('30-05-2022', 'dd-mm-yyyy'), to_date('22-04-2024', 'dd-mm-yyyy'), 'delayed', 2498, 96);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (97, to_date('15-04-2023', 'dd-mm-yyyy'), to_date('06-05-2024', 'dd-mm-yyyy'), 'pending', 1492, 97);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (98, to_date('14-05-2023', 'dd-mm-yyyy'), to_date('21-11-2023', 'dd-mm-yyyy'), 'delivered', 6335, 98);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (99, to_date('08-09-2022', 'dd-mm-yyyy'), to_date('17-10-2023', 'dd-mm-yyyy'), 'delayed', 6417, 99);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (100, to_date('30-11-2022', 'dd-mm-yyyy'), to_date('13-12-2023', 'dd-mm-yyyy'), 'delayed', 4400, 100);
commit;
prompt 493 records loaded
prompt Loading PRODUCT...
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (84527812, 'S-400 Missile System', 'Defense Systems', 8625674.87, 'Comprehensive protection and surveillance', 175024);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (23302061, 'S-400 Missile System', 'Defense Systems', 200303.52, 'High-precision targeting for aerial threats', 78772);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (29596685, 'Iron Dome', 'Anti-Tank Missiles', 9797086, 'High-precision targeting for aerial threats', 989704);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (55562290, 'S-400 Missile System', 'Defense Systems', 11653010.55, 'Armor-penetrating capability for ground targets', 315682);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (75670548, 'S-400 Missile System', 'Anti-Tank Missiles', 747810, 'Comprehensive protection and surveillance', 7489);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (74060004, 'Iron Dome', 'Surface-to-Air Missiles', 6509979, 'High-precision targeting for aerial threats', 269167);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (90148050, 'SM-6 (Standard Missile-6)', 'Surface-to-Air Missiles', 1406976, 'High-precision targeting for aerial threats', 402780);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (67385751, 'Aegis Combat System', 'Defense Systems', 9942930.04, 'Armor-penetrating capability for ground targets', 601186);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (62524908, 'Aegis Combat System', 'Surface-to-Air Missiles', 1558708, 'High-precision targeting for aerial threats', 917458);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (29534322, 'Iron Dome', 'Anti-Tank Missiles', 9924260, 'High-precision targeting for aerial threats', 624949);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (95710423, 'Hellfire Missile', 'Surface-to-Air Missiles', 725830, 'Comprehensive protection and surveillance', 300150);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (50701261, 'Hellfire Missile', 'Defense Systems', 7479780.9, 'High-precision targeting for aerial threats', 273969);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (60227306, 'Harpoon Missile', 'Anti-Tank Missiles', 7273772, 'Armor-penetrating capability for ground targets', 168354);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (58362577, 'Patriot Missile System', 'Anti-Tank Missiles', 9974448, 'Armor-penetrating capability for ground targets', 126781);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (83460337, 'Stinger Missile', 'Anti-Tank Missiles', 5735856, 'High-precision targeting for aerial threats', 621535);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (76293906, 'Iron Dome', 'Defense Systems', 8200302.58, 'Armor-penetrating capability for ground targets', 440454);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (52860099, 'Iron Dome', 'Anti-Tank Missiles', 8220901, 'Armor-penetrating capability for ground targets', 183327);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (91685383, 'THAAD (Terminal High Altitude Area Defense)', 'Anti-Tank Missiles', 7053548, 'High-precision targeting for aerial threats', 396009);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (24508042, 'S-400 Missile System', 'Surface-to-Air Missiles', 1339105, 'Comprehensive protection and surveillance', 900956);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (83008461, 'THAAD (Terminal High Altitude Area Defense)', 'Defense Systems', 11505486.37, 'High-precision targeting for aerial threats', 8884);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (30949123, 'Aegis Combat System', 'Surface-to-Air Missiles', 8457109, 'High-precision targeting for aerial threats', 680022);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (63790937, 'Hellfire Missile', 'Defense Systems', 6756945.95, 'Comprehensive protection and surveillance', 407557);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (54698281, 'SM-6 (Standard Missile-6)', 'Surface-to-Air Missiles', 4468212, 'Comprehensive protection and surveillance', 182750);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (19956426, 'SM-6 (Standard Missile-6)', 'Defense Systems', 5154823.77, 'Comprehensive protection and surveillance', 433463);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (56326978, 'Aegis Combat System', 'Defense Systems', 10012466, 'High-precision targeting for aerial threats', 867847);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (90884548, 'Stinger Missile', 'Surface-to-Air Missiles', 2154152, 'Comprehensive protection and surveillance', 765318);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (58536080, 'Hellfire Missile', 'Surface-to-Air Missiles', 5865889, 'High-precision targeting for aerial threats', 84);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (16848056, 'Stinger Missile', 'Defense Systems', 2550239.66, 'Comprehensive protection and surveillance', 20993);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (40121307, 'Javelin Missile', 'Defense Systems', 5065607.38, 'Comprehensive protection and surveillance', 707732);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (47983175, 'S-400 Missile System', 'Surface-to-Air Missiles', 8607218, 'Comprehensive protection and surveillance', 540040);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (46237521, 'Patriot Missile System', 'Defense Systems', 9565211.27, 'Armor-penetrating capability for ground targets', 415971);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (42449391, 'Iron Dome', 'Surface-to-Air Missiles', 5773511, 'High-precision targeting for aerial threats', 800017);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (43868080, 'Iron Dome', 'Anti-Tank Missiles', 1760875, 'Armor-penetrating capability for ground targets', 234401);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (73934948, 'Stinger Missile', 'Defense Systems', 10059369.91, 'Comprehensive protection and surveillance', 669721);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (63905530, 'Stinger Missile', 'Surface-to-Air Missiles', 346392, 'Armor-penetrating capability for ground targets', 126785);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (41164290, 'Harpoon Missile', 'Surface-to-Air Missiles', 9969048, 'High-precision targeting for aerial threats', 952461);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (23749871, 'Harpoon Missile', 'Defense Systems', 9229402.37, 'Comprehensive protection and surveillance', 941134);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (24563711, 'Stinger Missile', 'Anti-Tank Missiles', 8038187, 'Comprehensive protection and surveillance', 922497);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (86830652, 'SM-6 (Standard Missile-6)', 'Anti-Tank Missiles', 1842955, 'High-precision targeting for aerial threats', 628279);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (97741459, 'Aegis Combat System', 'Anti-Tank Missiles', 7304625, 'Comprehensive protection and surveillance', 807770);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (97959143, 'Javelin Missile', 'Surface-to-Air Missiles', 6318045, 'Comprehensive protection and surveillance', 227035);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (33938543, 'Stinger Missile', 'Anti-Tank Missiles', 7256650, 'High-precision targeting for aerial threats', 422037);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (75916838, 'Javelin Missile', 'Anti-Tank Missiles', 375800, 'Comprehensive protection and surveillance', 444099);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (90106486, 'Patriot Missile System', 'Surface-to-Air Missiles', 7419752, 'High-precision targeting for aerial threats', 399556);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (77186529, 'S-400 Missile System', 'Defense Systems', 6462594.5, 'Comprehensive protection and surveillance', 906794);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (23768294, 'Harpoon Missile', 'Anti-Tank Missiles', 9501093, 'Armor-penetrating capability for ground targets', 735427);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (17232221, 'Harpoon Missile', 'Defense Systems', 13084158.05, 'Armor-penetrating capability for ground targets', 416798);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (90318867, 'Iron Dome', 'Anti-Tank Missiles', 5776471, 'Comprehensive protection and surveillance', 584729);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (58234110, 'Iron Dome', 'Surface-to-Air Missiles', 1365922, 'Comprehensive protection and surveillance', 782959);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (50921118, 'THAAD (Terminal High Altitude Area Defense)', 'Anti-Tank Missiles', 6468186, 'High-precision targeting for aerial threats', 523565);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (34684902, 'THAAD (Terminal High Altitude Area Defense)', 'Defense Systems', 14125686.58, 'Comprehensive protection and surveillance', 61355);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (73654044, 'S-400 Missile System', 'Surface-to-Air Missiles', 2937280, 'Armor-penetrating capability for ground targets', 725147);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (10753700, 'THAAD (Terminal High Altitude Area Defense)', 'Surface-to-Air Missiles', 6262888, 'High-precision targeting for aerial threats', 280692);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (53069001, 'Iron Dome', 'Defense Systems', 5253997.52, 'Comprehensive protection and surveillance', 754051);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (35823728, 'THAAD (Terminal High Altitude Area Defense)', 'Anti-Tank Missiles', 3823965, 'High-precision targeting for aerial threats', 981188);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (15810430, 'THAAD (Terminal High Altitude Area Defense)', 'Anti-Tank Missiles', 4661814, 'Comprehensive protection and surveillance', 931751);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (67110125, 'Hellfire Missile', 'Defense Systems', 3995978.38, 'Armor-penetrating capability for ground targets', 145046);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (72457291, 'SM-6 (Standard Missile-6)', 'Surface-to-Air Missiles', 8057818, 'Armor-penetrating capability for ground targets', 476577);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (60764074, 'THAAD (Terminal High Altitude Area Defense)', 'Anti-Tank Missiles', 8199494, 'Comprehensive protection and surveillance', 346671);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (18241444, 'S-400 Missile System', 'Defense Systems', 4132095.76, 'High-precision targeting for aerial threats', 871206);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (75369505, 'Harpoon Missile', 'Anti-Tank Missiles', 9813585, 'Armor-penetrating capability for ground targets', 200722);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (57799235, 'Harpoon Missile', 'Anti-Tank Missiles', 7586434, 'Comprehensive protection and surveillance', 160818);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (74238626, 'Iron Dome', 'Anti-Tank Missiles', 7228926, 'Comprehensive protection and surveillance', 436150);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (11612540, 'Harpoon Missile', 'Surface-to-Air Missiles', 6437618, 'High-precision targeting for aerial threats', 135045);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (35412535, 'Patriot Missile System', 'Surface-to-Air Missiles', 9845795, 'Armor-penetrating capability for ground targets', 174336);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (54295504, 'Javelin Missile', 'Surface-to-Air Missiles', 9168209, 'Armor-penetrating capability for ground targets', 596824);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (10773159, 'Harpoon Missile', 'Surface-to-Air Missiles', 9952811, 'Comprehensive protection and surveillance', 239456);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (27383241, 'SM-6 (Standard Missile-6)', 'Defense Systems', 5895144.48, 'High-precision targeting for aerial threats', 171304);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (68172768, 'Stinger Missile', 'Defense Systems', 972207.79, 'High-precision targeting for aerial threats', 579190);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (61778729, 'Aegis Combat System', 'Surface-to-Air Missiles', 9167629, 'Comprehensive protection and surveillance', 357906);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (72987322, 'Javelin Missile', 'Defense Systems', 5173678.46, 'Comprehensive protection and surveillance', 123923);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (47514168, 'SM-6 (Standard Missile-6)', 'Defense Systems', 8460733.77, 'Armor-penetrating capability for ground targets', 778671);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (97999893, 'SM-6 (Standard Missile-6)', 'Defense Systems', 5723941.41, 'High-precision targeting for aerial threats', 662531);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (10983030, 'Aegis Combat System', 'Surface-to-Air Missiles', 3625906, 'Comprehensive protection and surveillance', 826032);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (23020416, 'Harpoon Missile', 'Anti-Tank Missiles', 1460595, 'High-precision targeting for aerial threats', 562904);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (62299072, 'Aegis Combat System', 'Anti-Tank Missiles', 7146382, 'Armor-penetrating capability for ground targets', 163116);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (58148018, 'SM-6 (Standard Missile-6)', 'Defense Systems', 14041508.15, 'Comprehensive protection and surveillance', 415319);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (37938545, 'Harpoon Missile', 'Surface-to-Air Missiles', 9085784, 'Armor-penetrating capability for ground targets', 779715);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (77082176, 'Patriot Missile System', 'Surface-to-Air Missiles', 8222269, 'Comprehensive protection and surveillance', 926786);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (66321864, 'SM-6 (Standard Missile-6)', 'Surface-to-Air Missiles', 2551959, 'Comprehensive protection and surveillance', 557042);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (79388951, 'Iron Dome', 'Defense Systems', 7928010.73, 'High-precision targeting for aerial threats', 644496);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (66490968, 'S-400 Missile System', 'Anti-Tank Missiles', 4835096, 'High-precision targeting for aerial threats', 544405);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (73128554, 'Patriot Missile System', 'Defense Systems', 13688143.23, 'Comprehensive protection and surveillance', 336503);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (82538648, 'Aegis Combat System', 'Surface-to-Air Missiles', 9617153, 'Comprehensive protection and surveillance', 400917);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (31750484, 'Patriot Missile System', 'Anti-Tank Missiles', 1791596, 'Armor-penetrating capability for ground targets', 107746);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (48946071, 'SM-6 (Standard Missile-6)', 'Defense Systems', 6543153.67, 'High-precision targeting for aerial threats', 705376);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (61662500, 'S-400 Missile System', 'Defense Systems', 9698596.63, 'Comprehensive protection and surveillance', 579556);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (34484754, 'Javelin Missile', 'Anti-Tank Missiles', 4909169, 'Comprehensive protection and surveillance', 87422);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (39379668, 'Hellfire Missile', 'Defense Systems', 4393029.12, 'High-precision targeting for aerial threats', 710763);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (54839245, 'Harpoon Missile', 'Defense Systems', 13574183.54, 'High-precision targeting for aerial threats', 383122);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (69659740, 'Stinger Missile', 'Surface-to-Air Missiles', 9362407, 'Comprehensive protection and surveillance', 88526);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (96606763, 'S-400 Missile System', 'Defense Systems', 12893180.85, 'High-precision targeting for aerial threats', 268085);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (78531101, 'Javelin Missile', 'Anti-Tank Missiles', 3731605, 'Armor-penetrating capability for ground targets', 767018);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (27830024, 'Iron Dome', 'Defense Systems', 2655703.17, 'High-precision targeting for aerial threats', 71243);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (27619560, 'Patriot Missile System', 'Defense Systems', 2282044.36, 'Comprehensive protection and surveillance', 982089);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (82719544, 'Iron Dome', 'Defense Systems', 3926260.87, 'High-precision targeting for aerial threats', 722426);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (98680204, 'Iron Dome', 'Surface-to-Air Missiles', 1092477, 'High-precision targeting for aerial threats', 320025);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (20721619, 'Harpoon Missile', 'Anti-Tank Missiles', 9475377, 'High-precision targeting for aerial threats', 36840);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (39740589, 'THAAD (Terminal High Altitude Area Defense)', 'Anti-Tank Missiles', 3705311, 'High-precision targeting for aerial threats', 168536);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (32588284, 'Hellfire Missile', 'Surface-to-Air Missiles', 5107091, 'Comprehensive protection and surveillance', 789597);
commit;
prompt 100 records committed...
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (36761506, 'THAAD (Terminal High Altitude Area Defense)', 'Defense Systems', 3344934.11, 'High-precision targeting for aerial threats', 528102);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (98605450, 'Iron Dome', 'Defense Systems', 408011, 'Comprehensive protection and surveillance', 283400);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (97221575, 'Aegis Combat System', 'Surface-to-Air Missiles', 1577529, 'Armor-penetrating capability for ground targets', 511783);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (16635517, 'Hellfire Missile', 'Defense Systems', 254352.24, 'High-precision targeting for aerial threats', 362521);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (84531922, 'Patriot Missile System', 'Defense Systems', 11930489.71, 'Comprehensive protection and surveillance', 111641);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (90130674, 'S-400 Missile System', 'Anti-Tank Missiles', 7046775, 'Comprehensive protection and surveillance', 76191);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (44687173, 'THAAD (Terminal High Altitude Area Defense)', 'Surface-to-Air Missiles', 9287928, 'High-precision targeting for aerial threats', 59888);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (58773159, 'Aegis Combat System', 'Defense Systems', 7368983.68, 'High-precision targeting for aerial threats', 444534);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (39059038, 'Javelin Missile', 'Anti-Tank Missiles', 2278177, 'Armor-penetrating capability for ground targets', 862874);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (86898721, 'Patriot Missile System', 'Surface-to-Air Missiles', 4677643, 'Comprehensive protection and surveillance', 30154);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (69738718, 'Stinger Missile', 'Defense Systems', 13484046.22, 'Armor-penetrating capability for ground targets', 336070);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (87359535, 'Stinger Missile', 'Surface-to-Air Missiles', 9356189, 'Armor-penetrating capability for ground targets', 268525);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (76334389, 'THAAD (Terminal High Altitude Area Defense)', 'Defense Systems', 7470170.55, 'Comprehensive protection and surveillance', 218135);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (70982821, 'Stinger Missile', 'Anti-Tank Missiles', 5837773, 'High-precision targeting for aerial threats', 760286);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (95630015, 'Iron Dome', 'Defense Systems', 9324889.51, 'Armor-penetrating capability for ground targets', 692221);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (94281414, 'Patriot Missile System', 'Anti-Tank Missiles', 4511206, 'Armor-penetrating capability for ground targets', 978577);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (68011741, 'THAAD (Terminal High Altitude Area Defense)', 'Surface-to-Air Missiles', 4836886, 'High-precision targeting for aerial threats', 892627);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (20572539, 'Javelin Missile', 'Surface-to-Air Missiles', 8774487, 'Armor-penetrating capability for ground targets', 94541);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (57068113, 'Hellfire Missile', 'Surface-to-Air Missiles', 9204972, 'Armor-penetrating capability for ground targets', 724925);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (52161038, 'SM-6 (Standard Missile-6)', 'Defense Systems', 5066427.28, 'Armor-penetrating capability for ground targets', 874109);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (51270374, 'Patriot Missile System', 'Anti-Tank Missiles', 2905250, 'Comprehensive protection and surveillance', 577691);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (43743302, 'Hellfire Missile', 'Anti-Tank Missiles', 5146992, 'Comprehensive protection and surveillance', 849210);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (69139092, 'THAAD (Terminal High Altitude Area Defense)', 'Surface-to-Air Missiles', 5999842, 'Armor-penetrating capability for ground targets', 753968);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (39688154, 'Aegis Combat System', 'Anti-Tank Missiles', 1875601, 'Comprehensive protection and surveillance', 216511);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (51803362, 'Iron Dome', 'Defense Systems', 8091108.54, 'Armor-penetrating capability for ground targets', 700567);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (90350934, 'Patriot Missile System', 'Defense Systems', 12117153.68, 'Armor-penetrating capability for ground targets', 166822);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (39358839, 'Stinger Missile', 'Surface-to-Air Missiles', 6276980, 'Armor-penetrating capability for ground targets', 363360);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (35077043, 'Aegis Combat System', 'Defense Systems', 13428769.12, 'High-precision targeting for aerial threats', 598294);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (69930851, 'THAAD (Terminal High Altitude Area Defense)', 'Defense Systems', 1570531.28, 'High-precision targeting for aerial threats', 246662);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (52051185, 'Stinger Missile', 'Anti-Tank Missiles', 2813188, 'Armor-penetrating capability for ground targets', 416526);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (72848834, 'Javelin Missile', 'Surface-to-Air Missiles', 8567855, 'Armor-penetrating capability for ground targets', 4847);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (97648558, 'Javelin Missile', 'Defense Systems', 1407900.53, 'High-precision targeting for aerial threats', 874720);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (49838349, 'S-400 Missile System', 'Anti-Tank Missiles', 2396773, 'Armor-penetrating capability for ground targets', 644315);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (70444263, 'Iron Dome', 'Anti-Tank Missiles', 3926699, 'High-precision targeting for aerial threats', 656987);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (50636928, 'S-400 Missile System', 'Anti-Tank Missiles', 3447803, 'High-precision targeting for aerial threats', 663928);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (37537147, 'SM-6 (Standard Missile-6)', 'Surface-to-Air Missiles', 824473, 'High-precision targeting for aerial threats', 657953);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (11939996, 'Javelin Missile', 'Defense Systems', 8237086.63, 'Comprehensive protection and surveillance', 712062);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (63344366, 'Javelin Missile', 'Anti-Tank Missiles', 8209001, 'High-precision targeting for aerial threats', 661773);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (91083124, 'Aegis Combat System', 'Anti-Tank Missiles', 1940518, 'Armor-penetrating capability for ground targets', 588369);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (13522889, 'Hellfire Missile', 'Anti-Tank Missiles', 4299384, 'Comprehensive protection and surveillance', 373690);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (78366855, 'THAAD (Terminal High Altitude Area Defense)', 'Defense Systems', 5895716.94, 'Armor-penetrating capability for ground targets', 668404);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (89174212, 'SM-6 (Standard Missile-6)', 'Surface-to-Air Missiles', 4600788, 'Armor-penetrating capability for ground targets', 507250);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (94430363, 'THAAD (Terminal High Altitude Area Defense)', 'Defense Systems', 280073.54, 'Comprehensive protection and surveillance', 79220);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (78988523, 'Hellfire Missile', 'Anti-Tank Missiles', 2492971, 'Comprehensive protection and surveillance', 880311);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (31580188, 'Aegis Combat System', 'Defense Systems', 10888609.8, 'Comprehensive protection and surveillance', 204069);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (19484571, 'Aegis Combat System', 'Defense Systems', 8396194.76, 'Armor-penetrating capability for ground targets', 722967);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (80480299, 'Aegis Combat System', 'Anti-Tank Missiles', 9109015, 'High-precision targeting for aerial threats', 344330);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (26001483, 'Patriot Missile System', 'Surface-to-Air Missiles', 6307622, 'High-precision targeting for aerial threats', 650510);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (26109737, 'THAAD (Terminal High Altitude Area Defense)', 'Surface-to-Air Missiles', 7867408, 'Armor-penetrating capability for ground targets', 616783);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (49598795, 'Harpoon Missile', 'Anti-Tank Missiles', 697701, 'High-precision targeting for aerial threats', 4553);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (59394083, 'Stinger Missile', 'Surface-to-Air Missiles', 476907, 'High-precision targeting for aerial threats', 414365);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (67520924, 'Patriot Missile System', 'Surface-to-Air Missiles', 1988180, 'Comprehensive protection and surveillance', 515444);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (23417008, 'S-400 Missile System', 'Surface-to-Air Missiles', 171592, 'Armor-penetrating capability for ground targets', 8528);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (67382352, 'Aegis Combat System', 'Surface-to-Air Missiles', 7411990, 'Comprehensive protection and surveillance', 489100);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (65618147, 'S-400 Missile System', 'Anti-Tank Missiles', 7132013, 'Armor-penetrating capability for ground targets', 121318);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (17729757, 'Patriot Missile System', 'Defense Systems', 9205328.17, 'Comprehensive protection and surveillance', 971369);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (19883552, 'Iron Dome', 'Anti-Tank Missiles', 8285184, 'Comprehensive protection and surveillance', 545314);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (40137354, 'Hellfire Missile', 'Defense Systems', 10007053.22, 'High-precision targeting for aerial threats', 593063);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (84934979, 'Aegis Combat System', 'Surface-to-Air Missiles', 1013455, 'High-precision targeting for aerial threats', 139532);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (30491680, 'SM-6 (Standard Missile-6)', 'Defense Systems', 5051077.65, 'Comprehensive protection and surveillance', 48781);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (77924243, 'Harpoon Missile', 'Surface-to-Air Missiles', 8133225, 'Comprehensive protection and surveillance', 779443);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (69622091, 'Aegis Combat System', 'Anti-Tank Missiles', 6477634, 'Armor-penetrating capability for ground targets', 412641);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (54638911, 'Aegis Combat System', 'Defense Systems', 6558301.26, 'Comprehensive protection and surveillance', 89209);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (15933206, 'SM-6 (Standard Missile-6)', 'Surface-to-Air Missiles', 1615719, 'High-precision targeting for aerial threats', 744058);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (70225563, 'S-400 Missile System', 'Defense Systems', 6744514.27, 'High-precision targeting for aerial threats', 34274);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (25195559, 'Stinger Missile', 'Anti-Tank Missiles', 5542070, 'High-precision targeting for aerial threats', 686676);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (26836894, 'Iron Dome', 'Defense Systems', 13459260.47, 'Armor-penetrating capability for ground targets', 702430);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (75150699, 'Aegis Combat System', 'Defense Systems', 1085040.12, 'High-precision targeting for aerial threats', 13600);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (37108881, 'Hellfire Missile', 'Surface-to-Air Missiles', 5207124, 'Armor-penetrating capability for ground targets', 851488);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (15086996, 'SM-6 (Standard Missile-6)', 'Surface-to-Air Missiles', 277334, 'Armor-penetrating capability for ground targets', 322036);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (44874286, 'Hellfire Missile', 'Defense Systems', 13873921.41, 'Armor-penetrating capability for ground targets', 51669);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (63042402, 'SM-6 (Standard Missile-6)', 'Surface-to-Air Missiles', 739623, 'Armor-penetrating capability for ground targets', 330469);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (77018735, 'Hellfire Missile', 'Surface-to-Air Missiles', 9161472, 'High-precision targeting for aerial threats', 500854);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (75790409, 'Patriot Missile System', 'Defense Systems', 14281332.12, 'Comprehensive protection and surveillance', 481512);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (92885627, 'Iron Dome', 'Anti-Tank Missiles', 1633883, 'Comprehensive protection and surveillance', 840806);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (79265468, 'Harpoon Missile', 'Surface-to-Air Missiles', 341112, 'Armor-penetrating capability for ground targets', 803532);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (40136114, 'Stinger Missile', 'Anti-Tank Missiles', 2103735, 'High-precision targeting for aerial threats', 552496);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (69584106, 'Iron Dome', 'Surface-to-Air Missiles', 3259415, 'Armor-penetrating capability for ground targets', 234206);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (28470422, 'Hellfire Missile', 'Surface-to-Air Missiles', 8645623, 'Armor-penetrating capability for ground targets', 758650);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (87317995, 'Iron Dome', 'Defense Systems', 9472117.93, 'Armor-penetrating capability for ground targets', 859098);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (15116737, 'THAAD (Terminal High Altitude Area Defense)', 'Anti-Tank Missiles', 5826817, 'Comprehensive protection and surveillance', 511657);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (60175229, 'Stinger Missile', 'Defense Systems', 9526270.6, 'High-precision targeting for aerial threats', 768420);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (38493926, 'S-400 Missile System', 'Anti-Tank Missiles', 1525914, 'Comprehensive protection and surveillance', 894946);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (11746052, 'THAAD (Terminal High Altitude Area Defense)', 'Anti-Tank Missiles', 4639951, 'High-precision targeting for aerial threats', 485061);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (78954336, 'Harpoon Missile', 'Anti-Tank Missiles', 4902549, 'High-precision targeting for aerial threats', 515967);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (86469285, 'Aegis Combat System', 'Defense Systems', 832475.55, 'High-precision targeting for aerial threats', 167049);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (88012920, 'Stinger Missile', 'Anti-Tank Missiles', 4454137, 'Comprehensive protection and surveillance', 218897);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (43475714, 'SM-6 (Standard Missile-6)', 'Anti-Tank Missiles', 9173436, 'High-precision targeting for aerial threats', 37540);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (29968938, 'Iron Dome', 'Surface-to-Air Missiles', 7570549, 'Armor-penetrating capability for ground targets', 95204);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (54464675, 'Iron Dome', 'Anti-Tank Missiles', 9526818, 'Comprehensive protection and surveillance', 745473);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (72326495, 'SM-6 (Standard Missile-6)', 'Surface-to-Air Missiles', 7472682, 'High-precision targeting for aerial threats', 120176);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (73270093, 'Aegis Combat System', 'Surface-to-Air Missiles', 5131765, 'Armor-penetrating capability for ground targets', 610020);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (93920145, 'Hellfire Missile', 'Anti-Tank Missiles', 3295849, 'High-precision targeting for aerial threats', 993564);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (17272228, 'SM-6 (Standard Missile-6)', 'Surface-to-Air Missiles', 639714, 'High-precision targeting for aerial threats', 951942);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (42151834, 'THAAD (Terminal High Altitude Area Defense)', 'Defense Systems', 5203317.7, 'Comprehensive protection and surveillance', 12442);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (53311367, 'THAAD (Terminal High Altitude Area Defense)', 'Defense Systems', 14157972.92, 'Comprehensive protection and surveillance', 964992);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (83245415, 'SM-6 (Standard Missile-6)', 'Surface-to-Air Missiles', 5095254, 'Comprehensive protection and surveillance', 54425);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (33259729, 'THAAD (Terminal High Altitude Area Defense)', 'Surface-to-Air Missiles', 2930159, 'Comprehensive protection and surveillance', 830473);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (51924991, 'SM-6 (Standard Missile-6)', 'Surface-to-Air Missiles', 1536028, 'High-precision targeting for aerial threats', 999359);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (26907813, 'Iron Dome', 'Anti-Tank Missiles', 5308655, 'Armor-penetrating capability for ground targets', 28095);
commit;
prompt 200 records committed...
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (69423343, 'Stinger Missile', 'Defense Systems', 12199557.61, 'Comprehensive protection and surveillance', 167614);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (52321455, 'Patriot Missile System', 'Defense Systems', 12578837.12, 'Armor-penetrating capability for ground targets', 46236);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (81226674, 'Javelin Missile', 'Surface-to-Air Missiles', 5027318, 'High-precision targeting for aerial threats', 603107);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (96325838, 'S-400 Missile System', 'Anti-Tank Missiles', 2523265, 'High-precision targeting for aerial threats', 944753);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (48461944, 'Hellfire Missile', 'Anti-Tank Missiles', 4581935, 'Armor-penetrating capability for ground targets', 279169);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (10272702, 'Iron Dome', 'Defense Systems', 5435364.37, 'Armor-penetrating capability for ground targets', 473447);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (29333024, 'THAAD (Terminal High Altitude Area Defense)', 'Defense Systems', 9926076.78, 'Comprehensive protection and surveillance', 555400);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (58747010, 'S-400 Missile System', 'Surface-to-Air Missiles', 3954421, 'Comprehensive protection and surveillance', 699322);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (39511933, 'THAAD (Terminal High Altitude Area Defense)', 'Anti-Tank Missiles', 1061509, 'Armor-penetrating capability for ground targets', 463609);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (41369317, 'S-400 Missile System', 'Anti-Tank Missiles', 9520372, 'Armor-penetrating capability for ground targets', 345759);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (52891400, 'Javelin Missile', 'Defense Systems', 12342819.8, 'Comprehensive protection and surveillance', 651001);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (60350090, 'Aegis Combat System', 'Defense Systems', 12935729.06, 'Comprehensive protection and surveillance', 296725);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (76605006, 'Hellfire Missile', 'Surface-to-Air Missiles', 6033765, 'Comprehensive protection and surveillance', 58696);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (88952233, 'SM-6 (Standard Missile-6)', 'Surface-to-Air Missiles', 5443971, 'High-precision targeting for aerial threats', 969150);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (76721156, 'Aegis Combat System', 'Anti-Tank Missiles', 6212834, 'High-precision targeting for aerial threats', 663740);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (18518062, 'Patriot Missile System', 'Defense Systems', 11915301.13, 'Armor-penetrating capability for ground targets', 506592);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (93517123, 'Aegis Combat System', 'Anti-Tank Missiles', 9876149, 'Comprehensive protection and surveillance', 862704);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (84216993, 'Javelin Missile', 'Surface-to-Air Missiles', 1294042, 'Armor-penetrating capability for ground targets', 997316);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (97739426, 'SM-6 (Standard Missile-6)', 'Surface-to-Air Missiles', 2036427, 'Comprehensive protection and surveillance', 325025);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (62170165, 'Javelin Missile', 'Defense Systems', 206080.86, 'Comprehensive protection and surveillance', 169908);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (61756786, 'S-400 Missile System', 'Surface-to-Air Missiles', 1419835, 'Comprehensive protection and surveillance', 394182);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (63108288, 'Aegis Combat System', 'Surface-to-Air Missiles', 1163402, 'High-precision targeting for aerial threats', 269561);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (22011903, 'Iron Dome', 'Anti-Tank Missiles', 334251, 'Comprehensive protection and surveillance', 364861);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (10218924, 'Patriot Missile System', 'Anti-Tank Missiles', 6608775, 'Comprehensive protection and surveillance', 68144);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (21678323, 'S-400 Missile System', 'Defense Systems', 14139312.96, 'Comprehensive protection and surveillance', 214219);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (41339487, 'Patriot Missile System', 'Defense Systems', 11047252.35, 'High-precision targeting for aerial threats', 211187);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (24928621, 'S-400 Missile System', 'Defense Systems', 849768.03, 'High-precision targeting for aerial threats', 615366);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (48152182, 'SM-6 (Standard Missile-6)', 'Surface-to-Air Missiles', 500401, 'Armor-penetrating capability for ground targets', 354906);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (96720169, 'Hellfire Missile', 'Defense Systems', 3687925.88, 'High-precision targeting for aerial threats', 311214);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (97537164, 'S-400 Missile System', 'Defense Systems', 9181864.51, 'Armor-penetrating capability for ground targets', 796388);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (84504734, 'Iron Dome', 'Anti-Tank Missiles', 5275657, 'High-precision targeting for aerial threats', 176785);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (82740130, 'Hellfire Missile', 'Anti-Tank Missiles', 2587208, 'Armor-penetrating capability for ground targets', 550070);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (40768147, 'Iron Dome', 'Defense Systems', 13202641.8, 'Armor-penetrating capability for ground targets', 548136);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (34510634, 'THAAD (Terminal High Altitude Area Defense)', 'Anti-Tank Missiles', 1566295, 'High-precision targeting for aerial threats', 73633);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (37806303, 'SM-6 (Standard Missile-6)', 'Surface-to-Air Missiles', 3801959, 'Comprehensive protection and surveillance', 646004);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (24867339, 'Harpoon Missile', 'Defense Systems', 724354.69, 'Comprehensive protection and surveillance', 96425);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (28643747, 'Aegis Combat System', 'Defense Systems', 13708577.66, 'Comprehensive protection and surveillance', 172296);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (58646482, 'Hellfire Missile', 'Surface-to-Air Missiles', 2224163, 'Comprehensive protection and surveillance', 253564);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (70501072, 'S-400 Missile System', 'Defense Systems', 2116603.98, 'Comprehensive protection and surveillance', 407570);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (10489791, 'Stinger Missile', 'Defense Systems', 10192636.69, 'Armor-penetrating capability for ground targets', 478814);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (79717411, 'Patriot Missile System', 'Surface-to-Air Missiles', 8844664, 'High-precision targeting for aerial threats', 387605);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (47428096, 'THAAD (Terminal High Altitude Area Defense)', 'Surface-to-Air Missiles', 8401081, 'Armor-penetrating capability for ground targets', 359385);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (19534248, 'Harpoon Missile', 'Defense Systems', 6573145.77, 'Armor-penetrating capability for ground targets', 987203);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (19716910, 'Harpoon Missile', 'Anti-Tank Missiles', 9817885, 'Armor-penetrating capability for ground targets', 905772);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (94646812, 'Harpoon Missile', 'Defense Systems', 12271944.18, 'Comprehensive protection and surveillance', 989345);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (15080196, 'Aegis Combat System', 'Surface-to-Air Missiles', 8927771, 'Armor-penetrating capability for ground targets', 439750);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (98929290, 'SM-6 (Standard Missile-6)', 'Defense Systems', 1425313.07, 'Armor-penetrating capability for ground targets', 467815);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (64018596, 'SM-6 (Standard Missile-6)', 'Anti-Tank Missiles', 1780821, 'Comprehensive protection and surveillance', 553670);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (55240135, 'Iron Dome', 'Surface-to-Air Missiles', 445421, 'Comprehensive protection and surveillance', 61435);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (66338365, 'THAAD (Terminal High Altitude Area Defense)', 'Surface-to-Air Missiles', 8940587, 'High-precision targeting for aerial threats', 344157);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (78713682, 'Stinger Missile', 'Defense Systems', 9405521.88, 'Comprehensive protection and surveillance', 968021);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (41557251, 'S-400 Missile System', 'Surface-to-Air Missiles', 971253, 'Comprehensive protection and surveillance', 373354);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (27444360, 'Javelin Missile', 'Anti-Tank Missiles', 245443, 'Comprehensive protection and surveillance', 736193);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (18343584, 'Hellfire Missile', 'Anti-Tank Missiles', 8631320, 'Armor-penetrating capability for ground targets', 60834);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (66969719, 'SM-6 (Standard Missile-6)', 'Defense Systems', 9154652.74, 'Comprehensive protection and surveillance', 183159);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (70644814, 'Javelin Missile', 'Surface-to-Air Missiles', 2747291, 'High-precision targeting for aerial threats', 459286);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (57458542, 'Patriot Missile System', 'Surface-to-Air Missiles', 3289480, 'High-precision targeting for aerial threats', 16604);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (40661758, 'Hellfire Missile', 'Surface-to-Air Missiles', 2415756, 'Armor-penetrating capability for ground targets', 617134);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (15010285, 'S-400 Missile System', 'Defense Systems', 3986411.95, 'Armor-penetrating capability for ground targets', 988802);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (41324792, 'Patriot Missile System', 'Anti-Tank Missiles', 1457347, 'Armor-penetrating capability for ground targets', 981182);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (50972092, 'THAAD (Terminal High Altitude Area Defense)', 'Defense Systems', 11579117.42, 'Comprehensive protection and surveillance', 661084);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (63428253, 'Hellfire Missile', 'Surface-to-Air Missiles', 8420976, 'Armor-penetrating capability for ground targets', 542427);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (15679639, 'Harpoon Missile', 'Surface-to-Air Missiles', 8085084, 'Comprehensive protection and surveillance', 106778);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (95079291, 'S-400 Missile System', 'Surface-to-Air Missiles', 2911813, 'High-precision targeting for aerial threats', 678159);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (85528058, 'Patriot Missile System', 'Anti-Tank Missiles', 3753012, 'High-precision targeting for aerial threats', 130750);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (23617423, 'S-400 Missile System', 'Anti-Tank Missiles', 9491417, 'Comprehensive protection and surveillance', 893483);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (44779190, 'Harpoon Missile', 'Surface-to-Air Missiles', 3682714, 'Comprehensive protection and surveillance', 833680);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (52661044, 'S-400 Missile System', 'Anti-Tank Missiles', 7773492, 'High-precision targeting for aerial threats', 915368);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (76011409, 'THAAD (Terminal High Altitude Area Defense)', 'Anti-Tank Missiles', 5455001, 'High-precision targeting for aerial threats', 599179);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (49437140, 'Aegis Combat System', 'Defense Systems', 5437184.25, 'Armor-penetrating capability for ground targets', 842370);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (45618284, 'THAAD (Terminal High Altitude Area Defense)', 'Anti-Tank Missiles', 3624043, 'Comprehensive protection and surveillance', 831887);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (40050450, 'Stinger Missile', 'Anti-Tank Missiles', 5466780, 'Comprehensive protection and surveillance', 303139);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (53262312, 'Hellfire Missile', 'Anti-Tank Missiles', 2762480, 'High-precision targeting for aerial threats', 24678);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (42848333, 'SM-6 (Standard Missile-6)', 'Defense Systems', 8872501.64, 'Comprehensive protection and surveillance', 826842);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (86689983, 'Harpoon Missile', 'Defense Systems', 7649620.89, 'Comprehensive protection and surveillance', 983078);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (62537595, 'Hellfire Missile', 'Anti-Tank Missiles', 8305589, 'High-precision targeting for aerial threats', 878623);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (65814418, 'Stinger Missile', 'Surface-to-Air Missiles', 5339884, 'Armor-penetrating capability for ground targets', 285049);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (10209509, 'Patriot Missile System', 'Anti-Tank Missiles', 1150843, 'Comprehensive protection and surveillance', 263230);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (52471844, 'SM-6 (Standard Missile-6)', 'Defense Systems', 6469525.55, 'Comprehensive protection and surveillance', 304243);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (56929294, 'S-400 Missile System', 'Anti-Tank Missiles', 7040036, 'Armor-penetrating capability for ground targets', 849928);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (64758137, 'S-400 Missile System', 'Surface-to-Air Missiles', 4038390, 'Armor-penetrating capability for ground targets', 374855);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (61046293, 'Iron Dome', 'Surface-to-Air Missiles', 5535473, 'Armor-penetrating capability for ground targets', 821830);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (37351703, 'Iron Dome', 'Defense Systems', 10010586.1, 'Armor-penetrating capability for ground targets', 926207);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (61881112, 'THAAD (Terminal High Altitude Area Defense)', 'Surface-to-Air Missiles', 6221862, 'High-precision targeting for aerial threats', 902763);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (41728927, 'Iron Dome', 'Surface-to-Air Missiles', 7034776, 'Armor-penetrating capability for ground targets', 665184);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (74945952, 'Javelin Missile', 'Defense Systems', 2770365.63, 'High-precision targeting for aerial threats', 264799);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (92678457, 'Stinger Missile', 'Defense Systems', 7112266.91, 'Comprehensive protection and surveillance', 134639);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (56354403, 'Javelin Missile', 'Surface-to-Air Missiles', 788622, 'Comprehensive protection and surveillance', 69578);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (60020568, 'Patriot Missile System', 'Surface-to-Air Missiles', 2339042, 'Comprehensive protection and surveillance', 225914);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (26576933, 'SM-6 (Standard Missile-6)', 'Defense Systems', 3728639.57, 'Comprehensive protection and surveillance', 846541);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (46937843, 'S-400 Missile System', 'Surface-to-Air Missiles', 9720012, 'High-precision targeting for aerial threats', 473570);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (96198338, 'Aegis Combat System', 'Anti-Tank Missiles', 2766607, 'Armor-penetrating capability for ground targets', 161204);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (88823448, 'Iron Dome', 'Surface-to-Air Missiles', 5070778, 'High-precision targeting for aerial threats', 210483);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (68833388, 'Hellfire Missile', 'Anti-Tank Missiles', 4709447, 'High-precision targeting for aerial threats', 276598);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (29053220, 'Stinger Missile', 'Anti-Tank Missiles', 112649, 'High-precision targeting for aerial threats', 911408);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (28856935, 'Harpoon Missile', 'Defense Systems', 13458780.25, 'High-precision targeting for aerial threats', 760994);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (90587843, 'Javelin Missile', 'Surface-to-Air Missiles', 1404278, 'Comprehensive protection and surveillance', 303150);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (14104712, 'THAAD (Terminal High Altitude Area Defense)', 'Surface-to-Air Missiles', 5731628, 'High-precision targeting for aerial threats', 245044);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (74811349, 'Hellfire Missile', 'Surface-to-Air Missiles', 5027298, 'High-precision targeting for aerial threats', 69456);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (46201095, 'SM-6 (Standard Missile-6)', 'Anti-Tank Missiles', 353946, 'Comprehensive protection and surveillance', 781464);
commit;
prompt 300 records committed...
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (91512197, 'Stinger Missile', 'Defense Systems', 10222946.48, 'Comprehensive protection and surveillance', 228763);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (13670067, 'SM-6 (Standard Missile-6)', 'Defense Systems', 13294131.95, 'Armor-penetrating capability for ground targets', 510373);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (76413178, 'Javelin Missile', 'Anti-Tank Missiles', 4081860, 'Comprehensive protection and surveillance', 512923);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (95485628, 'THAAD (Terminal High Altitude Area Defense)', 'Surface-to-Air Missiles', 7948446, 'Comprehensive protection and surveillance', 583432);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (55156404, 'Stinger Missile', 'Surface-to-Air Missiles', 2199233, 'Armor-penetrating capability for ground targets', 325024);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (95217918, 'THAAD (Terminal High Altitude Area Defense)', 'Surface-to-Air Missiles', 1230741, 'Armor-penetrating capability for ground targets', 549888);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (75149619, 'Javelin Missile', 'Anti-Tank Missiles', 1712517, 'Comprehensive protection and surveillance', 104444);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (38431286, 'Javelin Missile', 'Anti-Tank Missiles', 5661576, 'High-precision targeting for aerial threats', 657661);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (99180091, 'Iron Dome', 'Surface-to-Air Missiles', 1751361, 'High-precision targeting for aerial threats', 177254);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (88490564, 'Hellfire Missile', 'Defense Systems', 12270704.09, 'High-precision targeting for aerial threats', 772596);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (87202332, 'Patriot Missile System', 'Surface-to-Air Missiles', 7934472, 'Armor-penetrating capability for ground targets', 420094);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (18431796, 'Patriot Missile System', 'Anti-Tank Missiles', 8263516, 'Armor-penetrating capability for ground targets', 868999);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (65205896, 'Hellfire Missile', 'Surface-to-Air Missiles', 1058085, 'High-precision targeting for aerial threats', 315659);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (29053667, 'Aegis Combat System', 'Defense Systems', 7731833.04, 'High-precision targeting for aerial threats', 294595);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (92569505, 'Aegis Combat System', 'Defense Systems', 7132281.16, 'High-precision targeting for aerial threats', 227903);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (45885888, 'Stinger Missile', 'Defense Systems', 4428195.34, 'Comprehensive protection and surveillance', 263017);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (61807752, 'Patriot Missile System', 'Anti-Tank Missiles', 7450236, 'High-precision targeting for aerial threats', 975098);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (50190784, 'THAAD (Terminal High Altitude Area Defense)', 'Defense Systems', 4220490.79, 'High-precision targeting for aerial threats', 276966);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (97116635, 'Javelin Missile', 'Surface-to-Air Missiles', 7953907, 'Comprehensive protection and surveillance', 28872);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (61654331, 'THAAD (Terminal High Altitude Area Defense)', 'Surface-to-Air Missiles', 549076, 'High-precision targeting for aerial threats', 435154);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (90624166, 'SM-6 (Standard Missile-6)', 'Anti-Tank Missiles', 7627805, 'High-precision targeting for aerial threats', 917345);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (32922901, 'SM-6 (Standard Missile-6)', 'Defense Systems', 11579981.24, 'Comprehensive protection and surveillance', 826165);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (87752311, 'THAAD (Terminal High Altitude Area Defense)', 'Anti-Tank Missiles', 3986085, 'High-precision targeting for aerial threats', 660490);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (28641959, 'Hellfire Missile', 'Surface-to-Air Missiles', 7028864, 'Armor-penetrating capability for ground targets', 462354);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (15596504, 'THAAD (Terminal High Altitude Area Defense)', 'Defense Systems', 14620955.01, 'Armor-penetrating capability for ground targets', 315854);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (94152960, 'Stinger Missile', 'Anti-Tank Missiles', 2842121, 'Comprehensive protection and surveillance', 456910);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (60728994, 'Iron Dome', 'Surface-to-Air Missiles', 3681692, 'Comprehensive protection and surveillance', 962747);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (51504705, 'Iron Dome', 'Defense Systems', 10269802.07, 'Comprehensive protection and surveillance', 397208);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (55332267, 'Stinger Missile', 'Surface-to-Air Missiles', 3411908, 'High-precision targeting for aerial threats', 703032);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (22935393, 'Harpoon Missile', 'Surface-to-Air Missiles', 5726675, 'Comprehensive protection and surveillance', 117576);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (33068797, 'SM-6 (Standard Missile-6)', 'Anti-Tank Missiles', 768425, 'Comprehensive protection and surveillance', 506651);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (74481633, 'SM-6 (Standard Missile-6)', 'Surface-to-Air Missiles', 6205536, 'High-precision targeting for aerial threats', 324596);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (88593375, 'THAAD (Terminal High Altitude Area Defense)', 'Surface-to-Air Missiles', 845273, 'Armor-penetrating capability for ground targets', 979994);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (94870653, 'Javelin Missile', 'Defense Systems', 2778109.26, 'High-precision targeting for aerial threats', 778080);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (37114268, 'SM-6 (Standard Missile-6)', 'Anti-Tank Missiles', 5961208, 'Comprehensive protection and surveillance', 385246);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (57351967, 'Iron Dome', 'Anti-Tank Missiles', 5560516, 'High-precision targeting for aerial threats', 980824);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (22909451, 'Patriot Missile System', 'Surface-to-Air Missiles', 9214200, 'Comprehensive protection and surveillance', 488838);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (24624743, 'Aegis Combat System', 'Surface-to-Air Missiles', 5021682, 'Armor-penetrating capability for ground targets', 580280);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (98204172, 'Javelin Missile', 'Surface-to-Air Missiles', 7304180, 'Armor-penetrating capability for ground targets', 67123);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (89517123, 'S-400 Missile System', 'Defense Systems', 8380546.47, 'Comprehensive protection and surveillance', 935268);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (56316096, 'Patriot Missile System', 'Defense Systems', 7225311.54, 'High-precision targeting for aerial threats', 147404);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (16573750, 'Iron Dome', 'Anti-Tank Missiles', 9861282, 'Comprehensive protection and surveillance', 550856);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (15474271, 'Iron Dome', 'Surface-to-Air Missiles', 5381443, 'Comprehensive protection and surveillance', 312438);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (82207743, 'THAAD (Terminal High Altitude Area Defense)', 'Anti-Tank Missiles', 2173820, 'Comprehensive protection and surveillance', 334515);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (22218176, 'Patriot Missile System', 'Surface-to-Air Missiles', 4082532, 'Comprehensive protection and surveillance', 646543);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (43573377, 'Harpoon Missile', 'Defense Systems', 7399930.35, 'Comprehensive protection and surveillance', 876707);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (25783102, 'Patriot Missile System', 'Anti-Tank Missiles', 4596549, 'Comprehensive protection and surveillance', 151429);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (28815721, 'Hellfire Missile', 'Surface-to-Air Missiles', 786152, 'High-precision targeting for aerial threats', 208998);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (67378100, 'Hellfire Missile', 'Anti-Tank Missiles', 9429225, 'High-precision targeting for aerial threats', 709882);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (53853471, 'SM-6 (Standard Missile-6)', 'Surface-to-Air Missiles', 6314307, 'High-precision targeting for aerial threats', 742841);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (10762767, 'Patriot Missile System', 'Surface-to-Air Missiles', 120742, 'Comprehensive protection and surveillance', 925428);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (23351240, 'Harpoon Missile', 'Defense Systems', 6324856.36, 'High-precision targeting for aerial threats', 342146);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (53029103, 'Iron Dome', 'Defense Systems', 3883594.07, 'Comprehensive protection and surveillance', 416091);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (26037554, 'Javelin Missile', 'Surface-to-Air Missiles', 1149469, 'High-precision targeting for aerial threats', 732764);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (36994704, 'Patriot Missile System', 'Anti-Tank Missiles', 109956, 'High-precision targeting for aerial threats', 390383);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (37024797, 'S-400 Missile System', 'Defense Systems', 13791533.57, 'Comprehensive protection and surveillance', 702015);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (19113525, 'S-400 Missile System', 'Anti-Tank Missiles', 1511440, 'Armor-penetrating capability for ground targets', 583644);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (52287359, 'Hellfire Missile', 'Defense Systems', 4537786.15, 'Armor-penetrating capability for ground targets', 791370);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (69310476, 'Stinger Missile', 'Surface-to-Air Missiles', 3990552, 'High-precision targeting for aerial threats', 882864);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (82954240, 'THAAD (Terminal High Altitude Area Defense)', 'Defense Systems', 6204161.82, 'Armor-penetrating capability for ground targets', 435434);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (91646095, 'Stinger Missile', 'Surface-to-Air Missiles', 3791430, 'Comprehensive protection and surveillance', 218091);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (89572356, 'Aegis Combat System', 'Defense Systems', 11114425.26, 'High-precision targeting for aerial threats', 750334);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (27217548, 'S-400 Missile System', 'Anti-Tank Missiles', 6113810, 'High-precision targeting for aerial threats', 548587);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (48996797, 'THAAD (Terminal High Altitude Area Defense)', 'Defense Systems', 9183857.14, 'High-precision targeting for aerial threats', 424647);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (13202210, 'Harpoon Missile', 'Surface-to-Air Missiles', 6118490, 'Armor-penetrating capability for ground targets', 21818);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (99064288, 'Patriot Missile System', 'Surface-to-Air Missiles', 7815036, 'Comprehensive protection and surveillance', 416000);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (94450071, 'Iron Dome', 'Anti-Tank Missiles', 4979177, 'Armor-penetrating capability for ground targets', 633428);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (98706106, 'THAAD (Terminal High Altitude Area Defense)', 'Defense Systems', 2681932.53, 'Comprehensive protection and surveillance', 406449);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (96531219, 'Javelin Missile', 'Anti-Tank Missiles', 8541660, 'High-precision targeting for aerial threats', 966316);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (33656697, 'Hellfire Missile', 'Defense Systems', 1927284.14, 'High-precision targeting for aerial threats', 219776);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (21644659, 'SM-6 (Standard Missile-6)', 'Anti-Tank Missiles', 8126250, 'Armor-penetrating capability for ground targets', 836934);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (20414247, 'Aegis Combat System', 'Surface-to-Air Missiles', 4906126, 'Comprehensive protection and surveillance', 653828);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (91294699, 'Hellfire Missile', 'Surface-to-Air Missiles', 4884410, 'High-precision targeting for aerial threats', 926945);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (33609459, 'Harpoon Missile', 'Defense Systems', 10408863.75, 'Armor-penetrating capability for ground targets', 431017);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (32141175, 'Aegis Combat System', 'Defense Systems', 4385751.08, 'Armor-penetrating capability for ground targets', 728345);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (44438776, 'S-400 Missile System', 'Defense Systems', 11373869.64, 'Comprehensive protection and surveillance', 220109);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (13929744, 'S-400 Missile System', 'Surface-to-Air Missiles', 8364760, 'Armor-penetrating capability for ground targets', 380201);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (20318315, 'Iron Dome', 'Defense Systems', 6160402.8, 'Armor-penetrating capability for ground targets', 932426);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (90908512, 'Patriot Missile System', 'Defense Systems', 3891422.6, 'Armor-penetrating capability for ground targets', 225105);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (68414752, 'Aegis Combat System', 'Surface-to-Air Missiles', 1488700, 'Armor-penetrating capability for ground targets', 745590);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (60637238, 'Harpoon Missile', 'Anti-Tank Missiles', 3584148, 'High-precision targeting for aerial threats', 163481);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (38209402, 'SM-6 (Standard Missile-6)', 'Surface-to-Air Missiles', 9373783, 'Comprehensive protection and surveillance', 557933);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (56595369, 'Hellfire Missile', 'Surface-to-Air Missiles', 8012867, 'Armor-penetrating capability for ground targets', 133878);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (80751769, 'SM-6 (Standard Missile-6)', 'Anti-Tank Missiles', 6967588, 'Comprehensive protection and surveillance', 826687);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (53495144, 'SM-6 (Standard Missile-6)', 'Surface-to-Air Missiles', 3085044, 'Comprehensive protection and surveillance', 297349);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (84758782, 'Stinger Missile', 'Anti-Tank Missiles', 6988264, 'Comprehensive protection and surveillance', 993096);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (86706038, 'SM-6 (Standard Missile-6)', 'Defense Systems', 7694709.32, 'Comprehensive protection and surveillance', 754068);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (72215992, 'Stinger Missile', 'Defense Systems', 11112677.13, 'Comprehensive protection and surveillance', 947569);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (39696777, 'Javelin Missile', 'Surface-to-Air Missiles', 577322, 'High-precision targeting for aerial threats', 870298);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (58636975, 'Patriot Missile System', 'Anti-Tank Missiles', 8236561, 'Armor-penetrating capability for ground targets', 237986);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (35901182, 'Hellfire Missile', 'Anti-Tank Missiles', 8512568, 'High-precision targeting for aerial threats', 543829);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (65637181, 'Patriot Missile System', 'Surface-to-Air Missiles', 1296925, 'Armor-penetrating capability for ground targets', 974305);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (63914094, 'Patriot Missile System', 'Anti-Tank Missiles', 8933370, 'Armor-penetrating capability for ground targets', 986023);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (95978492, 'S-400 Missile System', 'Defense Systems', 2950539.24, 'High-precision targeting for aerial threats', 632577);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (97423620, 'S-400 Missile System', 'Anti-Tank Missiles', 9046169, 'Comprehensive protection and surveillance', 848583);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (83740728, 'Iron Dome', 'Surface-to-Air Missiles', 3774865, 'Comprehensive protection and surveillance', 211501);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (13785968, 'Stinger Missile', 'Defense Systems', 6957354.89, 'Armor-penetrating capability for ground targets', 773179);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (34776363, 'THAAD (Terminal High Altitude Area Defense)', 'Defense Systems', 7989365.3, 'High-precision targeting for aerial threats', 444641);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (77649101, 'Hellfire Missile', 'Defense Systems', 13510503.97, 'High-precision targeting for aerial threats', 692038);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (55104686, 'THAAD (Terminal High Altitude Area Defense)', 'Anti-Tank Missiles', 2766097, 'Armor-penetrating capability for ground targets', 21439);
commit;
prompt 400 records committed...
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (2001, 'Widget', 'Electronics', 25, 'Compact and versatile', 100);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (2002, 'Gadget', 'Electronics', 50, 'High-tech and durable', 200);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (2003, 'Thingamajig', 'Home Goods', 15, 'Useful for everyday tasks', 300);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (2004, 'Doohickey', 'Automotive', 75, 'Innovative and practical', 150);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (2005, 'Gizmo', 'Health', 100, 'Advanced medical device', 80);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (2006, 'Contraption', 'Industrial', 200, 'Heavy-duty equipment', 60);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (2007, 'Device', 'IT', 150, 'High performance', 120);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (2008, 'Apparatus', 'Construction', 500, 'Rugged and reliable', 50);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (2009, 'Instrument', 'Music', 300, 'High fidelity', 70);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (2010, 'Tool', 'Gardening', 40, 'Ergonomic and efficient', 90);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (1, 'air defense artillery gun', 'Radar Detection', 8798, 'Innovative solution for safeguarding against airborne attacks', 218);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (2, 'counter-drone jammer', 'Missile Defense', 7528, 'Cutting-edge technology for protecting airspace', 919);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (3, 'missile defense system', 'Anti-Aircraft Guns', 3835, 'Highly advanced missile system designed for intercepting enemy aircraft', 971);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (4, 'surface-to-air missile launcher', 'Anti-Aircraft Guns', 3889, 'State-of-the-art defense system against aerial threats', 85);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (5, 'surface-to-air missile launcher', 'Missile Defense', 7829, 'Innovative solution for safeguarding against airborne attacks', 136);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (6, 'air defense artillery gun', 'Anti-Aircraft Guns', 1914, 'Highly advanced missile system designed for intercepting enemy aircraft', 150);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (7, 'missile defense system', 'Missile Defense', 4957, 'Innovative solution for safeguarding against airborne attacks', 8);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (8, 'counter-drone jammer', 'Missile Defense', 6649, 'Top-secret missile technology for national security', 183);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (9, 'drone detection radar', 'Missile Defense', 1380, 'State-of-the-art defense system against aerial threats', 606);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (10, 'missile defense system', 'Missile Defense', 8844, 'Top-secret missile technology for national security', 786);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (11, 'drone detection radar', 'Missile Defense', 7300, 'State-of-the-art defense system against aerial threats', 608);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (12, 'counter-drone jammer', 'Missile Defense', 7682, 'Highly advanced missile system designed for intercepting enemy aircraft', 956);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (13, 'counter-drone jammer', 'Anti-Aircraft Guns', 2059, 'State-of-the-art defense system against aerial threats', 261);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (14, 'missile defense system', 'Anti-Aircraft Guns', 9169, 'Cutting-edge technology for protecting airspace', 247);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (15, 'drone detection radar', 'Radar Detection', 8012, 'Innovative solution for safeguarding against airborne attacks', 439);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (16, 'anti-aircraft missile system', 'Missile Defense', 8240, 'State-of-the-art defense system against aerial threats', 507);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (17, 'surface-to-air missile launcher', 'Anti-Aircraft Guns', 9085, 'Highly advanced missile system designed for intercepting enemy aircraft', 854);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (18, 'surface-to-air missile launcher', 'Radar Detection', 9687, 'Top-secret missile technology for national security', 934);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (19, 'missile defense system', 'Anti-Aircraft Guns', 7533, 'Highly advanced missile system designed for intercepting enemy aircraft', 639);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (20, 'counter-drone jammer', 'Anti-Aircraft Guns', 2600, 'Highly advanced missile system designed for intercepting enemy aircraft', 133);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (21, 'missile defense system', 'Missile Defense', 7116, 'Highly advanced missile system designed for intercepting enemy aircraft', 394);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (22, 'surface-to-air missile launcher', 'Radar Detection', 3602, 'Cutting-edge technology for protecting airspace', 368);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (23, 'anti-aircraft missile system', 'Radar Detection', 3290, 'Highly advanced missile system designed for intercepting enemy aircraft', 160);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (24, 'anti-aircraft missile system', 'Anti-Aircraft Guns', 1254, 'Top-secret missile technology for national security', 304);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (25, 'drone detection radar', 'Radar Detection', 1299, 'Top-secret missile technology for national security', 152);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (26, 'counter-drone jammer', 'Anti-Aircraft Guns', 2760, 'State-of-the-art defense system against aerial threats', 512);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (27, 'counter-drone jammer', 'Missile Defense', 6889, 'Highly advanced missile system designed for intercepting enemy aircraft', 842);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (28, 'drone detection radar', 'Radar Detection', 1044, 'Top-secret missile technology for national security', 344);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (29, 'air defense artillery gun', 'Radar Detection', 3284, 'Top-secret missile technology for national security', 722);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (30, 'missile defense system', 'Anti-Aircraft Guns', 4693, 'Highly advanced missile system designed for intercepting enemy aircraft', 152);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (31, 'drone detection radar', 'Missile Defense', 7228, 'State-of-the-art defense system against aerial threats', 151);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (32, 'surface-to-air missile launcher', 'Anti-Aircraft Guns', 8372, 'Innovative solution for safeguarding against airborne attacks', 769);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (33, 'air defense artillery gun', 'Missile Defense', 1877, 'Top-secret missile technology for national security', 723);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (34, 'air defense artillery gun', 'Radar Detection', 3190, 'Highly advanced missile system designed for intercepting enemy aircraft', 429);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (35, 'surface-to-air missile launcher', 'Anti-Aircraft Guns', 5750, 'Cutting-edge technology for protecting airspace', 734);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (36, 'air defense artillery gun', 'Missile Defense', 1965, 'State-of-the-art defense system against aerial threats', 936);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (37, 'anti-aircraft missile system', 'Missile Defense', 6404, 'Innovative solution for safeguarding against airborne attacks', 130);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (38, 'air defense artillery gun', 'Radar Detection', 2546, 'Top-secret missile technology for national security', 705);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (39, 'drone detection radar', 'Radar Detection', 7049, 'Innovative solution for safeguarding against airborne attacks', 764);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (40, 'drone detection radar', 'Radar Detection', 8667, 'Innovative solution for safeguarding against airborne attacks', 440);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (41, 'drone detection radar', 'Anti-Aircraft Guns', 2643, 'Innovative solution for safeguarding against airborne attacks', 407);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (42, 'missile defense system', 'Anti-Aircraft Guns', 1368, 'Innovative solution for safeguarding against airborne attacks', 482);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (43, 'counter-drone jammer', 'Anti-Aircraft Guns', 2442, 'Innovative solution for safeguarding against airborne attacks', 616);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (44, 'air defense artillery gun', 'Missile Defense', 6473, 'Highly advanced missile system designed for intercepting enemy aircraft', 757);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (45, 'air defense artillery gun', 'Anti-Aircraft Guns', 3173, 'State-of-the-art defense system against aerial threats', 543);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (46, 'missile defense system', 'Missile Defense', 5921, 'Innovative solution for safeguarding against airborne attacks', 55);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (47, 'anti-aircraft missile system', 'Missile Defense', 8618, 'Cutting-edge technology for protecting airspace', 413);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (48, 'counter-drone jammer', 'Radar Detection', 7630, 'Cutting-edge technology for protecting airspace', 444);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (49, 'air defense artillery gun', 'Missile Defense', 6172, 'Top-secret missile technology for national security', 793);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (50, 'surface-to-air missile launcher', 'Radar Detection', 4989, 'State-of-the-art defense system against aerial threats', 9);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (51, 'anti-aircraft missile system', 'Anti-Aircraft Guns', 4020, 'State-of-the-art defense system against aerial threats', 853);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (52, 'counter-drone jammer', 'Anti-Aircraft Guns', 4621, 'State-of-the-art defense system against aerial threats', 300);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (53, 'counter-drone jammer', 'Radar Detection', 1970, 'Highly advanced missile system designed for intercepting enemy aircraft', 379);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (54, 'counter-drone jammer', 'Anti-Aircraft Guns', 9387, 'Top-secret missile technology for national security', 916);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (55, 'drone detection radar', 'Missile Defense', 7723, 'Top-secret missile technology for national security', 616);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (56, 'drone detection radar', 'Missile Defense', 1948, 'Innovative solution for safeguarding against airborne attacks', 169);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (57, 'anti-aircraft missile system', 'Radar Detection', 6676, 'State-of-the-art defense system against aerial threats', 79);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (58, 'missile defense system', 'Missile Defense', 1206, 'Cutting-edge technology for protecting airspace', 375);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (59, 'drone detection radar', 'Radar Detection', 6424, 'State-of-the-art defense system against aerial threats', 721);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (60, 'surface-to-air missile launcher', 'Radar Detection', 5585, 'Top-secret missile technology for national security', 942);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (61, 'counter-drone jammer', 'Radar Detection', 9431, 'State-of-the-art defense system against aerial threats', 453);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (62, 'air defense artillery gun', 'Anti-Aircraft Guns', 1642, 'Highly advanced missile system designed for intercepting enemy aircraft', 813);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (63, 'drone detection radar', 'Missile Defense', 7910, 'State-of-the-art defense system against aerial threats', 278);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (64, 'anti-aircraft missile system', 'Missile Defense', 3712, 'State-of-the-art defense system against aerial threats', 709);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (65, 'anti-aircraft missile system', 'Radar Detection', 4495, 'Highly advanced missile system designed for intercepting enemy aircraft', 417);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (66, 'anti-aircraft missile system', 'Radar Detection', 2051, 'Highly advanced missile system designed for intercepting enemy aircraft', 305);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (67, 'counter-drone jammer', 'Anti-Aircraft Guns', 8000, 'Innovative solution for safeguarding against airborne attacks', 292);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (68, 'air defense artillery gun', 'Radar Detection', 6236, 'Top-secret missile technology for national security', 717);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (69, 'drone detection radar', 'Radar Detection', 1932, 'Cutting-edge technology for protecting airspace', 229);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (70, 'counter-drone jammer', 'Radar Detection', 2047, 'Top-secret missile technology for national security', 700);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (71, 'counter-drone jammer', 'Radar Detection', 5475, 'Top-secret missile technology for national security', 350);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (72, 'air defense artillery gun', 'Missile Defense', 1104, 'Innovative solution for safeguarding against airborne attacks', 342);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (73, 'counter-drone jammer', 'Radar Detection', 8131, 'Highly advanced missile system designed for intercepting enemy aircraft', 147);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (74, 'anti-aircraft missile system', 'Radar Detection', 6406, 'Highly advanced missile system designed for intercepting enemy aircraft', 762);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (75, 'air defense artillery gun', 'Radar Detection', 7788, 'State-of-the-art defense system against aerial threats', 15);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (76, 'missile defense system', 'Radar Detection', 9603, 'Top-secret missile technology for national security', 248);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (77, 'missile defense system', 'Anti-Aircraft Guns', 2641, 'Innovative solution for safeguarding against airborne attacks', 74);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (78, 'counter-drone jammer', 'Missile Defense', 6100, 'Top-secret missile technology for national security', 370);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (79, 'surface-to-air missile launcher', 'Radar Detection', 2747, 'Top-secret missile technology for national security', 436);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (80, 'anti-aircraft missile system', 'Anti-Aircraft Guns', 9337, 'State-of-the-art defense system against aerial threats', 665);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (81, 'missile defense system', 'Anti-Aircraft Guns', 1295, 'Cutting-edge technology for protecting airspace', 736);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (82, 'air defense artillery gun', 'Missile Defense', 7901, 'State-of-the-art defense system against aerial threats', 982);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (83, 'missile defense system', 'Radar Detection', 1075, 'State-of-the-art defense system against aerial threats', 774);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (84, 'missile defense system', 'Anti-Aircraft Guns', 2235, 'Innovative solution for safeguarding against airborne attacks', 347);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (85, 'anti-aircraft missile system', 'Anti-Aircraft Guns', 3341, 'Highly advanced missile system designed for intercepting enemy aircraft', 729);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (86, 'anti-aircraft missile system', 'Missile Defense', 7989, 'Top-secret missile technology for national security', 377);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (87, 'counter-drone jammer', 'Anti-Aircraft Guns', 3659, 'Innovative solution for safeguarding against airborne attacks', 379);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (88, 'anti-aircraft missile system', 'Radar Detection', 8323, 'Highly advanced missile system designed for intercepting enemy aircraft', 560);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (89, 'drone detection radar', 'Anti-Aircraft Guns', 9786, 'Cutting-edge technology for protecting airspace', 712);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (90, 'air defense artillery gun', 'Radar Detection', 4454, 'Highly advanced missile system designed for intercepting enemy aircraft', 81);
commit;
prompt 500 records committed...
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (91, 'air defense artillery gun', 'Radar Detection', 5829, 'State-of-the-art defense system against aerial threats', 904);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (92, 'surface-to-air missile launcher', 'Anti-Aircraft Guns', 6190, 'Highly advanced missile system designed for intercepting enemy aircraft', 46);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (93, 'counter-drone jammer', 'Missile Defense', 8672, 'Cutting-edge technology for protecting airspace', 956);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (94, 'drone detection radar', 'Missile Defense', 8331, 'Top-secret missile technology for national security', 930);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (95, 'counter-drone jammer', 'Radar Detection', 4751, 'Top-secret missile technology for national security', 803);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (96, 'air defense artillery gun', 'Anti-Aircraft Guns', 2294, 'Top-secret missile technology for national security', 104);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (97, 'counter-drone jammer', 'Missile Defense', 7385, 'State-of-the-art defense system against aerial threats', 833);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (98, 'missile defense system', 'Radar Detection', 3621, 'Cutting-edge technology for protecting airspace', 762);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (99, 'drone detection radar', 'Radar Detection', 2256, 'State-of-the-art defense system against aerial threats', 857);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (100, 'anti-aircraft missile system', 'Radar Detection', 3588, 'Highly advanced missile system designed for intercepting enemy aircraft', 192);
commit;
prompt 510 records loaded
prompt Loading PART_OF...
insert into PART_OF (orderid, productid)
values (1, 1);
insert into PART_OF (orderid, productid)
values (3, 3);
insert into PART_OF (orderid, productid)
values (4, 4);
insert into PART_OF (orderid, productid)
values (5, 5);
insert into PART_OF (orderid, productid)
values (6, 6);
insert into PART_OF (orderid, productid)
values (7, 7);
insert into PART_OF (orderid, productid)
values (8, 8);
insert into PART_OF (orderid, productid)
values (9, 9);
insert into PART_OF (orderid, productid)
values (10, 10);
insert into PART_OF (orderid, productid)
values (11, 11);
insert into PART_OF (orderid, productid)
values (12, 12);
insert into PART_OF (orderid, productid)
values (13, 13);
insert into PART_OF (orderid, productid)
values (14, 14);
insert into PART_OF (orderid, productid)
values (15, 15);
insert into PART_OF (orderid, productid)
values (16, 16);
insert into PART_OF (orderid, productid)
values (17, 17);
insert into PART_OF (orderid, productid)
values (18, 18);
insert into PART_OF (orderid, productid)
values (19, 19);
insert into PART_OF (orderid, productid)
values (20, 20);
insert into PART_OF (orderid, productid)
values (21, 21);
insert into PART_OF (orderid, productid)
values (22, 22);
insert into PART_OF (orderid, productid)
values (23, 23);
insert into PART_OF (orderid, productid)
values (24, 24);
insert into PART_OF (orderid, productid)
values (25, 25);
insert into PART_OF (orderid, productid)
values (26, 26);
insert into PART_OF (orderid, productid)
values (27, 27);
insert into PART_OF (orderid, productid)
values (28, 28);
insert into PART_OF (orderid, productid)
values (29, 29);
insert into PART_OF (orderid, productid)
values (30, 30);
insert into PART_OF (orderid, productid)
values (31, 31);
insert into PART_OF (orderid, productid)
values (32, 32);
insert into PART_OF (orderid, productid)
values (33, 33);
insert into PART_OF (orderid, productid)
values (34, 34);
insert into PART_OF (orderid, productid)
values (35, 35);
insert into PART_OF (orderid, productid)
values (36, 36);
insert into PART_OF (orderid, productid)
values (37, 37);
insert into PART_OF (orderid, productid)
values (38, 38);
insert into PART_OF (orderid, productid)
values (39, 39);
insert into PART_OF (orderid, productid)
values (40, 40);
insert into PART_OF (orderid, productid)
values (41, 41);
insert into PART_OF (orderid, productid)
values (42, 42);
insert into PART_OF (orderid, productid)
values (43, 43);
insert into PART_OF (orderid, productid)
values (44, 44);
insert into PART_OF (orderid, productid)
values (45, 45);
insert into PART_OF (orderid, productid)
values (46, 46);
insert into PART_OF (orderid, productid)
values (47, 47);
insert into PART_OF (orderid, productid)
values (48, 48);
insert into PART_OF (orderid, productid)
values (49, 49);
insert into PART_OF (orderid, productid)
values (50, 50);
insert into PART_OF (orderid, productid)
values (51, 51);
insert into PART_OF (orderid, productid)
values (52, 52);
insert into PART_OF (orderid, productid)
values (53, 53);
insert into PART_OF (orderid, productid)
values (54, 54);
insert into PART_OF (orderid, productid)
values (55, 55);
insert into PART_OF (orderid, productid)
values (56, 56);
insert into PART_OF (orderid, productid)
values (57, 57);
insert into PART_OF (orderid, productid)
values (58, 58);
insert into PART_OF (orderid, productid)
values (59, 59);
insert into PART_OF (orderid, productid)
values (60, 60);
insert into PART_OF (orderid, productid)
values (61, 61);
insert into PART_OF (orderid, productid)
values (63, 63);
insert into PART_OF (orderid, productid)
values (64, 64);
insert into PART_OF (orderid, productid)
values (65, 65);
insert into PART_OF (orderid, productid)
values (66, 66);
insert into PART_OF (orderid, productid)
values (67, 67);
insert into PART_OF (orderid, productid)
values (68, 68);
insert into PART_OF (orderid, productid)
values (69, 69);
insert into PART_OF (orderid, productid)
values (70, 70);
insert into PART_OF (orderid, productid)
values (71, 71);
insert into PART_OF (orderid, productid)
values (72, 72);
insert into PART_OF (orderid, productid)
values (73, 73);
insert into PART_OF (orderid, productid)
values (74, 74);
insert into PART_OF (orderid, productid)
values (75, 75);
insert into PART_OF (orderid, productid)
values (76, 76);
insert into PART_OF (orderid, productid)
values (77, 77);
insert into PART_OF (orderid, productid)
values (78, 78);
insert into PART_OF (orderid, productid)
values (79, 79);
insert into PART_OF (orderid, productid)
values (80, 80);
insert into PART_OF (orderid, productid)
values (81, 81);
insert into PART_OF (orderid, productid)
values (82, 82);
insert into PART_OF (orderid, productid)
values (83, 83);
insert into PART_OF (orderid, productid)
values (84, 84);
insert into PART_OF (orderid, productid)
values (85, 85);
insert into PART_OF (orderid, productid)
values (86, 86);
insert into PART_OF (orderid, productid)
values (87, 87);
insert into PART_OF (orderid, productid)
values (88, 88);
insert into PART_OF (orderid, productid)
values (89, 89);
insert into PART_OF (orderid, productid)
values (90, 90);
insert into PART_OF (orderid, productid)
values (91, 91);
insert into PART_OF (orderid, productid)
values (92, 92);
insert into PART_OF (orderid, productid)
values (93, 93);
insert into PART_OF (orderid, productid)
values (94, 94);
insert into PART_OF (orderid, productid)
values (95, 95);
insert into PART_OF (orderid, productid)
values (96, 96);
insert into PART_OF (orderid, productid)
values (97, 97);
insert into PART_OF (orderid, productid)
values (98, 98);
insert into PART_OF (orderid, productid)
values (99, 99);
insert into PART_OF (orderid, productid)
values (100, 100);
insert into PART_OF (orderid, productid)
values (1001, 2001);
insert into PART_OF (orderid, productid)
values (1002, 2003);
commit;
prompt 100 records committed...
insert into PART_OF (orderid, productid)
values (1003, 2002);
insert into PART_OF (orderid, productid)
values (1004, 2004);
insert into PART_OF (orderid, productid)
values (1005, 2001);
insert into PART_OF (orderid, productid)
values (1006, 2005);
insert into PART_OF (orderid, productid)
values (1008, 2007);
insert into PART_OF (orderid, productid)
values (1009, 2008);
insert into PART_OF (orderid, productid)
values (1010, 2009);
insert into PART_OF (orderid, productid)
values (10192467, 87359535);
insert into PART_OF (orderid, productid)
values (10305725, 27217548);
insert into PART_OF (orderid, productid)
values (10305725, 74481633);
insert into PART_OF (orderid, productid)
values (10382740, 50701261);
insert into PART_OF (orderid, productid)
values (10430257, 54464675);
insert into PART_OF (orderid, productid)
values (10987595, 63905530);
insert into PART_OF (orderid, productid)
values (11621396, 77924243);
insert into PART_OF (orderid, productid)
values (11952928, 54464675);
insert into PART_OF (orderid, productid)
values (12071508, 36761506);
insert into PART_OF (orderid, productid)
values (12467208, 90624166);
insert into PART_OF (orderid, productid)
values (12542125, 13202210);
insert into PART_OF (orderid, productid)
values (13175349, 58362577);
insert into PART_OF (orderid, productid)
values (13453977, 76605006);
insert into PART_OF (orderid, productid)
values (13655348, 39696777);
insert into PART_OF (orderid, productid)
values (13678080, 44874286);
insert into PART_OF (orderid, productid)
values (13678080, 62524908);
insert into PART_OF (orderid, productid)
values (13865454, 72215992);
insert into PART_OF (orderid, productid)
values (13894585, 29053220);
insert into PART_OF (orderid, productid)
values (14765097, 74238626);
insert into PART_OF (orderid, productid)
values (14765097, 82538648);
insert into PART_OF (orderid, productid)
values (14955002, 39688154);
insert into PART_OF (orderid, productid)
values (14955002, 97741459);
insert into PART_OF (orderid, productid)
values (15353698, 24624743);
insert into PART_OF (orderid, productid)
values (15702316, 16848056);
insert into PART_OF (orderid, productid)
values (15776963, 47983175);
insert into PART_OF (orderid, productid)
values (16212701, 19113525);
insert into PART_OF (orderid, productid)
values (16212701, 56595369);
insert into PART_OF (orderid, productid)
values (16212701, 63108288);
insert into PART_OF (orderid, productid)
values (16472279, 55104686);
insert into PART_OF (orderid, productid)
values (17246868, 38209402);
insert into PART_OF (orderid, productid)
values (17246868, 78988523);
insert into PART_OF (orderid, productid)
values (17501794, 74481633);
insert into PART_OF (orderid, productid)
values (17501794, 82740130);
insert into PART_OF (orderid, productid)
values (18215069, 66490968);
insert into PART_OF (orderid, productid)
values (18530627, 53029103);
insert into PART_OF (orderid, productid)
values (18689125, 51270374);
insert into PART_OF (orderid, productid)
values (18863880, 32922901);
insert into PART_OF (orderid, productid)
values (18863880, 77649101);
insert into PART_OF (orderid, productid)
values (19184254, 67110125);
insert into PART_OF (orderid, productid)
values (19420366, 61662500);
insert into PART_OF (orderid, productid)
values (19420366, 65637181);
insert into PART_OF (orderid, productid)
values (19499955, 15086996);
insert into PART_OF (orderid, productid)
values (19499955, 95217918);
insert into PART_OF (orderid, productid)
values (19515460, 45618284);
insert into PART_OF (orderid, productid)
values (19515460, 48461944);
insert into PART_OF (orderid, productid)
values (19605806, 13202210);
insert into PART_OF (orderid, productid)
values (20358216, 16635517);
insert into PART_OF (orderid, productid)
values (20558212, 15810430);
insert into PART_OF (orderid, productid)
values (20734597, 34484754);
insert into PART_OF (orderid, productid)
values (21478126, 17232221);
insert into PART_OF (orderid, productid)
values (21478126, 53495144);
insert into PART_OF (orderid, productid)
values (21478126, 74238626);
insert into PART_OF (orderid, productid)
values (21598115, 33068797);
insert into PART_OF (orderid, productid)
values (21598115, 33656697);
insert into PART_OF (orderid, productid)
values (21681616, 38493926);
insert into PART_OF (orderid, productid)
values (21800008, 69310476);
insert into PART_OF (orderid, productid)
values (21800008, 95710423);
insert into PART_OF (orderid, productid)
values (22095269, 52860099);
insert into PART_OF (orderid, productid)
values (22095269, 77186529);
insert into PART_OF (orderid, productid)
values (22234324, 19956426);
insert into PART_OF (orderid, productid)
values (22234324, 26037554);
insert into PART_OF (orderid, productid)
values (22310745, 26109737);
insert into PART_OF (orderid, productid)
values (22717205, 96325838);
insert into PART_OF (orderid, productid)
values (22717205, 97116635);
insert into PART_OF (orderid, productid)
values (22908574, 57799235);
insert into PART_OF (orderid, productid)
values (22908574, 60637238);
insert into PART_OF (orderid, productid)
values (23125267, 83740728);
insert into PART_OF (orderid, productid)
values (23544731, 74811349);
insert into PART_OF (orderid, productid)
values (23589087, 10218924);
insert into PART_OF (orderid, productid)
values (24073410, 18431796);
insert into PART_OF (orderid, productid)
values (24073410, 19883552);
insert into PART_OF (orderid, productid)
values (24348217, 49437140);
insert into PART_OF (orderid, productid)
values (24432556, 52051185);
insert into PART_OF (orderid, productid)
values (24467919, 90350934);
insert into PART_OF (orderid, productid)
values (24467919, 94430363);
insert into PART_OF (orderid, productid)
values (24588483, 76721156);
insert into PART_OF (orderid, productid)
values (24588483, 94281414);
insert into PART_OF (orderid, productid)
values (24828386, 84934979);
insert into PART_OF (orderid, productid)
values (24851597, 13785968);
insert into PART_OF (orderid, productid)
values (24851597, 29333024);
insert into PART_OF (orderid, productid)
values (25571560, 72457291);
insert into PART_OF (orderid, productid)
values (25729191, 10272702);
insert into PART_OF (orderid, productid)
values (25729191, 29053220);
insert into PART_OF (orderid, productid)
values (26407563, 18518062);
insert into PART_OF (orderid, productid)
values (26451191, 10489791);
insert into PART_OF (orderid, productid)
values (26488051, 25195559);
insert into PART_OF (orderid, productid)
values (26488051, 43573377);
insert into PART_OF (orderid, productid)
values (26773815, 43743302);
insert into PART_OF (orderid, productid)
values (26773815, 95079291);
insert into PART_OF (orderid, productid)
values (26966572, 67378100);
insert into PART_OF (orderid, productid)
values (26966572, 89572356);
insert into PART_OF (orderid, productid)
values (27077982, 15010285);
insert into PART_OF (orderid, productid)
values (27142082, 84504734);
commit;
prompt 200 records committed...
insert into PART_OF (orderid, productid)
values (27950422, 63914094);
insert into PART_OF (orderid, productid)
values (28312002, 73128554);
insert into PART_OF (orderid, productid)
values (28312002, 77082176);
insert into PART_OF (orderid, productid)
values (28467705, 67378100);
insert into PART_OF (orderid, productid)
values (28556162, 58234110);
insert into PART_OF (orderid, productid)
values (29679569, 75670548);
insert into PART_OF (orderid, productid)
values (30694864, 60637238);
insert into PART_OF (orderid, productid)
values (30916140, 14104712);
insert into PART_OF (orderid, productid)
values (30916140, 90908512);
insert into PART_OF (orderid, productid)
values (30977297, 23749871);
insert into PART_OF (orderid, productid)
values (30977297, 54638911);
insert into PART_OF (orderid, productid)
values (31900293, 62170165);
insert into PART_OF (orderid, productid)
values (32141175, 27830024);
insert into PART_OF (orderid, productid)
values (32141175, 32922901);
insert into PART_OF (orderid, productid)
values (32377066, 67110125);
insert into PART_OF (orderid, productid)
values (32377066, 67520924);
insert into PART_OF (orderid, productid)
values (32605534, 13202210);
insert into PART_OF (orderid, productid)
values (32605534, 53262312);
insert into PART_OF (orderid, productid)
values (33029912, 14104712);
insert into PART_OF (orderid, productid)
values (33029912, 84531922);
insert into PART_OF (orderid, productid)
values (33029912, 86689983);
insert into PART_OF (orderid, productid)
values (33104440, 27383241);
insert into PART_OF (orderid, productid)
values (33104440, 54464675);
insert into PART_OF (orderid, productid)
values (33104440, 80480299);
insert into PART_OF (orderid, productid)
values (33865478, 40050450);
insert into PART_OF (orderid, productid)
values (33865478, 41324792);
insert into PART_OF (orderid, productid)
values (33880439, 77924243);
insert into PART_OF (orderid, productid)
values (34070155, 39740589);
insert into PART_OF (orderid, productid)
values (34070155, 87359535);
insert into PART_OF (orderid, productid)
values (34940037, 13670067);
insert into PART_OF (orderid, productid)
values (34940037, 28470422);
insert into PART_OF (orderid, productid)
values (35376470, 15933206);
insert into PART_OF (orderid, productid)
values (37058869, 20414247);
insert into PART_OF (orderid, productid)
values (37058869, 75916838);
insert into PART_OF (orderid, productid)
values (38411452, 15933206);
insert into PART_OF (orderid, productid)
values (39543197, 15086996);
insert into PART_OF (orderid, productid)
values (39867776, 37537147);
insert into PART_OF (orderid, productid)
values (40247234, 35412535);
insert into PART_OF (orderid, productid)
values (40766213, 70982821);
insert into PART_OF (orderid, productid)
values (41035537, 27217548);
insert into PART_OF (orderid, productid)
values (41182271, 82538648);
insert into PART_OF (orderid, productid)
values (41255137, 97537164);
insert into PART_OF (orderid, productid)
values (41255654, 53853471);
insert into PART_OF (orderid, productid)
values (41470462, 46237521);
insert into PART_OF (orderid, productid)
values (41470462, 49838349);
insert into PART_OF (orderid, productid)
values (41624014, 15933206);
insert into PART_OF (orderid, productid)
values (41757137, 60637238);
insert into PART_OF (orderid, productid)
values (41832458, 53262312);
insert into PART_OF (orderid, productid)
values (42291147, 53029103);
insert into PART_OF (orderid, productid)
values (43278317, 26576933);
insert into PART_OF (orderid, productid)
values (43278317, 76011409);
insert into PART_OF (orderid, productid)
values (43656591, 40661758);
insert into PART_OF (orderid, productid)
values (43656591, 42848333);
insert into PART_OF (orderid, productid)
values (43980980, 23417008);
insert into PART_OF (orderid, productid)
values (45093026, 37537147);
insert into PART_OF (orderid, productid)
values (45137073, 26037554);
insert into PART_OF (orderid, productid)
values (45137073, 77018735);
insert into PART_OF (orderid, productid)
values (45168516, 15010285);
insert into PART_OF (orderid, productid)
values (45168516, 52321455);
insert into PART_OF (orderid, productid)
values (45168516, 54295504);
insert into PART_OF (orderid, productid)
values (45957679, 54839245);
insert into PART_OF (orderid, productid)
values (45957679, 99180091);
insert into PART_OF (orderid, productid)
values (46120475, 22935393);
insert into PART_OF (orderid, productid)
values (46317105, 31750484);
insert into PART_OF (orderid, productid)
values (46317105, 56595369);
insert into PART_OF (orderid, productid)
values (46317105, 80751769);
insert into PART_OF (orderid, productid)
values (46317105, 82954240);
insert into PART_OF (orderid, productid)
values (46702526, 39511933);
insert into PART_OF (orderid, productid)
values (46702526, 61046293);
insert into PART_OF (orderid, productid)
values (47109265, 62537595);
insert into PART_OF (orderid, productid)
values (48323552, 35823728);
insert into PART_OF (orderid, productid)
values (48323552, 75916838);
insert into PART_OF (orderid, productid)
values (48400394, 28643747);
insert into PART_OF (orderid, productid)
values (48634180, 24624743);
insert into PART_OF (orderid, productid)
values (49252991, 61654331);
insert into PART_OF (orderid, productid)
values (49252991, 90587843);
insert into PART_OF (orderid, productid)
values (49410269, 63428253);
insert into PART_OF (orderid, productid)
values (49791831, 68172768);
insert into PART_OF (orderid, productid)
values (50633001, 15010285);
insert into PART_OF (orderid, productid)
values (50633001, 39059038);
insert into PART_OF (orderid, productid)
values (50633001, 48461944);
insert into PART_OF (orderid, productid)
values (50633001, 53853471);
insert into PART_OF (orderid, productid)
values (50995796, 26109737);
insert into PART_OF (orderid, productid)
values (50995796, 47983175);
insert into PART_OF (orderid, productid)
values (51814617, 23302061);
insert into PART_OF (orderid, productid)
values (51814617, 56316096);
insert into PART_OF (orderid, productid)
values (51814617, 74060004);
insert into PART_OF (orderid, productid)
values (51814617, 84758782);
insert into PART_OF (orderid, productid)
values (52038292, 33656697);
insert into PART_OF (orderid, productid)
values (52409037, 67385751);
insert into PART_OF (orderid, productid)
values (52704646, 54839245);
insert into PART_OF (orderid, productid)
values (52737198, 16573750);
insert into PART_OF (orderid, productid)
values (52924480, 33609459);
insert into PART_OF (orderid, productid)
values (53423705, 19883552);
insert into PART_OF (orderid, productid)
values (53526720, 37108881);
insert into PART_OF (orderid, productid)
values (53731358, 84504734);
insert into PART_OF (orderid, productid)
values (53884663, 51504705);
insert into PART_OF (orderid, productid)
values (53884663, 87202332);
insert into PART_OF (orderid, productid)
values (53884663, 90587843);
insert into PART_OF (orderid, productid)
values (54193889, 73934948);
commit;
prompt 300 records committed...
insert into PART_OF (orderid, productid)
values (54297355, 26037554);
insert into PART_OF (orderid, productid)
values (54297355, 91685383);
insert into PART_OF (orderid, productid)
values (54478764, 54464675);
insert into PART_OF (orderid, productid)
values (54478764, 61807752);
insert into PART_OF (orderid, productid)
values (54976001, 70444263);
insert into PART_OF (orderid, productid)
values (54976001, 90148050);
insert into PART_OF (orderid, productid)
values (55109827, 16848056);
insert into PART_OF (orderid, productid)
values (55109827, 75149619);
insert into PART_OF (orderid, productid)
values (55109827, 77186529);
insert into PART_OF (orderid, productid)
values (55489053, 34484754);
insert into PART_OF (orderid, productid)
values (55489053, 66338365);
insert into PART_OF (orderid, productid)
values (56270335, 76011409);
insert into PART_OF (orderid, productid)
values (56270335, 78713682);
insert into PART_OF (orderid, productid)
values (56270335, 82954240);
insert into PART_OF (orderid, productid)
values (56814186, 37938545);
insert into PART_OF (orderid, productid)
values (56814186, 40050450);
insert into PART_OF (orderid, productid)
values (57794058, 90130674);
insert into PART_OF (orderid, productid)
values (57859448, 50190784);
insert into PART_OF (orderid, productid)
values (58100144, 74811349);
insert into PART_OF (orderid, productid)
values (58495697, 32922901);
insert into PART_OF (orderid, productid)
values (58587967, 74238626);
insert into PART_OF (orderid, productid)
values (58683634, 90587843);
insert into PART_OF (orderid, productid)
values (59190855, 69622091);
insert into PART_OF (orderid, productid)
values (59217071, 27619560);
insert into PART_OF (orderid, productid)
values (59217071, 87359535);
insert into PART_OF (orderid, productid)
values (59405013, 39358839);
insert into PART_OF (orderid, productid)
values (59405013, 40768147);
insert into PART_OF (orderid, productid)
values (59405013, 41324792);
insert into PART_OF (orderid, productid)
values (59405013, 43743302);
insert into PART_OF (orderid, productid)
values (59543351, 44438776);
insert into PART_OF (orderid, productid)
values (60607678, 15116737);
insert into PART_OF (orderid, productid)
values (60774397, 76334389);
insert into PART_OF (orderid, productid)
values (60774397, 94450071);
insert into PART_OF (orderid, productid)
values (61010625, 51803362);
insert into PART_OF (orderid, productid)
values (61050698, 41324792);
insert into PART_OF (orderid, productid)
values (61050698, 75150699);
insert into PART_OF (orderid, productid)
values (61075688, 13670067);
insert into PART_OF (orderid, productid)
values (61075688, 92678457);
insert into PART_OF (orderid, productid)
values (61102235, 99180091);
insert into PART_OF (orderid, productid)
values (61623388, 47428096);
insert into PART_OF (orderid, productid)
values (61751721, 58773159);
insert into PART_OF (orderid, productid)
values (62484334, 25195559);
insert into PART_OF (orderid, productid)
values (62484334, 27444360);
insert into PART_OF (orderid, productid)
values (62827313, 37537147);
insert into PART_OF (orderid, productid)
values (62827313, 97221575);
insert into PART_OF (orderid, productid)
values (63703457, 15679639);
insert into PART_OF (orderid, productid)
values (63703457, 26907813);
insert into PART_OF (orderid, productid)
values (64591321, 33068797);
insert into PART_OF (orderid, productid)
values (64782384, 44874286);
insert into PART_OF (orderid, productid)
values (64782384, 69310476);
insert into PART_OF (orderid, productid)
values (65395727, 61807752);
insert into PART_OF (orderid, productid)
values (65439870, 15810430);
insert into PART_OF (orderid, productid)
values (65439870, 29053667);
insert into PART_OF (orderid, productid)
values (65439870, 41339487);
insert into PART_OF (orderid, productid)
values (65921313, 28643747);
insert into PART_OF (orderid, productid)
values (65921313, 97221575);
insert into PART_OF (orderid, productid)
values (66319658, 17729757);
insert into PART_OF (orderid, productid)
values (66319658, 18518062);
insert into PART_OF (orderid, productid)
values (66319658, 58536080);
insert into PART_OF (orderid, productid)
values (67149382, 55104686);
insert into PART_OF (orderid, productid)
values (67149382, 75916838);
insert into PART_OF (orderid, productid)
values (67149382, 86830652);
insert into PART_OF (orderid, productid)
values (67149382, 90624166);
insert into PART_OF (orderid, productid)
values (67606267, 29053667);
insert into PART_OF (orderid, productid)
values (67606267, 82954240);
insert into PART_OF (orderid, productid)
values (67618229, 21644659);
insert into PART_OF (orderid, productid)
values (67618229, 65205896);
insert into PART_OF (orderid, productid)
values (67618229, 77924243);
insert into PART_OF (orderid, productid)
values (67838607, 17729757);
insert into PART_OF (orderid, productid)
values (67838607, 21644659);
insert into PART_OF (orderid, productid)
values (67838607, 44438776);
insert into PART_OF (orderid, productid)
values (67838607, 90587843);
insert into PART_OF (orderid, productid)
values (68774075, 13929744);
insert into PART_OF (orderid, productid)
values (69181376, 76605006);
insert into PART_OF (orderid, productid)
values (69298889, 10272702);
insert into PART_OF (orderid, productid)
values (69298889, 16848056);
insert into PART_OF (orderid, productid)
values (69298889, 27383241);
insert into PART_OF (orderid, productid)
values (69298889, 62537595);
insert into PART_OF (orderid, productid)
values (69353175, 19484571);
insert into PART_OF (orderid, productid)
values (69465420, 58646482);
insert into PART_OF (orderid, productid)
values (69678002, 58234110);
insert into PART_OF (orderid, productid)
values (69751252, 53029103);
insert into PART_OF (orderid, productid)
values (69751252, 82538648);
insert into PART_OF (orderid, productid)
values (70103784, 11939996);
insert into PART_OF (orderid, productid)
values (70103784, 56326978);
insert into PART_OF (orderid, productid)
values (71722461, 79265468);
insert into PART_OF (orderid, productid)
values (71959629, 33259729);
insert into PART_OF (orderid, productid)
values (72675369, 33656697);
insert into PART_OF (orderid, productid)
values (72675369, 69622091);
insert into PART_OF (orderid, productid)
values (72948531, 53069001);
insert into PART_OF (orderid, productid)
values (73218368, 43475714);
insert into PART_OF (orderid, productid)
values (73218368, 60350090);
insert into PART_OF (orderid, productid)
values (73323057, 29333024);
insert into PART_OF (orderid, productid)
values (73323057, 40137354);
insert into PART_OF (orderid, productid)
values (73879529, 37806303);
insert into PART_OF (orderid, productid)
values (74624489, 66490968);
insert into PART_OF (orderid, productid)
values (74899684, 52860099);
insert into PART_OF (orderid, productid)
values (74899684, 98204172);
insert into PART_OF (orderid, productid)
values (74983375, 11939996);
insert into PART_OF (orderid, productid)
values (76040902, 40768147);
commit;
prompt 400 records committed...
insert into PART_OF (orderid, productid)
values (76040902, 94646812);
insert into PART_OF (orderid, productid)
values (76272049, 84758782);
insert into PART_OF (orderid, productid)
values (76425222, 53069001);
insert into PART_OF (orderid, productid)
values (77393215, 83460337);
insert into PART_OF (orderid, productid)
values (77393215, 95079291);
insert into PART_OF (orderid, productid)
values (77721805, 35077043);
insert into PART_OF (orderid, productid)
values (77721805, 48996797);
insert into PART_OF (orderid, productid)
values (77859088, 87202332);
insert into PART_OF (orderid, productid)
values (77870256, 59394083);
insert into PART_OF (orderid, productid)
values (77870256, 75670548);
insert into PART_OF (orderid, productid)
values (78117587, 33259729);
insert into PART_OF (orderid, productid)
values (78117587, 88012920);
insert into PART_OF (orderid, productid)
values (78226785, 25195559);
insert into PART_OF (orderid, productid)
values (78226785, 76605006);
insert into PART_OF (orderid, productid)
values (79108858, 23768294);
insert into PART_OF (orderid, productid)
values (79108858, 49437140);
insert into PART_OF (orderid, productid)
values (79244161, 18343584);
insert into PART_OF (orderid, productid)
values (79244161, 28470422);
insert into PART_OF (orderid, productid)
values (79244161, 61756786);
insert into PART_OF (orderid, productid)
values (79282436, 86706038);
insert into PART_OF (orderid, productid)
values (79958108, 75916838);
insert into PART_OF (orderid, productid)
values (81749197, 69139092);
insert into PART_OF (orderid, productid)
values (81934454, 55562290);
insert into PART_OF (orderid, productid)
values (81948881, 29053667);
insert into PART_OF (orderid, productid)
values (83206369, 59394083);
insert into PART_OF (orderid, productid)
values (83206369, 83245415);
insert into PART_OF (orderid, productid)
values (83336594, 23351240);
insert into PART_OF (orderid, productid)
values (83569400, 94152960);
insert into PART_OF (orderid, productid)
values (84172948, 50972092);
insert into PART_OF (orderid, productid)
values (85318412, 42151834);
insert into PART_OF (orderid, productid)
values (85318412, 55156404);
insert into PART_OF (orderid, productid)
values (85318412, 77018735);
insert into PART_OF (orderid, productid)
values (85318412, 99180091);
insert into PART_OF (orderid, productid)
values (85552036, 86898721);
insert into PART_OF (orderid, productid)
values (85864060, 13785968);
insert into PART_OF (orderid, productid)
values (86932521, 10489791);
insert into PART_OF (orderid, productid)
values (87428147, 48152182);
insert into PART_OF (orderid, productid)
values (87500873, 90350934);
insert into PART_OF (orderid, productid)
values (87913132, 10773159);
insert into PART_OF (orderid, productid)
values (88078973, 52661044);
insert into PART_OF (orderid, productid)
values (88543737, 91685383);
insert into PART_OF (orderid, productid)
values (88611236, 29968938);
insert into PART_OF (orderid, productid)
values (89941451, 19113525);
insert into PART_OF (orderid, productid)
values (89973187, 69584106);
insert into PART_OF (orderid, productid)
values (91524473, 62299072);
insert into PART_OF (orderid, productid)
values (91524473, 88823448);
insert into PART_OF (orderid, productid)
values (91614446, 98706106);
insert into PART_OF (orderid, productid)
values (91746327, 18343584);
insert into PART_OF (orderid, productid)
values (92450308, 96325838);
insert into PART_OF (orderid, productid)
values (92484792, 65814418);
insert into PART_OF (orderid, productid)
values (92626590, 43573377);
insert into PART_OF (orderid, productid)
values (92626590, 75670548);
insert into PART_OF (orderid, productid)
values (92828941, 63905530);
insert into PART_OF (orderid, productid)
values (92828941, 95485628);
insert into PART_OF (orderid, productid)
values (93188547, 15080196);
insert into PART_OF (orderid, productid)
values (93188547, 28641959);
insert into PART_OF (orderid, productid)
values (93279035, 17729757);
insert into PART_OF (orderid, productid)
values (93279035, 19484571);
insert into PART_OF (orderid, productid)
values (93279035, 23020416);
insert into PART_OF (orderid, productid)
values (93315303, 42449391);
insert into PART_OF (orderid, productid)
values (93966237, 97537164);
insert into PART_OF (orderid, productid)
values (94271016, 75916838);
insert into PART_OF (orderid, productid)
values (95338906, 37114268);
insert into PART_OF (orderid, productid)
values (95338906, 61807752);
insert into PART_OF (orderid, productid)
values (97151747, 24867339);
insert into PART_OF (orderid, productid)
values (97151747, 66969719);
insert into PART_OF (orderid, productid)
values (97151747, 70225563);
insert into PART_OF (orderid, productid)
values (98476811, 80751769);
insert into PART_OF (orderid, productid)
values (98476811, 82954240);
insert into PART_OF (orderid, productid)
values (99349870, 89517123);
insert into PART_OF (orderid, productid)
values (99481067, 50190784);
insert into PART_OF (orderid, productid)
values (99481067, 63108288);
insert into PART_OF (orderid, productid)
values (99481067, 77649101);
insert into PART_OF (orderid, productid)
values (99591249, 65618147);
insert into PART_OF (orderid, productid)
values (99591249, 83740728);
insert into PART_OF (orderid, productid)
values (99591249, 94450071);
insert into PART_OF (orderid, productid)
values (99782262, 18241444);
insert into PART_OF (orderid, productid)
values (99782262, 39740589);
insert into PART_OF (orderid, productid)
values (99782262, 52471844);
insert into PART_OF (orderid, productid)
values (99782262, 67382352);
insert into PART_OF (orderid, productid)
values (99782262, 82538648);
insert into PART_OF (orderid, productid)
values (99782262, 94152960);
commit;
prompt 482 records loaded
prompt Loading PAYMENT...
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (78531473, to_date('11-03-2022', 'dd-mm-yyyy'), 'stocks', 7858402, '366', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (51188634, to_date('30-12-2022', 'dd-mm-yyyy'), 'stocks', 476907, '130', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (65211572, to_date('08-02-2022', 'dd-mm-yyyy'), 'credit card', 4026463, '931', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (54823093, to_date('07-10-2022', 'dd-mm-yyyy'), 'trade', 191294, '872', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (66672843, to_date('14-02-2022', 'dd-mm-yyyy'), 'stocks', 9214200, '598', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (28145978, to_date('07-01-2022', 'dd-mm-yyyy'), 'credit card', 7858402, '127', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (33353765, to_date('14-02-2022', 'dd-mm-yyyy'), 'trade', 8133225, '357', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (54758953, to_date('18-06-2022', 'dd-mm-yyyy'), 'trade', 6118490, '880', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (46529649, to_date('06-01-2023', 'dd-mm-yyyy'), 'trade', 7304180, '830', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (78215468, to_date('07-11-2022', 'dd-mm-yyyy'), 'cash', 4884410, '842', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (69839696, to_date('02-02-2023', 'dd-mm-yyyy'), 'credit card', 9109015, '461', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (72001220, to_date('31-03-2022', 'dd-mm-yyyy'), 'stocks', 8512568, '460', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (77079969, to_date('18-02-2022', 'dd-mm-yyyy'), 'credit card', 1404278, '959', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (80139628, to_date('30-12-2022', 'dd-mm-yyyy'), 'trade', 7948446, '334', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (50621359, to_date('23-08-2022', 'dd-mm-yyyy'), 'credit card', 7586434, '167', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (38422299, to_date('17-11-2022', 'dd-mm-yyyy'), 'cash', 4677643, '932', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (30452557, to_date('23-10-2022', 'dd-mm-yyyy'), 'credit card', 5095254, '100', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (96264497, to_date('20-11-2022', 'dd-mm-yyyy'), 'credit card', 8263516, '629', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (33848018, to_date('24-07-2022', 'dd-mm-yyyy'), 'trade', 1712517, '433', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (89185612, to_date('09-11-2022', 'dd-mm-yyyy'), 'cash', 3823965, '988', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (25660932, to_date('06-09-2022', 'dd-mm-yyyy'), 'cash', 8126250, '231', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (51914629, to_date('18-02-2022', 'dd-mm-yyyy'), 'credit card', 1712517, '474', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (29241197, to_date('19-05-2022', 'dd-mm-yyyy'), 'stocks', 9876149, '965', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (62120596, to_date('25-08-2022', 'dd-mm-yyyy'), 'credit card', 3801959, '348', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (17978380, to_date('29-03-2023', 'dd-mm-yyyy'), 'stocks', 3823965, '939', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (44768095, to_date('13-06-2022', 'dd-mm-yyyy'), 'credit card', 5778795, '978', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (37469691, to_date('17-04-2022', 'dd-mm-yyyy'), 'trade', 7586434, '905', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (77097705, to_date('11-04-2022', 'dd-mm-yyyy'), 'cash', 3533692, '437', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (18312950, to_date('10-02-2022', 'dd-mm-yyyy'), 'cash', 3624043, '99', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (24231479, to_date('27-07-2022', 'dd-mm-yyyy'), 'stocks', 3682714, '341', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (89524558, to_date('27-01-2022', 'dd-mm-yyyy'), 'credit card', 8133225, '497', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (35403407, to_date('26-11-2022', 'dd-mm-yyyy'), 'credit card', 6118490, '117', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (42582460, to_date('13-08-2022', 'dd-mm-yyyy'), 'credit card', 7273772, '495', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (10814884, to_date('28-06-2022', 'dd-mm-yyyy'), 'stocks', 1365922, '485', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (16094121, to_date('28-08-2022', 'dd-mm-yyyy'), 'credit card', 9817885, '778', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (19115185, to_date('03-02-2023', 'dd-mm-yyyy'), 'trade', 4596549, '329', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (61089490, to_date('14-01-2022', 'dd-mm-yyyy'), 'cash', 971253, '597', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (45506927, to_date('24-05-2022', 'dd-mm-yyyy'), 'stocks', 112649, '797', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (26938970, to_date('27-05-2022', 'dd-mm-yyyy'), 'stocks', 8420976, '299', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (60476540, to_date('17-01-2023', 'dd-mm-yyyy'), 'cash', 9204972, '810', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (37896388, to_date('09-07-2022', 'dd-mm-yyyy'), 'trade', 5535473, '199', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (49149739, to_date('23-11-2022', 'dd-mm-yyyy'), 'credit card', 4596549, '794', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (30266961, to_date('25-08-2022', 'dd-mm-yyyy'), 'credit card', 9161472, '759', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (91271987, to_date('12-03-2022', 'dd-mm-yyyy'), 'stocks', 824473, '779', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (60200267, to_date('04-01-2022', 'dd-mm-yyyy'), 'credit card', 4835096, '102', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (41813970, to_date('18-08-2022', 'dd-mm-yyyy'), 'cash', 664031, '801', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (32108214, to_date('29-08-2022', 'dd-mm-yyyy'), 'stocks', 4081860, '749', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (72202058, to_date('03-02-2022', 'dd-mm-yyyy'), 'credit card', 6834952, '603', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (17708006, to_date('23-06-2022', 'dd-mm-yyyy'), 'trade', 3533692, '820', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (92173782, to_date('30-06-2022', 'dd-mm-yyyy'), 'credit card', 4835096, '654', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (85690115, to_date('09-07-2022', 'dd-mm-yyyy'), 'cash', 277334, '398', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (32258298, to_date('16-09-2022', 'dd-mm-yyyy'), 'credit card', 2813188, '497', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (92011249, to_date('10-03-2022', 'dd-mm-yyyy'), 'cash', 7273772, '286', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (86881856, to_date('28-03-2023', 'dd-mm-yyyy'), 'trade', 6272698, '379', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (60812318, to_date('26-01-2022', 'dd-mm-yyyy'), 'stocks', 768425, '72', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (18098270, to_date('24-08-2022', 'dd-mm-yyyy'), 'credit card', 7909283, '220', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (75961406, to_date('10-08-2022', 'dd-mm-yyyy'), 'credit card', 6221862, '478', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (39944386, to_date('17-01-2023', 'dd-mm-yyyy'), 'stocks', 7419752, '873', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (43221739, to_date('19-06-2022', 'dd-mm-yyyy'), 'credit card', 109956, '64', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (43420551, to_date('23-01-2022', 'dd-mm-yyyy'), 'trade', 768425, '741', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (43044653, to_date('29-04-2023', 'dd-mm-yyyy'), 'trade', 1536028, '175', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (42096083, to_date('13-02-2023', 'dd-mm-yyyy'), 'trade', 2551959, '625', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (13987562, to_date('16-06-2022', 'dd-mm-yyyy'), 'credit card', 7867408, '285', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (38339736, to_date('04-12-2022', 'dd-mm-yyyy'), 'trade', 8057818, '961', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (26756930, to_date('24-04-2022', 'dd-mm-yyyy'), 'trade', 1149469, '590', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (30175174, to_date('05-08-2022', 'dd-mm-yyyy'), 'cash', 5661576, '356', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (68876236, to_date('12-08-2022', 'dd-mm-yyyy'), 'trade', 4581935, '945', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (68761434, to_date('07-08-2022', 'dd-mm-yyyy'), 'stocks', 5773511, '374', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (59978945, to_date('20-10-2022', 'dd-mm-yyyy'), 'credit card', 4479408, '111', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (96498400, to_date('12-10-2022', 'dd-mm-yyyy'), 'credit card', 4081860, '730', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (97726476, to_date('03-12-2022', 'dd-mm-yyyy'), 'cash', 7953907, '264', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (15757268, to_date('02-02-2022', 'dd-mm-yyyy'), 'cash', 9373783, '737', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (34351170, to_date('02-12-2022', 'dd-mm-yyyy'), 'stocks', 6779644, '919', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (78236019, to_date('07-02-2022', 'dd-mm-yyyy'), 'stocks', 6276980, '66', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (93824261, to_date('12-01-2023', 'dd-mm-yyyy'), 'stocks', 3553936, '100', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (64939881, to_date('14-04-2022', 'dd-mm-yyyy'), 'trade', 476907, '811', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (99648843, to_date('30-07-2022', 'dd-mm-yyyy'), 'stocks', 4414039, '761', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (46786804, to_date('26-12-2022', 'dd-mm-yyyy'), 'cash', 7034776, '954', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (13277838, to_date('04-07-2022', 'dd-mm-yyyy'), 'cash', 9670086, '693', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (25837926, to_date('20-11-2022', 'dd-mm-yyyy'), 'cash', 2339042, '12', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (73156967, to_date('18-05-2022', 'dd-mm-yyyy'), 'stocks', 9491417, '560', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (77153044, to_date('23-10-2022', 'dd-mm-yyyy'), 'trade', 2546711, '52', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (84392718, to_date('26-05-2022', 'dd-mm-yyyy'), 'trade', 5054252, '356', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (91271078, to_date('01-09-2022', 'dd-mm-yyyy'), 'credit card', 5102227, '79', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (19045312, to_date('23-07-2022', 'dd-mm-yyyy'), 'credit card', 173726, '145', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (17315543, to_date('15-02-2022', 'dd-mm-yyyy'), 'credit card', 334251, '641', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (37046678, to_date('05-11-2022', 'dd-mm-yyyy'), 'trade', 8305589, '110', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (66725021, to_date('11-05-2022', 'dd-mm-yyyy'), 'credit card', 2396773, '811', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (17743413, to_date('20-03-2023', 'dd-mm-yyyy'), 'credit card', 1842955, '914', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (67608622, to_date('30-03-2022', 'dd-mm-yyyy'), 'stocks', 5207124, '440', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (42064760, to_date('25-04-2023', 'dd-mm-yyyy'), 'credit card', 9476075, '412', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (39726460, to_date('04-04-2022', 'dd-mm-yyyy'), 'stocks', 6060038, '738', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (25315571, to_date('03-04-2023', 'dd-mm-yyyy'), 'credit card', 9373783, '571', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (10095117, to_date('01-11-2022', 'dd-mm-yyyy'), 'cash', 6982410, '205', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (30594274, to_date('08-11-2022', 'dd-mm-yyyy'), 'cash', 4026463, '840', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (59218113, to_date('19-06-2022', 'dd-mm-yyyy'), 'stocks', 5826817, '782', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (92835850, to_date('05-04-2023', 'dd-mm-yyyy'), 'trade', 5131765, '739', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (57941377, to_date('06-03-2022', 'dd-mm-yyyy'), 'stocks', 7040036, '447', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (93479794, to_date('01-01-2023', 'dd-mm-yyyy'), 'stocks', 8148685, '776', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (84933714, to_date('22-02-2023', 'dd-mm-yyyy'), 'cash', 7909283, '969', null);
commit;
prompt 100 records committed...
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (45763084, to_date('12-02-2023', 'dd-mm-yyyy'), 'stocks', 1150843, '709', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (84792271, to_date('17-09-2022', 'dd-mm-yyyy'), 'stocks', 5600917, '136', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (70638158, to_date('18-09-2022', 'dd-mm-yyyy'), 'credit card', 739623, '87', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (26773012, to_date('10-02-2022', 'dd-mm-yyyy'), 'stocks', 2911813, '126', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (63315870, to_date('03-04-2022', 'dd-mm-yyyy'), 'cash', 5466780, '104', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (24146181, to_date('30-04-2023', 'dd-mm-yyyy'), 'stocks', 6212834, '352', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (40433472, to_date('10-08-2022', 'dd-mm-yyyy'), 'trade', 2199233, '796', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (54176774, to_date('17-01-2023', 'dd-mm-yyyy'), 'cash', 8138311, '517', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (87847571, to_date('15-07-2022', 'dd-mm-yyyy'), 'cash', 191294, '545', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (88730006, to_date('10-04-2022', 'dd-mm-yyyy'), 'stocks', 9085784, '13', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (89052107, to_date('19-07-2022', 'dd-mm-yyyy'), 'trade', 7773492, '828', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (95501780, to_date('20-06-2022', 'dd-mm-yyyy'), 'credit card', 4835096, '606', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (44221315, to_date('19-03-2023', 'dd-mm-yyyy'), 'credit card', 5095254, '395', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (89874158, to_date('15-09-2022', 'dd-mm-yyyy'), 'stocks', 3791430, '516', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (79877699, to_date('22-03-2023', 'dd-mm-yyyy'), 'credit card', 3000498, '638', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (57395826, to_date('07-04-2023', 'dd-mm-yyyy'), 'cash', 725830, '687', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (59184997, to_date('30-06-2022', 'dd-mm-yyyy'), 'cash', 4489547, '389', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (16887567, to_date('26-04-2022', 'dd-mm-yyyy'), 'trade', 1791596, '480', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (52866150, to_date('30-05-2022', 'dd-mm-yyyy'), 'cash', 2154152, '917', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (44172726, to_date('26-12-2022', 'dd-mm-yyyy'), 'cash', 1013455, '596', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (50746276, to_date('09-02-2023', 'dd-mm-yyyy'), 'trade', 5734714, '353', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (76432680, to_date('22-11-2022', 'dd-mm-yyyy'), 'cash', 8276179, '384', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (83920629, to_date('16-03-2023', 'dd-mm-yyyy'), 'cash', 4600788, '302', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (37187307, to_date('22-01-2022', 'dd-mm-yyyy'), 'stocks', 2930159, '390', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (37547578, to_date('03-04-2023', 'dd-mm-yyyy'), 'cash', 4639951, '878', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (11900455, to_date('29-07-2022', 'dd-mm-yyyy'), 'credit card', 7773492, '280', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (54266569, to_date('19-04-2022', 'dd-mm-yyyy'), 'credit card', 5455001, '19', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (24210412, to_date('19-09-2022', 'dd-mm-yyyy'), 'credit card', 3259415, '36', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (88241095, to_date('01-03-2022', 'dd-mm-yyyy'), 'stocks', 5837773, '34', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (42785370, to_date('06-10-2022', 'dd-mm-yyyy'), 'credit card', 1316361, '471', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (49826668, to_date('11-03-2022', 'dd-mm-yyyy'), 'cash', 9491417, '603', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (38803900, to_date('07-08-2022', 'dd-mm-yyyy'), 'trade', 3774865, '95', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (90863783, to_date('06-01-2023', 'dd-mm-yyyy'), 'stocks', 9952811, '991', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (94060416, to_date('18-01-2023', 'dd-mm-yyyy'), 'trade', 6118490, '213', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (40595890, to_date('22-02-2022', 'dd-mm-yyyy'), 'trade', 2199233, '599', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (19695647, to_date('23-12-2022', 'dd-mm-yyyy'), 'cash', 8038187, '423', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (62212364, to_date('18-07-2022', 'dd-mm-yyyy'), 'trade', 3731605, '808', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (15552102, to_date('14-10-2022', 'dd-mm-yyyy'), 'stocks', 3682714, '376', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (10016468, to_date('29-05-2022', 'dd-mm-yyyy'), 'stocks', 1831796, '209', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (30154543, to_date('09-05-2022', 'dd-mm-yyyy'), 'credit card', 1445669, '847', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (97218327, to_date('01-04-2023', 'dd-mm-yyyy'), 'cash', 8263516, '34', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (71315450, to_date('06-09-2022', 'dd-mm-yyyy'), 'trade', 1615719, '166', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (84352895, to_date('23-02-2023', 'dd-mm-yyyy'), 'trade', 1339105, '991', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (27365493, to_date('11-01-2022', 'dd-mm-yyyy'), 'trade', 7948446, '861', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (48322925, to_date('08-01-2023', 'dd-mm-yyyy'), 'stocks', 824473, '410', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (79008998, to_date('17-05-2022', 'dd-mm-yyyy'), 'cash', 549076, '770', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (32066934, to_date('12-01-2022', 'dd-mm-yyyy'), 'stocks', 3289480, '588', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (81804419, to_date('17-05-2022', 'dd-mm-yyyy'), 'credit card', 1988180, '302', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (14852177, to_date('11-01-2022', 'dd-mm-yyyy'), 'cash', 2729307, '607', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (79269803, to_date('07-01-2022', 'dd-mm-yyyy'), 'stocks', 8381056, '104', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (23192612, to_date('17-06-2022', 'dd-mm-yyyy'), 'stocks', 9986309, '349', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (56613259, to_date('22-01-2023', 'dd-mm-yyyy'), 'stocks', 8038187, '34', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (22391869, to_date('22-12-2022', 'dd-mm-yyyy'), 'trade', 3000498, '860', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (15088433, to_date('15-07-2022', 'dd-mm-yyyy'), 'cash', 6837365, '418', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (38711221, to_date('02-03-2023', 'dd-mm-yyyy'), 'trade', 1149469, '65', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (96974966, to_date('29-04-2023', 'dd-mm-yyyy'), 'credit card', 7437067, '647', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (62162551, to_date('11-01-2022', 'dd-mm-yyyy'), 'cash', 3986085, '685', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (41183974, to_date('15-03-2023', 'dd-mm-yyyy'), 'trade', 3954421, '69', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (89926320, to_date('25-06-2022', 'dd-mm-yyyy'), 'cash', 6982410, '629', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (39488508, to_date('20-03-2022', 'dd-mm-yyyy'), 'cash', 4600788, '169', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (40394539, to_date('20-05-2022', 'dd-mm-yyyy'), 'stocks', 7034776, '543', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (23379027, to_date('23-03-2023', 'dd-mm-yyyy'), 'stocks', 6624272, '142', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (77838733, to_date('16-07-2022', 'dd-mm-yyyy'), 'cash', 9209785, '758', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (81543868, to_date('27-10-2022', 'dd-mm-yyyy'), 'cash', 2766607, '684', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (87702915, to_date('12-07-2022', 'dd-mm-yyyy'), 'cash', 9590539, '547', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (27974710, to_date('29-04-2023', 'dd-mm-yyyy'), 'trade', 4454137, '179', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (12521549, to_date('25-11-2022', 'dd-mm-yyyy'), 'credit card', 3624043, '644', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (10697048, to_date('22-03-2023', 'dd-mm-yyyy'), 'credit card', 2015258, '105', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (58462526, to_date('27-02-2023', 'dd-mm-yyyy'), 'trade', 6791155, '148', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (91125656, to_date('30-04-2023', 'dd-mm-yyyy'), 'stocks', 7858402, '843', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (52495124, to_date('16-02-2022', 'dd-mm-yyyy'), 'cash', 5961208, '654', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (54045061, to_date('22-01-2022', 'dd-mm-yyyy'), 'cash', 4581935, '774', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (20182985, to_date('02-02-2022', 'dd-mm-yyyy'), 'stocks', 9363143, '799', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (78215011, to_date('31-05-2022', 'dd-mm-yyyy'), 'credit card', 6509979, '633', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (94102078, to_date('04-01-2022', 'dd-mm-yyyy'), 'trade', 2224163, '29', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (17600940, to_date('06-10-2022', 'dd-mm-yyyy'), 'trade', 8364760, '244', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (22883672, to_date('30-06-2022', 'dd-mm-yyyy'), 'credit card', 2747291, '691', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (83229441, to_date('06-01-2022', 'dd-mm-yyyy'), 'cash', 3520814, '529', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (80882299, to_date('07-07-2022', 'dd-mm-yyyy'), 'cash', 1163402, '537', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (45668731, to_date('06-03-2023', 'dd-mm-yyyy'), 'cash', 3460438, '864', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (48468729, to_date('11-07-2022', 'dd-mm-yyyy'), 'trade', 6533168, '389', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (18134124, to_date('02-02-2022', 'dd-mm-yyyy'), 'cash', 9876149, '712', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (42947937, to_date('09-01-2022', 'dd-mm-yyyy'), 'credit card', 4581935, '226', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (30218496, to_date('13-06-2022', 'dd-mm-yyyy'), 'credit card', 5999842, '569', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (50102068, to_date('08-03-2022', 'dd-mm-yyyy'), 'cash', 4479408, '540', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (12247756, to_date('12-09-2022', 'dd-mm-yyyy'), 'stocks', 9924260, '255', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (46358411, to_date('25-11-2022', 'dd-mm-yyyy'), 'trade', 5961208, '36', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (10261313, to_date('08-08-2022', 'dd-mm-yyyy'), 'stocks', 5626041, '482', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (81582364, to_date('08-04-2022', 'dd-mm-yyyy'), 'stocks', 8148685, '572', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (91617547, to_date('01-12-2022', 'dd-mm-yyyy'), 'credit card', 1741848, '770', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (52495404, to_date('10-06-2022', 'dd-mm-yyyy'), 'credit card', 5146992, '529', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (31224276, to_date('27-02-2022', 'dd-mm-yyyy'), 'trade', 5661576, '648', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (66718057, to_date('13-04-2023', 'dd-mm-yyyy'), 'trade', 6608775, '369', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (38394224, to_date('05-06-2022', 'dd-mm-yyyy'), 'credit card', 4418773, '164', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (47437865, to_date('02-06-2022', 'dd-mm-yyyy'), 'stocks', 1615719, '585', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (94325493, to_date('05-01-2023', 'dd-mm-yyyy'), 'trade', 9476075, '716', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (18702356, to_date('06-01-2023', 'dd-mm-yyyy'), 'credit card', 494744, '947', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (60207028, to_date('27-01-2023', 'dd-mm-yyyy'), 'trade', 4906126, '244', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (81337009, to_date('11-09-2022', 'dd-mm-yyyy'), 'stocks', 5027298, '63', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (15949089, to_date('18-09-2022', 'dd-mm-yyyy'), 'trade', 2523265, '618', null);
commit;
prompt 200 records committed...
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (79488231, to_date('18-02-2022', 'dd-mm-yyyy'), 'credit card', 7109394, '189', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (19538718, to_date('30-06-2022', 'dd-mm-yyyy'), 'cash', 9204972, '475', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (37791316, to_date('17-10-2022', 'dd-mm-yyyy'), 'credit card', 2339042, '481', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (97020205, to_date('12-09-2022', 'dd-mm-yyyy'), 'stocks', 5961208, '259', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (19163421, to_date('27-01-2023', 'dd-mm-yyyy'), 'stocks', 9648034, '449', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (13100565, to_date('01-05-2022', 'dd-mm-yyyy'), 'trade', 9720012, '631', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (33221532, to_date('27-02-2022', 'dd-mm-yyyy'), 'stocks', 4902549, '750', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (82379998, to_date('18-03-2023', 'dd-mm-yyyy'), 'trade', 2415756, '200', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (85325430, to_date('02-05-2022', 'dd-mm-yyyy'), 'stocks', 3584148, '331', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (51207360, to_date('25-02-2023', 'dd-mm-yyyy'), 'cash', 112649, '495', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (96245667, to_date('15-01-2023', 'dd-mm-yyyy'), 'cash', 109956, '819', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (10160637, to_date('22-03-2022', 'dd-mm-yyyy'), 'trade', 353946, '356', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (52456528, to_date('05-09-2022', 'dd-mm-yyyy'), 'stocks', 3705311, '315', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (97152407, to_date('24-01-2022', 'dd-mm-yyyy'), 'trade', 7273772, '534', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (27054001, to_date('19-10-2022', 'dd-mm-yyyy'), 'stocks', 9657341, '383', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (71160311, to_date('05-05-2022', 'dd-mm-yyyy'), 'stocks', 8541660, '679', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (71298748, to_date('05-10-2022', 'dd-mm-yyyy'), 'stocks', 7586434, '467', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (16582525, to_date('01-04-2022', 'dd-mm-yyyy'), 'stocks', 5626041, '600', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (66784074, to_date('07-02-2022', 'dd-mm-yyyy'), 'credit card', 2995527, '546', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (18218223, to_date('28-01-2023', 'dd-mm-yyyy'), 'stocks', 7627805, '845', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (78228892, to_date('04-09-2022', 'dd-mm-yyyy'), 'cash', 1875601, '130', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (66873050, to_date('03-08-2022', 'dd-mm-yyyy'), 'credit card', 277334, '613', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (36895695, to_date('15-07-2022', 'dd-mm-yyyy'), 'stocks', 4709447, '546', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (15589591, to_date('29-05-2022', 'dd-mm-yyyy'), 'trade', 7959163, '939', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (14633525, to_date('23-11-2022', 'dd-mm-yyyy'), 'credit card', 6791155, '588', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (36502835, to_date('23-03-2023', 'dd-mm-yyyy'), 'trade', 5961208, '251', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (98545939, to_date('07-11-2022', 'dd-mm-yyyy'), 'cash', 1536028, '415', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (48320649, to_date('16-05-2022', 'dd-mm-yyyy'), 'credit card', 5999842, '153', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (46283980, to_date('06-03-2023', 'dd-mm-yyyy'), 'cash', 8057818, '792', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (94429244, to_date('26-02-2023', 'dd-mm-yyyy'), 'credit card', 5626041, '617', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (71964145, to_date('19-03-2023', 'dd-mm-yyyy'), 'trade', 2681689, '671', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (51623647, to_date('24-08-2022', 'dd-mm-yyyy'), 'stocks', 9924260, '438', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (62711354, to_date('28-10-2022', 'dd-mm-yyyy'), 'credit card', 7132013, '24', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (19463162, to_date('21-02-2023', 'dd-mm-yyyy'), 'trade', 1296925, '966', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (15826918, to_date('12-10-2022', 'dd-mm-yyyy'), 'trade', 9720012, '24', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (40251850, to_date('21-02-2022', 'dd-mm-yyyy'), 'cash', 6262888, '253', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (76581510, to_date('31-03-2022', 'dd-mm-yyyy'), 'stocks', 1558708, '555', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (49643987, to_date('18-04-2023', 'dd-mm-yyyy'), 'credit card', 824473, '371', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (86633130, to_date('16-08-2022', 'dd-mm-yyyy'), 'trade', 6468186, '21', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (57874539, to_date('25-03-2023', 'dd-mm-yyyy'), 'credit card', 8401081, '197', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (83070076, to_date('24-03-2023', 'dd-mm-yyyy'), 'trade', 5600917, '408', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (21614631, to_date('30-04-2023', 'dd-mm-yyyy'), 'credit card', 5455001, '384', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (38078915, to_date('23-04-2023', 'dd-mm-yyyy'), 'credit card', 971253, '776', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (36452012, to_date('11-09-2022', 'dd-mm-yyyy'), 'credit card', 5275657, '719', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (99237447, to_date('11-07-2022', 'dd-mm-yyyy'), 'cash', 3713670, '966', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (39996525, to_date('20-10-2022', 'dd-mm-yyyy'), 'trade', 1316361, '767', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (70432678, to_date('28-06-2022', 'dd-mm-yyyy'), 'trade', 5255590, '659', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (15610580, to_date('11-08-2022', 'dd-mm-yyyy'), 'cash', 5865889, '819', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (23403783, to_date('28-09-2022', 'dd-mm-yyyy'), 'credit card', 1058085, '727', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (66764614, to_date('17-09-2022', 'dd-mm-yyyy'), 'cash', 5027318, '177', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (59910084, to_date('17-02-2023', 'dd-mm-yyyy'), 'cash', 6271337, '937', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (92017570, to_date('13-08-2022', 'dd-mm-yyyy'), 'trade', 8430312, '707', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (34524010, to_date('13-04-2023', 'dd-mm-yyyy'), 'stocks', 9173436, '929', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (50622359, to_date('26-01-2023', 'dd-mm-yyyy'), 'cash', 2722773, '797', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (48049069, to_date('18-02-2023', 'dd-mm-yyyy'), 'credit card', 6624272, '517', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (98756328, to_date('30-10-2022', 'dd-mm-yyyy'), 'credit card', 6779644, '508', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (91562818, to_date('02-04-2023', 'dd-mm-yyyy'), 'stocks', 6779644, '295', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (56376735, to_date('27-02-2023', 'dd-mm-yyyy'), 'credit card', 1813881, '116', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (11084830, to_date('19-03-2022', 'dd-mm-yyyy'), 'stocks', 278677, '582', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (94701211, to_date('04-10-2022', 'dd-mm-yyyy'), 'cash', 5027298, '936', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (62869664, to_date('18-01-2023', 'dd-mm-yyyy'), 'trade', 5542070, '662', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (34313234, to_date('08-02-2023', 'dd-mm-yyyy'), 'credit card', 1566295, '516', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (79324832, to_date('01-03-2022', 'dd-mm-yyyy'), 'stocks', 4902549, '327', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (43892595, to_date('18-11-2022', 'dd-mm-yyyy'), 'trade', 7590108, '22', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (35553771, to_date('07-04-2023', 'dd-mm-yyyy'), 'credit card', 2842121, '730', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (39570865, to_date('23-10-2022', 'dd-mm-yyyy'), 'credit card', 9363143, '51', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (36523806, to_date('11-02-2023', 'dd-mm-yyyy'), 'trade', 109956, '605', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (34911869, to_date('31-03-2022', 'dd-mm-yyyy'), 'cash', 7934472, '717', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (84859126, to_date('18-04-2022', 'dd-mm-yyyy'), 'cash', 3024517, '707', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (91517151, to_date('08-03-2022', 'dd-mm-yyyy'), 'cash', 3024517, '60', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (79258747, to_date('12-06-2022', 'dd-mm-yyyy'), 'trade', 3000498, '651', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (50256441, to_date('09-09-2022', 'dd-mm-yyyy'), 'cash', 2766097, '690', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (43539484, to_date('21-03-2023', 'dd-mm-yyyy'), 'trade', 8381056, '14', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (33123129, to_date('27-09-2022', 'dd-mm-yyyy'), 'trade', 3460438, '898', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (46303917, to_date('06-01-2023', 'dd-mm-yyyy'), 'cash', 824473, '740', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (95714731, to_date('19-06-2022', 'dd-mm-yyyy'), 'stocks', 6271337, '924', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (81233364, to_date('04-02-2022', 'dd-mm-yyyy'), 'cash', 2173820, '942', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (20338355, to_date('05-07-2022', 'dd-mm-yyyy'), 'trade', 9648034, '632', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (88005843, to_date('14-10-2022', 'dd-mm-yyyy'), 'credit card', 4418773, '891', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (59741176, to_date('11-02-2023', 'dd-mm-yyyy'), 'credit card', 9109015, '456', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (23839050, to_date('28-10-2022', 'dd-mm-yyyy'), 'stocks', 3085044, '415', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (21465899, to_date('16-12-2022', 'dd-mm-yyyy'), 'credit card', 5107091, '678', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (75658318, to_date('10-01-2023', 'dd-mm-yyyy'), 'cash', 4207638, '553', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (22831231, to_date('31-01-2023', 'dd-mm-yyyy'), 'cash', 4677643, '31', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (22889593, to_date('14-10-2022', 'dd-mm-yyyy'), 'trade', 4902549, '579', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (36537347, to_date('28-07-2022', 'dd-mm-yyyy'), 'cash', 341112, '539', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (90877399, to_date('07-04-2023', 'dd-mm-yyyy'), 'trade', 3801959, '280', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (26896362, to_date('16-04-2023', 'dd-mm-yyyy'), 'credit card', 9924260, '802', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (54927809, to_date('22-05-2022', 'dd-mm-yyyy'), 'stocks', 971253, '565', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (46687799, to_date('05-06-2022', 'dd-mm-yyyy'), 'credit card', 4081860, '464', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (14976412, to_date('09-11-2022', 'dd-mm-yyyy'), 'stocks', 171592, '427', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (24639055, to_date('17-01-2022', 'dd-mm-yyyy'), 'stocks', 1406976, '57', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (50881281, to_date('28-08-2022', 'dd-mm-yyyy'), 'credit card', 9227856, '146', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (53530873, to_date('15-06-2022', 'dd-mm-yyyy'), 'stocks', 6477634, '150', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (18340945, to_date('27-07-2022', 'dd-mm-yyyy'), 'cash', 8263516, '848', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (98927809, to_date('15-04-2023', 'dd-mm-yyyy'), 'cash', 9109015, '816', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (25437355, to_date('29-10-2022', 'dd-mm-yyyy'), 'cash', 6287363, '412', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (28533701, to_date('08-01-2023', 'dd-mm-yyyy'), 'trade', 1633883, '413', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (59803854, to_date('01-03-2022', 'dd-mm-yyyy'), 'cash', 5255590, '577', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (52172139, to_date('18-03-2022', 'dd-mm-yyyy'), 'trade', 1940518, '623', null);
commit;
prompt 300 records committed...
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (26418145, to_date('04-04-2023', 'dd-mm-yyyy'), 'stocks', 9974448, '494', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (42391932, to_date('07-07-2022', 'dd-mm-yyyy'), 'stocks', 8276179, '899', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (16020260, to_date('24-04-2023', 'dd-mm-yyyy'), 'stocks', 9080071, '496', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (75697577, to_date('14-10-2022', 'dd-mm-yyyy'), 'credit card', 8038187, '157', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (84155529, to_date('01-01-2023', 'dd-mm-yyyy'), 'stocks', 8057818, '226', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (34404729, to_date('28-11-2022', 'dd-mm-yyyy'), 'cash', 6262888, '761', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (80842548, to_date('12-03-2023', 'dd-mm-yyyy'), 'cash', 7411990, '55', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (69120669, to_date('23-01-2022', 'dd-mm-yyyy'), 'cash', 9271350, '932', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (70866151, to_date('30-09-2022', 'dd-mm-yyyy'), 'cash', 4871444, '822', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (31849772, to_date('18-01-2022', 'dd-mm-yyyy'), 'stocks', 6252751, '336', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (84695372, to_date('22-09-2022', 'dd-mm-yyyy'), 'stocks', 1511440, '918', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (39723977, to_date('23-05-2022', 'dd-mm-yyyy'), 'cash', 494744, '46', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (10026422, to_date('16-05-2022', 'dd-mm-yyyy'), 'trade', 1230741, '606', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (99358255, to_date('09-03-2023', 'dd-mm-yyyy'), 'cash', 9526818, '829', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (73950649, to_date('25-10-2022', 'dd-mm-yyyy'), 'credit card', 3926699, '716', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (51831079, to_date('07-05-2022', 'dd-mm-yyyy'), 'cash', 4299384, '757', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (25747516, to_date('20-07-2022', 'dd-mm-yyyy'), 'credit card', 6033765, '650', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (18289890, to_date('13-04-2023', 'dd-mm-yyyy'), 'cash', 4615085, '50', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (80302562, to_date('18-04-2023', 'dd-mm-yyyy'), 'cash', 7867408, '662', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (86181569, to_date('28-04-2022', 'dd-mm-yyyy'), 'credit card', 109956, '297', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (22150376, to_date('30-04-2022', 'dd-mm-yyyy'), 'trade', 8222269, '493', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (46107903, to_date('21-07-2022', 'dd-mm-yyyy'), 'cash', 9349186, '19', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (70142561, to_date('26-02-2023', 'dd-mm-yyyy'), 'stocks', 9046169, '284', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (79306056, to_date('02-02-2022', 'dd-mm-yyyy'), 'stocks', 8806216, '448', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (82740707, to_date('13-01-2022', 'dd-mm-yyyy'), 'stocks', 191294, '814', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (55754035, to_date('23-01-2022', 'dd-mm-yyyy'), 'cash', 5724026, '719', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (73934359, to_date('18-02-2022', 'dd-mm-yyyy'), 'trade', 4038390, '91', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (52901164, to_date('26-05-2022', 'dd-mm-yyyy'), 'stocks', 3411908, '306', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (59783983, to_date('16-03-2022', 'dd-mm-yyyy'), 'cash', 2842121, '144', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (25023545, to_date('24-08-2022', 'dd-mm-yyyy'), 'trade', 6791155, '777', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (45588938, to_date('15-04-2022', 'dd-mm-yyyy'), 'credit card', 1842955, '272', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (63204534, to_date('26-07-2022', 'dd-mm-yyyy'), 'cash', 5275657, '923', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (63680441, to_date('01-07-2022', 'dd-mm-yyyy'), 'cash', 6221862, '498', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (75940206, to_date('28-06-2022', 'dd-mm-yyyy'), 'cash', 824473, '124', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (81839542, to_date('05-12-2022', 'dd-mm-yyyy'), 'stocks', 1760875, '385', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (60369823, to_date('18-01-2022', 'dd-mm-yyyy'), 'stocks', 6437618, '42', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (52340085, to_date('10-04-2023', 'dd-mm-yyyy'), 'cash', 5095254, '139', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (64131305, to_date('16-09-2022', 'dd-mm-yyyy'), 'cash', 5600917, '677', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (11616684, to_date('17-03-2022', 'dd-mm-yyyy'), 'cash', 8085084, '42', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (17841700, to_date('08-01-2022', 'dd-mm-yyyy'), 'trade', 8927771, '704', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (50557685, to_date('08-03-2023', 'dd-mm-yyyy'), 'cash', 5542070, '196', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (68202649, to_date('11-04-2022', 'dd-mm-yyyy'), 'cash', 8263516, '88', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (65423140, to_date('01-09-2022', 'dd-mm-yyyy'), 'cash', 5095254, '575', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (61730855, to_date('18-12-2022', 'dd-mm-yyyy'), 'cash', 4884410, '45', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (99387774, to_date('31-01-2022', 'dd-mm-yyyy'), 'stocks', 3713670, '396', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (69113556, to_date('04-04-2022', 'dd-mm-yyyy'), 'credit card', 9356189, '343', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (14708953, to_date('14-03-2022', 'dd-mm-yyyy'), 'credit card', 277334, '769', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (60188990, to_date('09-04-2022', 'dd-mm-yyyy'), 'cash', 1419835, '867', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (25519654, to_date('09-08-2022', 'dd-mm-yyyy'), 'cash', 278677, '731', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (79551863, to_date('27-01-2022', 'dd-mm-yyyy'), 'stocks', 7815036, '528', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (21246433, to_date('05-04-2022', 'dd-mm-yyyy'), 'stocks', 9046169, '512', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (22783822, to_date('14-06-2022', 'dd-mm-yyyy'), 'trade', 7586434, '439', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (20652392, to_date('09-06-2022', 'dd-mm-yyyy'), 'cash', 500401, '165', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (93308921, to_date('29-05-2022', 'dd-mm-yyyy'), 'trade', 6608775, '473', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (46505151, to_date('21-10-2022', 'dd-mm-yyyy'), 'cash', 5726675, '485', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (49874088, to_date('02-02-2022', 'dd-mm-yyyy'), 'trade', 4418773, '88', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (50869817, to_date('17-07-2022', 'dd-mm-yyyy'), 'stocks', 8541660, '278', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (34654596, to_date('18-10-2022', 'dd-mm-yyyy'), 'cash', 4909169, '450', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (71026949, to_date('19-07-2022', 'dd-mm-yyyy'), 'stocks', 5826817, '865', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (11984535, to_date('27-09-2022', 'dd-mm-yyyy'), 'trade', 3099369, '929', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (76015529, to_date('03-02-2022', 'dd-mm-yyyy'), 'cash', 7146382, '12', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (67712272, to_date('18-03-2023', 'dd-mm-yyyy'), 'trade', 1615719, '855', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (43800931, to_date('07-03-2023', 'dd-mm-yyyy'), 'stocks', 8933370, '23', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (39180930, to_date('08-07-2022', 'dd-mm-yyyy'), 'cash', 2339042, '586', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (89067890, to_date('17-09-2022', 'dd-mm-yyyy'), 'stocks', 9373783, '308', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (95833847, to_date('21-12-2022', 'dd-mm-yyyy'), 'stocks', 6834952, '916', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (11638469, to_date('28-12-2022', 'dd-mm-yyyy'), 'cash', 2937280, '155', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (20445053, to_date('03-01-2023', 'dd-mm-yyyy'), 'stocks', 3447803, '803', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (65515029, to_date('25-01-2022', 'dd-mm-yyyy'), 'trade', 4038390, '828', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (70974734, to_date('03-05-2022', 'dd-mm-yyyy'), 'cash', 7627805, '361', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (68548198, to_date('02-06-2022', 'dd-mm-yyyy'), 'cash', 9271350, '45', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (93049701, to_date('11-11-2022', 'dd-mm-yyyy'), 'stocks', 4600788, '203', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (92729840, to_date('09-02-2022', 'dd-mm-yyyy'), 'trade', 5865889, '636', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (33068862, to_date('24-09-2022', 'dd-mm-yyyy'), 'cash', 5734714, '97', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (35111021, to_date('24-12-2022', 'dd-mm-yyyy'), 'cash', 5108791, '692', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (51933687, to_date('15-01-2022', 'dd-mm-yyyy'), 'trade', 6988264, '911', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (49344983, to_date('27-08-2022', 'dd-mm-yyyy'), 'credit card', 5146992, '858', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (59403678, to_date('13-01-2023', 'dd-mm-yyyy'), 'trade', 4418773, '914', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (37855106, to_date('16-03-2022', 'dd-mm-yyyy'), 'cash', 5735856, '54', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (19076838, to_date('18-01-2022', 'dd-mm-yyyy'), 'credit card', 9373783, '322', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (94627883, to_date('26-12-2022', 'dd-mm-yyyy'), 'stocks', 5999842, '414', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (33995141, to_date('21-06-2022', 'dd-mm-yyyy'), 'cash', 112649, '201', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (98630885, to_date('06-03-2023', 'dd-mm-yyyy'), 'trade', 3624043, '656', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (32874998, to_date('18-03-2022', 'dd-mm-yyyy'), 'stocks', 1316361, '695', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (77855732, to_date('31-01-2022', 'dd-mm-yyyy'), 'stocks', 5626041, '654', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (46962728, to_date('09-03-2022', 'dd-mm-yyyy'), 'trade', 8332462, '552', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (83986058, to_date('01-11-2022', 'dd-mm-yyyy'), 'cash', 786152, '372', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (87515026, to_date('31-07-2022', 'dd-mm-yyyy'), 'trade', 4884410, '920', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (27690486, to_date('18-11-2022', 'dd-mm-yyyy'), 'cash', 3533692, '106', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (73904431, to_date('08-11-2022', 'dd-mm-yyyy'), 'credit card', 1988180, '542', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (14540590, to_date('06-11-2022', 'dd-mm-yyyy'), 'stocks', 9109015, '37', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (82349797, to_date('04-11-2022', 'dd-mm-yyyy'), 'trade', 6271337, '171', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (11553869, to_date('10-03-2023', 'dd-mm-yyyy'), 'credit card', 1316361, '100', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (15271757, to_date('03-04-2022', 'dd-mm-yyyy'), 'stocks', 3411908, '362', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (14361711, to_date('21-03-2023', 'dd-mm-yyyy'), 'credit card', 768425, '162', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (41273200, to_date('03-08-2022', 'dd-mm-yyyy'), 'trade', 2415756, '565', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (85002367, to_date('07-08-2022', 'dd-mm-yyyy'), 'credit card', 500401, '503', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (95744730, to_date('02-03-2022', 'dd-mm-yyyy'), 'trade', 4237526, '513', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (80338916, to_date('13-07-2022', 'dd-mm-yyyy'), 'stocks', 1813881, '633', null);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (62095143, to_date('13-11-2022', 'dd-mm-yyyy'), 'cash', 845273, '916', null);
commit;
prompt 400 records committed...
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (99346402, to_date('25-08-2022', 'dd-mm-yyyy'), 'credit card', 9085784, '203', 92626590);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (62181619, to_date('06-05-2022', 'dd-mm-yyyy'), 'stocks', 1058085, '862', 41605154);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (68053756, to_date('29-03-2023', 'dd-mm-yyyy'), 'cash', 9475377, '413', 85864060);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (83785749, to_date('10-01-2022', 'dd-mm-yyyy'), 'trade', 2551959, '313', 97151747);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (29982128, to_date('04-11-2022', 'dd-mm-yyyy'), 'cash', 9214200, '778', 92626590);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (63176420, to_date('16-08-2022', 'dd-mm-yyyy'), 'trade', 6730570, '171', 18957521);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (45054165, to_date('29-04-2022', 'dd-mm-yyyy'), 'stocks', 9648034, '74', 88611236);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (64341957, to_date('09-11-2022', 'dd-mm-yyyy'), 'credit card', 8645623, '492', 75160017);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (74956247, to_date('13-03-2022', 'dd-mm-yyyy'), 'stocks', 1615719, '590', 49252991);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (66505666, to_date('01-08-2022', 'dd-mm-yyyy'), 'trade', 4909169, '792', 14099702);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (45740603, to_date('01-06-2022', 'dd-mm-yyyy'), 'trade', 5826817, '354', 65842394);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (30043812, to_date('04-05-2022', 'dd-mm-yyyy'), 'credit card', 2015258, '600', 69751252);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (96555773, to_date('21-02-2022', 'dd-mm-yyyy'), 'stocks', 7570549, '515', 23589087);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (13028579, to_date('27-08-2022', 'dd-mm-yyyy'), 'trade', 9227856, '312', 50988611);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (69002080, to_date('29-03-2023', 'dd-mm-yyyy'), 'stocks', 341112, '172', 20358216);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (68396045, to_date('03-02-2023', 'dd-mm-yyyy'), 'cash', 8936656, '378', 29123352);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (37112096, to_date('20-11-2022', 'dd-mm-yyyy'), 'stocks', 845273, '413', 58495697);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (11739147, to_date('24-05-2022', 'dd-mm-yyyy'), 'stocks', 1294042, '794', 67149382);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (77956116, to_date('22-03-2023', 'dd-mm-yyyy'), 'cash', 4026854, '746', 55109827);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (49725652, to_date('02-05-2022', 'dd-mm-yyyy'), 'credit card', 1511440, '915', 28781639);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (92872622, to_date('14-02-2022', 'dd-mm-yyyy'), 'credit card', 9109015, '796', 73218368);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (19141124, to_date('20-01-2022', 'dd-mm-yyyy'), 'cash', 6506571, '548', 22717205);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (39323753, to_date('15-05-2022', 'dd-mm-yyyy'), 'trade', 4299384, '323', 73501747);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (26556894, to_date('03-10-2022', 'dd-mm-yyyy'), 'credit card', 6477634, '384', 76272049);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (33375773, to_date('30-03-2023', 'dd-mm-yyyy'), 'trade', 4207638, '544', 58100144);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (58623028, to_date('05-11-2022', 'dd-mm-yyyy'), 'credit card', 7934472, '747', 37058869);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (52804543, to_date('17-07-2022', 'dd-mm-yyyy'), 'credit card', 8936656, '811', 93279035);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (92986298, to_date('24-02-2022', 'dd-mm-yyyy'), 'trade', 7411990, '658', 24828386);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (50825986, to_date('25-04-2022', 'dd-mm-yyyy'), 'credit card', 9227856, '552', 55109827);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (79833145, to_date('11-03-2023', 'dd-mm-yyyy'), 'trade', 1760875, '175', 75117457);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (30451557, to_date('19-05-2022', 'dd-mm-yyyy'), 'cash', 1558708, '531', 69678002);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (64057657, to_date('14-12-2022', 'dd-mm-yyyy'), 'credit card', 8220901, '74', 16212701);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (79468713, to_date('05-12-2022', 'dd-mm-yyyy'), 'trade', 8430312, '451', 45137073);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (88054526, to_date('16-12-2022', 'dd-mm-yyyy'), 'credit card', 8567855, '852', 56270335);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (96046381, to_date('09-11-2022', 'dd-mm-yyyy'), 'cash', 2396773, '840', 29123352);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (55137029, to_date('12-03-2023', 'dd-mm-yyyy'), 'trade', 6318045, '52', 22095269);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (14965425, to_date('07-03-2023', 'dd-mm-yyyy'), 'credit card', 8236561, '279', 17246868);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (93579986, to_date('22-05-2022', 'dd-mm-yyyy'), 'trade', 9670086, '797', 22310745);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (84474116, to_date('25-03-2022', 'dd-mm-yyyy'), 'stocks', 8332462, '874', 10382740);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (71287738, to_date('24-01-2022', 'dd-mm-yyyy'), 'trade', 9271350, '824', 79958108);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (23768603, to_date('18-07-2022', 'dd-mm-yyyy'), 'credit card', 4454137, '171', 17364972);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (61087108, to_date('06-05-2022', 'dd-mm-yyyy'), 'trade', 3791430, '647', 42291147);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (31098379, to_date('02-12-2022', 'dd-mm-yyyy'), 'cash', 5535473, '208', 84172948);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (46645374, to_date('28-10-2022', 'dd-mm-yyyy'), 'trade', 7304625, '139', 72948531);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (42496749, to_date('19-02-2022', 'dd-mm-yyyy'), 'trade', 7591302, '52', 79244161);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (39013238, to_date('22-03-2023', 'dd-mm-yyyy'), 'stocks', 5102227, '380', 99349870);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (31136302, to_date('20-06-2022', 'dd-mm-yyyy'), 'credit card', 1163402, '523', 23544731);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (63792792, to_date('30-05-2022', 'dd-mm-yyyy'), 'credit card', 1419835, '867', 26407563);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (87309378, to_date('18-04-2022', 'dd-mm-yyyy'), 'cash', 5734714, '314', 41832458);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (18930490, to_date('20-07-2022', 'dd-mm-yyyy'), 'cash', 7046775, '984', 50633001);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (99033534, to_date('31-01-2023', 'dd-mm-yyyy'), 'stocks', 9491417, '350', 21598115);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (33135114, to_date('29-04-2022', 'dd-mm-yyyy'), 'credit card', 2729307, '799', 50211776);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (23282020, to_date('04-11-2022', 'dd-mm-yyyy'), 'stocks', 4906126, '521', 23125267);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (64920743, to_date('20-03-2023', 'dd-mm-yyyy'), 'credit card', 7934472, '187', 22717205);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (27839239, to_date('05-08-2022', 'dd-mm-yyyy'), 'cash', 2762480, '701', 38379788);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (92274724, to_date('30-03-2022', 'dd-mm-yyyy'), 'credit card', 2036427, '247', 80441743);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (53781223, to_date('28-04-2023', 'dd-mm-yyyy'), 'credit card', 3447803, '84', 62529227);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (82950640, to_date('26-01-2023', 'dd-mm-yyyy'), 'trade', 1780821, '70', 87114192);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (58581096, to_date('27-08-2022', 'dd-mm-yyyy'), 'credit card', 4207638, '797', 69935948);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (15386276, to_date('01-12-2022', 'dd-mm-yyyy'), 'cash', 7590108, '754', 21681616);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (39839548, to_date('03-04-2023', 'dd-mm-yyyy'), 'cash', 9168209, '927', 10382740);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (40246592, to_date('01-03-2023', 'dd-mm-yyyy'), 'trade', 971253, '815', 19961420);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (19640299, to_date('15-05-2022', 'dd-mm-yyyy'), 'trade', 5108791, '732', 32377066);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (62591687, to_date('05-06-2022', 'dd-mm-yyyy'), 'cash', 9214200, '817', 34346186);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (79530573, to_date('20-05-2022', 'dd-mm-yyyy'), 'credit card', 9648034, '245', 52704646);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (94669774, to_date('01-09-2022', 'dd-mm-yyyy'), 'trade', 7934472, '396', 20819418);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (86126561, to_date('09-07-2022', 'dd-mm-yyyy'), 'cash', 7908693, '169', 24828386);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (29335141, to_date('05-02-2023', 'dd-mm-yyyy'), 'cash', 9986309, '535', 39543197);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (97343893, to_date('04-04-2022', 'dd-mm-yyyy'), 'credit card', 3986085, '95', 76030186);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (94091127, to_date('15-02-2023', 'dd-mm-yyyy'), 'credit card', 6307622, '214', 61050698);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (99253106, to_date('26-02-2023', 'dd-mm-yyyy'), 'credit card', 2224163, '15', 31145877);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (95758086, to_date('04-06-2022', 'dd-mm-yyyy'), 'stocks', 3681692, '302', 32141175);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (63560115, to_date('27-06-2022', 'dd-mm-yyyy'), 'trade', 1316361, '155', 14099702);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (65766358, to_date('15-01-2022', 'dd-mm-yyyy'), 'cash', 1558667, '820', 22095269);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (55711678, to_date('09-07-2022', 'dd-mm-yyyy'), 'cash', 2199233, '130', 17246868);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (56074237, to_date('20-08-2022', 'dd-mm-yyyy'), 'stocks', 2822277, '503', 93720830);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (33625866, to_date('30-04-2022', 'dd-mm-yyyy'), 'credit card', 6113810, '389', 88611236);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (75710940, to_date('10-06-2022', 'dd-mm-yyyy'), 'stocks', 7109394, '623', 29573304);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (57047533, to_date('09-08-2022', 'dd-mm-yyyy'), 'stocks', 4884410, '998', 37058869);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (77944575, to_date('19-12-2022', 'dd-mm-yyyy'), 'stocks', 2722773, '214', 88611236);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (97528784, to_date('05-04-2022', 'dd-mm-yyyy'), 'trade', 6212834, '733', 66220926);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (88075111, to_date('26-06-2022', 'dd-mm-yyyy'), 'trade', 1296925, '523', 76528537);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (79034445, to_date('05-10-2022', 'dd-mm-yyyy'), 'stocks', 1940518, '445', 76425222);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (21852345, to_date('25-07-2022', 'dd-mm-yyyy'), 'credit card', 2396773, '850', 50995796);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (59172527, to_date('24-11-2022', 'dd-mm-yyyy'), 'cash', 768425, '789', 29679569);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (94518873, to_date('16-05-2022', 'dd-mm-yyyy'), 'cash', 6961708, '641', 81948881);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (11049702, to_date('12-08-2022', 'dd-mm-yyyy'), 'trade', 5207124, '265', 83343457);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (20478059, to_date('24-01-2022', 'dd-mm-yyyy'), 'cash', 2546711, '907', 79958108);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (15751766, to_date('06-08-2022', 'dd-mm-yyyy'), 'cash', 2339042, '502', 65574736);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (63586998, to_date('31-03-2023', 'dd-mm-yyyy'), 'trade', 8263516, '991', 53884663);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (55449110, to_date('17-04-2022', 'dd-mm-yyyy'), 'credit card', 7908693, '955', 11030061);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (68074493, to_date('11-07-2022', 'dd-mm-yyyy'), 'stocks', 5131765, '605', 40078701);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (37127188, to_date('31-12-2022', 'dd-mm-yyyy'), 'trade', 2729307, '845', 50633001);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (70084018, to_date('18-02-2022', 'dd-mm-yyyy'), 'stocks', 191294, '186', 52704646);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (46941987, to_date('13-09-2022', 'dd-mm-yyyy'), 'credit card', 8401081, '419', 83206369);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (59841691, to_date('28-12-2022', 'dd-mm-yyyy'), 'credit card', 9209785, '584', 55204216);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (25200496, to_date('29-08-2022', 'dd-mm-yyyy'), 'cash', 768425, '537', 87913132);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (64449236, to_date('01-11-2022', 'dd-mm-yyyy'), 'credit card', 445421, '76', 87913132);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (31966171, to_date('02-02-2023', 'dd-mm-yyyy'), 'cash', 8263516, '588', 10305725);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (11301960, to_date('05-02-2022', 'dd-mm-yyyy'), 'stocks', 4082532, '609', 92484792);
commit;
prompt 500 records committed...
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (23289408, to_date('05-08-2022', 'dd-mm-yyyy'), 'cash', 2518903, '681', 33424856);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (92131717, to_date('14-11-2022', 'dd-mm-yyyy'), 'cash', 4835096, '488', 18215069);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (38063011, to_date('26-08-2022', 'dd-mm-yyyy'), 'credit card', 4709447, '179', 75934121);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (97674876, to_date('19-04-2022', 'dd-mm-yyyy'), 'trade', 5339884, '247', 49791831);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (75502659, to_date('21-07-2022', 'dd-mm-yyyy'), 'trade', 1615719, '503', 23628665);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (62965293, to_date('12-01-2023', 'dd-mm-yyyy'), 'trade', 6477634, '902', 93279035);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (23252376, to_date('30-01-2022', 'dd-mm-yyyy'), 'credit card', 3295849, '329', 83206369);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (63252277, to_date('18-02-2022', 'dd-mm-yyyy'), 'credit card', 5381443, '542', 70992013);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (86114998, to_date('03-08-2022', 'dd-mm-yyyy'), 'credit card', 7590108, '992', 77937364);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (60543561, to_date('03-05-2022', 'dd-mm-yyyy'), 'trade', 5102227, '134', 73543101);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (70773268, to_date('17-02-2023', 'dd-mm-yyyy'), 'credit card', 3774865, '731', 77721805);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (38942192, to_date('24-04-2023', 'dd-mm-yyyy'), 'trade', 9876149, '640', 69751252);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (21594884, to_date('25-03-2022', 'dd-mm-yyyy'), 'credit card', 9173436, '982', 86194909);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (11630723, to_date('10-02-2023', 'dd-mm-yyyy'), 'stocks', 8420976, '251', 77631320);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (20799221, to_date('30-01-2022', 'dd-mm-yyyy'), 'credit card', 5255590, '905', 61751721);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (36716019, to_date('27-02-2022', 'dd-mm-yyyy'), 'trade', 1760875, '76', 10192467);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (45357391, to_date('17-11-2022', 'dd-mm-yyyy'), 'stocks', 5131765, '14', 24987475);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (41088772, to_date('01-04-2023', 'dd-mm-yyyy'), 'trade', 6318045, '716', 76342968);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (70459279, to_date('03-12-2022', 'dd-mm-yyyy'), 'cash', 8774487, '770', 66319658);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (72953977, to_date('27-01-2022', 'dd-mm-yyyy'), 'credit card', 191294, '131', 74899684);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (37080460, to_date('29-04-2022', 'dd-mm-yyyy'), 'credit card', 445421, '504', 65921313);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (75972823, to_date('01-09-2022', 'dd-mm-yyyy'), 'stocks', 3990552, '48', 81653079);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (58860782, to_date('28-09-2022', 'dd-mm-yyyy'), 'credit card', 476907, '763', 14955002);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (16767301, to_date('17-02-2022', 'dd-mm-yyyy'), 'stocks', 5033115, '354', 47109265);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (61028496, to_date('30-03-2022', 'dd-mm-yyyy'), 'trade', 5724026, '298', 22717205);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (15729542, to_date('05-01-2023', 'dd-mm-yyyy'), 'stocks', 7909283, '696', 80271654);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (67650356, to_date('16-12-2022', 'dd-mm-yyyy'), 'credit card', 4835096, '297', 60459056);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (69814789, to_date('01-03-2022', 'dd-mm-yyyy'), 'cash', 1633883, '469', 20734597);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (17237085, to_date('09-10-2022', 'dd-mm-yyyy'), 'trade', 7419752, '327', 88859076);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (95959362, to_date('22-03-2023', 'dd-mm-yyyy'), 'cash', 5381443, '111', 91614446);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (78973846, to_date('24-09-2022', 'dd-mm-yyyy'), 'credit card', 9648034, '516', 29123352);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (25123631, to_date('26-04-2022', 'dd-mm-yyyy'), 'stocks', 5102227, '715', 24851597);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (29575705, to_date('27-03-2022', 'dd-mm-yyyy'), 'credit card', 4511206, '91', 25284368);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (36959982, to_date('20-09-2022', 'dd-mm-yyyy'), 'stocks', 6509979, '993', 26488051);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (30768109, to_date('10-04-2023', 'dd-mm-yyyy'), 'cash', 6988264, '186', 48400394);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (35105786, to_date('11-09-2022', 'dd-mm-yyyy'), 'cash', 7053548, '483', 39867776);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (17392347, to_date('19-06-2022', 'dd-mm-yyyy'), 'trade', 476907, '23', 10594141);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (73101367, to_date('05-01-2023', 'dd-mm-yyyy'), 'credit card', 5107091, '93', 13175349);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (36136022, to_date('11-10-2022', 'dd-mm-yyyy'), 'credit card', 1566295, '339', 98476811);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (20932974, to_date('10-04-2022', 'dd-mm-yyyy'), 'credit card', 9876149, '981', 61120744);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (94888519, to_date('28-05-2022', 'dd-mm-yyyy'), 'credit card', 2154152, '188', 55204216);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (92200747, to_date('09-08-2022', 'dd-mm-yyyy'), 'trade', 5961208, '769', 52363187);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (62721474, to_date('28-04-2023', 'dd-mm-yyyy'), 'stocks', 5381443, '987', 18215069);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (71911685, to_date('21-02-2023', 'dd-mm-yyyy'), 'trade', 4237526, '961', 57859448);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (70494243, to_date('05-05-2022', 'dd-mm-yyyy'), 'credit card', 4677643, '965', 29508837);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (34897617, to_date('29-07-2022', 'dd-mm-yyyy'), 'credit card', 9720012, '803', 57794058);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (62084371, to_date('20-02-2023', 'dd-mm-yyyy'), 'trade', 3459878, '819', 59072138);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (34858171, to_date('08-10-2022', 'dd-mm-yyyy'), 'cash', 739623, '372', 61012473);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (26243059, to_date('30-10-2022', 'dd-mm-yyyy'), 'trade', 7590108, '760', 40247234);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (24028740, to_date('01-11-2022', 'dd-mm-yyyy'), 'credit card', 5146992, '997', 23628665);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (99075635, to_date('05-03-2022', 'dd-mm-yyyy'), 'credit card', 2652547, '849', 14557742);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (93473453, to_date('30-03-2022', 'dd-mm-yyyy'), 'cash', 3460438, '50', 77393215);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (87147021, to_date('12-04-2022', 'dd-mm-yyyy'), 'stocks', 5070778, '643', 54193889);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (44003142, to_date('19-05-2022', 'dd-mm-yyyy'), 'stocks', 4511206, '902', 78226785);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (31212204, to_date('07-05-2022', 'dd-mm-yyyy'), 'stocks', 120742, '147', 41605154);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (87718314, to_date('08-07-2022', 'dd-mm-yyyy'), 'credit card', 2339042, '415', 85864060);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (10571700, to_date('11-07-2022', 'dd-mm-yyyy'), 'trade', 5542070, '80', 27781281);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (70177116, to_date('12-03-2022', 'dd-mm-yyyy'), 'stocks', 8835277, '497', 77393215);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (88052029, to_date('25-06-2022', 'dd-mm-yyyy'), 'stocks', 6276980, '477', 76342968);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (93188306, to_date('04-01-2022', 'dd-mm-yyyy'), 'trade', 1092477, '178', 15776963);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (35611180, to_date('05-06-2022', 'dd-mm-yyyy'), 'trade', 639714, '584', 72948531);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (18229221, to_date('04-11-2022', 'dd-mm-yyyy'), 'cash', 9501093, '859', 43656591);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (10569080, to_date('13-07-2022', 'dd-mm-yyyy'), 'trade', 4596549, '54', 57794058);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (10488745, to_date('01-03-2022', 'dd-mm-yyyy'), 'stocks', 6506571, '978', 98476811);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (22463064, to_date('09-02-2022', 'dd-mm-yyyy'), 'cash', 9017582, '455', 97151747);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (53535280, to_date('22-01-2022', 'dd-mm-yyyy'), 'trade', 6205536, '892', 60265062);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (80528341, to_date('08-07-2022', 'dd-mm-yyyy'), 'credit card', 9520372, '156', 76030186);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (54609713, to_date('21-05-2022', 'dd-mm-yyyy'), 'trade', 3024517, '142', 91524473);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (31803467, to_date('15-03-2023', 'dd-mm-yyyy'), 'stocks', 6533168, '411', 20358216);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (90543383, to_date('23-12-2022', 'dd-mm-yyyy'), 'trade', 4909169, '972', 99782262);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (79860811, to_date('06-10-2022', 'dd-mm-yyyy'), 'stocks', 1230741, '864', 21478126);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (74301056, to_date('14-12-2022', 'dd-mm-yyyy'), 'stocks', 7627805, '277', 76425222);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (94162024, to_date('18-06-2022', 'dd-mm-yyyy'), 'trade', 5778795, '310', 19420366);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (50038506, to_date('28-10-2022', 'dd-mm-yyyy'), 'credit card', 9520372, '744', 69056450);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (41447388, to_date('05-08-2022', 'dd-mm-yyyy'), 'cash', 5773511, '50', 62529227);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (69296881, to_date('21-08-2022', 'dd-mm-yyyy'), 'stocks', 4906126, '817', 55489053);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (69069408, to_date('27-01-2023', 'dd-mm-yyyy'), 'stocks', 8541660, '381', 19923947);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (61449457, to_date('20-01-2023', 'dd-mm-yyyy'), 'stocks', 8645623, '504', 91555345);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (90443088, to_date('29-09-2022', 'dd-mm-yyyy'), 'trade', 6437618, '810', 43457317);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (45569703, to_date('02-02-2022', 'dd-mm-yyyy'), 'credit card', 1558667, '129', 93188547);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (19219837, to_date('07-03-2023', 'dd-mm-yyyy'), 'trade', 6118490, '101', 47744726);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (72772711, to_date('18-03-2022', 'dd-mm-yyyy'), 'trade', 9754342, '701', 91746327);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (17567300, to_date('17-06-2022', 'dd-mm-yyyy'), 'cash', 5542070, '337', 26488051);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (19320669, to_date('07-01-2023', 'dd-mm-yyyy'), 'stocks', 5535473, '591', 41470462);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (67087325, to_date('10-01-2022', 'dd-mm-yyyy'), 'cash', 4600788, '34', 64591321);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (60353329, to_date('05-01-2023', 'dd-mm-yyyy'), 'credit card', 9173436, '443', 14765097);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (40358933, to_date('30-08-2022', 'dd-mm-yyyy'), 'stocks', 8138311, '452', 81952885);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (24243474, to_date('30-05-2022', 'dd-mm-yyyy'), 'trade', 8835277, '471', 92920365);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (93106289, to_date('21-11-2022', 'dd-mm-yyyy'), 'stocks', 2587208, '319', 28261423);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (57577390, to_date('01-02-2023', 'dd-mm-yyyy'), 'trade', 3926699, '49', 88543737);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (26991664, to_date('29-05-2022', 'dd-mm-yyyy'), 'credit card', 9986309, '772', 53884663);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (80760330, to_date('01-12-2022', 'dd-mm-yyyy'), 'trade', 6624272, '578', 19923947);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (53033412, to_date('26-08-2022', 'dd-mm-yyyy'), 'cash', 1294042, '711', 52409037);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (14246987, to_date('11-03-2023', 'dd-mm-yyyy'), 'credit card', 1831796, '742', 79108858);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (75648934, to_date('07-02-2023', 'dd-mm-yyyy'), 'cash', 3909529, '373', 65842394);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (55396961, to_date('19-06-2022', 'dd-mm-yyyy'), 'credit card', 788622, '984', 28781639);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (17322645, to_date('02-09-2022', 'dd-mm-yyyy'), 'credit card', 1791596, '276', 92450308);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (15955229, to_date('23-02-2022', 'dd-mm-yyyy'), 'cash', 7570549, '374', 54976001);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (13898948, to_date('19-02-2022', 'dd-mm-yyyy'), 'cash', 8591515, '459', 54478764);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (60157611, to_date('01-07-2022', 'dd-mm-yyyy'), 'trade', 494744, '713', 11952928);
commit;
prompt 600 records committed...
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (30500201, to_date('24-05-2022', 'dd-mm-yyyy'), 'cash', 5280946, '49', 24467919);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (53461241, to_date('30-05-2022', 'dd-mm-yyyy'), 'cash', 7570549, '54', 49410269);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (68069681, to_date('28-05-2022', 'dd-mm-yyyy'), 'trade', 1149469, '87', 78780176);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (41900037, to_date('22-11-2022', 'dd-mm-yyyy'), 'cash', 2523265, '403', 92248639);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (60539560, to_date('04-04-2022', 'dd-mm-yyyy'), 'credit card', 5207124, '744', 99782262);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (62065164, to_date('04-05-2022', 'dd-mm-yyyy'), 'cash', 3295849, '863', 27781281);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (92623869, to_date('12-04-2023', 'dd-mm-yyyy'), 'credit card', 8401081, '808', 13678080);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (91710511, to_date('17-03-2022', 'dd-mm-yyyy'), 'cash', 1460595, '16', 73528794);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (38236469, to_date('13-08-2022', 'dd-mm-yyyy'), 'cash', 4979177, '466', 26070875);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (50983153, to_date('03-02-2023', 'dd-mm-yyyy'), 'trade', 6205536, '577', 92450308);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (59534017, to_date('03-03-2022', 'dd-mm-yyyy'), 'cash', 5443971, '422', 85318412);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (34278823, to_date('06-04-2023', 'dd-mm-yyyy'), 'stocks', 1988180, '509', 65921313);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (76583938, to_date('27-08-2022', 'dd-mm-yyyy'), 'stocks', 1831796, '343', 61012473);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (52722380, to_date('25-03-2022', 'dd-mm-yyyy'), 'stocks', 334251, '286', 25669470);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (97657393, to_date('01-10-2022', 'dd-mm-yyyy'), 'cash', 9271350, '583', 77859088);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (97273278, to_date('30-09-2022', 'dd-mm-yyyy'), 'stocks', 6369025, '556', 30694864);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (60147246, to_date('18-04-2023', 'dd-mm-yyyy'), 'trade', 3909529, '252', 58587967);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (72456033, to_date('09-04-2023', 'dd-mm-yyyy'), 'stocks', 3459878, '127', 89941451);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (82111033, to_date('06-04-2023', 'dd-mm-yyyy'), 'stocks', 7590108, '552', 69465420);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (50715695, to_date('06-02-2022', 'dd-mm-yyyy'), 'trade', 9813585, '194', 79282436);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (44438934, to_date('21-02-2022', 'dd-mm-yyyy'), 'cash', 1365922, '494', 88476204);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (37398313, to_date('24-08-2022', 'dd-mm-yyyy'), 'trade', 4871444, '954', 25284368);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (33646737, to_date('21-01-2022', 'dd-mm-yyyy'), 'cash', 9363143, '851', 32141175);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (56356409, to_date('11-06-2022', 'dd-mm-yyyy'), 'credit card', 2657894, '518', 19515460);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (25293811, to_date('05-01-2023', 'dd-mm-yyyy'), 'stocks', 3085044, '494', 23850560);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (16179441, to_date('29-03-2023', 'dd-mm-yyyy'), 'stocks', 845273, '66', 25284368);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (68026071, to_date('06-03-2023', 'dd-mm-yyyy'), 'stocks', 5661576, '966', 55109827);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (77049273, to_date('07-03-2022', 'dd-mm-yyyy'), 'stocks', 5054252, '402', 18090981);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (68243951, to_date('04-12-2022', 'dd-mm-yyyy'), 'credit card', 4596549, '468', 41470462);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (78220649, to_date('09-09-2022', 'dd-mm-yyyy'), 'trade', 5773511, '802', 71575648);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (75395368, to_date('23-04-2023', 'dd-mm-yyyy'), 'cash', 2551959, '36', 48632896);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (96126654, to_date('18-07-2022', 'dd-mm-yyyy'), 'trade', 9526818, '146', 83206369);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (77893694, to_date('13-12-2022', 'dd-mm-yyyy'), 'credit card', 9617153, '129', 24987475);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (63109187, to_date('29-11-2022', 'dd-mm-yyyy'), 'cash', 6369025, '347', 73528794);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (29660724, to_date('30-08-2022', 'dd-mm-yyyy'), 'trade', 9227856, '497', 62484334);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (66774433, to_date('22-07-2022', 'dd-mm-yyyy'), 'credit card', 7109394, '179', 46317105);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (17294645, to_date('01-03-2023', 'dd-mm-yyyy'), 'credit card', 140756, '355', 81934454);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (27863003, to_date('27-07-2022', 'dd-mm-yyyy'), 'cash', 5999842, '847', 73528794);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (41407009, to_date('28-03-2023', 'dd-mm-yyyy'), 'credit card', 6509979, '750', 67618229);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (37320674, to_date('22-11-2022', 'dd-mm-yyyy'), 'trade', 9214200, '897', 50995796);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (46857334, to_date('14-02-2023', 'dd-mm-yyyy'), 'stocks', 3024517, '504', 56270335);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (59552832, to_date('24-01-2023', 'dd-mm-yyyy'), 'cash', 8645623, '284', 77721805);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (31042296, to_date('24-07-2022', 'dd-mm-yyyy'), 'credit card', 7437067, '626', 38379788);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (66042918, to_date('14-04-2022', 'dd-mm-yyyy'), 'credit card', 9046169, '74', 61120744);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (10096519, to_date('06-10-2022', 'dd-mm-yyyy'), 'trade', 277334, '556', 68682772);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (46165608, to_date('24-02-2023', 'dd-mm-yyyy'), 'trade', 4979177, '377', 88859076);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (44676723, to_date('30-04-2022', 'dd-mm-yyyy'), 'cash', 4979177, '747', 93720830);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (28104780, to_date('26-07-2022', 'dd-mm-yyyy'), 'credit card', 824473, '403', 64591321);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (83692190, to_date('26-12-2022', 'dd-mm-yyyy'), 'cash', 5600917, '647', 58495697);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (60396488, to_date('09-05-2022', 'dd-mm-yyyy'), 'credit card', 5339884, '799', 60607678);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (38660235, to_date('13-02-2023', 'dd-mm-yyyy'), 'credit card', 9974448, '942', 49237883);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (64096927, to_date('21-04-2022', 'dd-mm-yyyy'), 'cash', 2766097, '366', 10594141);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (88686675, to_date('06-01-2023', 'dd-mm-yyyy'), 'stocks', 8381056, '183', 84172948);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (95575400, to_date('28-04-2022', 'dd-mm-yyyy'), 'cash', 1445669, '994', 52924480);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (46071294, to_date('15-03-2023', 'dd-mm-yyyy'), 'trade', 1988180, '613', 79927690);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (29932292, to_date('18-12-2022', 'dd-mm-yyyy'), 'credit card', 788622, '46', 87555652);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (32538317, to_date('21-07-2022', 'dd-mm-yyyy'), 'stocks', 5731628, '463', 50633001);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (15042034, to_date('29-01-2023', 'dd-mm-yyyy'), 'cash', 1163402, '861', 50633001);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (36091875, to_date('09-10-2022', 'dd-mm-yyyy'), 'credit card', 2173820, '404', 59190855);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (76221074, to_date('10-07-2022', 'dd-mm-yyyy'), 'credit card', 9209785, '811', 75160017);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (58496475, to_date('06-01-2022', 'dd-mm-yyyy'), 'stocks', 8199494, '410', 77393215);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (41520846, to_date('10-04-2023', 'dd-mm-yyyy'), 'trade', 2339042, '441', 65395727);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (43382470, to_date('14-11-2022', 'dd-mm-yyyy'), 'credit card', 4081860, '900', 69298889);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (57645738, to_date('10-05-2022', 'dd-mm-yyyy'), 'trade', 6477634, '62', 19515460);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (34976524, to_date('21-10-2022', 'dd-mm-yyyy'), 'stocks', 9648034, '217', 27142082);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (76496060, to_date('01-02-2023', 'dd-mm-yyyy'), 'stocks', 9491417, '602', 27142082);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (27457087, to_date('26-12-2022', 'dd-mm-yyyy'), 'credit card', 9813585, '343', 16472279);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (22336015, to_date('06-03-2022', 'dd-mm-yyyy'), 'stocks', 4835096, '818', 43272453);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (44934855, to_date('20-03-2022', 'dd-mm-yyyy'), 'credit card', 8927771, '54', 71722461);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (99586664, to_date('24-02-2023', 'dd-mm-yyyy'), 'stocks', 4902549, '746', 58100144);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (92058249, to_date('10-08-2022', 'dd-mm-yyyy'), 'credit card', 6212834, '258', 69465420);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (71243899, to_date('09-12-2022', 'dd-mm-yyyy'), 'stocks', 8933370, '519', 65439870);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (65243874, to_date('03-01-2023', 'dd-mm-yyyy'), 'trade', 1316361, '743', 65842394);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (27921410, to_date('22-02-2022', 'dd-mm-yyyy'), 'cash', 4581935, '481', 88611236);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (74531995, to_date('02-11-2022', 'dd-mm-yyyy'), 'cash', 4906126, '193', 66319658);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (37518653, to_date('06-02-2023', 'dd-mm-yyyy'), 'trade', 2822277, '617', 65574736);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (96067001, to_date('04-01-2023', 'dd-mm-yyyy'), 'credit card', 8057818, '483', 78117587);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (25513819, to_date('10-05-2022', 'dd-mm-yyyy'), 'trade', 5070778, '301', 73501747);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (35202879, to_date('15-08-2022', 'dd-mm-yyyy'), 'trade', 3705311, '384', 51814617);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (65881803, to_date('10-11-2022', 'dd-mm-yyyy'), 'credit card', 7014413, '324', 13894585);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (20233675, to_date('09-01-2022', 'dd-mm-yyyy'), 'credit card', 8541660, '477', 10168824);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (92637174, to_date('15-04-2023', 'dd-mm-yyyy'), 'trade', 9861282, '289', 89973187);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (26748971, to_date('03-01-2023', 'dd-mm-yyyy'), 'trade', 1460595, '451', 77870256);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (22002143, to_date('29-01-2023', 'dd-mm-yyyy'), 'trade', 5339884, '267', 61075688);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (92614349, to_date('26-01-2022', 'dd-mm-yyyy'), 'credit card', 1058085, '667', 27077982);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (15199528, to_date('25-03-2023', 'dd-mm-yyyy'), 'credit card', 7046775, '793', 26966572);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (43576858, to_date('23-01-2022', 'dd-mm-yyyy'), 'trade', 341112, '82', 17920164);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (71870730, to_date('11-11-2022', 'dd-mm-yyyy'), 'cash', 1061509, '194', 92828941);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (79495490, to_date('25-04-2022', 'dd-mm-yyyy'), 'stocks', 768425, '410', 26070875);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (34118695, to_date('05-03-2022', 'dd-mm-yyyy'), 'credit card', 9986309, '143', 21478126);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (61196640, to_date('10-02-2023', 'dd-mm-yyyy'), 'trade', 3986085, '702', 88543737);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (91175889, to_date('27-06-2022', 'dd-mm-yyyy'), 'cash', 7014413, '647', 23850560);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (17954583, to_date('26-04-2023', 'dd-mm-yyyy'), 'trade', 5837773, '150', 23054747);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (74697259, to_date('23-01-2022', 'dd-mm-yyyy'), 'credit card', 7908693, '276', 19923947);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (75596935, to_date('05-01-2023', 'dd-mm-yyyy'), 'credit card', 346392, '214', 56876593);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (64678209, to_date('20-04-2022', 'dd-mm-yyyy'), 'credit card', 2154152, '674', 92450308);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (75235127, to_date('14-04-2023', 'dd-mm-yyyy'), 'stocks', 9475377, '122', 57859448);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (55997565, to_date('16-01-2023', 'dd-mm-yyyy'), 'trade', 9349186, '487', 72948531);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (52619874, to_date('16-01-2023', 'dd-mm-yyyy'), 'credit card', 3986085, '609', 89941451);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (35585545, to_date('23-12-2022', 'dd-mm-yyyy'), 'credit card', 4639951, '487', 61751721);
commit;
prompt 700 records committed...
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (48121639, to_date('22-04-2022', 'dd-mm-yyyy'), 'stocks', 9192528, '38', 77859088);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (20216727, to_date('26-05-2022', 'dd-mm-yyyy'), 'credit card', 2937280, '95', 69678002);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (57336106, to_date('04-07-2022', 'dd-mm-yyyy'), 'stocks', 445421, '729', 28857091);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (54928019, to_date('12-02-2023', 'dd-mm-yyyy'), 'stocks', 3411908, '162', 34070155);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (32314649, to_date('12-08-2022', 'dd-mm-yyyy'), 'credit card', 9475377, '759', 97151747);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (82061625, to_date('05-10-2022', 'dd-mm-yyyy'), 'stocks', 1842955, '107', 87913132);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (23419795, to_date('17-12-2022', 'dd-mm-yyyy'), 'stocks', 2154152, '904', 27077982);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (40933016, to_date('21-02-2022', 'dd-mm-yyyy'), 'trade', 5456844, '324', 57631041);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (11805703, to_date('04-03-2022', 'dd-mm-yyyy'), 'cash', 6469584, '27', 65574736);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (18123901, to_date('23-01-2023', 'dd-mm-yyyy'), 'credit card', 1092477, '933', 14765097);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (62523621, to_date('28-02-2023', 'dd-mm-yyyy'), 'stocks', 5961208, '664', 93966237);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (88400190, to_date('18-03-2023', 'dd-mm-yyyy'), 'stocks', 7815036, '844', 85864060);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (78252364, to_date('28-11-2022', 'dd-mm-yyyy'), 'trade', 9526818, '75', 41757137);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (26254966, to_date('10-10-2022', 'dd-mm-yyyy'), 'credit card', 5626041, '95', 17246868);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (53653778, to_date('16-04-2023', 'dd-mm-yyyy'), 'stocks', 3713670, '413', 54297355);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (58076456, to_date('31-10-2022', 'dd-mm-yyyy'), 'cash', 1751361, '529', 77035256);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (20353210, to_date('29-12-2022', 'dd-mm-yyyy'), 'cash', 2154152, '388', 95338906);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (44940996, to_date('26-02-2022', 'dd-mm-yyyy'), 'credit card', 171592, '828', 18530627);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (42544977, to_date('20-07-2022', 'dd-mm-yyyy'), 'cash', 5466780, '123', 33880439);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (66031000, to_date('29-01-2023', 'dd-mm-yyyy'), 'trade', 5526336, '776', 85864060);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (83222835, to_date('24-05-2022', 'dd-mm-yyyy'), 'cash', 3926699, '361', 45168516);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (62677932, to_date('28-06-2022', 'dd-mm-yyyy'), 'stocks', 1163402, '878', 59313687);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (11035445, to_date('26-01-2022', 'dd-mm-yyyy'), 'credit card', 7028864, '21', 88859076);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (73030270, to_date('10-07-2022', 'dd-mm-yyyy'), 'trade', 2224163, '309', 52704646);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (17766847, to_date('17-02-2023', 'dd-mm-yyyy'), 'stocks', 8381056, '974', 57631041);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (67346480, to_date('14-05-2022', 'dd-mm-yyyy'), 'cash', 1445669, '119', 65842394);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (96441923, to_date('03-07-2022', 'dd-mm-yyyy'), 'credit card', 4081860, '276', 56814186);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (13912980, to_date('23-02-2023', 'dd-mm-yyyy'), 'cash', 1875601, '813', 10987595);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (20056871, to_date('18-11-2022', 'dd-mm-yyyy'), 'stocks', 3085044, '518', 93188547);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (85587113, to_date('26-03-2023', 'dd-mm-yyyy'), 'stocks', 6791155, '237', 15702316);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (90934669, to_date('07-12-2022', 'dd-mm-yyyy'), 'trade', 7858402, '691', 54193889);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (16965111, to_date('10-08-2022', 'dd-mm-yyyy'), 'stocks', 7948446, '683', 28467705);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (50705548, to_date('15-03-2023', 'dd-mm-yyyy'), 'trade', 8835277, '229', 14557742);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (42175069, to_date('01-01-2023', 'dd-mm-yyyy'), 'cash', 2523265, '464', 54193889);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (20912456, to_date('19-06-2022', 'dd-mm-yyyy'), 'credit card', 3289480, '392', 60774397);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (83294909, to_date('17-06-2022', 'dd-mm-yyyy'), 'credit card', 2551959, '653', 60774397);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (54241533, to_date('18-02-2023', 'dd-mm-yyyy'), 'cash', 3712427, '18', 33865478);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (69395351, to_date('13-12-2022', 'dd-mm-yyyy'), 'cash', 6838649, '239', 52409037);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (96377573, to_date('16-02-2023', 'dd-mm-yyyy'), 'trade', 3801959, '492', 21800008);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (36207884, to_date('04-02-2023', 'dd-mm-yyyy'), 'credit card', 277334, '519', 21060377);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (88484498, to_date('08-02-2022', 'dd-mm-yyyy'), 'stocks', 5726675, '140', 15859164);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (96417730, to_date('22-08-2022', 'dd-mm-yyyy'), 'trade', 5724026, '875', 87913132);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (30310825, to_date('23-02-2022', 'dd-mm-yyyy'), 'stocks', 5731628, '807', 11764838);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (10581815, to_date('27-08-2022', 'dd-mm-yyyy'), 'trade', 7472682, '809', 76342968);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (93920131, to_date('06-11-2022', 'dd-mm-yyyy'), 'trade', 9192528, '887', 20358216);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (68671739, to_date('04-11-2022', 'dd-mm-yyyy'), 'credit card', 8381056, '305', 13175349);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (68046531, to_date('01-11-2022', 'dd-mm-yyyy'), 'cash', 9271350, '542', 20819418);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (42241743, to_date('06-08-2022', 'dd-mm-yyyy'), 'stocks', 3926699, '495', 71961058);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (23075135, to_date('02-05-2022', 'dd-mm-yyyy'), 'cash', 9813585, '297', 57859448);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (77221679, to_date('12-02-2023', 'dd-mm-yyyy'), 'stocks', 7053548, '687', 61075688);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (36647527, to_date('11-11-2022', 'dd-mm-yyyy'), 'stocks', 1875601, '945', 77405651);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (17334978, to_date('22-08-2022', 'dd-mm-yyyy'), 'cash', 5726675, '639', 33029912);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (59892227, to_date('28-08-2022', 'dd-mm-yyyy'), 'cash', 9227856, '775', 89381130);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (38141617, to_date('23-01-2022', 'dd-mm-yyyy'), 'stocks', 7545422, '180', 49639306);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (1222222222222, to_date('05-06-2024 15:11:00', 'dd-mm-yyyy hh24:mi:ss'), 'Credit Card', 150.75, 'ABC123', 1);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (71706093, to_date('29-04-2022', 'dd-mm-yyyy'), 'stocks', 3520814, '129', 23125267);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (123, to_date('05-06-2024 15:12:46', 'dd-mm-yyyy hh24:mi:ss'), 'Credit Card', 150.75, 'ABC123', 1);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (91890385, to_date('20-11-2022', 'dd-mm-yyyy'), 'credit card', 1536028, '552', 19515460);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (99589310, to_date('15-03-2022', 'dd-mm-yyyy'), 'stocks', 4677643, '305', 45093026);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (1234, to_date('05-06-2024 15:13:08', 'dd-mm-yyyy hh24:mi:ss'), 'Credit Card', 150.75, 'ABC123', 1);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (65613630, to_date('17-10-2022', 'dd-mm-yyyy'), 'credit card', 353946, '870', 22234324);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (12686579, to_date('07-01-2023', 'dd-mm-yyyy'), 'stocks', 9648034, '927', 49252991);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (91073347, to_date('06-11-2022', 'dd-mm-yyyy'), 'stocks', 375800, '301', 25669470);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (16396587, to_date('05-02-2022', 'dd-mm-yyyy'), 'credit card', 6961708, '749', 53884663);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (23858457, to_date('11-10-2022', 'dd-mm-yyyy'), 'trade', 6205536, '589', 52409037);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (57883563, to_date('03-05-2022', 'dd-mm-yyyy'), 'stocks', 8567855, '454', 81944586);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (66459173, to_date('07-01-2022', 'dd-mm-yyyy'), 'cash', 9491417, '446', 26070875);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (71266443, to_date('31-08-2022', 'dd-mm-yyyy'), 'credit card', 2766607, '839', 20558212);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (57196402, to_date('08-02-2023', 'dd-mm-yyyy'), 'trade', 6468186, '957', 27776987);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (17344465, to_date('29-01-2022', 'dd-mm-yyyy'), 'credit card', 7858402, '961', 19923947);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (62077203, to_date('17-03-2022', 'dd-mm-yyyy'), 'stocks', 7109394, '652', 17364972);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (73265131, to_date('31-12-2022', 'dd-mm-yyyy'), 'trade', 6509979, '543', 13894585);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (27275263, to_date('06-01-2022', 'dd-mm-yyyy'), 'cash', 6988264, '784', 16472279);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (62817180, to_date('13-06-2022', 'dd-mm-yyyy'), 'trade', 9204972, '706', 65395727);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (22236364, to_date('07-02-2023', 'dd-mm-yyyy'), 'cash', 6506571, '32', 19923947);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (17348553, to_date('17-11-2022', 'dd-mm-yyyy'), 'trade', 7472682, '58', 22908574);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (83408852, to_date('13-01-2023', 'dd-mm-yyyy'), 'trade', 9356189, '400', 10382740);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (67309367, to_date('08-11-2022', 'dd-mm-yyyy'), 'cash', 9845795, '12', 99436889);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (18599103, to_date('03-03-2023', 'dd-mm-yyyy'), 'cash', 1404278, '552', 26773815);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (24419878, to_date('26-01-2022', 'dd-mm-yyyy'), 'cash', 8364760, '498', 20734597);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (71951997, to_date('10-04-2023', 'dd-mm-yyyy'), 'credit card', 5108791, '356', 92248639);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (94463453, to_date('27-02-2022', 'dd-mm-yyyy'), 'cash', 786152, '952', 85318412);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (19556381, to_date('15-07-2022', 'dd-mm-yyyy'), 'stocks', 4469062, '777', 46702526);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (20704538, to_date('30-03-2023', 'dd-mm-yyyy'), 'stocks', 1365922, '612', 79512672);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (25675541, to_date('19-12-2022', 'dd-mm-yyyy'), 'stocks', 3682714, '126', 17364972);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (77931628, to_date('01-12-2022', 'dd-mm-yyyy'), 'credit card', 4606594, '115', 65842394);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (19602673, to_date('09-04-2023', 'dd-mm-yyyy'), 'trade', 7909283, '516', 61623388);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (47125232, to_date('03-12-2022', 'dd-mm-yyyy'), 'credit card', 1741848, '441', 61075688);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (23141344, to_date('30-01-2023', 'dd-mm-yyyy'), 'trade', 6318045, '767', 59217071);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (40750849, to_date('29-04-2022', 'dd-mm-yyyy'), 'trade', 1615719, '173', 69056450);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (78710971, to_date('21-12-2022', 'dd-mm-yyyy'), 'cash', 7304625, '510', 46131079);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (28676926, to_date('12-05-2022', 'dd-mm-yyyy'), 'trade', 2722773, '13', 60265062);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (48077281, to_date('21-11-2022', 'dd-mm-yyyy'), 'trade', 6838649, '646', 33029912);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (44717838, to_date('05-02-2023', 'dd-mm-yyyy'), 'trade', 4414039, '662', 11952928);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (91707784, to_date('26-12-2022', 'dd-mm-yyyy'), 'credit card', 3588551, '145', 10382740);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (83801849, to_date('22-06-2022', 'dd-mm-yyyy'), 'stocks', 9192528, '29', 62827313);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (3001, to_date('02-05-2024', 'dd-mm-yyyy'), 'Credit Card', 150, '4001', 1001);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (3002, to_date('04-05-2024', 'dd-mm-yyyy'), 'PayPal', 200, '4002', 1002);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (3003, to_date('06-05-2024', 'dd-mm-yyyy'), 'Bank Transfer', 300, '4003', 1003);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (3004, to_date('08-05-2024', 'dd-mm-yyyy'), 'Cash', 400, '4004', 1004);
commit;
prompt 800 records committed...
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (3005, to_date('10-05-2024', 'dd-mm-yyyy'), 'Credit Card', 250, '4005', 1005);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (3006, to_date('12-05-2024', 'dd-mm-yyyy'), 'PayPal', 350, '4006', 1006);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (3008, to_date('16-05-2024', 'dd-mm-yyyy'), 'Cash', 500, '4008', 1008);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (3009, to_date('18-05-2024', 'dd-mm-yyyy'), 'Credit Card', 600, '4009', 1009);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (3010, to_date('20-05-2024', 'dd-mm-yyyy'), 'PayPal', 700, '4010', 1010);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (12222222, to_date('15-11-2022', 'dd-mm-yyyy'), 'credit card', 8439, '1', 1);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (3, to_date('23-06-2022', 'dd-mm-yyyy'), 'credit card', 7688, '3', 3);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (4, to_date('11-03-2023', 'dd-mm-yyyy'), 'stocks', 3566, '4', 4);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (5, to_date('02-04-2023', 'dd-mm-yyyy'), 'cash', 9994, '5', 5);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (6, to_date('24-12-2022', 'dd-mm-yyyy'), 'Apple Pay', 6129, '6', 6);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (7, to_date('29-12-2022', 'dd-mm-yyyy'), 'PayPal', 5754, '7', 7);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (8, to_date('26-03-2023', 'dd-mm-yyyy'), 'cash', 9244, '8', 8);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (9, to_date('08-04-2023', 'dd-mm-yyyy'), 'PayPal', 8838, '9', 9);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (10, to_date('30-01-2023', 'dd-mm-yyyy'), 'PayPal', 8250, '10', 10);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (11, to_date('29-11-2022', 'dd-mm-yyyy'), 'Apple Pay', 6541, '11', 11);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (12, to_date('24-11-2022', 'dd-mm-yyyy'), 'Apple Pay', 5711, '12', 12);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (13, to_date('19-11-2022', 'dd-mm-yyyy'), 'stocks', 2222, '13', 13);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (14, to_date('22-03-2023', 'dd-mm-yyyy'), 'stocks', 8481, '14', 14);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (15, to_date('13-05-2023', 'dd-mm-yyyy'), 'PayPal', 9488, '15', 15);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (16, to_date('27-11-2022', 'dd-mm-yyyy'), 'cash', 2147, '16', 16);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (17, to_date('08-08-2022', 'dd-mm-yyyy'), 'PayPal', 6931, '17', 17);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (18, to_date('29-07-2022', 'dd-mm-yyyy'), 'PayPal', 1072, '18', 18);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (19, to_date('10-03-2023', 'dd-mm-yyyy'), 'Apple Pay', 1016, '19', 19);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (20, to_date('14-09-2022', 'dd-mm-yyyy'), 'cash', 2112, '20', 20);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (21, to_date('12-09-2022', 'dd-mm-yyyy'), 'credit card', 6551, '21', 21);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (22, to_date('01-09-2022', 'dd-mm-yyyy'), 'credit card', 3661, '22', 22);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (23, to_date('24-08-2022', 'dd-mm-yyyy'), 'cash', 4677, '23', 23);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (24, to_date('23-03-2023', 'dd-mm-yyyy'), 'stocks', 2708, '24', 24);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (25, to_date('14-05-2023', 'dd-mm-yyyy'), 'cash', 6892, '25', 25);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (26, to_date('19-04-2023', 'dd-mm-yyyy'), 'Apple Pay', 7198, '26', 26);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (27, to_date('12-11-2022', 'dd-mm-yyyy'), 'credit card', 1906, '27', 27);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (28, to_date('05-09-2022', 'dd-mm-yyyy'), 'Venmo', 3896, '28', 28);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (29, to_date('20-09-2022', 'dd-mm-yyyy'), 'Apple Pay', 7425, '29', 29);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (30, to_date('12-02-2023', 'dd-mm-yyyy'), 'stocks', 6703, '30', 30);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (31, to_date('02-07-2022', 'dd-mm-yyyy'), 'PayPal', 8832, '31', 31);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (32, to_date('15-01-2023', 'dd-mm-yyyy'), 'stocks', 2343, '32', 32);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (33, to_date('03-09-2022', 'dd-mm-yyyy'), 'cash', 8835, '33', 33);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (34, to_date('12-07-2022', 'dd-mm-yyyy'), 'credit card', 7538, '34', 34);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (35, to_date('15-10-2022', 'dd-mm-yyyy'), 'Apple Pay', 7423, '35', 35);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (36, to_date('25-12-2022', 'dd-mm-yyyy'), 'Venmo', 5288, '36', 36);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (37, to_date('24-09-2022', 'dd-mm-yyyy'), 'cash', 5076, '37', 37);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (38, to_date('07-03-2023', 'dd-mm-yyyy'), 'PayPal', 9391, '38', 38);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (39, to_date('04-02-2023', 'dd-mm-yyyy'), 'stocks', 3285, '39', 39);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (40, to_date('03-09-2022', 'dd-mm-yyyy'), 'Apple Pay', 1633, '40', 40);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (41, to_date('02-07-2022', 'dd-mm-yyyy'), 'Apple Pay', 1363, '41', 41);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (42, to_date('23-04-2023', 'dd-mm-yyyy'), 'Venmo', 9901, '42', 42);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (43, to_date('07-12-2022', 'dd-mm-yyyy'), 'Apple Pay', 5956, '43', 43);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (44, to_date('15-03-2023', 'dd-mm-yyyy'), 'PayPal', 3079, '44', 44);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (45, to_date('06-08-2022', 'dd-mm-yyyy'), 'credit card', 6045, '45', 45);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (46, to_date('09-04-2023', 'dd-mm-yyyy'), 'credit card', 2322, '46', 46);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (47, to_date('18-04-2023', 'dd-mm-yyyy'), 'stocks', 3578, '47', 47);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (48, to_date('01-01-2023', 'dd-mm-yyyy'), 'Apple Pay', 8735, '48', 48);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (49, to_date('13-04-2023', 'dd-mm-yyyy'), 'PayPal', 5909, '49', 49);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (50, to_date('26-11-2022', 'dd-mm-yyyy'), 'cash', 2701, '50', 50);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (51, to_date('29-10-2022', 'dd-mm-yyyy'), 'credit card', 8461, '51', 51);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (52, to_date('01-09-2022', 'dd-mm-yyyy'), 'stocks', 5568, '52', 52);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (53, to_date('14-01-2023', 'dd-mm-yyyy'), 'Apple Pay', 8814, '53', 53);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (54, to_date('25-09-2022', 'dd-mm-yyyy'), 'stocks', 5792, '54', 54);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (55, to_date('01-07-2022', 'dd-mm-yyyy'), 'Venmo', 7719, '55', 55);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (56, to_date('11-08-2022', 'dd-mm-yyyy'), 'credit card', 8084, '56', 56);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (57, to_date('08-04-2023', 'dd-mm-yyyy'), 'cash', 6306, '57', 57);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (58, to_date('20-09-2022', 'dd-mm-yyyy'), 'PayPal', 7889, '58', 58);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (59, to_date('21-06-2022', 'dd-mm-yyyy'), 'Apple Pay', 6719, '59', 59);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (60, to_date('25-09-2022', 'dd-mm-yyyy'), 'Apple Pay', 7184, '60', 60);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (61, to_date('21-02-2023', 'dd-mm-yyyy'), 'credit card', 2103, '61', 61);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (63, to_date('31-08-2022', 'dd-mm-yyyy'), 'cash', 9996, '63', 63);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (64, to_date('10-04-2023', 'dd-mm-yyyy'), 'stocks', 1150, '64', 64);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (65, to_date('09-04-2023', 'dd-mm-yyyy'), 'Venmo', 1239, '65', 65);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (66, to_date('31-12-2022', 'dd-mm-yyyy'), 'PayPal', 2872, '66', 66);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (67, to_date('29-11-2022', 'dd-mm-yyyy'), 'Venmo', 9776, '67', 67);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (68, to_date('08-12-2022', 'dd-mm-yyyy'), 'Venmo', 5752, '68', 68);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (69, to_date('03-12-2022', 'dd-mm-yyyy'), 'Venmo', 7636, '69', 69);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (70, to_date('03-06-2022', 'dd-mm-yyyy'), 'PayPal', 6770, '70', 70);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (71, to_date('05-09-2022', 'dd-mm-yyyy'), 'cash', 9810, '71', 71);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (72, to_date('01-01-2023', 'dd-mm-yyyy'), 'credit card', 1540, '72', 72);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (73, to_date('14-02-2023', 'dd-mm-yyyy'), 'PayPal', 4035, '73', 73);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (74, to_date('05-04-2023', 'dd-mm-yyyy'), 'Apple Pay', 2840, '74', 74);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (75, to_date('28-02-2023', 'dd-mm-yyyy'), 'stocks', 3132, '75', 75);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (76, to_date('18-02-2023', 'dd-mm-yyyy'), 'stocks', 3718, '76', 76);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (77, to_date('12-07-2022', 'dd-mm-yyyy'), 'stocks', 7063, '77', 77);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (78, to_date('13-12-2022', 'dd-mm-yyyy'), 'credit card', 4255, '78', 78);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (79, to_date('17-07-2022', 'dd-mm-yyyy'), 'cash', 7471, '79', 79);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (80, to_date('05-07-2022', 'dd-mm-yyyy'), 'Apple Pay', 3712, '80', 80);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (81, to_date('09-09-2022', 'dd-mm-yyyy'), 'Venmo', 5501, '81', 81);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (82, to_date('22-02-2023', 'dd-mm-yyyy'), 'Venmo', 9120, '82', 82);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (83, to_date('12-01-2023', 'dd-mm-yyyy'), 'stocks', 1522, '83', 83);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (84, to_date('01-05-2023', 'dd-mm-yyyy'), 'credit card', 2810, '84', 84);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (85, to_date('05-07-2022', 'dd-mm-yyyy'), 'cash', 5280, '85', 85);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (86, to_date('16-01-2023', 'dd-mm-yyyy'), 'PayPal', 1961, '86', 86);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (87, to_date('03-11-2022', 'dd-mm-yyyy'), 'Apple Pay', 9046, '87', 87);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (88, to_date('08-01-2023', 'dd-mm-yyyy'), 'PayPal', 2225, '88', 88);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (89, to_date('09-10-2022', 'dd-mm-yyyy'), 'credit card', 6402, '89', 89);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (90, to_date('27-07-2022', 'dd-mm-yyyy'), 'stocks', 2405, '90', 90);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (91, to_date('19-06-2022', 'dd-mm-yyyy'), 'Apple Pay', 1996, '91', 91);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (92, to_date('19-12-2022', 'dd-mm-yyyy'), 'stocks', 7329, '92', 92);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (93, to_date('25-11-2022', 'dd-mm-yyyy'), 'stocks', 1825, '93', 93);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (94, to_date('04-06-2022', 'dd-mm-yyyy'), 'credit card', 6332, '94', 94);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (95, to_date('29-01-2023', 'dd-mm-yyyy'), 'Apple Pay', 8868, '95', 95);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (96, to_date('07-10-2022', 'dd-mm-yyyy'), 'PayPal', 8072, '96', 96);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (97, to_date('10-05-2023', 'dd-mm-yyyy'), 'stocks', 9556, '97', 97);
commit;
prompt 900 records committed...
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (98, to_date('04-08-2022', 'dd-mm-yyyy'), 'cash', 7510, '98', 98);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (99, to_date('21-12-2022', 'dd-mm-yyyy'), 'Apple Pay', 8068, '99', 99);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (100, to_date('02-04-2023', 'dd-mm-yyyy'), 'credit card', 6669, '100', 100);
commit;
prompt 903 records loaded
prompt Loading SUPPORT_TICKET...
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (28752241, 'Vulnerability to cyber attacks', 'Resolved', to_date('01-02-2023', 'dd-mm-yyyy'), to_date('12-02-2024', 'dd-mm-yyyy'), 67803385, 81119660);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (67715533, 'Operator training and human error', 'Pending Review', to_date('02-02-2022', 'dd-mm-yyyy'), to_date('06-06-2023', 'dd-mm-yyyy'), 18905876, 94372304);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (23764497, 'Integration with existing defense systems', 'Pending', to_date('26-09-2022', 'dd-mm-yyyy'), to_date('09-11-2023', 'dd-mm-yyyy'), 23764681, 64964952);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (36525785, 'False positives and negatives', 'Pending Review', to_date('29-06-2022', 'dd-mm-yyyy'), to_date('17-06-2023', 'dd-mm-yyyy'), 86143960, 50930370);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (75338635, 'Maintenance and operational costs', 'Resolved', to_date('21-01-2023', 'dd-mm-yyyy'), to_date('08-09-2023', 'dd-mm-yyyy'), 71718606, 16971947);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (18823672, 'Interception accuracy', 'Closed', to_date('02-03-2023', 'dd-mm-yyyy'), to_date('22-01-2024', 'dd-mm-yyyy'), 94432158, 22578416);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (69349871, 'Maintenance and operational costs', 'Escalated', to_date('27-03-2023', 'dd-mm-yyyy'), to_date('08-02-2024', 'dd-mm-yyyy'), 99420157, 92914190);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (45188637, 'Integration with existing defense systems', 'Urgent', to_date('29-04-2022', 'dd-mm-yyyy'), to_date('05-01-2024', 'dd-mm-yyyy'), 98048623, 35708697);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (41159612, 'Integration with existing defense systems', 'Pending Review', to_date('03-12-2022', 'dd-mm-yyyy'), to_date('11-06-2023', 'dd-mm-yyyy'), 99026347, 65864223);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (46271681, 'Integration with existing defense systems', 'Pending Review', to_date('30-04-2023', 'dd-mm-yyyy'), to_date('19-05-2023', 'dd-mm-yyyy'), 52789268, 18081451);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (49589726, 'Interception accuracy', 'Escalated', to_date('18-05-2022', 'dd-mm-yyyy'), to_date('06-08-2023', 'dd-mm-yyyy'), 54563648, 52622636);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (88530892, 'Communication latency', 'Pending Review', to_date('28-08-2022', 'dd-mm-yyyy'), to_date('16-07-2023', 'dd-mm-yyyy'), 89798029, 81119660);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (38561938, 'Supply chain security', 'Resolved', to_date('10-05-2022', 'dd-mm-yyyy'), to_date('12-10-2023', 'dd-mm-yyyy'), 39604366, 13265686);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (56900111, 'False positives and negatives', 'Escalated', to_date('09-02-2023', 'dd-mm-yyyy'), to_date('18-07-2023', 'dd-mm-yyyy'), 59252850, 27273162);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (74943415, 'Maintenance and operational costs', 'Pending', to_date('01-02-2023', 'dd-mm-yyyy'), to_date('13-02-2024', 'dd-mm-yyyy'), 84514288, 47850199);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (50136588, 'Communication latency', 'Resolved', to_date('18-02-2023', 'dd-mm-yyyy'), to_date('23-03-2024', 'dd-mm-yyyy'), 73029532, 93154110);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (97128598, 'Supply chain security', 'Urgent', to_date('02-02-2023', 'dd-mm-yyyy'), to_date('01-06-2023', 'dd-mm-yyyy'), 95826413, 25129884);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (78939169, 'Environmental adaptability', 'Escalated', to_date('15-02-2022', 'dd-mm-yyyy'), to_date('14-06-2023', 'dd-mm-yyyy'), 27286133, 98008948);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (49209564, 'Integration with existing defense systems', 'Urgent', to_date('10-10-2022', 'dd-mm-yyyy'), to_date('24-11-2023', 'dd-mm-yyyy'), 21014885, 35825128);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (50831348, 'Integration with existing defense systems', 'Urgent', to_date('06-01-2023', 'dd-mm-yyyy'), to_date('11-08-2023', 'dd-mm-yyyy'), 61074545, 81261537);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (19161429, 'Reliability of detection systems', 'Resolved', to_date('05-02-2023', 'dd-mm-yyyy'), to_date('22-01-2024', 'dd-mm-yyyy'), 90755223, 72765447);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (73619697, 'False positives and negatives', 'Pending Review', to_date('24-05-2022', 'dd-mm-yyyy'), to_date('17-07-2023', 'dd-mm-yyyy'), 78035150, 20358405);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (66531204, 'Reliability of detection systems', 'Resolved', to_date('19-06-2022', 'dd-mm-yyyy'), to_date('29-06-2023', 'dd-mm-yyyy'), 86330317, 47149421);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (97031569, 'Operator training and human error', 'Escalated', to_date('08-02-2022', 'dd-mm-yyyy'), to_date('13-11-2023', 'dd-mm-yyyy'), 28451383, 46538655);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (84927116, 'Communication latency', 'Resolved', to_date('14-03-2023', 'dd-mm-yyyy'), to_date('31-12-2023', 'dd-mm-yyyy'), 42458539, 24162881);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (90238508, 'Vulnerability to cyber attacks', 'Urgent', to_date('29-10-2022', 'dd-mm-yyyy'), to_date('03-06-2023', 'dd-mm-yyyy'), 31768349, 81828427);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (11683736, 'Supply chain security', 'Resolved', to_date('19-05-2022', 'dd-mm-yyyy'), to_date('03-03-2024', 'dd-mm-yyyy'), 18766984, 17118876);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (87834636, 'Environmental adaptability', 'Closed', to_date('10-03-2022', 'dd-mm-yyyy'), to_date('12-07-2023', 'dd-mm-yyyy'), 89085003, 79283183);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (80965730, 'Supply chain security', 'Resolved', to_date('05-11-2022', 'dd-mm-yyyy'), to_date('18-11-2023', 'dd-mm-yyyy'), 57735974, 29650588);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (96389517, 'Operator training and human error', 'Pending Review', to_date('23-09-2022', 'dd-mm-yyyy'), to_date('20-06-2023', 'dd-mm-yyyy'), 57464776, 92372173);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (40601104, 'False positives and negatives', 'Resolved', to_date('08-04-2023', 'dd-mm-yyyy'), to_date('27-09-2023', 'dd-mm-yyyy'), 79481773, 81828427);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (21766559, 'Integration with existing defense systems', 'Pending', to_date('20-11-2022', 'dd-mm-yyyy'), to_date('13-12-2023', 'dd-mm-yyyy'), 61251646, 47615557);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (43237731, 'Vulnerability to cyber attacks', 'Pending', to_date('11-08-2022', 'dd-mm-yyyy'), to_date('06-11-2023', 'dd-mm-yyyy'), 24574132, 16747819);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (34324871, 'Supply chain security', 'Pending Review', to_date('08-12-2022', 'dd-mm-yyyy'), to_date('04-10-2023', 'dd-mm-yyyy'), 66586949, 48534835);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (29072891, 'False positives and negatives', 'Pending', to_date('27-06-2022', 'dd-mm-yyyy'), to_date('16-12-2023', 'dd-mm-yyyy'), 75706743, 44369962);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (86241629, 'Communication latency', 'Resolved', to_date('03-01-2023', 'dd-mm-yyyy'), to_date('01-03-2024', 'dd-mm-yyyy'), 87836917, 56834602);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (14720068, 'Operator training and human error', 'Closed', to_date('05-02-2023', 'dd-mm-yyyy'), to_date('13-04-2024', 'dd-mm-yyyy'), 43645466, 12293095);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (12858035, 'Integration with existing defense systems', 'Pending Review', to_date('07-01-2023', 'dd-mm-yyyy'), to_date('15-05-2023', 'dd-mm-yyyy'), 91233616, 63132707);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (49076005, 'Supply chain security', 'Pending Review', to_date('04-02-2022', 'dd-mm-yyyy'), to_date('23-05-2023', 'dd-mm-yyyy'), 50140697, 72765447);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (63789835, 'Communication latency', 'Pending Review', to_date('20-05-2022', 'dd-mm-yyyy'), to_date('21-03-2024', 'dd-mm-yyyy'), 85366873, 27095403);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (30459280, 'False positives and negatives', 'Escalated', to_date('08-01-2023', 'dd-mm-yyyy'), to_date('06-10-2023', 'dd-mm-yyyy'), 50354801, 23022486);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (10178121, 'Operator training and human error', 'Pending Review', to_date('25-04-2022', 'dd-mm-yyyy'), to_date('05-05-2023', 'dd-mm-yyyy'), 68635839, 62318647);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (52934222, 'Maintenance and operational costs', 'Resolved', to_date('31-05-2022', 'dd-mm-yyyy'), to_date('25-10-2023', 'dd-mm-yyyy'), 99420157, 65681397);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (97512801, 'Supply chain security', 'Pending Review', to_date('11-02-2022', 'dd-mm-yyyy'), to_date('27-07-2023', 'dd-mm-yyyy'), 53097853, 18700397);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (51735919, 'Operator training and human error', 'Urgent', to_date('07-01-2023', 'dd-mm-yyyy'), to_date('14-08-2023', 'dd-mm-yyyy'), 67787013, 48623161);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (29564614, 'Supply chain security', 'Closed', to_date('25-05-2022', 'dd-mm-yyyy'), to_date('16-10-2023', 'dd-mm-yyyy'), 52971711, 77108638);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (71198441, 'Environmental adaptability', 'Pending', to_date('11-11-2022', 'dd-mm-yyyy'), to_date('21-02-2024', 'dd-mm-yyyy'), 76562622, 59704787);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (63736981, 'Communication latency', 'Urgent', to_date('05-12-2022', 'dd-mm-yyyy'), to_date('13-04-2024', 'dd-mm-yyyy'), 82838120, 86188800);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (61684062, 'Environmental adaptability', 'Pending Review', to_date('25-02-2023', 'dd-mm-yyyy'), to_date('13-09-2023', 'dd-mm-yyyy'), 87260394, 42229227);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (82221229, 'Reliability of detection systems', 'Pending Review', to_date('11-09-2022', 'dd-mm-yyyy'), to_date('04-06-2023', 'dd-mm-yyyy'), 96586622, 95797610);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (67841379, 'Integration with existing defense systems', 'Urgent', to_date('29-11-2022', 'dd-mm-yyyy'), to_date('28-07-2023', 'dd-mm-yyyy'), 67967662, 17424418);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (42332873, 'Operator training and human error', 'Escalated', to_date('15-11-2022', 'dd-mm-yyyy'), to_date('13-11-2023', 'dd-mm-yyyy'), 86377675, 92654065);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (17209644, 'Interception accuracy', 'Resolved', to_date('15-04-2022', 'dd-mm-yyyy'), to_date('30-03-2024', 'dd-mm-yyyy'), 10222203, 16941013);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (23947666, 'Communication latency', 'Pending', to_date('15-10-2022', 'dd-mm-yyyy'), to_date('06-02-2024', 'dd-mm-yyyy'), 97921756, 83860242);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (58860483, 'Maintenance and operational costs', 'Resolved', to_date('10-10-2022', 'dd-mm-yyyy'), to_date('26-12-2023', 'dd-mm-yyyy'), 66802431, 93043478);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (77668999, 'False positives and negatives', 'Pending', to_date('22-09-2022', 'dd-mm-yyyy'), to_date('03-01-2024', 'dd-mm-yyyy'), 87142600, 96010688);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (94551370, 'False positives and negatives', 'Closed', to_date('28-07-2022', 'dd-mm-yyyy'), to_date('20-11-2023', 'dd-mm-yyyy'), 94619363, 50482581);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (14868008, 'Interception accuracy', 'Escalated', to_date('03-07-2022', 'dd-mm-yyyy'), to_date('07-02-2024', 'dd-mm-yyyy'), 21479883, 73020463);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (42882783, 'Vulnerability to cyber attacks', 'Pending', to_date('28-08-2022', 'dd-mm-yyyy'), to_date('10-10-2023', 'dd-mm-yyyy'), 87260394, 35708697);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (55669400, 'False positives and negatives', 'Resolved', to_date('27-05-2022', 'dd-mm-yyyy'), to_date('07-07-2023', 'dd-mm-yyyy'), 92210982, 99508568);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (68327959, 'False positives and negatives', 'Closed', to_date('16-08-2022', 'dd-mm-yyyy'), to_date('04-04-2024', 'dd-mm-yyyy'), 13596747, 98008948);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (53934496, 'Environmental adaptability', 'Pending', to_date('15-04-2023', 'dd-mm-yyyy'), to_date('23-04-2024', 'dd-mm-yyyy'), 73029532, 64558450);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (34865457, 'Communication latency', 'Pending Review', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('16-08-2023', 'dd-mm-yyyy'), 31733408, 12063596);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (94943398, 'Reliability of detection systems', 'Resolved', to_date('09-09-2022', 'dd-mm-yyyy'), to_date('16-04-2024', 'dd-mm-yyyy'), 55234278, 33365865);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (16415463, 'Reliability of detection systems', 'Pending', to_date('07-04-2023', 'dd-mm-yyyy'), to_date('15-09-2023', 'dd-mm-yyyy'), 12197075, 79397292);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (32425461, 'False positives and negatives', 'Pending Review', to_date('22-09-2022', 'dd-mm-yyyy'), to_date('08-06-2023', 'dd-mm-yyyy'), 42819356, 66198811);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (66485844, 'Vulnerability to cyber attacks', 'Pending', to_date('21-07-2022', 'dd-mm-yyyy'), to_date('20-12-2023', 'dd-mm-yyyy'), 54302716, 64964952);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (72456369, 'Environmental adaptability', 'Closed', to_date('13-12-2022', 'dd-mm-yyyy'), to_date('04-02-2024', 'dd-mm-yyyy'), 42403279, 83860242);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (65498410, 'Integration with existing defense systems', 'Pending', to_date('30-01-2022', 'dd-mm-yyyy'), to_date('17-01-2024', 'dd-mm-yyyy'), 96703276, 64558450);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (63156140, 'Maintenance and operational costs', 'Resolved', to_date('29-03-2022', 'dd-mm-yyyy'), to_date('20-12-2023', 'dd-mm-yyyy'), 24030481, 83468426);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (39314662, 'Maintenance and operational costs', 'Escalated', to_date('05-01-2023', 'dd-mm-yyyy'), to_date('13-02-2024', 'dd-mm-yyyy'), 50354801, 80135037);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (76710290, 'Maintenance and operational costs', 'Resolved', to_date('01-02-2023', 'dd-mm-yyyy'), to_date('25-05-2023', 'dd-mm-yyyy'), 27611169, 88095276);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (54621125, 'Integration with existing defense systems', 'Closed', to_date('27-03-2023', 'dd-mm-yyyy'), to_date('03-08-2023', 'dd-mm-yyyy'), 23001271, 27866692);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (59366180, 'Integration with existing defense systems', 'Pending Review', to_date('12-03-2022', 'dd-mm-yyyy'), to_date('09-04-2024', 'dd-mm-yyyy'), 38339252, 93085730);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (93902791, 'Vulnerability to cyber attacks', 'Pending', to_date('09-06-2022', 'dd-mm-yyyy'), to_date('05-09-2023', 'dd-mm-yyyy'), 82732528, 67511575);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (96704832, 'Environmental adaptability', 'Pending Review', to_date('23-01-2022', 'dd-mm-yyyy'), to_date('15-08-2023', 'dd-mm-yyyy'), 85366873, 21031690);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (41787217, 'Integration with existing defense systems', 'Urgent', to_date('03-02-2023', 'dd-mm-yyyy'), to_date('31-01-2024', 'dd-mm-yyyy'), 15440490, 18081451);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (14119090, 'False positives and negatives', 'Pending', to_date('10-03-2022', 'dd-mm-yyyy'), to_date('29-11-2023', 'dd-mm-yyyy'), 95588116, 40125782);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (45033484, 'Operator training and human error', 'Urgent', to_date('29-03-2023', 'dd-mm-yyyy'), to_date('08-11-2023', 'dd-mm-yyyy'), 11519494, 25601183);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (60008684, 'False positives and negatives', 'Pending Review', to_date('06-04-2023', 'dd-mm-yyyy'), to_date('13-08-2023', 'dd-mm-yyyy'), 25554128, 36424108);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (17755410, 'Reliability of detection systems', 'Closed', to_date('05-11-2022', 'dd-mm-yyyy'), to_date('28-01-2024', 'dd-mm-yyyy'), 66802431, 51162768);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (55601836, 'Supply chain security', 'Escalated', to_date('01-01-2023', 'dd-mm-yyyy'), to_date('21-04-2024', 'dd-mm-yyyy'), 33020826, 25487781);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (54426296, 'Environmental adaptability', 'Pending Review', to_date('29-08-2022', 'dd-mm-yyyy'), to_date('08-10-2023', 'dd-mm-yyyy'), 48894891, 63984513);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (84987826, 'Supply chain security', 'Closed', to_date('06-02-2023', 'dd-mm-yyyy'), to_date('29-10-2023', 'dd-mm-yyyy'), 10011040, 22027123);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (13010768, 'Interception accuracy', 'Closed', to_date('06-09-2022', 'dd-mm-yyyy'), to_date('19-02-2024', 'dd-mm-yyyy'), 27778669, 17118876);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (75636144, 'Maintenance and operational costs', 'Resolved', to_date('13-07-2022', 'dd-mm-yyyy'), to_date('15-02-2024', 'dd-mm-yyyy'), 96511163, 69850015);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (42636578, 'Environmental adaptability', 'Pending', to_date('23-12-2022', 'dd-mm-yyyy'), to_date('28-11-2023', 'dd-mm-yyyy'), 88610801, 98442581);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (63282879, 'Integration with existing defense systems', 'Escalated', to_date('25-04-2023', 'dd-mm-yyyy'), to_date('24-08-2023', 'dd-mm-yyyy'), 87042220, 19941178);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (21478947, 'Communication latency', 'Pending', to_date('10-02-2023', 'dd-mm-yyyy'), to_date('10-01-2024', 'dd-mm-yyyy'), 66648742, 63984513);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (61832503, 'Integration with existing defense systems', 'Pending', to_date('13-03-2022', 'dd-mm-yyyy'), to_date('19-05-2023', 'dd-mm-yyyy'), 20516305, 61646766);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (99211723, 'Maintenance and operational costs', 'Pending Review', to_date('25-04-2023', 'dd-mm-yyyy'), to_date('08-10-2023', 'dd-mm-yyyy'), 93588437, 41006933);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (99050222, 'False positives and negatives', 'Pending', to_date('26-09-2022', 'dd-mm-yyyy'), to_date('13-04-2024', 'dd-mm-yyyy'), 78004881, 21691339);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (25108100, 'Supply chain security', 'Pending Review', to_date('24-03-2023', 'dd-mm-yyyy'), to_date('28-02-2024', 'dd-mm-yyyy'), 46121501, 79426451);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (95431356, 'Reliability of detection systems', 'Urgent', to_date('25-09-2022', 'dd-mm-yyyy'), to_date('10-03-2024', 'dd-mm-yyyy'), 72074362, 87449313);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (53274054, 'False positives and negatives', 'Closed', to_date('04-03-2023', 'dd-mm-yyyy'), to_date('18-07-2023', 'dd-mm-yyyy'), 89335717, 58240196);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (24854931, 'False positives and negatives', 'Pending Review', to_date('14-07-2022', 'dd-mm-yyyy'), to_date('30-08-2023', 'dd-mm-yyyy'), 74158462, 96883344);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (31194930, 'Communication latency', 'Urgent', to_date('31-07-2022', 'dd-mm-yyyy'), to_date('23-07-2023', 'dd-mm-yyyy'), 78818005, 35355829);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (34583735, 'Communication latency', 'Pending Review', to_date('30-09-2022', 'dd-mm-yyyy'), to_date('23-01-2024', 'dd-mm-yyyy'), 10293566, 35825128);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (12394721, 'Environmental adaptability', 'Resolved', to_date('28-01-2023', 'dd-mm-yyyy'), to_date('19-01-2024', 'dd-mm-yyyy'), 96837631, 80962037);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (16987553, 'Vulnerability to cyber attacks', 'Closed', to_date('09-02-2022', 'dd-mm-yyyy'), to_date('16-03-2024', 'dd-mm-yyyy'), 73195846, 53091633);
commit;
prompt 100 records committed...
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (59173630, 'Reliability of detection systems', 'Urgent', to_date('15-10-2022', 'dd-mm-yyyy'), to_date('09-11-2023', 'dd-mm-yyyy'), 78818005, 96293674);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (29165108, 'Vulnerability to cyber attacks', 'Pending Review', to_date('23-06-2022', 'dd-mm-yyyy'), to_date('11-10-2023', 'dd-mm-yyyy'), 10222203, 47850199);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (62727373, 'Reliability of detection systems', 'Pending Review', to_date('16-09-2022', 'dd-mm-yyyy'), to_date('30-01-2024', 'dd-mm-yyyy'), 54054025, 22779706);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (47548459, 'Supply chain security', 'Escalated', to_date('07-03-2022', 'dd-mm-yyyy'), to_date('13-08-2023', 'dd-mm-yyyy'), 91831066, 91245220);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (36086462, 'Interception accuracy', 'Closed', to_date('26-09-2022', 'dd-mm-yyyy'), to_date('01-03-2024', 'dd-mm-yyyy'), 38831861, 72765447);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (65716170, 'Vulnerability to cyber attacks', 'Escalated', to_date('09-03-2022', 'dd-mm-yyyy'), to_date('23-12-2023', 'dd-mm-yyyy'), 94691263, 24162881);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (45870336, 'Supply chain security', 'Resolved', to_date('02-06-2022', 'dd-mm-yyyy'), to_date('27-07-2023', 'dd-mm-yyyy'), 89798029, 48534835);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (73143519, 'Communication latency', 'Pending Review', to_date('25-08-2022', 'dd-mm-yyyy'), to_date('03-01-2024', 'dd-mm-yyyy'), 56069320, 92923830);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (32454730, 'Maintenance and operational costs', 'Closed', to_date('07-10-2022', 'dd-mm-yyyy'), to_date('19-10-2023', 'dd-mm-yyyy'), 99278701, 71812980);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (93604348, 'Maintenance and operational costs', 'Closed', to_date('18-03-2022', 'dd-mm-yyyy'), to_date('19-01-2024', 'dd-mm-yyyy'), 10615587, 38717490);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (80426065, 'Maintenance and operational costs', 'Escalated', to_date('05-07-2022', 'dd-mm-yyyy'), to_date('20-04-2024', 'dd-mm-yyyy'), 67681216, 13265686);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (92534861, 'False positives and negatives', 'Pending', to_date('07-02-2023', 'dd-mm-yyyy'), to_date('05-01-2024', 'dd-mm-yyyy'), 17024629, 76115146);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (32768894, 'Supply chain security', 'Resolved', to_date('01-02-2023', 'dd-mm-yyyy'), to_date('20-03-2024', 'dd-mm-yyyy'), 61251646, 35708697);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (55999747, 'Communication latency', 'Resolved', to_date('26-09-2022', 'dd-mm-yyyy'), to_date('27-12-2023', 'dd-mm-yyyy'), 85742567, 85651969);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (88726606, 'Operator training and human error', 'Escalated', to_date('12-11-2022', 'dd-mm-yyyy'), to_date('10-01-2024', 'dd-mm-yyyy'), 44993322, 32155969);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (38090457, 'Supply chain security', 'Resolved', to_date('22-03-2022', 'dd-mm-yyyy'), to_date('17-09-2023', 'dd-mm-yyyy'), 55234278, 48534835);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (77316570, 'Supply chain security', 'Pending', to_date('06-03-2023', 'dd-mm-yyyy'), to_date('06-09-2023', 'dd-mm-yyyy'), 59288647, 91941817);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (71759311, 'Communication latency', 'Pending', to_date('18-01-2023', 'dd-mm-yyyy'), to_date('21-03-2024', 'dd-mm-yyyy'), 76562622, 92575580);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (31693827, 'Communication latency', 'Resolved', to_date('27-04-2023', 'dd-mm-yyyy'), to_date('06-03-2024', 'dd-mm-yyyy'), 87401392, 58395283);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (28376283, 'False positives and negatives', 'Urgent', to_date('05-04-2023', 'dd-mm-yyyy'), to_date('27-06-2023', 'dd-mm-yyyy'), 31768349, 84046587);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (14567175, 'False positives and negatives', 'Resolved', to_date('20-08-2022', 'dd-mm-yyyy'), to_date('20-06-2023', 'dd-mm-yyyy'), 49891570, 40125782);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (46812926, 'Reliability of detection systems', 'Resolved', to_date('10-12-2022', 'dd-mm-yyyy'), to_date('28-08-2023', 'dd-mm-yyyy'), 24659641, 64301667);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (57303159, 'Environmental adaptability', 'Pending', to_date('30-08-2022', 'dd-mm-yyyy'), to_date('19-08-2023', 'dd-mm-yyyy'), 54289748, 13662391);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (91734813, 'Maintenance and operational costs', 'Closed', to_date('14-08-2022', 'dd-mm-yyyy'), to_date('11-03-2024', 'dd-mm-yyyy'), 10011040, 85123323);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (15831961, 'Operator training and human error', 'Urgent', to_date('05-01-2023', 'dd-mm-yyyy'), to_date('21-08-2023', 'dd-mm-yyyy'), 79123923, 81027755);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (86145237, 'Maintenance and operational costs', 'Pending', to_date('29-09-2022', 'dd-mm-yyyy'), to_date('04-06-2023', 'dd-mm-yyyy'), 63207641, 13265686);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (60619613, 'Interception accuracy', 'Pending Review', to_date('13-08-2022', 'dd-mm-yyyy'), to_date('19-02-2024', 'dd-mm-yyyy'), 71430184, 23987210);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (23193586, 'Supply chain security', 'Urgent', to_date('29-07-2022', 'dd-mm-yyyy'), to_date('12-03-2024', 'dd-mm-yyyy'), 84924184, 38717490);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (56418190, 'Maintenance and operational costs', 'Closed', to_date('01-06-2022', 'dd-mm-yyyy'), to_date('08-09-2023', 'dd-mm-yyyy'), 31674879, 64558450);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (39966907, 'Operator training and human error', 'Pending Review', to_date('23-08-2022', 'dd-mm-yyyy'), to_date('10-01-2024', 'dd-mm-yyyy'), 18766984, 22027123);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (65874801, 'Environmental adaptability', 'Pending', to_date('07-03-2022', 'dd-mm-yyyy'), to_date('22-05-2023', 'dd-mm-yyyy'), 17009998, 22378117);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (59547606, 'Operator training and human error', 'Pending Review', to_date('13-03-2023', 'dd-mm-yyyy'), to_date('20-03-2024', 'dd-mm-yyyy'), 31674879, 33365865);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (99996199, 'Vulnerability to cyber attacks', 'Closed', to_date('28-12-2022', 'dd-mm-yyyy'), to_date('19-08-2023', 'dd-mm-yyyy'), 73741015, 64301667);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (50169089, 'Reliability of detection systems', 'Pending Review', to_date('22-05-2022', 'dd-mm-yyyy'), to_date('28-11-2023', 'dd-mm-yyyy'), 97052515, 48109402);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (73553731, 'Environmental adaptability', 'Urgent', to_date('04-07-2022', 'dd-mm-yyyy'), to_date('18-11-2023', 'dd-mm-yyyy'), 13376107, 93154110);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (19959315, 'Reliability of detection systems', 'Escalated', to_date('14-04-2023', 'dd-mm-yyyy'), to_date('04-01-2024', 'dd-mm-yyyy'), 78035994, 50084826);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (45398107, 'Interception accuracy', 'Pending Review', to_date('04-07-2022', 'dd-mm-yyyy'), to_date('18-04-2024', 'dd-mm-yyyy'), 49703969, 48534835);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (25654846, 'Vulnerability to cyber attacks', 'Escalated', to_date('04-10-2022', 'dd-mm-yyyy'), to_date('12-09-2023', 'dd-mm-yyyy'), 39817959, 93245618);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (17960113, 'Reliability of detection systems', 'Closed', to_date('30-01-2023', 'dd-mm-yyyy'), to_date('19-12-2023', 'dd-mm-yyyy'), 49703969, 60678395);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (71919900, 'Environmental adaptability', 'Closed', to_date('24-03-2023', 'dd-mm-yyyy'), to_date('19-04-2024', 'dd-mm-yyyy'), 55234278, 35053402);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (47566910, 'Interception accuracy', 'Urgent', to_date('05-10-2022', 'dd-mm-yyyy'), to_date('20-11-2023', 'dd-mm-yyyy'), 82838120, 57655257);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (47641273, 'Operator training and human error', 'Urgent', to_date('21-07-2022', 'dd-mm-yyyy'), to_date('11-07-2023', 'dd-mm-yyyy'), 72074362, 13643000);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (53228934, 'Vulnerability to cyber attacks', 'Urgent', to_date('21-02-2022', 'dd-mm-yyyy'), to_date('21-10-2023', 'dd-mm-yyyy'), 13376107, 16493046);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (94915670, 'Reliability of detection systems', 'Urgent', to_date('06-01-2023', 'dd-mm-yyyy'), to_date('16-07-2023', 'dd-mm-yyyy'), 27450835, 53199981);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (46874719, 'Communication latency', 'Pending', to_date('24-09-2022', 'dd-mm-yyyy'), to_date('08-02-2024', 'dd-mm-yyyy'), 66802431, 25129884);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (38526077, 'Operator training and human error', 'Pending', to_date('12-06-2022', 'dd-mm-yyyy'), to_date('03-04-2024', 'dd-mm-yyyy'), 68571163, 93097471);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (58255046, 'Vulnerability to cyber attacks', 'Urgent', to_date('02-08-2022', 'dd-mm-yyyy'), to_date('16-02-2024', 'dd-mm-yyyy'), 13456767, 65735430);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (36643270, 'Operator training and human error', 'Pending', to_date('04-05-2022', 'dd-mm-yyyy'), to_date('19-05-2023', 'dd-mm-yyyy'), 57730914, 23987210);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (63528891, 'Communication latency', 'Pending', to_date('25-02-2023', 'dd-mm-yyyy'), to_date('25-05-2023', 'dd-mm-yyyy'), 22431263, 70085003);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (20412356, 'Environmental adaptability', 'Closed', to_date('04-03-2022', 'dd-mm-yyyy'), to_date('17-07-2023', 'dd-mm-yyyy'), 44993322, 85343331);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (63506517, 'Operator training and human error', 'Pending', to_date('30-06-2022', 'dd-mm-yyyy'), to_date('12-12-2023', 'dd-mm-yyyy'), 99605950, 92914190);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (79117470, 'Reliability of detection systems', 'Escalated', to_date('31-03-2023', 'dd-mm-yyyy'), to_date('15-12-2023', 'dd-mm-yyyy'), 10615587, 19200760);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (46284792, 'Operator training and human error', 'Pending Review', to_date('21-02-2023', 'dd-mm-yyyy'), to_date('05-02-2024', 'dd-mm-yyyy'), 26250050, 84233322);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (61885331, 'Interception accuracy', 'Resolved', to_date('10-01-2023', 'dd-mm-yyyy'), to_date('21-12-2023', 'dd-mm-yyyy'), 16292512, 30749980);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (85191510, 'False positives and negatives', 'Escalated', to_date('06-10-2022', 'dd-mm-yyyy'), to_date('19-09-2023', 'dd-mm-yyyy'), 66947950, 53081260);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (84515276, 'Maintenance and operational costs', 'Pending Review', to_date('19-01-2023', 'dd-mm-yyyy'), to_date('20-04-2024', 'dd-mm-yyyy'), 24574132, 68164722);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (67183960, 'Supply chain security', 'Resolved', to_date('16-11-2022', 'dd-mm-yyyy'), to_date('05-07-2023', 'dd-mm-yyyy'), 84111141, 72744093);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (24134784, 'Operator training and human error', 'Pending Review', to_date('31-10-2022', 'dd-mm-yyyy'), to_date('10-10-2023', 'dd-mm-yyyy'), 61648409, 40751966);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (34747408, 'Reliability of detection systems', 'Closed', to_date('28-03-2022', 'dd-mm-yyyy'), to_date('04-07-2023', 'dd-mm-yyyy'), 12834085, 81643293);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (63100129, 'Interception accuracy', 'Escalated', to_date('28-07-2022', 'dd-mm-yyyy'), to_date('13-08-2023', 'dd-mm-yyyy'), 23764681, 67182998);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (56536402, 'Maintenance and operational costs', 'Closed', to_date('02-12-2022', 'dd-mm-yyyy'), to_date('11-04-2024', 'dd-mm-yyyy'), 96511163, 64207060);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (50016950, 'False positives and negatives', 'Escalated', to_date('02-09-2022', 'dd-mm-yyyy'), to_date('02-11-2023', 'dd-mm-yyyy'), 66586949, 68164722);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (34120972, 'Operator training and human error', 'Resolved', to_date('25-12-2022', 'dd-mm-yyyy'), to_date('20-03-2024', 'dd-mm-yyyy'), 89443524, 20358405);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (98069925, 'False positives and negatives', 'Pending Review', to_date('24-01-2022', 'dd-mm-yyyy'), to_date('05-02-2024', 'dd-mm-yyyy'), 45756835, 16941013);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (94865789, 'Interception accuracy', 'Pending', to_date('11-12-2022', 'dd-mm-yyyy'), to_date('11-07-2023', 'dd-mm-yyyy'), 54666303, 82801846);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (62149604, 'Integration with existing defense systems', 'Resolved', to_date('08-07-2022', 'dd-mm-yyyy'), to_date('03-01-2024', 'dd-mm-yyyy'), 84514288, 98008948);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (49808260, 'Maintenance and operational costs', 'Pending Review', to_date('06-01-2022', 'dd-mm-yyyy'), to_date('06-12-2023', 'dd-mm-yyyy'), 27286133, 94690261);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (74672618, 'Communication latency', 'Escalated', to_date('30-08-2022', 'dd-mm-yyyy'), to_date('19-07-2023', 'dd-mm-yyyy'), 60147305, 42229227);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (51036284, 'Interception accuracy', 'Closed', to_date('03-01-2023', 'dd-mm-yyyy'), to_date('04-08-2023', 'dd-mm-yyyy'), 66402088, 74086583);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (68634112, 'Vulnerability to cyber attacks', 'Closed', to_date('21-02-2023', 'dd-mm-yyyy'), to_date('27-11-2023', 'dd-mm-yyyy'), 17115038, 92914190);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (31123051, 'False positives and negatives', 'Pending', to_date('25-01-2022', 'dd-mm-yyyy'), to_date('11-11-2023', 'dd-mm-yyyy'), 73929631, 49385556);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (33433145, 'Vulnerability to cyber attacks', 'Urgent', to_date('05-04-2022', 'dd-mm-yyyy'), to_date('09-02-2024', 'dd-mm-yyyy'), 48944513, 80135037);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (78279760, 'Supply chain security', 'Pending Review', to_date('14-11-2022', 'dd-mm-yyyy'), to_date('03-06-2023', 'dd-mm-yyyy'), 72748895, 94571566);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (37498177, 'Interception accuracy', 'Resolved', to_date('12-09-2022', 'dd-mm-yyyy'), to_date('02-10-2023', 'dd-mm-yyyy'), 99026347, 46666412);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (50662551, 'Vulnerability to cyber attacks', 'Urgent', to_date('30-06-2022', 'dd-mm-yyyy'), to_date('25-07-2023', 'dd-mm-yyyy'), 13376107, 26283456);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (99835436, 'Communication latency', 'Closed', to_date('09-01-2023', 'dd-mm-yyyy'), to_date('02-09-2023', 'dd-mm-yyyy'), 54302716, 93907876);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (82342172, 'Operator training and human error', 'Closed', to_date('04-03-2023', 'dd-mm-yyyy'), to_date('21-11-2023', 'dd-mm-yyyy'), 97385354, 54066626);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (13453044, 'Vulnerability to cyber attacks', 'Escalated', to_date('26-04-2023', 'dd-mm-yyyy'), to_date('10-12-2023', 'dd-mm-yyyy'), 54569464, 59449184);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (57439104, 'Supply chain security', 'Urgent', to_date('10-03-2022', 'dd-mm-yyyy'), to_date('23-04-2024', 'dd-mm-yyyy'), 79223054, 38435240);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (45303248, 'Reliability of detection systems', 'Escalated', to_date('02-11-2022', 'dd-mm-yyyy'), to_date('26-11-2023', 'dd-mm-yyyy'), 41933583, 73020463);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (78467800, 'Integration with existing defense systems', 'Urgent', to_date('04-04-2023', 'dd-mm-yyyy'), to_date('05-08-2023', 'dd-mm-yyyy'), 38685099, 59108893);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (93058903, 'Supply chain security', 'Resolved', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('23-04-2024', 'dd-mm-yyyy'), 57730914, 13289169);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (45646671, 'Reliability of detection systems', 'Pending', to_date('31-10-2022', 'dd-mm-yyyy'), to_date('06-11-2023', 'dd-mm-yyyy'), 28451383, 79085143);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (86823580, 'Interception accuracy', 'Urgent', to_date('21-02-2023', 'dd-mm-yyyy'), to_date('29-11-2023', 'dd-mm-yyyy'), 83407796, 41096524);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (46440148, 'Communication latency', 'Pending Review', to_date('27-10-2022', 'dd-mm-yyyy'), to_date('19-12-2023', 'dd-mm-yyyy'), 91233616, 87215493);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (24530828, 'Communication latency', 'Escalated', to_date('23-07-2022', 'dd-mm-yyyy'), to_date('23-11-2023', 'dd-mm-yyyy'), 46565539, 55372821);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (55056408, 'Integration with existing defense systems', 'Pending Review', to_date('06-03-2022', 'dd-mm-yyyy'), to_date('03-01-2024', 'dd-mm-yyyy'), 95916928, 26629738);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (75398227, 'Reliability of detection systems', 'Escalated', to_date('29-10-2022', 'dd-mm-yyyy'), to_date('03-09-2023', 'dd-mm-yyyy'), 93319530, 94571566);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (79808935, 'Communication latency', 'Pending Review', to_date('28-01-2022', 'dd-mm-yyyy'), to_date('18-02-2024', 'dd-mm-yyyy'), 71718606, 55534854);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (97331022, 'Integration with existing defense systems', 'Pending Review', to_date('11-03-2022', 'dd-mm-yyyy'), to_date('10-02-2024', 'dd-mm-yyyy'), 17009998, 72765447);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (23274512, 'Environmental adaptability', 'Escalated', to_date('22-09-2022', 'dd-mm-yyyy'), to_date('25-01-2024', 'dd-mm-yyyy'), 22152428, 43052751);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (82646979, 'Integration with existing defense systems', 'Urgent', to_date('20-11-2022', 'dd-mm-yyyy'), to_date('02-09-2023', 'dd-mm-yyyy'), 95826413, 50930370);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (72896707, 'Supply chain security', 'Resolved', to_date('11-10-2022', 'dd-mm-yyyy'), to_date('08-09-2023', 'dd-mm-yyyy'), 18228257, 86759135);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (79763852, 'Supply chain security', 'Urgent', to_date('30-10-2022', 'dd-mm-yyyy'), to_date('02-06-2023', 'dd-mm-yyyy'), 80257977, 81549307);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (21977120, 'Vulnerability to cyber attacks', 'Closed', to_date('04-10-2022', 'dd-mm-yyyy'), to_date('12-06-2023', 'dd-mm-yyyy'), 96607176, 99913540);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (43210901, 'Environmental adaptability', 'Escalated', to_date('22-02-2023', 'dd-mm-yyyy'), to_date('08-07-2023', 'dd-mm-yyyy'), 97921756, 61348541);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (91016106, 'Supply chain security', 'Pending Review', to_date('13-01-2023', 'dd-mm-yyyy'), to_date('17-11-2023', 'dd-mm-yyyy'), 71382022, 96051151);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (86521131, 'Interception accuracy', 'Escalated', to_date('04-09-2022', 'dd-mm-yyyy'), to_date('05-07-2023', 'dd-mm-yyyy'), 32258996, 93245618);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (79137468, 'Reliability of detection systems', 'Closed', to_date('22-02-2022', 'dd-mm-yyyy'), to_date('21-01-2024', 'dd-mm-yyyy'), 83979292, 20983251);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (49887122, 'Vulnerability to cyber attacks', 'Closed', to_date('01-10-2022', 'dd-mm-yyyy'), to_date('10-10-2023', 'dd-mm-yyyy'), 48432072, 76023266);
commit;
prompt 200 records committed...
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (62716326, 'Supply chain security', 'Escalated', to_date('05-12-2022', 'dd-mm-yyyy'), to_date('08-07-2023', 'dd-mm-yyyy'), 22793386, 56171610);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (17613674, 'False positives and negatives', 'Resolved', to_date('22-03-2022', 'dd-mm-yyyy'), to_date('10-02-2024', 'dd-mm-yyyy'), 25554128, 69600577);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (60905539, 'Communication latency', 'Urgent', to_date('26-08-2022', 'dd-mm-yyyy'), to_date('20-08-2023', 'dd-mm-yyyy'), 23001628, 55186758);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (17724620, 'Vulnerability to cyber attacks', 'Closed', to_date('22-04-2023', 'dd-mm-yyyy'), to_date('10-08-2023', 'dd-mm-yyyy'), 80277347, 54594862);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (93853622, 'Operator training and human error', 'Resolved', to_date('10-11-2022', 'dd-mm-yyyy'), to_date('15-10-2023', 'dd-mm-yyyy'), 74158462, 44942109);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (57009736, 'Vulnerability to cyber attacks', 'Closed', to_date('03-11-2022', 'dd-mm-yyyy'), to_date('17-09-2023', 'dd-mm-yyyy'), 99272709, 76023266);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (84096789, 'Communication latency', 'Pending', to_date('05-08-2022', 'dd-mm-yyyy'), to_date('09-08-2023', 'dd-mm-yyyy'), 91996325, 61952238);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (31834115, 'Vulnerability to cyber attacks', 'Pending', to_date('26-01-2022', 'dd-mm-yyyy'), to_date('31-01-2024', 'dd-mm-yyyy'), 24308577, 96833634);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (92112520, 'Supply chain security', 'Closed', to_date('20-04-2023', 'dd-mm-yyyy'), to_date('05-08-2023', 'dd-mm-yyyy'), 56908720, 11359073);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (13258623, 'Reliability of detection systems', 'Urgent', to_date('16-06-2022', 'dd-mm-yyyy'), to_date('29-11-2023', 'dd-mm-yyyy'), 60533897, 13934808);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (39109614, 'Environmental adaptability', 'Escalated', to_date('29-03-2023', 'dd-mm-yyyy'), to_date('19-03-2024', 'dd-mm-yyyy'), 67681216, 79397292);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (29443824, 'Communication latency', 'Closed', to_date('04-03-2022', 'dd-mm-yyyy'), to_date('11-09-2023', 'dd-mm-yyyy'), 97393992, 11857649);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (44592560, 'Integration with existing defense systems', 'Escalated', to_date('10-04-2022', 'dd-mm-yyyy'), to_date('15-01-2024', 'dd-mm-yyyy'), 54289748, 91482850);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (64842999, 'Supply chain security', 'Pending', to_date('02-03-2023', 'dd-mm-yyyy'), to_date('24-07-2023', 'dd-mm-yyyy'), 54804747, 19677024);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (92497841, 'Vulnerability to cyber attacks', 'Escalated', to_date('15-08-2022', 'dd-mm-yyyy'), to_date('12-07-2023', 'dd-mm-yyyy'), 87142600, 48061480);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (57457453, 'Interception accuracy', 'Pending Review', to_date('06-09-2022', 'dd-mm-yyyy'), to_date('17-09-2023', 'dd-mm-yyyy'), 61180240, 63984513);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (33381417, 'Communication latency', 'Escalated', to_date('29-11-2022', 'dd-mm-yyyy'), to_date('24-04-2024', 'dd-mm-yyyy'), 84514288, 40751966);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (10554252, 'Interception accuracy', 'Pending', to_date('23-02-2022', 'dd-mm-yyyy'), to_date('12-10-2023', 'dd-mm-yyyy'), 79372519, 53771409);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (61865143, 'Interception accuracy', 'Pending', to_date('24-08-2022', 'dd-mm-yyyy'), to_date('06-03-2024', 'dd-mm-yyyy'), 99272709, 43052751);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (36857874, 'Interception accuracy', 'Pending Review', to_date('23-01-2022', 'dd-mm-yyyy'), to_date('05-11-2023', 'dd-mm-yyyy'), 71718606, 76622103);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (33950291, 'Interception accuracy', 'Pending Review', to_date('24-11-2022', 'dd-mm-yyyy'), to_date('02-06-2023', 'dd-mm-yyyy'), 42768514, 45171084);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (59447936, 'Reliability of detection systems', 'Pending Review', to_date('06-12-2022', 'dd-mm-yyyy'), to_date('04-07-2023', 'dd-mm-yyyy'), 33337208, 27095403);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (18503584, 'Operator training and human error', 'Escalated', to_date('17-03-2023', 'dd-mm-yyyy'), to_date('07-02-2024', 'dd-mm-yyyy'), 91831066, 11912356);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (67550270, 'Supply chain security', 'Resolved', to_date('09-06-2022', 'dd-mm-yyyy'), to_date('18-12-2023', 'dd-mm-yyyy'), 59252850, 35053402);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (96840304, 'Reliability of detection systems', 'Pending Review', to_date('26-12-2022', 'dd-mm-yyyy'), to_date('20-08-2023', 'dd-mm-yyyy'), 38628579, 47647666);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (65223045, 'Reliability of detection systems', 'Resolved', to_date('13-01-2022', 'dd-mm-yyyy'), to_date('13-06-2023', 'dd-mm-yyyy'), 71520279, 25059771);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (74495060, 'Maintenance and operational costs', 'Pending Review', to_date('03-01-2022', 'dd-mm-yyyy'), to_date('27-10-2023', 'dd-mm-yyyy'), 29698601, 40125782);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (79738478, 'Interception accuracy', 'Pending Review', to_date('01-06-2022', 'dd-mm-yyyy'), to_date('02-11-2023', 'dd-mm-yyyy'), 40050758, 15535924);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (95608667, 'Reliability of detection systems', 'Closed', to_date('27-12-2022', 'dd-mm-yyyy'), to_date('19-11-2023', 'dd-mm-yyyy'), 41933583, 55534854);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (72368867, 'False positives and negatives', 'Resolved', to_date('23-01-2022', 'dd-mm-yyyy'), to_date('04-07-2023', 'dd-mm-yyyy'), 24434420, 42506479);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (33494383, 'Supply chain security', 'Pending Review', to_date('31-03-2023', 'dd-mm-yyyy'), to_date('31-01-2024', 'dd-mm-yyyy'), 18228257, 11912356);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (90428282, 'Operator training and human error', 'Resolved', to_date('06-07-2022', 'dd-mm-yyyy'), to_date('07-03-2024', 'dd-mm-yyyy'), 42819356, 35708697);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (46503367, 'Communication latency', 'Closed', to_date('08-03-2023', 'dd-mm-yyyy'), to_date('14-06-2023', 'dd-mm-yyyy'), 64825226, 93245618);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (23923157, 'Integration with existing defense systems', 'Closed', to_date('14-12-2022', 'dd-mm-yyyy'), to_date('27-01-2024', 'dd-mm-yyyy'), 75706743, 13265686);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (56912751, 'Interception accuracy', 'Escalated', to_date('08-10-2022', 'dd-mm-yyyy'), to_date('20-11-2023', 'dd-mm-yyyy'), 97902204, 49017588);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (96151413, 'Environmental adaptability', 'Resolved', to_date('29-03-2022', 'dd-mm-yyyy'), to_date('30-05-2023', 'dd-mm-yyyy'), 90734472, 77108638);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (47835109, 'Environmental adaptability', 'Closed', to_date('18-10-2022', 'dd-mm-yyyy'), to_date('16-09-2023', 'dd-mm-yyyy'), 66406975, 76115146);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (13185395, 'Interception accuracy', 'Closed', to_date('15-03-2023', 'dd-mm-yyyy'), to_date('14-10-2023', 'dd-mm-yyyy'), 31935182, 15274111);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (99720359, 'Interception accuracy', 'Pending Review', to_date('11-08-2022', 'dd-mm-yyyy'), to_date('09-03-2024', 'dd-mm-yyyy'), 76603440, 52090085);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (95504005, 'Operator training and human error', 'Closed', to_date('04-12-2022', 'dd-mm-yyyy'), to_date('03-12-2023', 'dd-mm-yyyy'), 93319530, 25059771);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (79515286, 'Reliability of detection systems', 'Urgent', to_date('06-03-2022', 'dd-mm-yyyy'), to_date('03-10-2023', 'dd-mm-yyyy'), 15440490, 93760431);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (54228877, 'Maintenance and operational costs', 'Closed', to_date('15-04-2023', 'dd-mm-yyyy'), to_date('18-08-2023', 'dd-mm-yyyy'), 86160304, 52622636);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (32586902, 'Environmental adaptability', 'Resolved', to_date('19-04-2023', 'dd-mm-yyyy'), to_date('06-11-2023', 'dd-mm-yyyy'), 34223998, 43223357);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (37593244, 'Maintenance and operational costs', 'Resolved', to_date('31-08-2022', 'dd-mm-yyyy'), to_date('27-10-2023', 'dd-mm-yyyy'), 73929631, 19906683);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (15728704, 'Maintenance and operational costs', 'Urgent', to_date('13-05-2022', 'dd-mm-yyyy'), to_date('09-03-2024', 'dd-mm-yyyy'), 72074362, 55372821);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (78555369, 'Vulnerability to cyber attacks', 'Pending Review', to_date('23-07-2022', 'dd-mm-yyyy'), to_date('04-06-2023', 'dd-mm-yyyy'), 25945415, 46115979);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (49578723, 'Vulnerability to cyber attacks', 'Urgent', to_date('09-04-2022', 'dd-mm-yyyy'), to_date('16-08-2023', 'dd-mm-yyyy'), 48558953, 38338043);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (46209829, 'Integration with existing defense systems', 'Resolved', to_date('21-08-2022', 'dd-mm-yyyy'), to_date('16-05-2023', 'dd-mm-yyyy'), 59288647, 26751198);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (77736104, 'Interception accuracy', 'Closed', to_date('25-06-2022', 'dd-mm-yyyy'), to_date('03-03-2024', 'dd-mm-yyyy'), 31733408, 64827973);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (83131340, 'Environmental adaptability', 'Pending Review', to_date('19-03-2023', 'dd-mm-yyyy'), to_date('18-03-2024', 'dd-mm-yyyy'), 68635839, 70085003);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (12253036, 'Operator training and human error', 'Escalated', to_date('27-11-2022', 'dd-mm-yyyy'), to_date('19-09-2023', 'dd-mm-yyyy'), 35948729, 48623161);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (14091298, 'Environmental adaptability', 'Pending Review', to_date('25-05-2022', 'dd-mm-yyyy'), to_date('02-12-2023', 'dd-mm-yyyy'), 58511392, 33269799);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (64382851, 'Interception accuracy', 'Closed', to_date('06-10-2022', 'dd-mm-yyyy'), to_date('27-09-2023', 'dd-mm-yyyy'), 30047947, 50583748);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (30516127, 'Reliability of detection systems', 'Resolved', to_date('20-11-2022', 'dd-mm-yyyy'), to_date('10-09-2023', 'dd-mm-yyyy'), 50109125, 17118876);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (33702980, 'False positives and negatives', 'Pending', to_date('20-04-2023', 'dd-mm-yyyy'), to_date('03-04-2024', 'dd-mm-yyyy'), 26465702, 93043478);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (70793444, 'Supply chain security', 'Closed', to_date('30-04-2023', 'dd-mm-yyyy'), to_date('12-04-2024', 'dd-mm-yyyy'), 87401392, 68164722);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (86292810, 'Integration with existing defense systems', 'Pending Review', to_date('28-08-2022', 'dd-mm-yyyy'), to_date('11-11-2023', 'dd-mm-yyyy'), 67681216, 40125782);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (98519876, 'Supply chain security', 'Closed', to_date('28-02-2022', 'dd-mm-yyyy'), to_date('23-11-2023', 'dd-mm-yyyy'), 73741015, 20358405);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (96399083, 'Environmental adaptability', 'Pending Review', to_date('26-12-2022', 'dd-mm-yyyy'), to_date('28-04-2024', 'dd-mm-yyyy'), 16292512, 42287134);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (30923588, 'Integration with existing defense systems', 'Resolved', to_date('18-11-2022', 'dd-mm-yyyy'), to_date('18-08-2023', 'dd-mm-yyyy'), 65260797, 72765447);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (11111091, 'False positives and negatives', 'Resolved', to_date('25-07-2022', 'dd-mm-yyyy'), to_date('25-06-2023', 'dd-mm-yyyy'), 45629416, 59704787);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (55556005, 'Environmental adaptability', 'Escalated', to_date('06-02-2023', 'dd-mm-yyyy'), to_date('16-06-2023', 'dd-mm-yyyy'), 31935182, 98155811);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (37053244, 'Communication latency', 'Pending Review', to_date('22-03-2022', 'dd-mm-yyyy'), to_date('17-09-2023', 'dd-mm-yyyy'), 89335717, 71913410);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (52653851, 'Reliability of detection systems', 'Urgent', to_date('11-04-2022', 'dd-mm-yyyy'), to_date('17-06-2023', 'dd-mm-yyyy'), 27753546, 22779706);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (81354513, 'Interception accuracy', 'Resolved', to_date('24-12-2022', 'dd-mm-yyyy'), to_date('31-10-2023', 'dd-mm-yyyy'), 45455137, 45196498);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (72926152, 'Maintenance and operational costs', 'Closed', to_date('29-04-2022', 'dd-mm-yyyy'), to_date('07-09-2023', 'dd-mm-yyyy'), 90691080, 81549307);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (83890617, 'Reliability of detection systems', 'Closed', to_date('13-07-2022', 'dd-mm-yyyy'), to_date('12-12-2023', 'dd-mm-yyyy'), 31733408, 42004482);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (71546220, 'Operator training and human error', 'Escalated', to_date('20-02-2022', 'dd-mm-yyyy'), to_date('27-07-2023', 'dd-mm-yyyy'), 45629416, 71913410);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (22140491, 'Interception accuracy', 'Closed', to_date('14-03-2023', 'dd-mm-yyyy'), to_date('10-11-2023', 'dd-mm-yyyy'), 35270389, 57079314);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (99450917, 'Maintenance and operational costs', 'Resolved', to_date('08-12-2022', 'dd-mm-yyyy'), to_date('13-06-2023', 'dd-mm-yyyy'), 18828530, 26913646);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (67078683, 'Reliability of detection systems', 'Resolved', to_date('21-12-2022', 'dd-mm-yyyy'), to_date('25-11-2023', 'dd-mm-yyyy'), 99272709, 81500448);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (28293642, 'Vulnerability to cyber attacks', 'Resolved', to_date('26-12-2022', 'dd-mm-yyyy'), to_date('02-05-2023', 'dd-mm-yyyy'), 38283166, 76663286);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (86464742, 'Interception accuracy', 'Resolved', to_date('10-10-2022', 'dd-mm-yyyy'), to_date('07-11-2023', 'dd-mm-yyyy'), 25271570, 72765447);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (46188483, 'Maintenance and operational costs', 'Resolved', to_date('20-09-2022', 'dd-mm-yyyy'), to_date('21-09-2023', 'dd-mm-yyyy'), 70094374, 96293674);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (73814534, 'Environmental adaptability', 'Closed', to_date('27-04-2022', 'dd-mm-yyyy'), to_date('09-10-2023', 'dd-mm-yyyy'), 66406975, 12473697);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (73345877, 'Communication latency', 'Resolved', to_date('02-12-2022', 'dd-mm-yyyy'), to_date('25-06-2023', 'dd-mm-yyyy'), 66802431, 19200760);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (65371576, 'Vulnerability to cyber attacks', 'Urgent', to_date('31-03-2022', 'dd-mm-yyyy'), to_date('11-05-2023', 'dd-mm-yyyy'), 73609023, 48850105);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (20459891, 'Interception accuracy', 'Closed', to_date('04-12-2022', 'dd-mm-yyyy'), to_date('23-06-2023', 'dd-mm-yyyy'), 37174955, 81643293);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (26664104, 'Communication latency', 'Closed', to_date('18-04-2023', 'dd-mm-yyyy'), to_date('15-08-2023', 'dd-mm-yyyy'), 91996325, 37607652);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (43888868, 'Maintenance and operational costs', 'Escalated', to_date('24-06-2022', 'dd-mm-yyyy'), to_date('30-09-2023', 'dd-mm-yyyy'), 22793386, 12360036);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (52860508, 'Operator training and human error', 'Resolved', to_date('17-09-2022', 'dd-mm-yyyy'), to_date('23-10-2023', 'dd-mm-yyyy'), 66648742, 68766738);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (50899697, 'Reliability of detection systems', 'Resolved', to_date('08-07-2022', 'dd-mm-yyyy'), to_date('03-02-2024', 'dd-mm-yyyy'), 55234278, 21000949);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (96247108, 'Vulnerability to cyber attacks', 'Closed', to_date('29-03-2023', 'dd-mm-yyyy'), to_date('01-01-2024', 'dd-mm-yyyy'), 57518681, 17686373);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (51146377, 'Interception accuracy', 'Pending Review', to_date('23-12-2022', 'dd-mm-yyyy'), to_date('11-02-2024', 'dd-mm-yyyy'), 87401392, 93619695);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (27872959, 'Maintenance and operational costs', 'Pending Review', to_date('29-10-2022', 'dd-mm-yyyy'), to_date('19-05-2023', 'dd-mm-yyyy'), 93841124, 33494717);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (27750771, 'Communication latency', 'Escalated', to_date('10-01-2023', 'dd-mm-yyyy'), to_date('18-06-2023', 'dd-mm-yyyy'), 18176375, 35511914);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (11861430, 'Vulnerability to cyber attacks', 'Escalated', to_date('23-07-2022', 'dd-mm-yyyy'), to_date('13-05-2023', 'dd-mm-yyyy'), 31674879, 17424418);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (78472637, 'Interception accuracy', 'Resolved', to_date('06-05-2022', 'dd-mm-yyyy'), to_date('12-07-2023', 'dd-mm-yyyy'), 90147871, 64558450);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (18202772, 'Operator training and human error', 'Closed', to_date('01-10-2022', 'dd-mm-yyyy'), to_date('07-01-2024', 'dd-mm-yyyy'), 73085333, 17690127);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (65121988, 'Vulnerability to cyber attacks', 'Resolved', to_date('27-10-2022', 'dd-mm-yyyy'), to_date('10-06-2023', 'dd-mm-yyyy'), 56325911, 89405048);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (36140714, 'Supply chain security', 'Pending', to_date('16-09-2022', 'dd-mm-yyyy'), to_date('12-04-2024', 'dd-mm-yyyy'), 94809507, 11897171);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (23204767, 'Integration with existing defense systems', 'Urgent', to_date('01-01-2022', 'dd-mm-yyyy'), to_date('21-04-2024', 'dd-mm-yyyy'), 48004855, 76622103);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (23674316, 'Integration with existing defense systems', 'Pending', to_date('18-04-2022', 'dd-mm-yyyy'), to_date('13-09-2023', 'dd-mm-yyyy'), 97052515, 54594862);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (74427558, 'Interception accuracy', 'Urgent', to_date('02-08-2022', 'dd-mm-yyyy'), to_date('09-05-2023', 'dd-mm-yyyy'), 72074362, 26538156);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (92338914, 'Environmental adaptability', 'Closed', to_date('06-03-2023', 'dd-mm-yyyy'), to_date('24-08-2023', 'dd-mm-yyyy'), 26465702, 82766735);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (17743706, 'Interception accuracy', 'Closed', to_date('29-11-2022', 'dd-mm-yyyy'), to_date('05-08-2023', 'dd-mm-yyyy'), 57436382, 59704787);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (68431914, 'Supply chain security', 'Pending', to_date('07-03-2022', 'dd-mm-yyyy'), to_date('22-04-2024', 'dd-mm-yyyy'), 54302716, 28552995);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (60726749, 'Integration with existing defense systems', 'Escalated', to_date('09-11-2022', 'dd-mm-yyyy'), to_date('02-09-2023', 'dd-mm-yyyy'), 13661684, 37830269);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (35335541, 'False positives and negatives', 'Closed', to_date('29-01-2023', 'dd-mm-yyyy'), to_date('10-06-2023', 'dd-mm-yyyy'), 79653532, 18700397);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (77832413, 'Communication latency', 'Resolved', to_date('26-04-2022', 'dd-mm-yyyy'), to_date('18-08-2023', 'dd-mm-yyyy'), 99272709, 55407648);
commit;
prompt 300 records committed...
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (54684350, 'Supply chain security', 'Pending Review', to_date('10-12-2022', 'dd-mm-yyyy'), to_date('19-09-2023', 'dd-mm-yyyy'), 53805635, 78052010);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (66182751, 'Maintenance and operational costs', 'Resolved', to_date('24-09-2022', 'dd-mm-yyyy'), to_date('08-02-2024', 'dd-mm-yyyy'), 83979292, 30246422);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (29955365, 'Vulnerability to cyber attacks', 'Pending Review', to_date('26-10-2022', 'dd-mm-yyyy'), to_date('02-09-2023', 'dd-mm-yyyy'), 46565539, 69052929);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (38500077, 'Reliability of detection systems', 'Pending Review', to_date('06-03-2023', 'dd-mm-yyyy'), to_date('22-08-2023', 'dd-mm-yyyy'), 49541412, 86630665);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (12748202, 'Operator training and human error', 'Closed', to_date('20-01-2023', 'dd-mm-yyyy'), to_date('14-12-2023', 'dd-mm-yyyy'), 46767112, 83860242);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (57359424, 'False positives and negatives', 'Closed', to_date('28-07-2022', 'dd-mm-yyyy'), to_date('14-09-2023', 'dd-mm-yyyy'), 58511392, 55267731);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (22696318, 'Maintenance and operational costs', 'Closed', to_date('27-11-2022', 'dd-mm-yyyy'), to_date('30-07-2023', 'dd-mm-yyyy'), 61251646, 71933637);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (40641098, 'False positives and negatives', 'Closed', to_date('12-01-2022', 'dd-mm-yyyy'), to_date('15-08-2023', 'dd-mm-yyyy'), 19745492, 85651969);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (14733759, 'Interception accuracy', 'Closed', to_date('06-03-2022', 'dd-mm-yyyy'), to_date('17-07-2023', 'dd-mm-yyyy'), 68571163, 48623161);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (75574696, 'Operator training and human error', 'Pending', to_date('09-03-2023', 'dd-mm-yyyy'), to_date('18-09-2023', 'dd-mm-yyyy'), 17024629, 87034260);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (15459358, 'Communication latency', 'Resolved', to_date('15-08-2022', 'dd-mm-yyyy'), to_date('15-04-2024', 'dd-mm-yyyy'), 11386390, 83947281);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (53697585, 'Environmental adaptability', 'Resolved', to_date('14-06-2022', 'dd-mm-yyyy'), to_date('17-05-2023', 'dd-mm-yyyy'), 23388359, 30988658);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (31717260, 'Supply chain security', 'Pending Review', to_date('25-05-2022', 'dd-mm-yyyy'), to_date('27-05-2023', 'dd-mm-yyyy'), 89443524, 96248818);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (92029347, 'False positives and negatives', 'Resolved', to_date('25-04-2022', 'dd-mm-yyyy'), to_date('16-04-2024', 'dd-mm-yyyy'), 65329400, 72765447);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (92414112, 'Reliability of detection systems', 'Pending', to_date('22-03-2023', 'dd-mm-yyyy'), to_date('08-07-2023', 'dd-mm-yyyy'), 42458539, 63132707);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (36743211, 'Maintenance and operational costs', 'Resolved', to_date('27-01-2022', 'dd-mm-yyyy'), to_date('20-11-2023', 'dd-mm-yyyy'), 42768514, 96051151);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (21929929, 'Integration with existing defense systems', 'Pending Review', to_date('01-11-2022', 'dd-mm-yyyy'), to_date('24-04-2024', 'dd-mm-yyyy'), 13675493, 73405396);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (83313460, 'Integration with existing defense systems', 'Closed', to_date('27-03-2022', 'dd-mm-yyyy'), to_date('15-04-2024', 'dd-mm-yyyy'), 67787013, 71933637);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (18133499, 'Integration with existing defense systems', 'Resolved', to_date('10-06-2022', 'dd-mm-yyyy'), to_date('27-04-2024', 'dd-mm-yyyy'), 36254297, 71933637);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (48500538, 'False positives and negatives', 'Escalated', to_date('17-06-2022', 'dd-mm-yyyy'), to_date('01-11-2023', 'dd-mm-yyyy'), 25554128, 24162881);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (14324588, 'Integration with existing defense systems', 'Escalated', to_date('12-04-2022', 'dd-mm-yyyy'), to_date('23-11-2023', 'dd-mm-yyyy'), 84322428, 59141156);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (40192619, 'Vulnerability to cyber attacks', 'Pending', to_date('13-08-2022', 'dd-mm-yyyy'), to_date('17-12-2023', 'dd-mm-yyyy'), 76562622, 26283456);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (87602349, 'Maintenance and operational costs', 'Closed', to_date('26-03-2023', 'dd-mm-yyyy'), to_date('14-08-2023', 'dd-mm-yyyy'), 85948925, 16442662);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (13016306, 'Supply chain security', 'Closed', to_date('17-05-2022', 'dd-mm-yyyy'), to_date('04-10-2023', 'dd-mm-yyyy'), 92655517, 66590336);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (76870516, 'False positives and negatives', 'Pending Review', to_date('05-09-2022', 'dd-mm-yyyy'), to_date('04-05-2023', 'dd-mm-yyyy'), 91021750, 56171610);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (94643446, 'Operator training and human error', 'Escalated', to_date('21-11-2022', 'dd-mm-yyyy'), to_date('21-12-2023', 'dd-mm-yyyy'), 90734472, 48850105);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (14755111, 'Reliability of detection systems', 'Pending', to_date('31-01-2023', 'dd-mm-yyyy'), to_date('05-03-2024', 'dd-mm-yyyy'), 56069320, 90589554);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (73210778, 'Maintenance and operational costs', 'Escalated', to_date('11-02-2023', 'dd-mm-yyyy'), to_date('30-06-2023', 'dd-mm-yyyy'), 46121501, 56171610);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (97251797, 'Maintenance and operational costs', 'Urgent', to_date('03-01-2023', 'dd-mm-yyyy'), to_date('21-08-2023', 'dd-mm-yyyy'), 55036429, 67182998);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (68160747, 'Reliability of detection systems', 'Pending', to_date('19-08-2022', 'dd-mm-yyyy'), to_date('30-07-2023', 'dd-mm-yyyy'), 76522038, 96293674);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (93445398, 'Integration with existing defense systems', 'Closed', to_date('18-05-2022', 'dd-mm-yyyy'), to_date('02-03-2024', 'dd-mm-yyyy'), 79372519, 76663286);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (88657546, 'False positives and negatives', 'Closed', to_date('24-03-2022', 'dd-mm-yyyy'), to_date('21-12-2023', 'dd-mm-yyyy'), 79653532, 81828427);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (85466398, 'Interception accuracy', 'Closed', to_date('02-04-2023', 'dd-mm-yyyy'), to_date('03-10-2023', 'dd-mm-yyyy'), 88610801, 86759135);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (18312517, 'Supply chain security', 'Pending', to_date('03-08-2022', 'dd-mm-yyyy'), to_date('29-01-2024', 'dd-mm-yyyy'), 33337208, 84847306);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (31593331, 'Environmental adaptability', 'Closed', to_date('23-10-2022', 'dd-mm-yyyy'), to_date('02-10-2023', 'dd-mm-yyyy'), 46767112, 30004002);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (80392488, 'Vulnerability to cyber attacks', 'Pending Review', to_date('11-12-2022', 'dd-mm-yyyy'), to_date('20-11-2023', 'dd-mm-yyyy'), 35557001, 48743769);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (33701044, 'Vulnerability to cyber attacks', 'Closed', to_date('07-01-2023', 'dd-mm-yyyy'), to_date('21-04-2024', 'dd-mm-yyyy'), 40839706, 55167864);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (57108469, 'Communication latency', 'Closed', to_date('24-09-2022', 'dd-mm-yyyy'), to_date('22-03-2024', 'dd-mm-yyyy'), 89798029, 72765447);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (79717640, 'Communication latency', 'Closed', to_date('20-09-2022', 'dd-mm-yyyy'), to_date('28-10-2023', 'dd-mm-yyyy'), 49703969, 16493046);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (58115308, 'False positives and negatives', 'Resolved', to_date('26-08-2022', 'dd-mm-yyyy'), to_date('26-06-2023', 'dd-mm-yyyy'), 71044320, 84289834);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (73012738, 'Vulnerability to cyber attacks', 'Urgent', to_date('03-02-2023', 'dd-mm-yyyy'), to_date('05-05-2023', 'dd-mm-yyyy'), 79123923, 64558450);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (60120519, 'Environmental adaptability', 'Resolved', to_date('06-01-2022', 'dd-mm-yyyy'), to_date('24-12-2023', 'dd-mm-yyyy'), 97385354, 26283456);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (59321283, 'Operator training and human error', 'Closed', to_date('06-03-2023', 'dd-mm-yyyy'), to_date('18-06-2023', 'dd-mm-yyyy'), 58740743, 16793442);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (49627404, 'Environmental adaptability', 'Pending Review', to_date('10-06-2022', 'dd-mm-yyyy'), to_date('26-09-2023', 'dd-mm-yyyy'), 28451383, 58281867);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (97448973, 'Interception accuracy', 'Pending Review', to_date('15-11-2022', 'dd-mm-yyyy'), to_date('04-02-2024', 'dd-mm-yyyy'), 18766984, 91245220);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (19099337, 'Communication latency', 'Closed', to_date('20-04-2023', 'dd-mm-yyyy'), to_date('01-09-2023', 'dd-mm-yyyy'), 67967662, 87034260);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (94849809, 'Interception accuracy', 'Resolved', to_date('19-02-2023', 'dd-mm-yyyy'), to_date('14-07-2023', 'dd-mm-yyyy'), 25554128, 87215493);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (37432262, 'Environmental adaptability', 'Resolved', to_date('16-04-2022', 'dd-mm-yyyy'), to_date('16-01-2024', 'dd-mm-yyyy'), 27104007, 81027755);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (10128163, 'Integration with existing defense systems', 'Resolved', to_date('20-07-2022', 'dd-mm-yyyy'), to_date('23-03-2024', 'dd-mm-yyyy'), 17115038, 66916660);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (59437894, 'False positives and negatives', 'Pending', to_date('23-04-2023', 'dd-mm-yyyy'), to_date('13-05-2023', 'dd-mm-yyyy'), 24308577, 11593556);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (79264965, 'Communication latency', 'Urgent', to_date('13-08-2022', 'dd-mm-yyyy'), to_date('20-10-2023', 'dd-mm-yyyy'), 97932782, 32484933);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (66307121, 'Maintenance and operational costs', 'Pending', to_date('30-03-2023', 'dd-mm-yyyy'), to_date('02-05-2023', 'dd-mm-yyyy'), 95357416, 54594862);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (88065296, 'Communication latency', 'Closed', to_date('06-12-2022', 'dd-mm-yyyy'), to_date('01-08-2023', 'dd-mm-yyyy'), 27753546, 96744987);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (38172731, 'Reliability of detection systems', 'Pending Review', to_date('30-05-2022', 'dd-mm-yyyy'), to_date('19-10-2023', 'dd-mm-yyyy'), 58196781, 87449313);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (24126074, 'Operator training and human error', 'Escalated', to_date('13-12-2022', 'dd-mm-yyyy'), to_date('30-07-2023', 'dd-mm-yyyy'), 89798029, 12473697);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (17302604, 'Vulnerability to cyber attacks', 'Resolved', to_date('20-02-2023', 'dd-mm-yyyy'), to_date('15-05-2023', 'dd-mm-yyyy'), 65486123, 40046332);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (73076492, 'Environmental adaptability', 'Pending', to_date('19-09-2022', 'dd-mm-yyyy'), to_date('15-10-2023', 'dd-mm-yyyy'), 87142600, 20358405);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (33277776, 'Operator training and human error', 'Pending Review', to_date('16-01-2023', 'dd-mm-yyyy'), to_date('20-06-2023', 'dd-mm-yyyy'), 26465702, 76115146);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (24594801, 'Maintenance and operational costs', 'Pending', to_date('12-07-2022', 'dd-mm-yyyy'), to_date('04-07-2023', 'dd-mm-yyyy'), 80634418, 81828427);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (93322045, 'Supply chain security', 'Pending', to_date('17-06-2022', 'dd-mm-yyyy'), to_date('02-07-2023', 'dd-mm-yyyy'), 88079734, 71812980);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (79043134, 'Supply chain security', 'Pending', to_date('16-12-2022', 'dd-mm-yyyy'), to_date('22-06-2023', 'dd-mm-yyyy'), 13596747, 52337857);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (18931908, 'Operator training and human error', 'Urgent', to_date('13-03-2023', 'dd-mm-yyyy'), to_date('25-01-2024', 'dd-mm-yyyy'), 69009658, 32573055);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (75508645, 'Environmental adaptability', 'Pending Review', to_date('15-07-2022', 'dd-mm-yyyy'), to_date('22-11-2023', 'dd-mm-yyyy'), 42768514, 78312137);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (17109857, 'Interception accuracy', 'Closed', to_date('05-04-2023', 'dd-mm-yyyy'), to_date('06-03-2024', 'dd-mm-yyyy'), 85923657, 26913646);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (20438396, 'Integration with existing defense systems', 'Resolved', to_date('15-03-2023', 'dd-mm-yyyy'), to_date('04-07-2023', 'dd-mm-yyyy'), 91021750, 94757310);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (71242083, 'Communication latency', 'Closed', to_date('15-04-2023', 'dd-mm-yyyy'), to_date('08-03-2024', 'dd-mm-yyyy'), 81191202, 77991076);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (22970912, 'Vulnerability to cyber attacks', 'Resolved', to_date('04-01-2022', 'dd-mm-yyyy'), to_date('03-09-2023', 'dd-mm-yyyy'), 70721780, 15143232);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (98202110, 'Environmental adaptability', 'Pending', to_date('07-04-2023', 'dd-mm-yyyy'), to_date('24-08-2023', 'dd-mm-yyyy'), 95588116, 32573055);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (61585024, 'Supply chain security', 'Resolved', to_date('14-04-2022', 'dd-mm-yyyy'), to_date('28-10-2023', 'dd-mm-yyyy'), 96293589, 94757310);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (19020861, 'Communication latency', 'Resolved', to_date('29-12-2022', 'dd-mm-yyyy'), to_date('10-01-2024', 'dd-mm-yyyy'), 24768061, 85343331);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (18519866, 'Interception accuracy', 'Escalated', to_date('13-10-2022', 'dd-mm-yyyy'), to_date('07-10-2023', 'dd-mm-yyyy'), 91021750, 44942109);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (15177617, 'Communication latency', 'Pending', to_date('03-04-2022', 'dd-mm-yyyy'), to_date('26-12-2023', 'dd-mm-yyyy'), 60406218, 21000949);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (90851516, 'Interception accuracy', 'Resolved', to_date('21-03-2023', 'dd-mm-yyyy'), to_date('22-06-2023', 'dd-mm-yyyy'), 48894891, 28599808);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (81443236, 'Supply chain security', 'Pending Review', to_date('11-06-2022', 'dd-mm-yyyy'), to_date('02-09-2023', 'dd-mm-yyyy'), 39817959, 44970893);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (87590295, 'Vulnerability to cyber attacks', 'Escalated', to_date('09-08-2022', 'dd-mm-yyyy'), to_date('15-03-2024', 'dd-mm-yyyy'), 16292512, 64301667);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (61568386, 'Environmental adaptability', 'Pending Review', to_date('16-09-2022', 'dd-mm-yyyy'), to_date('05-09-2023', 'dd-mm-yyyy'), 98149767, 11855385);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (96313136, 'False positives and negatives', 'Resolved', to_date('30-04-2022', 'dd-mm-yyyy'), to_date('11-02-2024', 'dd-mm-yyyy'), 39604366, 39374108);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (33080203, 'Communication latency', 'Pending', to_date('08-01-2023', 'dd-mm-yyyy'), to_date('06-06-2023', 'dd-mm-yyyy'), 64825226, 39095239);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (21292683, 'Operator training and human error', 'Resolved', to_date('22-02-2022', 'dd-mm-yyyy'), to_date('03-05-2023', 'dd-mm-yyyy'), 50095158, 57651751);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (45155881, 'Integration with existing defense systems', 'Pending Review', to_date('01-04-2023', 'dd-mm-yyyy'), to_date('01-08-2023', 'dd-mm-yyyy'), 16292512, 57079314);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (13453938, 'Supply chain security', 'Urgent', to_date('01-04-2023', 'dd-mm-yyyy'), to_date('19-02-2024', 'dd-mm-yyyy'), 60533897, 17202750);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (87106161, 'Reliability of detection systems', 'Resolved', to_date('26-01-2022', 'dd-mm-yyyy'), to_date('27-12-2023', 'dd-mm-yyyy'), 25271570, 65681397);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (61405278, 'Maintenance and operational costs', 'Pending Review', to_date('23-03-2022', 'dd-mm-yyyy'), to_date('26-06-2023', 'dd-mm-yyyy'), 78004881, 30854231);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (87550494, 'Reliability of detection systems', 'Escalated', to_date('24-01-2023', 'dd-mm-yyyy'), to_date('23-04-2024', 'dd-mm-yyyy'), 54302716, 66916660);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (27878560, 'Vulnerability to cyber attacks', 'Closed', to_date('16-12-2022', 'dd-mm-yyyy'), to_date('02-08-2023', 'dd-mm-yyyy'), 60147305, 50752399);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (64023884, 'Reliability of detection systems', 'Resolved', to_date('11-03-2023', 'dd-mm-yyyy'), to_date('30-05-2023', 'dd-mm-yyyy'), 80345156, 61348541);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (87797796, 'Communication latency', 'Closed', to_date('29-06-2022', 'dd-mm-yyyy'), to_date('16-10-2023', 'dd-mm-yyyy'), 79481773, 46666412);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (82647962, 'Integration with existing defense systems', 'Resolved', to_date('25-10-2022', 'dd-mm-yyyy'), to_date('06-04-2024', 'dd-mm-yyyy'), 38628579, 96833634);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (88502527, 'Environmental adaptability', 'Closed', to_date('02-05-2022', 'dd-mm-yyyy'), to_date('15-04-2024', 'dd-mm-yyyy'), 31935182, 48109402);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (95750828, 'Operator training and human error', 'Pending Review', to_date('26-03-2023', 'dd-mm-yyyy'), to_date('19-05-2023', 'dd-mm-yyyy'), 94224302, 96744987);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (80005519, 'Interception accuracy', 'Urgent', to_date('07-04-2022', 'dd-mm-yyyy'), to_date('08-05-2023', 'dd-mm-yyyy'), 83896964, 52622636);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (85056495, 'Environmental adaptability', 'Pending', to_date('10-05-2022', 'dd-mm-yyyy'), to_date('17-10-2023', 'dd-mm-yyyy'), 61251646, 93074635);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (4001, 'Unable to login', 'Pending Review', to_date('01-05-2024', 'dd-mm-yyyy'), to_date('03-05-2024', 'dd-mm-yyyy'), 12134353, 34428347);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (4002, 'Payment not processed', 'In Progress', to_date('03-05-2024', 'dd-mm-yyyy'), to_date('07-05-2024', 'dd-mm-yyyy'), 23894729, 55839283);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (4003, 'Order not delivered', 'Resolved', to_date('05-05-2024', 'dd-mm-yyyy'), to_date('10-05-2024', 'dd-mm-yyyy'), 87432904, 44782930);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (4004, 'Product malfunction', 'Escalated', to_date('07-05-2024', 'dd-mm-yyyy'), to_date('10-05-2024', 'dd-mm-yyyy'), 56290837, 98745612);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (4005, 'Account suspended', 'In Progress', to_date('09-05-2024', 'dd-mm-yyyy'), to_date('14-05-2024', 'dd-mm-yyyy'), 34789012, 23456789);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (4006, 'Refund issue', 'Resolved', to_date('11-05-2024', 'dd-mm-yyyy'), to_date('13-05-2024', 'dd-mm-yyyy'), 90875634, 65748392);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (4007, 'Unable to contact support', 'Escalated', to_date('13-05-2024', 'dd-mm-yyyy'), to_date('18-05-2024', 'dd-mm-yyyy'), 67983245, 39485721);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (4008, 'Wrong item received', 'In Progress', to_date('15-05-2024', 'dd-mm-yyyy'), to_date('20-05-2024', 'dd-mm-yyyy'), 45329087, 83947563);
commit;
prompt 400 records committed...
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (4009, 'Website down', 'Resolved', to_date('17-05-2024', 'dd-mm-yyyy'), to_date('19-05-2024', 'dd-mm-yyyy'), 12983475, 49283756);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (4010, 'Order canceled but charged', 'Escalated', to_date('19-05-2024', 'dd-mm-yyyy'), to_date('22-05-2024', 'dd-mm-yyyy'), 76348219, 38572049);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (1, 'Guidance system malfunction', 'open', to_date('08-05-2023', 'dd-mm-yyyy'), to_date('25-02-2024', 'dd-mm-yyyy'), 1, 1);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (2, 'Engine ignition problem', 'in progress', to_date('08-04-2023', 'dd-mm-yyyy'), to_date('30-10-2023', 'dd-mm-yyyy'), 2, 2);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (3, 'Warhead detonation failure', 'closed', to_date('23-03-2023', 'dd-mm-yyyy'), to_date('09-05-2024', 'dd-mm-yyyy'), 3, 3);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (4, 'Communication breakdown', 'in progress', to_date('30-08-2022', 'dd-mm-yyyy'), to_date('06-04-2024', 'dd-mm-yyyy'), 4, 4);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (5, 'Communication breakdown', 'resolved', to_date('11-11-2022', 'dd-mm-yyyy'), to_date('07-12-2023', 'dd-mm-yyyy'), 5, 5);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (6, 'Engine ignition problem', 'resolved', to_date('31-08-2022', 'dd-mm-yyyy'), to_date('09-10-2023', 'dd-mm-yyyy'), 6, 6);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (7, 'Warhead detonation failure', 'open', to_date('09-07-2022', 'dd-mm-yyyy'), to_date('16-03-2024', 'dd-mm-yyyy'), 7, 7);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (8, 'Missile failed to launch', 'open', to_date('14-01-2023', 'dd-mm-yyyy'), to_date('24-03-2024', 'dd-mm-yyyy'), 8, 8);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (9, 'Communication breakdown', 'in progress', to_date('12-06-2022', 'dd-mm-yyyy'), to_date('01-06-2023', 'dd-mm-yyyy'), 9, 9);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (10, 'Communication breakdown', 'in progress', to_date('21-08-2022', 'dd-mm-yyyy'), to_date('20-01-2024', 'dd-mm-yyyy'), 10, 10);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (11, 'Communication breakdown', 'closed', to_date('24-11-2022', 'dd-mm-yyyy'), to_date('14-09-2023', 'dd-mm-yyyy'), 11, 11);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (12, 'Targeting error detected', 'open', to_date('16-12-2022', 'dd-mm-yyyy'), to_date('10-05-2024', 'dd-mm-yyyy'), 12, 12);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (13, 'Targeting error detected', 'in progress', to_date('06-01-2023', 'dd-mm-yyyy'), to_date('21-06-2023', 'dd-mm-yyyy'), 13, 13);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (14, 'Engine ignition problem', 'closed', to_date('06-05-2023', 'dd-mm-yyyy'), to_date('22-05-2023', 'dd-mm-yyyy'), 14, 14);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (15, 'Communication breakdown', 'closed', to_date('12-05-2023', 'dd-mm-yyyy'), to_date('16-10-2023', 'dd-mm-yyyy'), 15, 15);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (16, 'Engine ignition problem', 'open', to_date('06-05-2023', 'dd-mm-yyyy'), to_date('06-03-2024', 'dd-mm-yyyy'), 16, 16);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (17, 'Targeting error detected', 'open', to_date('18-06-2022', 'dd-mm-yyyy'), to_date('17-05-2024', 'dd-mm-yyyy'), 17, 17);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (18, 'Targeting error detected', 'in progress', to_date('27-06-2022', 'dd-mm-yyyy'), to_date('04-08-2023', 'dd-mm-yyyy'), 18, 18);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (19, 'Targeting error detected', 'in progress', to_date('05-10-2022', 'dd-mm-yyyy'), to_date('24-08-2023', 'dd-mm-yyyy'), 19, 19);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (20, 'Warhead detonation failure', 'in progress', to_date('17-05-2023', 'dd-mm-yyyy'), to_date('13-11-2023', 'dd-mm-yyyy'), 20, 20);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (21, 'Warhead detonation failure', 'resolved', to_date('27-11-2022', 'dd-mm-yyyy'), to_date('06-01-2024', 'dd-mm-yyyy'), 21, 21);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (22, 'Warhead detonation failure', 'closed', to_date('05-11-2022', 'dd-mm-yyyy'), to_date('07-07-2023', 'dd-mm-yyyy'), 22, 22);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (23, 'Engine ignition problem', 'open', to_date('21-04-2023', 'dd-mm-yyyy'), to_date('29-09-2023', 'dd-mm-yyyy'), 23, 23);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (24, 'Communication breakdown', 'closed', to_date('24-09-2022', 'dd-mm-yyyy'), to_date('30-03-2024', 'dd-mm-yyyy'), 24, 24);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (25, 'Engine ignition problem', 'open', to_date('18-11-2022', 'dd-mm-yyyy'), to_date('19-01-2024', 'dd-mm-yyyy'), 25, 25);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (26, 'Guidance system malfunction', 'open', to_date('25-11-2022', 'dd-mm-yyyy'), to_date('02-09-2023', 'dd-mm-yyyy'), 26, 26);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (27, 'Engine ignition problem', 'resolved', to_date('28-09-2022', 'dd-mm-yyyy'), to_date('03-11-2023', 'dd-mm-yyyy'), 27, 27);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (28, 'Warhead detonation failure', 'closed', to_date('31-03-2023', 'dd-mm-yyyy'), to_date('02-06-2023', 'dd-mm-yyyy'), 28, 28);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (29, 'Warhead detonation failure', 'in progress', to_date('06-10-2022', 'dd-mm-yyyy'), to_date('24-10-2023', 'dd-mm-yyyy'), 29, 29);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (30, 'Guidance system malfunction', 'closed', to_date('17-10-2022', 'dd-mm-yyyy'), to_date('02-06-2023', 'dd-mm-yyyy'), 30, 30);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (31, 'Communication breakdown', 'in progress', to_date('03-01-2023', 'dd-mm-yyyy'), to_date('29-05-2023', 'dd-mm-yyyy'), 31, 31);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (32, 'Guidance system malfunction', 'in progress', to_date('06-02-2023', 'dd-mm-yyyy'), to_date('19-10-2023', 'dd-mm-yyyy'), 32, 32);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (33, 'Warhead detonation failure', 'resolved', to_date('14-06-2022', 'dd-mm-yyyy'), to_date('08-01-2024', 'dd-mm-yyyy'), 33, 33);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (34, 'Warhead detonation failure', 'closed', to_date('17-06-2022', 'dd-mm-yyyy'), to_date('15-09-2023', 'dd-mm-yyyy'), 34, 34);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (35, 'Engine ignition problem', 'resolved', to_date('22-10-2022', 'dd-mm-yyyy'), to_date('04-06-2023', 'dd-mm-yyyy'), 35, 35);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (36, 'Missile failed to launch', 'closed', to_date('13-05-2023', 'dd-mm-yyyy'), to_date('04-10-2023', 'dd-mm-yyyy'), 36, 36);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (37, 'Missile failed to launch', 'open', to_date('22-09-2022', 'dd-mm-yyyy'), to_date('10-03-2024', 'dd-mm-yyyy'), 37, 37);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (38, 'Guidance system malfunction', 'closed', to_date('19-04-2023', 'dd-mm-yyyy'), to_date('08-09-2023', 'dd-mm-yyyy'), 38, 38);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (39, 'Communication breakdown', 'resolved', to_date('10-05-2023', 'dd-mm-yyyy'), to_date('10-01-2024', 'dd-mm-yyyy'), 39, 39);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (40, 'Guidance system malfunction', 'closed', to_date('27-06-2022', 'dd-mm-yyyy'), to_date('23-04-2024', 'dd-mm-yyyy'), 40, 40);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (41, 'Engine ignition problem', 'closed', to_date('16-09-2022', 'dd-mm-yyyy'), to_date('15-03-2024', 'dd-mm-yyyy'), 41, 41);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (42, 'Warhead detonation failure', 'open', to_date('16-08-2022', 'dd-mm-yyyy'), to_date('05-09-2023', 'dd-mm-yyyy'), 42, 42);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (43, 'Communication breakdown', 'resolved', to_date('03-03-2023', 'dd-mm-yyyy'), to_date('25-10-2023', 'dd-mm-yyyy'), 43, 43);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (44, 'Targeting error detected', 'open', to_date('03-08-2022', 'dd-mm-yyyy'), to_date('04-01-2024', 'dd-mm-yyyy'), 44, 44);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (45, 'Guidance system malfunction', 'in progress', to_date('29-06-2022', 'dd-mm-yyyy'), to_date('02-01-2024', 'dd-mm-yyyy'), 45, 45);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (46, 'Engine ignition problem', 'closed', to_date('22-04-2023', 'dd-mm-yyyy'), to_date('07-06-2023', 'dd-mm-yyyy'), 46, 46);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (47, 'Guidance system malfunction', 'in progress', to_date('25-03-2023', 'dd-mm-yyyy'), to_date('29-01-2024', 'dd-mm-yyyy'), 47, 47);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (48, 'Warhead detonation failure', 'closed', to_date('07-10-2022', 'dd-mm-yyyy'), to_date('18-09-2023', 'dd-mm-yyyy'), 48, 48);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (49, 'Warhead detonation failure', 'open', to_date('11-01-2023', 'dd-mm-yyyy'), to_date('11-07-2023', 'dd-mm-yyyy'), 49, 49);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (50, 'Missile failed to launch', 'resolved', to_date('11-04-2023', 'dd-mm-yyyy'), to_date('01-11-2023', 'dd-mm-yyyy'), 50, 50);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (51, 'Targeting error detected', 'in progress', to_date('20-01-2023', 'dd-mm-yyyy'), to_date('07-08-2023', 'dd-mm-yyyy'), 51, 51);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (52, 'Engine ignition problem', 'open', to_date('04-01-2023', 'dd-mm-yyyy'), to_date('12-09-2023', 'dd-mm-yyyy'), 52, 52);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (53, 'Warhead detonation failure', 'in progress', to_date('12-07-2022', 'dd-mm-yyyy'), to_date('15-10-2023', 'dd-mm-yyyy'), 53, 53);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (54, 'Missile failed to launch', 'closed', to_date('06-07-2022', 'dd-mm-yyyy'), to_date('30-04-2024', 'dd-mm-yyyy'), 54, 54);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (55, 'Missile failed to launch', 'open', to_date('28-03-2023', 'dd-mm-yyyy'), to_date('18-11-2023', 'dd-mm-yyyy'), 55, 55);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (56, 'Missile failed to launch', 'open', to_date('20-12-2022', 'dd-mm-yyyy'), to_date('29-09-2023', 'dd-mm-yyyy'), 56, 56);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (57, 'Engine ignition problem', 'open', to_date('30-07-2022', 'dd-mm-yyyy'), to_date('02-05-2024', 'dd-mm-yyyy'), 57, 57);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (58, 'Warhead detonation failure', 'open', to_date('28-09-2022', 'dd-mm-yyyy'), to_date('04-11-2023', 'dd-mm-yyyy'), 58, 58);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (59, 'Warhead detonation failure', 'in progress', to_date('20-03-2023', 'dd-mm-yyyy'), to_date('25-10-2023', 'dd-mm-yyyy'), 59, 59);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (60, 'Warhead detonation failure', 'resolved', to_date('02-10-2022', 'dd-mm-yyyy'), to_date('05-04-2024', 'dd-mm-yyyy'), 60, 60);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (61, 'Engine ignition problem', 'in progress', to_date('06-08-2022', 'dd-mm-yyyy'), to_date('11-10-2023', 'dd-mm-yyyy'), 61, 61);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (62, 'Communication breakdown', 'in progress', to_date('11-06-2022', 'dd-mm-yyyy'), to_date('18-12-2023', 'dd-mm-yyyy'), 62, 62);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (63, 'Engine ignition problem', 'resolved', to_date('15-02-2023', 'dd-mm-yyyy'), to_date('31-01-2024', 'dd-mm-yyyy'), 63, 63);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (64, 'Engine ignition problem', 'resolved', to_date('23-12-2022', 'dd-mm-yyyy'), to_date('03-07-2023', 'dd-mm-yyyy'), 64, 64);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (65, 'Guidance system malfunction', 'closed', to_date('25-02-2023', 'dd-mm-yyyy'), to_date('16-05-2024', 'dd-mm-yyyy'), 65, 65);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (66, 'Targeting error detected', 'resolved', to_date('26-07-2022', 'dd-mm-yyyy'), to_date('04-11-2023', 'dd-mm-yyyy'), 66, 66);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (67, 'Guidance system malfunction', 'closed', to_date('06-06-2022', 'dd-mm-yyyy'), to_date('03-06-2023', 'dd-mm-yyyy'), 67, 67);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (68, 'Communication breakdown', 'closed', to_date('09-06-2022', 'dd-mm-yyyy'), to_date('22-01-2024', 'dd-mm-yyyy'), 68, 68);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (69, 'Communication breakdown', 'resolved', to_date('17-06-2022', 'dd-mm-yyyy'), to_date('03-09-2023', 'dd-mm-yyyy'), 69, 69);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (70, 'Communication breakdown', 'open', to_date('28-03-2023', 'dd-mm-yyyy'), to_date('05-05-2024', 'dd-mm-yyyy'), 70, 70);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (71, 'Guidance system malfunction', 'in progress', to_date('10-10-2022', 'dd-mm-yyyy'), to_date('02-11-2023', 'dd-mm-yyyy'), 71, 71);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (72, 'Guidance system malfunction', 'in progress', to_date('17-07-2022', 'dd-mm-yyyy'), to_date('07-06-2023', 'dd-mm-yyyy'), 72, 72);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (73, 'Communication breakdown', 'resolved', to_date('11-06-2022', 'dd-mm-yyyy'), to_date('28-08-2023', 'dd-mm-yyyy'), 73, 73);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (74, 'Warhead detonation failure', 'open', to_date('03-07-2022', 'dd-mm-yyyy'), to_date('13-01-2024', 'dd-mm-yyyy'), 74, 74);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (75, 'Guidance system malfunction', 'resolved', to_date('27-08-2022', 'dd-mm-yyyy'), to_date('10-11-2023', 'dd-mm-yyyy'), 75, 75);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (76, 'Engine ignition problem', 'resolved', to_date('19-09-2022', 'dd-mm-yyyy'), to_date('08-03-2024', 'dd-mm-yyyy'), 76, 76);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (77, 'Warhead detonation failure', 'open', to_date('06-12-2022', 'dd-mm-yyyy'), to_date('09-11-2023', 'dd-mm-yyyy'), 77, 77);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (78, 'Warhead detonation failure', 'closed', to_date('11-05-2023', 'dd-mm-yyyy'), to_date('20-02-2024', 'dd-mm-yyyy'), 78, 78);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (79, 'Engine ignition problem', 'closed', to_date('17-01-2023', 'dd-mm-yyyy'), to_date('21-11-2023', 'dd-mm-yyyy'), 79, 79);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (80, 'Missile failed to launch', 'resolved', to_date('04-03-2023', 'dd-mm-yyyy'), to_date('02-12-2023', 'dd-mm-yyyy'), 80, 80);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (81, 'Targeting error detected', 'open', to_date('23-11-2022', 'dd-mm-yyyy'), to_date('18-06-2023', 'dd-mm-yyyy'), 81, 81);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (82, 'Engine ignition problem', 'in progress', to_date('17-12-2022', 'dd-mm-yyyy'), to_date('07-11-2023', 'dd-mm-yyyy'), 82, 82);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (83, 'Warhead detonation failure', 'in progress', to_date('12-10-2022', 'dd-mm-yyyy'), to_date('25-10-2023', 'dd-mm-yyyy'), 83, 83);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (84, 'Targeting error detected', 'resolved', to_date('23-10-2022', 'dd-mm-yyyy'), to_date('27-03-2024', 'dd-mm-yyyy'), 84, 84);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (85, 'Missile failed to launch', 'in progress', to_date('20-07-2022', 'dd-mm-yyyy'), to_date('14-04-2024', 'dd-mm-yyyy'), 85, 85);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (86, 'Targeting error detected', 'closed', to_date('12-12-2022', 'dd-mm-yyyy'), to_date('22-11-2023', 'dd-mm-yyyy'), 86, 86);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (87, 'Engine ignition problem', 'in progress', to_date('11-03-2023', 'dd-mm-yyyy'), to_date('05-04-2024', 'dd-mm-yyyy'), 87, 87);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (88, 'Missile failed to launch', 'resolved', to_date('13-04-2023', 'dd-mm-yyyy'), to_date('20-11-2023', 'dd-mm-yyyy'), 88, 88);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (89, 'Targeting error detected', 'in progress', to_date('21-09-2022', 'dd-mm-yyyy'), to_date('04-11-2023', 'dd-mm-yyyy'), 89, 89);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (90, 'Targeting error detected', 'in progress', to_date('02-06-2022', 'dd-mm-yyyy'), to_date('14-09-2023', 'dd-mm-yyyy'), 90, 90);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (91, 'Guidance system malfunction', 'in progress', to_date('06-02-2023', 'dd-mm-yyyy'), to_date('17-12-2023', 'dd-mm-yyyy'), 91, 91);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (92, 'Missile failed to launch', 'closed', to_date('08-04-2023', 'dd-mm-yyyy'), to_date('11-02-2024', 'dd-mm-yyyy'), 92, 92);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (93, 'Guidance system malfunction', 'open', to_date('10-05-2023', 'dd-mm-yyyy'), to_date('20-02-2024', 'dd-mm-yyyy'), 93, 93);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (94, 'Missile failed to launch', 'resolved', to_date('29-07-2022', 'dd-mm-yyyy'), to_date('02-08-2023', 'dd-mm-yyyy'), 94, 94);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (95, 'Targeting error detected', 'closed', to_date('09-01-2023', 'dd-mm-yyyy'), to_date('08-06-2023', 'dd-mm-yyyy'), 95, 95);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (96, 'Warhead detonation failure', 'resolved', to_date('16-08-2022', 'dd-mm-yyyy'), to_date('21-11-2023', 'dd-mm-yyyy'), 96, 96);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (97, 'Warhead detonation failure', 'closed', to_date('30-06-2022', 'dd-mm-yyyy'), to_date('16-05-2024', 'dd-mm-yyyy'), 97, 97);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (98, 'Missile failed to launch', 'in progress', to_date('18-02-2023', 'dd-mm-yyyy'), to_date('20-08-2023', 'dd-mm-yyyy'), 98, 98);
commit;
prompt 500 records committed...
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (99, 'Engine ignition problem', 'closed', to_date('28-08-2022', 'dd-mm-yyyy'), to_date('02-08-2023', 'dd-mm-yyyy'), 99, 99);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (100, 'Communication breakdown', 'resolved', to_date('02-07-2022', 'dd-mm-yyyy'), to_date('23-07-2023', 'dd-mm-yyyy'), 100, 100);
commit;
prompt 502 records loaded
prompt Enabling foreign key constraints for CUSTOMERS...
alter table CUSTOMERS enable constraint FK_CUSTOMER;
prompt Enabling foreign key constraints for AIR_ORDER...
alter table AIR_ORDER enable constraint FK_ORDER_;
prompt Enabling foreign key constraints for PART_OF...
alter table PART_OF enable constraint FK_PART_OF;
alter table PART_OF enable constraint FK_PART_OF2;
prompt Enabling foreign key constraints for PAYMENT...
alter table PAYMENT enable constraint FK_PAYMENT;
prompt Enabling foreign key constraints for SUPPORT_TICKET...
alter table SUPPORT_TICKET enable constraint FK_SUPPORT_TICKET;
alter table SUPPORT_TICKET enable constraint FK_SUPPORT_TICKET2;
prompt Enabling triggers for ACCOUNT_MANAGER...
alter table ACCOUNT_MANAGER enable all triggers;
prompt Enabling triggers for CUSTOMERS...
alter table CUSTOMERS enable all triggers;
prompt Enabling triggers for AIR_ORDER...
alter table AIR_ORDER enable all triggers;
prompt Enabling triggers for PRODUCT...
alter table PRODUCT enable all triggers;
prompt Enabling triggers for PART_OF...
alter table PART_OF enable all triggers;
prompt Enabling triggers for PAYMENT...
alter table PAYMENT enable all triggers;
prompt Enabling triggers for SUPPORT_TICKET...
alter table SUPPORT_TICKET enable all triggers;

set feedback on
set define on
prompt Done
