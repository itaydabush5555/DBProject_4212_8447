prompt PL/SQL Developer Export Tables for user SYS@XE
prompt Created by Dabush on Monday, 1 July 2024
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
  paymentmethod VARCHAR2(50) not null,
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
values (48262283, 'LindaParker', 'linda.p@pharmacia.be', '99691423', 'mossad');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (81513420, 'TalvinLaw', 'talvin@gapinc.com', '99206784', 'shabak');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (74854868, 'MickyColon', 'mcolon@ecopy.com', '12421787', 'refael');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (50974786, 'ColeyDouglas', 'coley@extremepizza.com', '30810035', 'shabak');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (89845799, 'VerucaDiBiasio', 'veruca.dibiasio@servicelink.com', '67854510', 'idf');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (18217124, 'AllanWopat', 'allan.wopat@healthscribe.com', '43591567', 'idf');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (59229602, 'AmandaBogguss', 'a.bogguss@csi.com', '33299162', 'ministry of defence');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (26168416, 'ThelmaCrouse', 'thelma.crouse@pharmacia.pe', '44522025', 'ministry of defence');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (32336221, 'LarnelleBarnett', 'larnelleb@tarragonrealty.hk', '36026571', 'refael');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (53330905, 'RhettNugent', 'rhett.n@bioanalytical.de', '47983413', 'refael');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (13830308, 'CherylCoverdale', 'cheryl.coverdale@lydiantrust.com', '48262342', 'refael');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (92724719, 'AnjelicaChaplin', 'anjelica.chaplin@mre.com', '58724902', 'mossad');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (76805170, 'BobbiKeener', 'bobbi.k@accuship.ca', '85246823', 'shabak');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (72012718, 'HollandDomino', 'holland.domino@lms.com', '61561564', 'ministry of defence');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (95117510, 'RickNuman', 'rnuman@gsat.jp', '18608799', 'shabak');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (42785299, 'WallacePaxton', 'wallace.paxton@capitalautomotive.ec', '59839050', 'idf');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (37100134, 'JodyBoone', 'jboone@componentgraphics.com', '19447741', 'idf');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (56090177, 'AdrienWarburton', 'adrien.warburton@fnb.fr', '63535782', 'shabak');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (83720497, 'LoisGriffiths', 'lois.griffiths@aquickdelivery.uk', '94374450', 'shabak');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (64365513, 'VinceWilkinson', 'vince.wilkinson@ibfh.jp', '90506274', 'idf');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (84618355, 'YolandaLatifah', 'ylatifah@owm.no', '47406513', 'refael');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (58798436, 'NicoleCross', 'ncross@monitronicsinternational.com', '25757858', 'mossad');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (41135368, 'HarryShelton', 'harry.s@ppr.fr', '74390066', 'mossad');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (30319594, 'PattiDupree', 'patti.dupree@elmco.se', '32992992', 'mossad');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (67606405, 'VickieGambon', 'v.gambon@seiaarons.com', '34342458', 'refael');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (68009450, 'FredericNivola', 'fredericn@enterprise.jp', '94994145', 'ministry of defence');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (40279638, 'RichieCobbs', 'richie.cobbs@shar.com', '90427812', 'mossad');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (34179616, 'CledusHedaya', 'cledus.hedaya@asa.li', '65840354', 'ministry of defence');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (65252375, 'CaseyWeaving', 'casey.weaving@faef.fi', '53350718', 'shabak');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (63035913, 'KateSuchet', 'kate.suchet@alternativetechnology.uk', '62317028', 'mossad');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (74053824, 'KevinPresley', 'kevin.presley@zoneperfectnutrition.com', '47806503', 'mossad');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (25586438, 'OwenDale', 'o.dale@vfs.de', '79110490', 'ministry of defence');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (10389457, 'ConnieWalker', 'connie@solipsys.de', '96712176', 'refael');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (10842068, 'BobbiPressly', 'bobbi.pressly@tmaresources.uk', '78060652', 'idf');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (63681411, 'DemiBorden', 'demi.borden@mls.de', '20151337', 'idf');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (57661706, 'SissyFlanagan', 'sissy.flanagan@ecopy.com', '24304469', 'refael');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (34547826, 'MerrileeBosco', 'merrilee@valleyoaksystems.uk', '73295224', 'idf');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (25441111, 'KateEnglish', 'kate@bayer.se', '74109491', 'refael');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (53171946, 'FrancesKotto', 'frances.kotto@ivci.de', '89819942', 'ministry of defence');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (38452053, 'JoshuaFord', 'jford@novartis.com', '77923468', 'ministry of defence');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (46887068, 'TemueraMantegna', 'temueram@meghasystems.nl', '36253645', 'mossad');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (44982031, 'RicardoLofgren', 'ricardo.lofgren@prosum.com', '25070603', 'shabak');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (61452332, 'BlairPlummer', 'blair@hencie.com', '35042163', 'shabak');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (21561518, 'RikLavigne', 'rik@usphysicaltherapy.com', '28948451', 'ministry of defence');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (86503833, 'JayBell', 'jay.bell@evergreenresources.pl', '90879576', 'mossad');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (51259353, 'KidStiller', 'k.stiller@loreal.de', '17093056', 'shabak');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (58391234, 'EthanPosey', 'ethan.posey@valleyoaksystems.au', '85233117', 'idf');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (35665486, 'JosephStrong', 'joseph.s@prosperitybancshares.de', '68528165', 'mossad');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (11678217, 'MaryLindo', 'mary.lindo@tilia.it', '99654765', 'refael');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (48523546, 'ViggoMulroney', 'viggo@providentbancorp.com', '77995411', 'shabak');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (38008634, 'JudeMatthau', 'jmatthau@stonebrewing.com', '69997683', 'ministry of defence');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (87294530, 'AshtonPesci', 'ashton.pesci@caliber.com', '83654512', 'ministry of defence');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (93724646, 'DougGold', 'doug.gold@usenergyservices.com', '80297579', 'shabak');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (99957203, 'JuniorGrant', 'j.grant@owm.fr', '52430228', 'ministry of defence');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (23170936, 'BozReno', 'boz.reno@bioreference.com', '41910791', 'mossad');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (97526793, 'KylieApplegate', 'kapplegate@scriptsave.com', '54700164', 'shabak');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (16120175, 'BobLindley', 'bobl@myricom.com', '15183700', 'refael');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (63292865, 'CourtneyMills', 'courtneym@gbas.com', '14685128', 'ministry of defence');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (68255934, 'AaronRollins', 'aaron.rollins@limitedbrands.jp', '87517166', 'mossad');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (21751206, 'EdwardRoberts', 'edward@ibfh.com', '11000738', 'refael');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (29471845, 'RufusThurman', 'rufus.thurman@kmart.pl', '37047429', 'ministry of defence');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (14647959, 'SuzyWalsh', 'suzy.walsh@nlx.au', '71443853', 'mossad');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (80521010, 'KimberlyGoldblum', 'kimberly.goldblum@ptg.nl', '71220426', 'refael');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (92788888, 'RachidStewart', 'rachid@kmart.com', '55053303', 'idf');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (67097118, 'BozRichards', 'boz.richards@kroger.jp', '75550225', 'shabak');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (89463328, 'DavidRizzo', 'davidr@mission.fr', '46738001', 'ministry of defence');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (37896029, 'CatherineNapolitano', 'catherinen@mms.com', '50933170', 'idf');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (33120027, 'TeaArnold', 'tea.arnold@anheuserbusch.com', '26162821', 'idf');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (81203133, 'BillyUnion', 'b.union@loreal.cl', '40741782', 'refael');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (48524665, 'LucindaEder', 'l.eder@midwestmedia.com', '61270233', 'shabak');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (58304446, 'GilPitt', 'gil@infovision.com', '87678554', 'mossad');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (64848868, 'HarryZahn', 'h.zahn@gltg.com', '25941603', 'shabak');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (98622663, 'SydneyMinogue', 'sydney.m@hospitalsolutions.com', '48669894', 'idf');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (18792965, 'PeterMcIntyre', 'peter.mcintyre@questarcapital.com', '82761179', 'refael');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (86972825, 'AshtonBrooks', 'a.brooks@grayhawksystems.com', '44143789', 'mossad');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (28716947, 'BreckinCummings', 'breckin@procurementcentre.br', '44611514', 'shabak');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (54302713, 'LinHingle', 'lin@limitedbrands.es', '65466165', 'shabak');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (60976032, 'MandyShepard', 'mandy.shepard@mds.jp', '71332194', 'shabak');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (71399259, 'DerrickAdkins', 'derrick.a@bowman.uk', '68437267', 'shabak');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (97042332, 'QueenOverstreet', 'queeno@electricalsolutions.ch', '20579055', 'mossad');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (14087170, 'OliverSevigny', 'oliver.sevigny@vitacostcom.it', '85584680', 'refael');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (27145721, 'GoranScorsese', 'goran@hiltonhotels.de', '65532029', 'ministry of defence');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (48696874, 'AnjelicaTwilley', 'anjelica.twilley@techrx.com', '10613362', 'mossad');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (59504229, 'GiovanniLovitz', 'giovanni.lovitz@swp.com', '99484294', 'ministry of defence');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (21325971, 'LuisHerrmann', 'luis@parksite.uk', '13717224', 'shabak');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (97158353, 'LarryHersh', 'l.hersh@educationaldevelopment.cn', '28947686', 'ministry of defence');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (45442845, 'MarinaPayton', 'marina.payton@simplycertificates.com', '96704527', 'shabak');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (76963377, 'DarylWheel', 'dwheel@peerlessmanufacturing.de', '49051620', 'idf');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (60180068, 'CoreyHatfield', 'corey.hatfield@base.jp', '17632905', 'mossad');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (20780563, 'BeverleyPony', 'beverley@printtech.fr', '72321208', 'ministry of defence');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (98674817, 'JoeJackman', 'joe.jackman@volkswagen.it', '63323844', 'ministry of defence');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (96081193, 'LiquidUnger', 'l.unger@reckittbenckiser.uk', '88969708', 'shabak');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (10670802, 'CurtisBegley', 'curtis@inspirationsoftware.com', '53566787', 'ministry of defence');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (58761637, 'PatStormare', 'pstormare@techbooks.de', '25692692', 'shabak');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (63342886, 'MurrayHorizon', 'murray.h@irissoftware.com', '25122109', 'refael');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (24312332, 'DelroyPuckett', 'd.puckett@pioneermortgage.at', '37785889', 'ministry of defence');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (11449262, 'MaggieD''Onofrio', 'maggie@its.at', '61685392', 'shabak');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (92639077, 'GarryGreene', 'g.greene@sensortechnologies.de', '69867908', 'ministry of defence');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (57662757, 'JuiceDiesel', 'juice.diesel@envisiontelephony.com', '24381583', 'shabak');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (16305031, 'AliHarary', 'ali.h@astute.ch', '75347428', 'idf');
commit;
prompt 100 records committed...
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (42947560, 'RufusAvital', 'ravital@pds.com', '57580916', 'ministry of defence');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (32430536, 'JesseTravolta', 'jesset@cima.in', '48286225', 'refael');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (24093550, 'MaureenStiller', 'maureen.stiller@accesssystems.ar', '72639623', 'ministry of defence');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (64836269, 'GladysKudrow', 'gladys@stiknowledge.de', '69798927', 'refael');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (55983169, 'AnthonyLandau', 'anthony.landau@isd.com', '94144793', 'refael');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (27921692, 'RicardoAlbright', 'ricardo@mds.com', '39246326', 'idf');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (53490786, 'AlanWilder', 'alan.wilder@intel.br', '53645438', 'ministry of defence');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (95377982, 'NatalieBurmester', 'nburmester@terrafirma.de', '25268577', 'ministry of defence');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (12270385, 'JonWinger', 'j.winger@savela.pl', '58132984', 'mossad');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (55527141, 'ToddCopeland', 'todd.copeland@mainstreetbanks.com', '68014683', 'shabak');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (37589679, 'DebraDutton', 'ddutton@wellsfinancial.be', '35017365', 'shabak');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (35455127, 'JuiceThurman', 'juice.t@marlabs.com', '29961256', 'shabak');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (51793598, 'EmilioPlimpton', 'emiliop@hotmail.com', '10694160', 'shabak');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (30057569, 'SalmaAllison', 'salma.allison@atlanticcredit.com', '37791133', 'refael');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (52948447, 'FranzMcKean', 'franz.mckean@businessplus.uk', '51778380', 'idf');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (18192279, 'MiaCattrall', 'mia@nissanmotor.de', '29233226', 'shabak');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (24714985, 'AmandaGellar', 'amanda.gellar@mcdonalds.uk', '61295362', 'shabak');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (57172755, 'CeiliAlbright', 'ceili.albright@nat.com', '68997065', 'refael');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (80099462, 'SissyDiffie', 'sissy.d@bigdoughcom.com', '93001985', 'shabak');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (28834144, 'WarrenBarrymore', 'wbarrymore@dancor.com', '67450792', 'ministry of defence');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (54569073, 'DebiCollette', 'dcollette@trc.br', '60270069', 'refael');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (91607447, 'BozTaylor', 'boz.taylor@montpelierplastics.com', '88548044', 'shabak');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (67718134, 'EmmylouLynn', 'emmylou.l@globalwireless.com', '54851567', 'ministry of defence');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (19789687, 'PaulMcBride', 'paul.m@serentec.com', '16936059', 'idf');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (38179588, 'SonaHawke', 'sona.hawke@kmart.ca', '25130794', 'ministry of defence');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (40664733, 'ElleFlack', 'ellef@mwp.uk', '67792163', 'idf');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (83387331, 'GordHaynes', 'gord.haynes@investorstitle.de', '63425043', 'shabak');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (84292030, 'DougBroderick', 'doug.broderick@naturescure.com', '78618247', 'shabak');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (22742162, 'JonnyPeebles', 'jonny.p@greene.de', '78174444', 'shabak');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (81026262, 'RodneySingletary', 'rodney.singletary@monitronicsinternational.com', '31154958', 'idf');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (12054149, 'SaraChapman', 'sara.chapman@topicsentertainment.be', '70691042', 'ministry of defence');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (97375479, 'VictoriaReid', 'v.reid@intel.com', '61155439', 'shabak');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (12125716, 'RichardJanssen', 'richard.janssen@spotfireholdings.de', '66087846', 'ministry of defence');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (25470185, 'CateWitherspoon', 'cate.w@trinityhomecare.uk', '56337926', 'refael');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (16486624, 'RosanneVan Der Beek', 'rosanne.vanderbeek@harrison.uk', '63210251', 'refael');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (75222502, 'FisherFariq', 'fisher.f@usenergyservices.com', '48563465', 'ministry of defence');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (79467005, 'TziWinans', 'twinans@unilever.com', '75796139', 'shabak');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (11953374, 'LaurieSorvino', 'l.sorvino@priorityexpress.com', '66682742', 'idf');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (33591003, 'CherryKeitel', 'cherry.keitel@contract.com', '13044796', 'ministry of defence');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (39312813, 'EmersonSaxon', 'emerson.saxon@infopros.in', '99937906', 'ministry of defence');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (40424418, 'LievCarradine', 'lcarradine@pra.com', '92666378', 'ministry of defence');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (53805434, 'SonnyGoodman', 'sonny.goodman@invisioncom.de', '64405074', 'refael');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (28784273, 'LatinBlades', 'latin.blades@talx.ca', '34987897', 'ministry of defence');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (60281327, 'BradBurmester', 'brad.burmester@seafoxboat.com', '47088002', 'idf');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (88442161, 'StevieRhymes', 'stevier@marsinc.de', '76711606', 'shabak');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (65968564, 'DanniPierce', 'danni.pierce@mwp.de', '30203257', 'ministry of defence');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (90609320, 'MindySoul', 'mindy.soul@simplycertificates.au', '18318809', 'ministry of defence');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (53948112, 'BobbiWhitmore', 'bobbiw@telecheminternational.com', '27810556', 'mossad');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (40981256, 'LaurieWinwood', 'laurie.winwood@interfacesoftware.com', '28243854', 'idf');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (80318978, 'BurtMoriarty', 'burt.m@investorstitle.de', '21809037', 'ministry of defence');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (86198357, 'FreddieLarter', 'freddie@conquest.is', '51681788', 'shabak');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (61080008, 'JoshuaKahn', 'joshuak@apexsystems.com', '57904620', 'ministry of defence');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (26386141, 'DermotMcCann', 'dermot.mccann@mosaic.uk', '12947949', 'shabak');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (78743272, 'LennyGosdin', 'lenny.gosdin@topicsentertainment.de', '43595886', 'idf');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (84153294, 'NicoleMollard', 'nicolem@floorgraphics.com', '18806883', 'refael');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (12537331, 'JoshuaWorrell', 'joshua.worrell@typhoon.com', '96385161', 'refael');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (35092710, 'KateGracie', 'kate.gracie@mls.com', '69503142', 'idf');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (21006417, 'NilsJay', 'nils@peerlessmanufacturing.at', '54015093', 'mossad');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (82822656, 'JeffCusack', 'jeff.cusack@priorityexpress.nc', '68726839', 'ministry of defence');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (77252335, 'JoelyPlimpton', 'jplimpton@glmt.com', '95782172', 'shabak');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (68840671, 'NickCrouse', 'ncrouse@teoco.de', '98303671', 'mossad');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (39457119, 'DevonDavid', 'devon@techbooks.com', '98130142', 'refael');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (28015591, 'MarinaLiotta', 'mliotta@alogent.pe', '13650418', 'mossad');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (76173383, 'RheaKravitz', 'rhea.kravitz@procurementcentre.com', '46857126', 'idf');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (93580069, 'ClintTrevino', 'clint.trevino@restaurantpartners.de', '35805775', 'ministry of defence');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (16551905, 'Fredde Lancie', 'f.delancie@mastercardinternational.com', '27691354', 'idf');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (70452684, 'JaneaneMorrison', 'janeane.morrison@gtp.uk', '94054403', 'mossad');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (20837013, 'AvrilPerry', 'avril@businessplus.com', '36810531', 'shabak');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (60957159, 'GordSchreiber', 'gord.schreiber@tropicaloasis.de', '81111679', 'refael');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (48379600, 'CameronKier', 'c.kier@mss.com', '77881510', 'idf');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (55133153, 'MarcCoyote', 'marc.coyote@investorstitle.pl', '68547648', 'shabak');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (85894488, 'JenniferCummings', 'jennifer@quicksilverresources.ge', '86266115', 'ministry of defence');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (15776023, 'ThinElliott', 'thin.elliott@hardwoodwholesalers.dk', '93822155', 'ministry of defence');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (99396967, 'ReginaRichter', 'regina.richter@ceom.se', '23101639', 'idf');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (78667587, 'DanniMacy', 'd.macy@arkidata.ca', '46487443', 'refael');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (54917654, 'JeremyGunton', 'jeremy.gunton@wav.com', '33333117', 'mossad');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (63542839, 'BrothersWright', 'bwright@qssgroup.br', '98064422', 'refael');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (12471457, 'RobbyCube', 'robby.cube@granitesystems.com', '31201859', 'ministry of defence');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (95607525, 'DenisSuchet', 'deniss@spotfireholdings.com', '53689538', 'shabak');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (30993385, 'CarolynSchiavelli', 'carolyn.schiavelli@parksite.se', '43898873', 'mossad');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (60922255, 'ClarenceJay', 'clarencej@usdairyproducers.com', '88544459', 'refael');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (66782732, 'LarenzIsaak', 'larenz.i@trekequipment.br', '20327149', 'refael');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (55883122, 'KyraCurry', 'kyra.curry@talx.com', '78417383', 'shabak');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (45826801, 'PhoebeLane', 'plane@callhenry.com', '33081398', 'refael');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (73232830, 'HollandSenior', 'holland.senior@proclarity.br', '75167234', 'ministry of defence');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (63310475, 'TerrenceRonstadt', 't.ronstadt@mcdonalds.cr', '27855137', 'ministry of defence');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (12930124, 'CateRoth', 'c.roth@pis.com', '78122499', 'ministry of defence');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (26125772, 'JulianaMalkovich', 'juliana.malkovich@ctg.cy', '40125788', 'shabak');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (92923016, 'StockardLevert', 'stockard@gtp.lt', '47658398', 'mossad');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (56227838, 'ChristineO''Neill', 'christine.oneill@actechnologies.it', '40097359', 'mossad');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (14758552, 'ThomasFisher', 'thomas.fisher@irissoftware.se', '39351678', 'shabak');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (48134079, 'ShelbyMorales', 'shelbym@vms.ca', '10800766', 'idf');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (20927003, 'RutgerDepp', 'r.depp@totalentertainment.br', '22723700', 'refael');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (48525494, 'MaxineShorter', 'maxine.shorter@knightsbridge.ch', '46031302', 'idf');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (46497757, 'DonaldJovovich', 'donald.jovovich@sweetproductions.za', '25349667', 'shabak');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (76990088, 'AdamMoss', 'a.moss@lms.de', '75350794', 'mossad');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (29260815, 'RobbyFierstein', 'robbyf@tarragonrealty.uk', '46574976', 'shabak');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (40601624, 'BarbaraLennox', 'blennox@marriottinternational.in', '94641537', 'shabak');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (52928864, 'JonnyGiannini', 'jgiannini@ahl.no', '25291026', 'idf');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (77375983, 'LiquidMinogue', 'liquid.minogue@esteelauder.com', '53886961', 'mossad');
commit;
prompt 200 records committed...
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (1, 'John Doe', 'john.doe@example.com', '1234567890', 'Sales');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (93645798, 'GordDuvall', 'gord.duvall@mqsoftware.au', '30010267', 'vip');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (98494608, 'NileEvanswood', 'nile.e@banfeproducts.uk', '69991555', 'vip');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (74884671, 'ArmandChoice', 'armand.c@kimberlyclark.it', '52748682', 'vip');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (70619118, 'RonnieSedaka', 'ronnie.sedaka@officedepot.com', '29915529', 'vip');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (88226991, 'TeriSingletary', 'teri.s@networkdisplay.de', '71509925', 'vip');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (12240369, 'RodneyWarren', 'r.warren@newhorizons.com', '51476174', 'vip');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (47246458, 'JohnnieColton', 'jcolton@cyberthink.com', '53989336', 'vip');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (76448429, 'RadneyHumphrey', 'radney@staffforce.uk', '66967915', 'vip');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (71581175, 'AngieSchreiber', 'a.schreiber@tlsservicebureau.com', '36639810', 'vip');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (84650888, 'JoshuaCurtis', 'joshua@pfizer.au', '46595965', 'vip');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (91787136, 'SuzyCoverdale', 'suzy@marriottinternational.com', '16660697', 'vip');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (63216870, 'NickCoolidge', 'nick@lloydgroup.br', '74230448', 'vip');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (74898238, 'CarolTorino', 'carolt@kelmooreinvestment.com', '26082671', 'vip');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (46291696, 'TerryNavarro', 'terry@ibfh.fr', '76359318', 'vip');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (76640553, 'ClintVoight', 'cvoight@berkshirehathaway.br', '49619384', 'vip');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (16195422, 'JuniorDaniels', 'junior.daniels@unilever.br', '79244571', 'vip');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (50205766, 'DorryFinney', 'dorry.finney@escalade.com', '62897961', 'vip');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (52265116, 'RoscoeWayans', 'r.wayans@securitycheck.com', '10074866', 'vip');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (18405578, 'Jean-LucMcDiarmid', 'jeanluc.mcdiarmid@vms.uk', '22614045', 'vip');
insert into ACCOUNT_MANAGER (accountmanagerid, name, email, phone, department)
values (95594631, 'ElizabethMellencamp', 'e.mellencamp@ceb.com', '36365589', 'vip');
commit;
prompt 221 records loaded
prompt Loading CUSTOMERS...
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (92854052, 'USA', '34956987', 'mitchell.dempsey@supplycorecom.com', '68 Delroy Street', 'mossad', 93645798);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (65702533, 'USA', '28759793', 'sona@idas.com', '82 Barry Road', 'refael', 93645798);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (99979592, 'South Korea', '90169249', 'nastassja.hong@gentrasystems.com', '33 Stockard Street', 'ministry of defence', 93580069);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (31021143, 'USA', '95713777', 'junior@otbd.com', '6 Scaggs Road', 'ministry of defence', 93645798);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (11311183, 'United Kingdom', '34583295', 'candice.rollins@coadvantageresources.uk', '758 Clark', 'mossad', 24714985);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (37031324, 'Australia', '79039730', 'kate.b@usgovernment.au', '74 Kershaw', 'ministry of defence', 93645798);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (67214968, 'Poland', '68273501', 'loretta@escalade.pl', '71 Goldie', 'mossad', 67606405);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (84360223, 'USA', '78676598', 'kiefer.tomei@anheuserbusch.com', '673 Harrison Ave', 'idf', 93645798);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (89241937, 'USA', '52441965', 'kevn.f@fmi.com', '55 Edmunds Street', 'shabak', 92724719);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (82736622, 'USA', '21612757', 'rene.jenkins@aco.com', '77 Metcalf Road', 'shabak', 93645798);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (71358712, 'South Africa', '19761200', 't.favreau@medamicus.za', '82nd Street', 'idf', 93645798);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (20344983, 'USA', '85083917', 'roscoe.ferrell@irissoftware.com', '481 Sophie Blvd', 'shabak', 93645798);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (74243613, 'USA', '47413251', 'm.hawke@serentec.com', '82 Gaines Drive', 'shabak', 93645798);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (22900368, 'USA', '78620197', 'kristin.evanswood@greene.com', '67 Brenda Street', 'shabak', 93645798);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (43265993, 'Switzerland', '98925417', 'mae.mould@summitenergy.ch', '39 Claire', 'idf', 93645798);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (32420685, 'USA', '39385461', 'chalee@cis.com', '60 McLachlan Drive', 'ministry of defence', 93645798);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (54088195, 'USA', '97356059', 'dwight.foster@scjohnson.com', '68 Rooker Street', 'idf', 93645798);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (10840739, 'Switzerland', '60644746', 'owen@atlanticnet.ch', '47 Media Road', 'shabak', 93645798);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (74048849, 'USA', '66958806', 'rita.nelson@spotfireholdings.com', '71 Rosanna Street', 'refael', 71399259);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (78624858, 'USA', '26689283', 'debi.shawn@nat.com', '62 Gooding Blvd', 'refael', 93645798);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (33314613, 'USA', '55867655', 'sammyp@jcpenney.com', '10 Oslo Road', 'refael', 93645798);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (28740228, 'Germany', '14775525', 'arobards@datawarehouse.de', '22 Dench Road', 'idf', 93645798);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (15585992, 'USA', '63518758', 'amacpherson@palmbeachtan.com', '7 Syracuse Drive', 'ministry of defence', 93645798);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (74677527, 'Iceland', '22814260', 'kenneth.mccracken@albertsons.is', '6 Skarsgard Drive', 'shabak', 60281327);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (81418452, 'USA', '91398262', 'max.lunch@exinomtechnologies.com', '373 Johnny Road', 'mossad', 93645798);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (97415593, 'Canada', '50928102', 'vanessa@iss.ca', '7 Lerner Street', 'shabak', 93645798);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (57352525, 'United Kingdom', '27818929', 's.keaton@gha.uk', '6 Pitstone Street', 'shabak', 93645798);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (47712085, 'USA', '30120937', 'giovanni.campbell@envisiontelephony.com', '85 Guelph Street', 'idf', 93645798);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (79357743, 'Italy', '36081705', 'devon.burke@esoftsolutions.it', '527 Yulin Road', 'shabak', 54917654);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (30061988, 'USA', '88065062', 'rip.mcgriff@carteretmortgage.com', '36 Wehrheim Street', 'mossad', 93645798);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (62526376, 'Japan', '77610844', 'nanci.singh@prp.jp', '52nd Street', 'idf', 86198357);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (96951684, 'USA', '50570482', 'ian@nha.com', '46 Coe Blvd', 'shabak', 30057569);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (89936499, 'Italy', '13854112', 'cathyl@kmart.it', '51 Hornsby Street', 'mossad', 93645798);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (75426354, 'USA', '51544501', 'marie.h@authoria.com', '818 Brothers Drive', 'mossad', 93645798);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (36812939, 'USA', '30762060', 'gloria.franks@bat.com', '31st Street', 'ministry of defence', 28716947);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (54748279, 'Japan', '41115062', 'c.senior@alohanysystems.jp', '590 Pandrup Road', 'refael', 24093550);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (11056490, 'USA', '75689204', 'jesusc@carteretmortgage.com', '68 Perry Road', 'mossad', 93645798);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (43756556, 'Austria', '21565957', 'betty.heatherly@astute.at', '83 Bountiful Blvd', 'mossad', 93645798);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (77642002, 'Israel', '81494543', 'freddiei@tilsonlandscape.il', '704 Stephanie Ave', 'ministry of defence', 93645798);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (35281037, 'Germany', '79528280', 'lupe.n@vfs.de', '44 Boorem Street', 'refael', 93645798);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (65610666, 'Japan', '94843740', 'a.carlton@mms.jp', '39 McClinton Road', 'idf', 40981256);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (11410646, 'United Kingdom', '45644614', 'willie.dutton@waltdisney.uk', '15 Renee Road', 'ministry of defence', 93645798);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (86054195, 'Japan', '43969080', 'kathleen.collie@nat.jp', '444 Claymont Street', 'idf', 93645798);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (99005237, 'USA', '10951437', 'lou.brooke@netnumina.com', '63rd Street', 'refael', 16305031);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (23720801, 'Australia', '94143709', 'nanci.hart@eastmankodak.au', '75 Dafoe Street', 'refael', 81203133);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (97259537, 'United Kingdom', '57210363', 'gplace@infopros.uk', '506 Collie Ave', 'ministry of defence', 93645798);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (60928528, 'Germany', '59057260', 'debi.broadbent@gra.de', '72 Raleigh Road', 'idf', 93645798);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (71110942, 'South Africa', '22725053', 'dorry.miller@angieslist.za', '1 Leo Street', 'shabak', 93645798);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (39403818, 'USA', '64276563', 'alec.warwick@loreal.com', '21 Rome Drive', 'shabak', 93645798);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (59933677, 'United Kingdom', '89411569', 'trick.harrison@greene.uk', '696 Jeter Drive', 'idf', 93645798);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (16354941, 'USA', '75811248', 'khidalgo@priorityleasing.com', '47 Swannanoa Road', 'refael', 64836269);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (94249883, 'USA', '21184358', 'clea.crowell@telesynthesis.com', '407 Diehl Road', 'shabak', 93645798);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (97745277, 'Venezuela', '92202248', 'earl.dushku@esteelauder.ve', '85 Aaron Blvd', 'mossad', 37589679);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (20191024, 'Germany', '81537519', 'hwhitaker@ositissoftware.de', '30 Pollak Street', 'mossad', 93645798);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (86843873, 'Greece', '91876894', 'wang.z@vivendiuniversal.gr', '73 Polley Drive', 'refael', 24312332);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (33133087, 'France', '77357019', 'scronin@gbas.fr', '416 Rhymes Road', 'mossad', 78667587);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (17561794, 'USA', '99656671', 'drew.ramirez@tlsservicebureau.com', '35 Hiatt Road', 'ministry of defence', 19789687);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (15593866, 'France', '29165228', 'celia@cima.fr', '26 Fort McMurray Ave', 'ministry of defence', 78667587);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (96895448, 'Hungary', '59271460', 'dick.dorff@verizon.hu', '53rd Street', 'shabak', 51259353);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (28817809, 'China', '93689938', 'jon.sizemore@tama.cn', '54 Mykelti Drive', 'shabak', 93645798);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (34849605, 'Japan', '76317192', 'k.vaughn@astute.jp', '42 Kidman Street', 'ministry of defence', 63035913);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (72032008, 'Japan', '90263699', 'jay.durning@oriservices.jp', '10 Cardiff Road', 'ministry of defence', 93645798);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (86514668, 'Poland', '56949722', 'lour@proclarity.pl', '98 Max Street', 'refael', 16551905);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (55818347, 'USA', '98991847', 'vonda.wariner@hondamotor.com', '83rd Street', 'idf', 93645798);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (37316644, 'Denmark', '37949191', 'goldie.woods@cocacola.dk', '62nd Street', 'refael', 93645798);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (20113136, 'USA', '86367854', 'cuba@trainersoft.com', '15 Chaam Street', 'idf', 93645798);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (35963572, 'USA', '90363753', 'denzel.parsons@bps.com', '68 Lena Drive', 'refael', 93645798);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (20834380, 'Australia', '21399263', 'anjelica.ripley@pacificdatadesigns.au', '77 Thora Road', 'ministry of defence', 79467005);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (15326270, 'United Kingdom', '53964091', 'kelly.mcbride@oriservices.uk', '406 O''Donnell Drive', 'refael', 93645798);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (59743184, 'Japan', '29807982', 'garth.b@proclarity.jp', '348 Emmerich Road', 'mossad', 74053824);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (39313492, 'USA', '19710853', 'leon.morse@wyeth.com', '59 Lachey Drive', 'shabak', 14087170);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (83846105, 'Spain', '60319000', 'terry@ogi.es', '21 Ramirez Road', 'shabak', 14758552);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (34793536, 'Japan', '80550439', 'stelland@fns.jp', '83 Leeds Road', 'ministry of defence', 93645798);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (85682722, 'USA', '99685132', 'horace.b@aquascapedesigns.com', '61 Tobolowsky Street', 'shabak', 93645798);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (48870120, 'USA', '95049684', 'darius.marley@healthscribe.com', '35 Skaggs Ave', 'idf', 93645798);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (52321215, 'Croatia', '45518890', 'jaime.rooker@diageo.com', '60 Alleroed Street', 'mossad', 93645798);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (38174594, 'USA', '55200194', 'clennox@trafficmanagement.com', '351 Vai Drive', 'mossad', 27921692);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (31650026, 'USA', '71483902', 'slee@fmt.com', '39 Santana do parnaíba Road', 'ministry of defence', 32336221);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (84657835, 'USA', '66431398', 'leo.copeland@navigatorsystems.com', '50 Keener Ave', 'ministry of defence', 93645798);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (72063537, 'USA', '13880766', 't.mccready@clorox.com', '26 Jack Road', 'mossad', 93645798);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (74072275, 'USA', '98683442', 'vmarie@americanland.com', '66 New Hyde Park Road', 'refael', 54917654);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (56727091, 'Germany', '25016758', 'gene.red@drinkmorewater.de', '529 Rich Road', 'mossad', 93645798);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (95814419, 'USA', '34520556', 'hpage@capital.com', '2 Jack Drive', 'idf', 37589679);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (74742649, 'Germany', '51831531', 'caroline.t@thinktanksystems.de', '81 Deschanel Street', 'ministry of defence', 93645798);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (60843836, 'Germany', '20995669', 'mattc@lms.de', '16 Shue Road', 'ministry of defence', 93645798);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (27044249, 'USA', '36760935', 'dylane@dsp.com', '40 McGovern Road', 'idf', 39457119);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (34948701, 'Germany', '92296891', 'alec@cascadebancorp.de', '76 Tori Drive', 'idf', 93645798);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (12074999, 'USA', '13538220', 'meryl.kinnear@proclarity.com', '50 Carlyle Drive', 'shabak', 93645798);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (87552354, 'USA', '46595277', 'k.pesci@ibm.com', '65 Dublin Street', 'ministry of defence', 93645798);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (16285988, 'Canada', '76644153', 'colm.g@acsis.ca', '6 Snipes Drive', 'ministry of defence', 21325971);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (70266179, 'Spain', '22602716', 'nikki.vicious@gapinc.es', '36 Chappelle Drive', 'idf', 18792965);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (37207125, 'USA', '74938855', 'malcolmr@circuitcitystores.com', '74 Oulu Ave', 'shabak', 93645798);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (64207208, 'United Kingdom', '39869609', 'trey.vaughn@fmb.uk', '27 Durham', 'mossad', 23170936);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (92355989, 'Japan', '74813602', 'lizzy.mahood@ogi.jp', '786 Edwin Street', 'shabak', 93645798);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (45349098, 'Switzerland', '89556372', 'g.arthur@aci.ch', '33 Anna Road', 'mossad', 96081193);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (31417541, 'Germany', '28706195', 'juice@netnumina.de', '491 Moody Drive', 'idf', 93645798);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (99433231, 'Switzerland', '14962414', 'karen@labradanutrition.ch', '834 Ann Ave', 'refael', 76963377);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (25535209, 'Finland', '21589371', 'rik.norton@capitolbancorp.fi', '26 Beck Drive', 'refael', 50974786);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (54655982, 'Brazil', '98733584', 'franco.finn@staffforce.br', '33 Whittier Street', 'refael', 10389457);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (65891332, 'USA', '61945745', 'jody.hawn@mms.com', '62 Lewin Ave', 'ministry of defence', 93645798);
commit;
prompt 100 records committed...
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (20315447, 'USA', '55410761', 'claude.cochran@shar.com', '13rd Street', 'ministry of defence', 93645798);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (91104836, 'USA', '30107206', 'max.postlethwaite@ntas.com', '43rd Street', 'ministry of defence', 86503833);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (51638591, 'Japan', '53756116', 'marlon.worrell@ssi.jp', '52 Rosemead Drive', 'mossad', 93645798);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (54670908, 'Germany', '71128815', 'rick@tilia.de', '80 Joaquim', 'mossad', 93645798);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (92665521, 'USA', '49118204', 'domingo.witt@ois.com', '85 Key Biscayne Road', 'ministry of defence', 58798436);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (81969040, 'Australia', '51971570', 'norm.k@scriptsave.au', '33rd Street', 'mossad', 93645798);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (16596417, 'Sweden', '25885937', 'andrewo@printcafesoftware.se', '524 Baltimore Drive', 'shabak', 93645798);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (56882009, 'USA', '14999770', 'burton.rea@firstsouthbancorp.com', '73 Lennix Street', 'mossad', 93645798);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (85889675, 'Belgium', '20796124', 'quentin@bis.be', '10 Tori Drive', 'mossad', 93645798);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (99402438, 'USA', '97602973', 'nickyn@northhighland.com', '4 Seann Drive', 'ministry of defence', 93645798);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (95561954, 'Italy', '38126173', 'diane.levin@albertsons.it', '2 Burgess Hill Ave', 'ministry of defence', 93645798);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (32877721, 'Germany', '76338178', 'thin@accesssystems.de', '74 Spike', 'shabak', 93645798);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (54103386, 'France', '58206454', 'famkeh@sony.fr', '31 Valencia Drive', 'ministry of defence', 93645798);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (96835597, 'Germany', '45590268', 'juliettet@oss.de', '61 Cetera Road', 'shabak', 93645798);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (94146730, 'Brazil', '62357480', 'terry.bugnon@hudsonriverbancorp.br', '43 Nagano Street', 'shabak', 93645798);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (62933363, 'USA', '76111135', 'benjamin.dunn@powerlight.com', '29 Holeman Street', 'ministry of defence', 93645798);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (78216572, 'United Kingdom', '38985385', 'mint.guest@creditorsinterchange.uk', '14 Robin Street', 'refael', 93645798);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (17126069, 'United Kingdom', '18928354', 'trick@unica.uk', '67 Katie Street', 'shabak', 11449262);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (35498377, 'USA', '97235480', 'julianae@pearllawgroup.com', '715 Lang Street', 'ministry of defence', 55883122);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (34424868, 'USA', '77737905', 'bo.t@yashtechnologies.com', '428 Ratzenberger Street', 'ministry of defence', 93645798);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (23486725, 'USA', '84872906', 'terry.mortensen@campbellsoup.com', '568 Hagerty Street', 'ministry of defence', 93645798);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (48576763, 'Canada', '98985501', 'hugo.paymer@eastmankodak.ca', '45 Nara Street', 'ministry of defence', 93645798);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (96178588, 'USA', '44501607', 'fats.coleman@timberlanewoodcrafters.com', '63 Gayle Ave', 'refael', 93645798);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (83177693, 'USA', '16564136', 'brad@doraldentalusa.com', '463 Teng Ave', 'refael', 93645798);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (63442847, 'USA', '36521017', 'cathy.osmond@glmt.com', '5 Drive Drive', 'shabak', 93645798);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (59295976, 'USA', '47800284', 'amy.gere@slt.com', '71st Street', 'shabak', 28834144);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (19321854, 'Netherlands', '83051687', 'dabney@infinity.nl', '73rd Street', 'mossad', 93645798);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (61137958, 'USA', '31184092', 'miki@bmm.com', '97 Strong Street', 'refael', 93645798);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (27399832, 'Japan', '98132847', 'roy.humphrey@ccfholding.jp', '692 Gere Street', 'shabak', 93645798);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (43599881, 'South Africa', '15778926', 'diamond.jackson@denaliventures.za', '75 Woodward Street', 'refael', 93645798);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (64639428, 'Brazil', '75691789', 'josh.bates@genextechnologies.br', '51st Street', 'ministry of defence', 93645798);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (17963068, 'USA', '41051285', 'latin.cozier@doraldentalusa.com', '13 Collin Street', 'refael', 93645798);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (19792292, 'USA', '24728616', 'b.washington@astute.com', '21 Ryder Drive', 'idf', 11953374);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (63861534, 'USA', '54019465', 'herbie.coleman@bps.com', '80 Eschen Street', 'idf', 93645798);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (91466324, 'Israel', '39454957', 'clive.browne@tmt.il', '43 Redford Street', 'ministry of defence', 12054149);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (17882271, 'Germany', '21232367', 'isabella@swi.de', '50 Lindo Drive', 'refael', 21561518);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (76928249, 'India', '76845647', 'faye.elliott@dsp.in', '4 Rosas Drive', 'ministry of defence', 93645798);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (18675026, 'USA', '60054389', 'chad.sampson@mms.com', '698 Diaz Drive', 'refael', 40424418);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (16844774, 'Austria', '66128877', 'danny.holly@inspirationsoftware.at', '28 Easton Drive', 'ministry of defence', 93645798);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (36373252, 'United Kingdom', '26550477', 'z.pacino@generalmills.uk', '95 Sartain', 'idf', 93645798);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (69517856, 'USA', '72490247', 'robbie.a@unicru.com', '28 Beckham Road', 'shabak', 93645798);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (88868162, 'Canada', '57044202', 'w.domino@kingston.ca', '14 Hawkins Drive', 'refael', 93645798);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (61171248, 'Italy', '63691191', 'avril.wayans@contract.it', '24 Pigott-Smith Ave', 'idf', 93645798);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (33067757, 'USA', '52753182', 'uma.evanswood@nhhc.com', '1 Oshawa Road', 'idf', 93645798);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (85003854, 'Japan', '15704153', 'a.duchovny@visionarysystems.jp', '13rd Street', 'ministry of defence', 48524665);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (19137978, 'Germany', '60893962', 'spencer.weston@asa.de', '80 Josh Road', 'refael', 95117510);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (86155159, 'Germany', '29827983', 'wholmes@jma.de', '34 Payton Road', 'shabak', 63542839);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (61154579, 'Germany', '58175445', 'j.plowright@wci.de', '852 Danger Drive', 'ministry of defence', 93645798);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (65892682, 'France', '87910076', 'cbugnon@ufs.fr', '54 Candice Street', 'mossad', 93645798);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (44272847, 'Denmark', '33966964', 'isaiah@diamondtechnologies.dk', '62nd Street', 'mossad', 93645798);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (21498697, 'USA', '84959671', 'ernie.glenn@arkidata.com', '64 Katrin', 'shabak', 93645798);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (82793030, 'Japan', '13678704', 'matthew.hutton@clubone.jp', '308 Santorso Road', 'mossad', 40424418);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (92535882, 'Germany', '11704670', 'andrea.kirshner@signalperfection.de', '28 Ramsey Blvd', 'shabak', 93645798);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (71611157, 'USA', '88818711', 'garry.s@irissoftware.com', '922 Rhys Street', 'refael', 56090177);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (43856352, 'Sweden', '73094917', 'thelma.polley@scripnet.se', '30 Osborne Ave', 'ministry of defence', 93645798);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (32591990, 'Israel', '54356046', 'oded.woods@ositissoftware.il', '30 Loggia Ave', 'mossad', 93645798);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (68401747, 'Switzerland', '41892245', 'ernie.farrow@lifelinesystems.ch', '52 Schenectady Road', 'shabak', 93645798);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (64103674, 'Germany', '14942006', 'stephen@newviewgifts.de', '81 Mia Blvd', 'shabak', 93645798);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (50467355, 'India', '84475869', 'trick.copeland@tastefullysimple.in', '38 Robert Street', 'mossad', 93645798);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (90745803, 'Denmark', '95389670', 'demi.patton@gateway.dk', '81 Collin Road', 'shabak', 93645798);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (51957721, 'Germany', '57401702', 'madeleine.hoffman@scripnet.de', '12nd Street', 'shabak', 97375479);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (20233702, 'Germany', '88072919', 'william@microtek.de', '50 Cape town Drive', 'refael', 32430536);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (90862878, 'United Kingdom', '85333528', 'xander.elliott@fmt.uk', '86 Sainte-Marie Ave', 'refael', 93645798);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (73291243, 'Germany', '15692418', 'sally.brolin@dell.de', '27 Wright Road', 'ministry of defence', 93645798);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (16752796, 'USA', '28349828', 'dermot@walmartstores.com', '13 Farris Drive', 'refael', 93645798);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (17634484, 'USA', '23629789', 'tramaine.tucci@intraspheretechnologies.com', '59 Howard Road', 'shabak', 93645798);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (21346943, 'Germany', '73431632', 'jeanluc.lucas@ivorysystems.de', '20 Andrea Street', 'refael', 60976032);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (23320965, 'Finland', '23205661', 'dylan.tsettos@pragmatechsoftware.fi', '42nd Street', 'refael', 93645798);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (52282046, 'USA', '29045143', 'balston@capitolbancorp.com', '45 Albright Street', 'ministry of defence', 93645798);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (71460396, 'Germany', '32795734', 'melbaw@nha.de', '100 Corona Drive', 'ministry of defence', 30319594);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (43322564, 'USA', '45223542', 'eugene.degraw@wendysinternational.com', '13rd Street', 'idf', 78743272);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (13867485, 'USA', '17114690', 'merilleeb@epiqsystems.com', '100 Pointe-claire', 'mossad', 93645798);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (30556154, 'United Kingdom', '95393707', 'cpolito@dis.uk', '98 Rosanna Street', 'refael', 28716947);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (55819347, 'Spain', '12707860', 'eddie.r@trx.es', '310 Schiavelli Road', 'mossad', 93645798);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (21509784, 'China', '57390466', 'j.collette@stonebrewing.cn', '92 Peachtree City Ave', 'idf', 93645798);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (69372437, 'Germany', '10017133', 'veruca@authoria.de', '953 Shoreline Road', 'refael', 93645798);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (72930320, 'Canada', '58718606', 'ian.weir@ivci.ca', '98 Negbaur Drive', 'mossad', 93645798);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (62218719, 'USA', '67175635', 'mary@albertsons.com', '19 Cary', 'refael', 12270385);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (81525413, 'Japan', '29524180', 'garth@sbc.jp', '78 Flanagan Blvd', 'shabak', 93645798);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (71061207, 'Canada', '99142202', 'c.mcgill@ams.ca', '14 Lopez Road', 'ministry of defence', 93645798);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (41522255, 'USA', '22535991', 'cevin.vai@wellsfinancial.com', '554 Dreieich Street', 'idf', 93645798);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (28411817, 'Switzerland', '63312187', 'temuera.summer@dillards.ch', '18 Cronin Road', 'shabak', 93645798);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (83480577, 'Belgium', '11968292', 'ritchie.mahood@yes.be', '31 Debbie Street', 'ministry of defence', 93645798);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (61456823, 'USA', '12859685', 'reese.f@hatworld.com', '45 Berkoff', 'idf', 93645798);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (23759349, 'USA', '33575080', 'celiao@seafoxboat.com', '82 Bruce Drive', 'ministry of defence', 54302713);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (93869133, 'South Africa', '80196642', 'roscoe.c@yes.za', '78 Bacon Blvd', 'idf', 93645798);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (40481802, 'Poland', '35259896', 'michelle.tilly@jcpenney.pl', '46 Trejo Street', 'shabak', 10670802);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (42142840, 'USA', '62257051', 'r.mazzello@qestrel.com', '94 Karen Drive', 'idf', 93645798);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (23250655, 'USA', '69329453', 'val.womack@ivci.com', '75 Lapointe Street', 'ministry of defence', 93645798);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (34017820, 'Brazil', '46156332', 'carolet@solipsys.br', '52nd Street', 'refael', 93645798);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (59279749, 'Italy', '80523871', 'thelmak@gltg.it', '69 Hynde Road', 'refael', 93645798);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (92642538, 'Switzerland', '71225164', 'kurt.bonham@americanland.ch', '41 Ashley Blvd', 'mossad', 10842068);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (39370182, 'Canada', '37710760', 'denis.m@team.ca', '5 Weisberg Drive', 'mossad', 79467005);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (97578691, 'Canada', '99699857', 'jason.saintemarie@gulfmarkoffshore.ca', '213 Emmerich Drive', 'ministry of defence', 93645798);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (27373972, 'New Zealand', '67924294', 'rupert.wolf@tigris.nz', '83 Michendorf Road', 'ministry of defence', 77375983);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (13629800, 'USA', '62709479', 'leeg@trusecure.com', '4 Palmer Street', 'ministry of defence', 21561518);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (87982560, 'France', '52255107', 'anita.murphy@progressivedesigns.fr', '85 Bachman Road', 'ministry of defence', 93645798);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (89799326, 'Russia', '56031744', 'dwight.levin@ciwservices.com', '86 Whitley Blvd', 'mossad', 93645798);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (92887180, 'United Kingdom', '44820085', 'milla.barkin@smg.uk', '43 Fichtner Ave', 'shabak', 26386141);
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (42423384, 'USA', '81315483', 'cate.malone@pharmacia.com', '15 Rachael Road', 'shabak', 24312332);
commit;
prompt 200 records committed...
insert into CUSTOMERS (customerid, name, contactnumber, email, address, industrytype, accountmanagerid)
values (1, 'Sample Customer', '0987654321', 'customer@example.com', '123 Main St', 'Retail', 1);
commit;
prompt 201 records loaded
prompt Loading AIR_ORDER...
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (45343624, to_date('20-01-2022', 'dd-mm-yyyy'), to_date('10-08-2023', 'dd-mm-yyyy'), 'Delivered', 7903122, 17963068);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (46348857, to_date('27-12-2022', 'dd-mm-yyyy'), to_date('28-10-2023', 'dd-mm-yyyy'), 'Shipped', 4596196, 56727091);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (89739640, to_date('08-09-2022', 'dd-mm-yyyy'), to_date('27-09-2023', 'dd-mm-yyyy'), 'Pending', 9516154, 19321854);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (42567869, to_date('09-12-2022', 'dd-mm-yyyy'), to_date('18-08-2023', 'dd-mm-yyyy'), 'Shipped', 4251269, 74243613);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (62150938, to_date('20-03-2023', 'dd-mm-yyyy'), to_date('26-11-2023', 'dd-mm-yyyy'), 'Delivered', 7573095, 71061207);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (71600752, to_date('14-12-2022', 'dd-mm-yyyy'), to_date('18-02-2024', 'dd-mm-yyyy'), 'Processed', 9076802, 84657835);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (33105564, to_date('04-01-2022', 'dd-mm-yyyy'), to_date('10-09-2023', 'dd-mm-yyyy'), 'Completed', 8136904, 81418452);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (89062047, to_date('11-04-2023', 'dd-mm-yyyy'), to_date('04-12-2023', 'dd-mm-yyyy'), 'Completed', 772221, 89799326);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (88692266, to_date('13-09-2022', 'dd-mm-yyyy'), to_date('16-03-2024', 'dd-mm-yyyy'), 'Shipped', 844129, 73291243);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (48324694, to_date('26-12-2022', 'dd-mm-yyyy'), to_date('27-11-2023', 'dd-mm-yyyy'), 'Pending', 1993792, 11056490);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (38534334, to_date('21-03-2022', 'dd-mm-yyyy'), to_date('05-05-2023', 'dd-mm-yyyy'), 'Pending', 4692439, 13867485);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (32935042, to_date('08-02-2023', 'dd-mm-yyyy'), to_date('21-11-2023', 'dd-mm-yyyy'), 'Shipped', 580588, 34793536);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (28269220, to_date('23-10-2022', 'dd-mm-yyyy'), to_date('23-04-2024', 'dd-mm-yyyy'), 'Processed', 9873954, 13867485);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (71653287, to_date('10-12-2022', 'dd-mm-yyyy'), to_date('23-03-2024', 'dd-mm-yyyy'), 'Pending', 4110994, 59933677);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (69556806, to_date('05-08-2022', 'dd-mm-yyyy'), to_date('16-11-2023', 'dd-mm-yyyy'), 'Delivered', 9516154, 63442847);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (76125747, to_date('14-03-2023', 'dd-mm-yyyy'), to_date('22-03-2024', 'dd-mm-yyyy'), 'Shipped', 1646242, 61171248);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (44901192, to_date('05-10-2022', 'dd-mm-yyyy'), to_date('12-05-2023', 'dd-mm-yyyy'), 'Pending', 2492541, 56727091);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (65592894, to_date('09-04-2022', 'dd-mm-yyyy'), to_date('27-12-2023', 'dd-mm-yyyy'), 'Processed', 4338006, 37316644);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (28415757, to_date('28-04-2023', 'dd-mm-yyyy'), to_date('08-10-2023', 'dd-mm-yyyy'), 'Processed', 8608134, 11410646);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (55156473, to_date('31-12-2022', 'dd-mm-yyyy'), to_date('11-11-2023', 'dd-mm-yyyy'), 'Shipped', 9930179, 23486725);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (72316176, to_date('27-11-2022', 'dd-mm-yyyy'), to_date('18-09-2023', 'dd-mm-yyyy'), 'Completed', 2948580, 89799326);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (99026809, to_date('11-03-2023', 'dd-mm-yyyy'), to_date('24-05-2023', 'dd-mm-yyyy'), 'Delivered', 6454841, 74243613);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (89793726, to_date('28-04-2023', 'dd-mm-yyyy'), to_date('16-09-2023', 'dd-mm-yyyy'), 'Shipped', 9066342, 97259537);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (41271233, to_date('13-04-2022', 'dd-mm-yyyy'), to_date('28-01-2024', 'dd-mm-yyyy'), 'Shipped', 6287307, 97259537);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (96098609, to_date('19-04-2022', 'dd-mm-yyyy'), to_date('17-12-2023', 'dd-mm-yyyy'), 'Completed', 1833073, 35281037);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (10511620, to_date('01-03-2022', 'dd-mm-yyyy'), to_date('23-07-2023', 'dd-mm-yyyy'), 'Pending', 2455633, 81418452);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (15864881, to_date('28-08-2022', 'dd-mm-yyyy'), to_date('04-05-2023', 'dd-mm-yyyy'), 'Pending', 3176117, 85889675);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (67495106, to_date('11-04-2023', 'dd-mm-yyyy'), to_date('10-01-2024', 'dd-mm-yyyy'), 'Delivered', 7573095, 92355989);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (50162378, to_date('09-02-2023', 'dd-mm-yyyy'), to_date('05-10-2023', 'dd-mm-yyyy'), 'Processed', 9665246, 56882009);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (43940072, to_date('16-12-2022', 'dd-mm-yyyy'), to_date('03-04-2024', 'dd-mm-yyyy'), 'Pending', 7967867, 87982560);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (32084160, to_date('16-07-2022', 'dd-mm-yyyy'), to_date('09-04-2024', 'dd-mm-yyyy'), 'Completed', 1696477, 35963572);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (96061311, to_date('17-04-2023', 'dd-mm-yyyy'), to_date('28-11-2023', 'dd-mm-yyyy'), 'Pending', 2873663, 71358712);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (93688442, to_date('05-07-2022', 'dd-mm-yyyy'), to_date('15-06-2023', 'dd-mm-yyyy'), 'Completed', 2688335, 97259537);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (25730382, to_date('20-01-2022', 'dd-mm-yyyy'), to_date('19-01-2024', 'dd-mm-yyyy'), 'Shipped', 9852545, 84360223);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (41423687, to_date('19-11-2022', 'dd-mm-yyyy'), to_date('02-05-2023', 'dd-mm-yyyy'), 'Processed', 7630660, 68401747);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (54978245, to_date('04-07-2022', 'dd-mm-yyyy'), to_date('06-02-2024', 'dd-mm-yyyy'), 'Pending', 8370975, 33067757);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (27340466, to_date('24-08-2022', 'dd-mm-yyyy'), to_date('30-07-2023', 'dd-mm-yyyy'), 'Shipped', 8136904, 43856352);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (38768910, to_date('22-03-2022', 'dd-mm-yyyy'), to_date('30-06-2023', 'dd-mm-yyyy'), 'Shipped', 2492541, 35963572);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (27014259, to_date('20-01-2022', 'dd-mm-yyyy'), to_date('19-10-2023', 'dd-mm-yyyy'), 'Delivered', 5607773, 31417541);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (56073570, to_date('29-10-2022', 'dd-mm-yyyy'), to_date('11-10-2023', 'dd-mm-yyyy'), 'Pending', 844129, 81525413);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (82940119, to_date('18-03-2022', 'dd-mm-yyyy'), to_date('02-12-2023', 'dd-mm-yyyy'), 'Completed', 6282765, 57352525);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (26554668, to_date('10-03-2023', 'dd-mm-yyyy'), to_date('22-03-2024', 'dd-mm-yyyy'), 'Processed', 4782431, 27399832);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (14395239, to_date('23-06-2022', 'dd-mm-yyyy'), to_date('28-10-2023', 'dd-mm-yyyy'), 'Completed', 6202242, 71061207);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (38041998, to_date('30-04-2023', 'dd-mm-yyyy'), to_date('03-02-2024', 'dd-mm-yyyy'), 'Delivered', 1696477, 99402438);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (10186094, to_date('12-03-2023', 'dd-mm-yyyy'), to_date('31-05-2023', 'dd-mm-yyyy'), 'Pending', 3432237, 72063537);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (85430038, to_date('04-06-2022', 'dd-mm-yyyy'), to_date('29-08-2023', 'dd-mm-yyyy'), 'Completed', 1638835, 48870120);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (22711863, to_date('15-04-2023', 'dd-mm-yyyy'), to_date('29-08-2023', 'dd-mm-yyyy'), 'Delivered', 5772361, 65892682);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (45911739, to_date('24-03-2022', 'dd-mm-yyyy'), to_date('29-05-2023', 'dd-mm-yyyy'), 'Shipped', 2401835, 62933363);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (71508264, to_date('09-06-2022', 'dd-mm-yyyy'), to_date('15-10-2023', 'dd-mm-yyyy'), 'Completed', 5772361, 10840739);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (43436009, to_date('12-11-2022', 'dd-mm-yyyy'), to_date('30-03-2024', 'dd-mm-yyyy'), 'Pending', 9016717, 20315447);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (15520884, to_date('04-12-2022', 'dd-mm-yyyy'), to_date('28-03-2024', 'dd-mm-yyyy'), 'Shipped', 7602887, 16596417);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (24778986, to_date('26-08-2022', 'dd-mm-yyyy'), to_date('27-03-2024', 'dd-mm-yyyy'), 'Processed', 8885480, 69517856);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (23169983, to_date('12-08-2022', 'dd-mm-yyyy'), to_date('25-04-2024', 'dd-mm-yyyy'), 'Completed', 5840293, 55818347);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (29915313, to_date('18-09-2022', 'dd-mm-yyyy'), to_date('24-04-2024', 'dd-mm-yyyy'), 'Delivered', 5650110, 52321215);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (17901723, to_date('10-12-2022', 'dd-mm-yyyy'), to_date('12-10-2023', 'dd-mm-yyyy'), 'Shipped', 3570772, 51638591);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (58946225, to_date('06-12-2022', 'dd-mm-yyyy'), to_date('22-07-2023', 'dd-mm-yyyy'), 'Processed', 1423691, 62933363);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (10407667, to_date('24-05-2022', 'dd-mm-yyyy'), to_date('27-07-2023', 'dd-mm-yyyy'), 'Processed', 8184827, 55819347);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (21778797, to_date('20-02-2023', 'dd-mm-yyyy'), to_date('11-09-2023', 'dd-mm-yyyy'), 'Shipped', 3616686, 72930320);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (50999597, to_date('19-12-2022', 'dd-mm-yyyy'), to_date('04-12-2023', 'dd-mm-yyyy'), 'Delivered', 7272475, 15585992);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (30612695, to_date('27-08-2022', 'dd-mm-yyyy'), to_date('06-07-2023', 'dd-mm-yyyy'), 'Processed', 2873663, 97578691);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (23211833, to_date('18-10-2022', 'dd-mm-yyyy'), to_date('25-01-2024', 'dd-mm-yyyy'), 'Completed', 4596196, 35963572);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (79640672, to_date('02-11-2022', 'dd-mm-yyyy'), to_date('25-04-2024', 'dd-mm-yyyy'), 'Pending', 419004, 28817809);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (49796873, to_date('22-01-2023', 'dd-mm-yyyy'), to_date('02-10-2023', 'dd-mm-yyyy'), 'Pending', 8179153, 36373252);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (25790111, to_date('05-12-2022', 'dd-mm-yyyy'), to_date('20-02-2024', 'dd-mm-yyyy'), 'Completed', 9066342, 10840739);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (81371099, to_date('04-03-2023', 'dd-mm-yyyy'), to_date('07-10-2023', 'dd-mm-yyyy'), 'Pending', 8630203, 22900368);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (44606281, to_date('01-10-2022', 'dd-mm-yyyy'), to_date('03-04-2024', 'dd-mm-yyyy'), 'Shipped', 3963775, 20315447);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (28362564, to_date('26-08-2022', 'dd-mm-yyyy'), to_date('28-08-2023', 'dd-mm-yyyy'), 'Pending', 780367, 43756556);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (81296460, to_date('22-01-2023', 'dd-mm-yyyy'), to_date('17-03-2024', 'dd-mm-yyyy'), 'Pending', 6162934, 92854052);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (18563632, to_date('07-02-2022', 'dd-mm-yyyy'), to_date('19-01-2024', 'dd-mm-yyyy'), 'Completed', 5049540, 47712085);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (16782726, to_date('15-06-2022', 'dd-mm-yyyy'), to_date('28-05-2023', 'dd-mm-yyyy'), 'Shipped', 6520876, 78624858);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (92765749, to_date('02-04-2022', 'dd-mm-yyyy'), to_date('23-10-2023', 'dd-mm-yyyy'), 'Shipped', 4692439, 30061988);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (11644533, to_date('02-12-2022', 'dd-mm-yyyy'), to_date('17-07-2023', 'dd-mm-yyyy'), 'Processed', 326217, 34948701);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (77256073, to_date('23-04-2023', 'dd-mm-yyyy'), to_date('26-06-2023', 'dd-mm-yyyy'), 'Delivered', 9007035, 34948701);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (75626743, to_date('22-03-2023', 'dd-mm-yyyy'), to_date('13-05-2023', 'dd-mm-yyyy'), 'Pending', 5984801, 81525413);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (65589779, to_date('20-03-2023', 'dd-mm-yyyy'), to_date('03-05-2023', 'dd-mm-yyyy'), 'Processed', 8028882, 85682722);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (46222895, to_date('03-01-2022', 'dd-mm-yyyy'), to_date('05-08-2023', 'dd-mm-yyyy'), 'Pending', 8028882, 42142840);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (14888608, to_date('27-03-2023', 'dd-mm-yyyy'), to_date('09-09-2023', 'dd-mm-yyyy'), 'Processed', 6596332, 87552354);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (70221490, to_date('11-04-2023', 'dd-mm-yyyy'), to_date('17-11-2023', 'dd-mm-yyyy'), 'Completed', 741619, 11056490);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (72274769, to_date('20-01-2023', 'dd-mm-yyyy'), to_date('02-11-2023', 'dd-mm-yyyy'), 'Processed', 8193198, 89936499);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (44660055, to_date('24-09-2022', 'dd-mm-yyyy'), to_date('16-05-2023', 'dd-mm-yyyy'), 'Delivered', 7973877, 63861534);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (42083601, to_date('17-11-2022', 'dd-mm-yyyy'), to_date('12-08-2023', 'dd-mm-yyyy'), 'Completed', 7552221, 88868162);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (55289191, to_date('18-02-2023', 'dd-mm-yyyy'), to_date('01-09-2023', 'dd-mm-yyyy'), 'Processed', 8028882, 75426354);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (39283565, to_date('24-07-2022', 'dd-mm-yyyy'), to_date('16-07-2023', 'dd-mm-yyyy'), 'Completed', 8316821, 95561954);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (86457534, to_date('21-02-2023', 'dd-mm-yyyy'), to_date('05-01-2024', 'dd-mm-yyyy'), 'Completed', 6237387, 96835597);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (98130466, to_date('15-01-2023', 'dd-mm-yyyy'), to_date('25-05-2023', 'dd-mm-yyyy'), 'Processed', 1616443, 59933677);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (32159564, to_date('22-03-2022', 'dd-mm-yyyy'), to_date('24-06-2023', 'dd-mm-yyyy'), 'Shipped', 4524958, 54103386);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (42193615, to_date('04-02-2022', 'dd-mm-yyyy'), to_date('25-07-2023', 'dd-mm-yyyy'), 'Processed', 780367, 63861534);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (10847062, to_date('28-04-2023', 'dd-mm-yyyy'), to_date('09-04-2024', 'dd-mm-yyyy'), 'Processed', 5278598, 50467355);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (46697598, to_date('26-04-2022', 'dd-mm-yyyy'), to_date('18-10-2023', 'dd-mm-yyyy'), 'Processed', 5772361, 64639428);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (23222894, to_date('15-08-2022', 'dd-mm-yyyy'), to_date('09-10-2023', 'dd-mm-yyyy'), 'Shipped', 9667683, 16844774);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (35782292, to_date('03-07-2022', 'dd-mm-yyyy'), to_date('14-05-2023', 'dd-mm-yyyy'), 'Completed', 351581, 23320965);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (16089827, to_date('14-03-2023', 'dd-mm-yyyy'), to_date('06-06-2023', 'dd-mm-yyyy'), 'Shipped', 5840293, 74742649);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (22501391, to_date('17-03-2022', 'dd-mm-yyyy'), to_date('25-01-2024', 'dd-mm-yyyy'), 'Completed', 1387914, 78624858);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (37123734, to_date('27-01-2022', 'dd-mm-yyyy'), to_date('06-12-2023', 'dd-mm-yyyy'), 'Processed', 6639880, 61456823);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (84481920, to_date('01-06-2022', 'dd-mm-yyyy'), to_date('01-02-2024', 'dd-mm-yyyy'), 'Processed', 306874, 34424868);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (28823177, to_date('17-02-2023', 'dd-mm-yyyy'), to_date('27-09-2023', 'dd-mm-yyyy'), 'Completed', 6162934, 32420685);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (13039382, to_date('21-04-2022', 'dd-mm-yyyy'), to_date('02-10-2023', 'dd-mm-yyyy'), 'Shipped', 803056, 88868162);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (26764951, to_date('18-03-2022', 'dd-mm-yyyy'), to_date('06-12-2023', 'dd-mm-yyyy'), 'Completed', 292431, 31021143);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (19590430, to_date('19-01-2022', 'dd-mm-yyyy'), to_date('06-11-2023', 'dd-mm-yyyy'), 'Pending', 6374316, 85889675);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (33797584, to_date('03-03-2022', 'dd-mm-yyyy'), to_date('12-04-2024', 'dd-mm-yyyy'), 'Processed', 4367361, 84657835);
commit;
prompt 100 records committed...
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (11738054, to_date('21-02-2023', 'dd-mm-yyyy'), to_date('27-11-2023', 'dd-mm-yyyy'), 'Processed', 2903624, 99402438);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (46056187, to_date('02-01-2023', 'dd-mm-yyyy'), to_date('09-02-2024', 'dd-mm-yyyy'), 'Pending', 8660626, 85682722);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (34535393, to_date('09-09-2022', 'dd-mm-yyyy'), to_date('28-09-2023', 'dd-mm-yyyy'), 'Completed', 7269388, 60928528);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (43480666, to_date('31-03-2023', 'dd-mm-yyyy'), to_date('26-07-2023', 'dd-mm-yyyy'), 'Delivered', 6420274, 97259537);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (75298852, to_date('29-01-2022', 'dd-mm-yyyy'), to_date('04-05-2023', 'dd-mm-yyyy'), 'Completed', 6202242, 97415593);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (96542903, to_date('23-01-2022', 'dd-mm-yyyy'), to_date('04-05-2023', 'dd-mm-yyyy'), 'Delivered', 5049540, 42142840);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (44768545, to_date('17-09-2022', 'dd-mm-yyyy'), to_date('01-11-2023', 'dd-mm-yyyy'), 'Completed', 9119432, 83480577);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (56836563, to_date('27-03-2023', 'dd-mm-yyyy'), to_date('24-02-2024', 'dd-mm-yyyy'), 'Pending', 3616686, 32877721);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (20549357, to_date('19-01-2023', 'dd-mm-yyyy'), to_date('01-03-2024', 'dd-mm-yyyy'), 'Delivered', 2115137, 11056490);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (96798843, to_date('12-01-2022', 'dd-mm-yyyy'), to_date('04-06-2023', 'dd-mm-yyyy'), 'Processed', 6596332, 44272847);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (19958698, to_date('27-02-2022', 'dd-mm-yyyy'), to_date('31-05-2023', 'dd-mm-yyyy'), 'Completed', 9001365, 61137958);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (48568747, to_date('16-01-2023', 'dd-mm-yyyy'), to_date('18-07-2023', 'dd-mm-yyyy'), 'Processed', 2492541, 86054195);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (32481650, to_date('29-04-2022', 'dd-mm-yyyy'), to_date('01-09-2023', 'dd-mm-yyyy'), 'Shipped', 8768264, 69372437);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (70133273, to_date('13-11-2022', 'dd-mm-yyyy'), to_date('19-05-2023', 'dd-mm-yyyy'), 'Processed', 1826373, 65702533);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (91194300, to_date('05-03-2022', 'dd-mm-yyyy'), to_date('04-09-2023', 'dd-mm-yyyy'), 'Delivered', 3218566, 32591990);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (71698994, to_date('06-05-2022', 'dd-mm-yyyy'), to_date('23-10-2023', 'dd-mm-yyyy'), 'Delivered', 8608134, 92355989);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (37166599, to_date('07-06-2022', 'dd-mm-yyyy'), to_date('07-10-2023', 'dd-mm-yyyy'), 'Processed', 3963775, 71358712);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (68841810, to_date('23-06-2022', 'dd-mm-yyyy'), to_date('29-02-2024', 'dd-mm-yyyy'), 'Processed', 1481297, 60843836);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (41812723, to_date('12-12-2022', 'dd-mm-yyyy'), to_date('16-02-2024', 'dd-mm-yyyy'), 'Processed', 1631928, 96178588);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (39008956, to_date('12-07-2022', 'dd-mm-yyyy'), to_date('04-05-2023', 'dd-mm-yyyy'), 'Completed', 6967122, 23250655);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (72132403, to_date('10-10-2022', 'dd-mm-yyyy'), to_date('24-11-2023', 'dd-mm-yyyy'), 'Shipped', 780367, 34424868);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (27057960, to_date('30-10-2022', 'dd-mm-yyyy'), to_date('06-08-2023', 'dd-mm-yyyy'), 'Shipped', 5191432, 33314613);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (83278061, to_date('30-10-2022', 'dd-mm-yyyy'), to_date('04-04-2024', 'dd-mm-yyyy'), 'Delivered', 1505143, 12074999);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (61625775, to_date('01-08-2022', 'dd-mm-yyyy'), to_date('18-03-2024', 'dd-mm-yyyy'), 'Shipped', 159973, 90862878);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (94869357, to_date('22-09-2022', 'dd-mm-yyyy'), to_date('14-08-2023', 'dd-mm-yyyy'), 'Delivered', 9970693, 34017820);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (27202333, to_date('27-02-2022', 'dd-mm-yyyy'), to_date('03-03-2024', 'dd-mm-yyyy'), 'Processed', 6322552, 54088195);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (10498218, to_date('24-11-2022', 'dd-mm-yyyy'), to_date('07-04-2024', 'dd-mm-yyyy'), 'Shipped', 7365426, 34424868);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (34972793, to_date('15-02-2022', 'dd-mm-yyyy'), to_date('02-02-2024', 'dd-mm-yyyy'), 'Completed', 978766, 17634484);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (24977793, to_date('28-09-2022', 'dd-mm-yyyy'), to_date('04-04-2024', 'dd-mm-yyyy'), 'Pending', 2455633, 96835597);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (68241221, to_date('09-12-2022', 'dd-mm-yyyy'), to_date('20-03-2024', 'dd-mm-yyyy'), 'Delivered', 9007035, 21498697);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (35880175, to_date('31-05-2022', 'dd-mm-yyyy'), to_date('25-01-2024', 'dd-mm-yyyy'), 'Processed', 2688335, 72032008);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (35627737, to_date('10-01-2022', 'dd-mm-yyyy'), to_date('18-08-2023', 'dd-mm-yyyy'), 'Completed', 6723503, 37316644);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (45766106, to_date('07-09-2022', 'dd-mm-yyyy'), to_date('06-11-2023', 'dd-mm-yyyy'), 'Processed', 2406533, 82736622);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (49767001, to_date('16-06-2022', 'dd-mm-yyyy'), to_date('03-08-2023', 'dd-mm-yyyy'), 'Delivered', 9001365, 28411817);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (78875875, to_date('04-09-2022', 'dd-mm-yyyy'), to_date('07-12-2023', 'dd-mm-yyyy'), 'Processed', 2948580, 65891332);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (63564977, to_date('22-03-2022', 'dd-mm-yyyy'), to_date('21-09-2023', 'dd-mm-yyyy'), 'Completed', 5543353, 20344983);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (11141992, to_date('12-12-2022', 'dd-mm-yyyy'), to_date('23-12-2023', 'dd-mm-yyyy'), 'Shipped', 4338006, 20344983);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (70131212, to_date('12-11-2022', 'dd-mm-yyyy'), to_date('27-09-2023', 'dd-mm-yyyy'), 'Completed', 6083817, 54670908);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (53729095, to_date('01-02-2022', 'dd-mm-yyyy'), to_date('08-06-2023', 'dd-mm-yyyy'), 'Completed', 4367361, 34017820);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (27244804, to_date('20-02-2022', 'dd-mm-yyyy'), to_date('29-08-2023', 'dd-mm-yyyy'), 'Delivered', 803056, 61137958);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (89282429, to_date('03-06-2022', 'dd-mm-yyyy'), to_date('08-12-2023', 'dd-mm-yyyy'), 'Completed', 7973877, 12074999);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (17866964, to_date('23-03-2023', 'dd-mm-yyyy'), to_date('24-10-2023', 'dd-mm-yyyy'), 'Pending', 978766, 99402438);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (69806554, to_date('30-03-2023', 'dd-mm-yyyy'), to_date('18-05-2023', 'dd-mm-yyyy'), 'Shipped', 1638835, 71061207);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (32794409, to_date('26-04-2023', 'dd-mm-yyyy'), to_date('16-08-2023', 'dd-mm-yyyy'), 'Pending', 351581, 59279749);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (48487980, to_date('25-03-2023', 'dd-mm-yyyy'), to_date('09-06-2023', 'dd-mm-yyyy'), 'Completed', 1696477, 71358712);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (71017467, to_date('10-04-2022', 'dd-mm-yyyy'), to_date('14-02-2024', 'dd-mm-yyyy'), 'Completed', 1631928, 97578691);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (32108471, to_date('29-06-2022', 'dd-mm-yyyy'), to_date('08-10-2023', 'dd-mm-yyyy'), 'Delivered', 1904641, 55819347);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (92660307, to_date('17-08-2022', 'dd-mm-yyyy'), to_date('30-09-2023', 'dd-mm-yyyy'), 'Pending', 8660626, 63442847);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (46023720, to_date('28-12-2022', 'dd-mm-yyyy'), to_date('25-11-2023', 'dd-mm-yyyy'), 'Processed', 6420274, 94249883);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (86148845, to_date('22-08-2022', 'dd-mm-yyyy'), to_date('26-09-2023', 'dd-mm-yyyy'), 'Completed', 1696477, 97415593);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (86672432, to_date('28-12-2022', 'dd-mm-yyyy'), to_date('27-09-2023', 'dd-mm-yyyy'), 'Pending', 5840293, 99402438);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (35352016, to_date('18-02-2023', 'dd-mm-yyyy'), to_date('14-06-2023', 'dd-mm-yyyy'), 'Delivered', 3432237, 16752796);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (53070769, to_date('07-03-2022', 'dd-mm-yyyy'), to_date('05-12-2023', 'dd-mm-yyyy'), 'Shipped', 2406533, 90862878);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (16725326, to_date('16-01-2023', 'dd-mm-yyyy'), to_date('13-10-2023', 'dd-mm-yyyy'), 'Completed', 4233028, 61154579);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (17981118, to_date('01-06-2022', 'dd-mm-yyyy'), to_date('18-06-2023', 'dd-mm-yyyy'), 'Delivered', 2271187, 43265993);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (66807252, to_date('14-07-2022', 'dd-mm-yyyy'), to_date('12-06-2023', 'dd-mm-yyyy'), 'Processed', 292431, 20315447);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (81358060, to_date('14-04-2022', 'dd-mm-yyyy'), to_date('01-04-2024', 'dd-mm-yyyy'), 'Pending', 5543353, 47712085);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (64160828, to_date('21-04-2022', 'dd-mm-yyyy'), to_date('13-12-2023', 'dd-mm-yyyy'), 'Processed', 6322552, 48576763);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (32436619, to_date('05-02-2022', 'dd-mm-yyyy'), to_date('06-11-2023', 'dd-mm-yyyy'), 'Shipped', 7256087, 23320965);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (68022210, to_date('17-03-2023', 'dd-mm-yyyy'), to_date('10-04-2024', 'dd-mm-yyyy'), 'Processed', 1585041, 51638591);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (25584000, to_date('25-04-2023', 'dd-mm-yyyy'), to_date('28-11-2023', 'dd-mm-yyyy'), 'Processed', 5278598, 17634484);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (48805566, to_date('18-01-2022', 'dd-mm-yyyy'), to_date('29-12-2023', 'dd-mm-yyyy'), 'Shipped', 351581, 15585992);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (98238957, to_date('17-07-2022', 'dd-mm-yyyy'), to_date('21-07-2023', 'dd-mm-yyyy'), 'Pending', 4850906, 13867485);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (48528200, to_date('22-09-2022', 'dd-mm-yyyy'), to_date('31-10-2023', 'dd-mm-yyyy'), 'Pending', 7330138, 20191024);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (77380207, to_date('25-07-2022', 'dd-mm-yyyy'), to_date('12-06-2023', 'dd-mm-yyyy'), 'Completed', 2704067, 63861534);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (60148420, to_date('21-04-2022', 'dd-mm-yyyy'), to_date('28-06-2023', 'dd-mm-yyyy'), 'Shipped', 8193198, 81969040);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (61218313, to_date('20-02-2023', 'dd-mm-yyyy'), to_date('13-04-2024', 'dd-mm-yyyy'), 'Pending', 1491551, 87982560);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (92123288, to_date('07-06-2022', 'dd-mm-yyyy'), to_date('22-08-2023', 'dd-mm-yyyy'), 'Delivered', 6960451, 48870120);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (45496635, to_date('03-12-2022', 'dd-mm-yyyy'), to_date('23-03-2024', 'dd-mm-yyyy'), 'Processed', 7922953, 39403818);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (45002614, to_date('10-02-2022', 'dd-mm-yyyy'), to_date('25-11-2023', 'dd-mm-yyyy'), 'Delivered', 4367361, 84360223);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (28042256, to_date('17-03-2022', 'dd-mm-yyyy'), to_date('29-12-2023', 'dd-mm-yyyy'), 'Delivered', 482226, 54670908);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (36160443, to_date('25-09-2022', 'dd-mm-yyyy'), to_date('29-11-2023', 'dd-mm-yyyy'), 'Completed', 2271187, 75426354);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (80888742, to_date('28-01-2023', 'dd-mm-yyyy'), to_date('16-04-2024', 'dd-mm-yyyy'), 'Completed', 8193198, 35281037);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (51601257, to_date('27-07-2022', 'dd-mm-yyyy'), to_date('14-01-2024', 'dd-mm-yyyy'), 'Processed', 4567629, 37207125);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (97017792, to_date('26-02-2023', 'dd-mm-yyyy'), to_date('04-05-2023', 'dd-mm-yyyy'), 'Pending', 5762208, 71110942);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (97920142, to_date('07-04-2023', 'dd-mm-yyyy'), to_date('18-11-2023', 'dd-mm-yyyy'), 'Delivered', 3343934, 93869133);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (13868615, to_date('19-10-2022', 'dd-mm-yyyy'), to_date('13-03-2024', 'dd-mm-yyyy'), 'Completed', 9001365, 65892682);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (76158359, to_date('16-03-2023', 'dd-mm-yyyy'), to_date('03-08-2023', 'dd-mm-yyyy'), 'Pending', 3343934, 64103674);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (51464467, to_date('23-08-2022', 'dd-mm-yyyy'), to_date('21-07-2023', 'dd-mm-yyyy'), 'Pending', 978766, 69517856);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (39958423, to_date('24-01-2023', 'dd-mm-yyyy'), to_date('14-02-2024', 'dd-mm-yyyy'), 'Pending', 6295224, 23320965);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (50211760, to_date('27-04-2022', 'dd-mm-yyyy'), to_date('24-03-2024', 'dd-mm-yyyy'), 'Shipped', 482226, 94146730);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (98703687, to_date('06-01-2022', 'dd-mm-yyyy'), to_date('22-11-2023', 'dd-mm-yyyy'), 'Pending', 9007035, 90745803);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (41075811, to_date('03-10-2022', 'dd-mm-yyyy'), to_date('16-06-2023', 'dd-mm-yyyy'), 'Processed', 9873954, 78216572);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (40461955, to_date('23-04-2023', 'dd-mm-yyyy'), to_date('19-10-2023', 'dd-mm-yyyy'), 'Shipped', 3218566, 97578691);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (73678322, to_date('23-02-2023', 'dd-mm-yyyy'), to_date('07-02-2024', 'dd-mm-yyyy'), 'Delivered', 1423691, 28740228);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (67345461, to_date('09-04-2023', 'dd-mm-yyyy'), to_date('02-01-2024', 'dd-mm-yyyy'), 'Completed', 1491551, 54088195);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (87798520, to_date('27-09-2022', 'dd-mm-yyyy'), to_date('21-05-2023', 'dd-mm-yyyy'), 'Delivered', 3752109, 15326270);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (71371841, to_date('16-01-2023', 'dd-mm-yyyy'), to_date('21-02-2024', 'dd-mm-yyyy'), 'Pending', 7269388, 15585992);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (17247861, to_date('14-05-2022', 'dd-mm-yyyy'), to_date('24-02-2024', 'dd-mm-yyyy'), 'Delivered', 3752109, 86054195);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (31785393, to_date('09-01-2022', 'dd-mm-yyyy'), to_date('17-09-2023', 'dd-mm-yyyy'), 'Pending', 3863212, 76928249);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (87988358, to_date('03-11-2022', 'dd-mm-yyyy'), to_date('27-04-2024', 'dd-mm-yyyy'), 'Shipped', 6925930, 97415593);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (49885578, to_date('18-08-2022', 'dd-mm-yyyy'), to_date('13-10-2023', 'dd-mm-yyyy'), 'Completed', 351581, 92535882);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (99283105, to_date('07-06-2022', 'dd-mm-yyyy'), to_date('30-09-2023', 'dd-mm-yyyy'), 'Processed', 4338006, 37031324);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (59195808, to_date('18-01-2022', 'dd-mm-yyyy'), to_date('15-01-2024', 'dd-mm-yyyy'), 'Pending', 2688335, 21509784);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (38245386, to_date('20-01-2022', 'dd-mm-yyyy'), to_date('01-07-2023', 'dd-mm-yyyy'), 'Completed', 7602134, 65891332);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (93238641, to_date('02-12-2022', 'dd-mm-yyyy'), to_date('17-05-2023', 'dd-mm-yyyy'), 'Delivered', 4782431, 36373252);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (15407639, to_date('04-03-2022', 'dd-mm-yyyy'), to_date('18-07-2023', 'dd-mm-yyyy'), 'Delivered', 9016717, 77642002);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (39764009, to_date('01-12-2022', 'dd-mm-yyyy'), to_date('16-09-2023', 'dd-mm-yyyy'), 'Processed', 1616443, 52282046);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (80012686, to_date('16-01-2022', 'dd-mm-yyyy'), to_date('12-04-2024', 'dd-mm-yyyy'), 'Shipped', 4540426, 92535882);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (55211525, to_date('03-10-2022', 'dd-mm-yyyy'), to_date('19-08-2023', 'dd-mm-yyyy'), 'Shipped', 4008284, 19321854);
commit;
prompt 200 records committed...
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (54558007, to_date('05-04-2022', 'dd-mm-yyyy'), to_date('31-01-2024', 'dd-mm-yyyy'), 'Delivered', 6922656, 55819347);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (79125714, to_date('13-12-2022', 'dd-mm-yyyy'), to_date('01-10-2023', 'dd-mm-yyyy'), 'Pending', 6587945, 83177693);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (83642274, to_date('12-10-2022', 'dd-mm-yyyy'), to_date('05-12-2023', 'dd-mm-yyyy'), 'Pending', 2472311, 17634484);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (17220217, to_date('06-01-2022', 'dd-mm-yyyy'), to_date('10-01-2024', 'dd-mm-yyyy'), 'Delivered', 5049540, 20315447);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (36319648, to_date('10-02-2022', 'dd-mm-yyyy'), to_date('18-09-2023', 'dd-mm-yyyy'), 'Delivered', 1387914, 35963572);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (24491649, to_date('06-07-2022', 'dd-mm-yyyy'), to_date('12-11-2023', 'dd-mm-yyyy'), 'Shipped', 6516848, 17963068);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (95883854, to_date('06-01-2022', 'dd-mm-yyyy'), to_date('17-07-2023', 'dd-mm-yyyy'), 'Pending', 3963775, 43599881);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (72580041, to_date('08-09-2022', 'dd-mm-yyyy'), to_date('22-01-2024', 'dd-mm-yyyy'), 'Delivered', 6295224, 20315447);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (90949868, to_date('21-02-2023', 'dd-mm-yyyy'), to_date('25-05-2023', 'dd-mm-yyyy'), 'Processed', 3218566, 20113136);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (16160718, to_date('26-01-2022', 'dd-mm-yyyy'), to_date('18-08-2023', 'dd-mm-yyyy'), 'Delivered', 5607773, 41522255);
insert into AIR_ORDER (orderid, orderdate, deliverydate, status, totalamount, customerid)
values (1, to_date('21-06-2024 10:43:13', 'dd-mm-yyyy hh24:mi:ss'), to_date('11-07-2024 10:43:13', 'dd-mm-yyyy hh24:mi:ss'), 'Delivered', 200, 1);
commit;
prompt 211 records loaded
prompt Loading PRODUCT...
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (75289000, 'S-400 Missile System', 'Surface-to-Air Missiles', 6516848, 'Armor-penetrating capability for ground targets', 476971);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (74564581, 'Stinger Missile', 'Anti-Tank Missiles', 1357093, 'Armor-penetrating capability for ground targets', 789205);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (91234132, 'Stinger Missile', 'Anti-Tank Missiles', 5650110, 'High-precision targeting for aerial threats', 835069);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (47301842, 'Javelin Missile', 'Surface-to-Air Missiles', 6322552, 'Armor-penetrating capability for ground targets', 862952);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (32341993, 'Iron Dome', 'Defense Systems', 1826373, 'Comprehensive protection and surveillance', 409995);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (10215771, 'Hellfire Missile', 'Anti-Tank Missiles', 7269388, 'Comprehensive protection and surveillance', 722527);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (38677145, 'S-400 Missile System', 'Surface-to-Air Missiles', 2115137, 'High-precision targeting for aerial threats', 501406);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (23467437, 'S-400 Missile System', 'Defense Systems', 2903624, 'High-precision targeting for aerial threats', 887912);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (15190791, 'S-400 Missile System', 'Surface-to-Air Missiles', 1423691, 'Comprehensive protection and surveillance', 462293);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (12663198, 'Patriot Missile System', 'Surface-to-Air Missiles', 6523155, 'High-precision targeting for aerial threats', 985064);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (17531192, 'Iron Dome', 'Surface-to-Air Missiles', 9516154, 'High-precision targeting for aerial threats', 483222);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (37388026, 'Patriot Missile System', 'Defense Systems', 482226, 'Comprehensive protection and surveillance', 382208);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (48999849, 'Iron Dome', 'Defense Systems', 842169, 'Armor-penetrating capability for ground targets', 522081);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (85217351, 'Stinger Missile', 'Defense Systems', 8885480, 'High-precision targeting for aerial threats', 385699);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (19314312, 'Javelin Missile', 'Surface-to-Air Missiles', 306874, 'Comprehensive protection and surveillance', 519961);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (84488662, 'Stinger Missile', 'Surface-to-Air Missiles', 328811, 'Comprehensive protection and surveillance', 261079);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (74708898, 'S-400 Missile System', 'Defense Systems', 8136904, 'High-precision targeting for aerial threats', 293797);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (41614135, 'Harpoon Missile', 'Defense Systems', 8179153, 'High-precision targeting for aerial threats', 594953);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (91404530, 'SM-6 (Standard Missile-6)', 'Anti-Tank Missiles', 4072052, 'Armor-penetrating capability for ground targets', 746389);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (51215515, 'S-400 Missile System', 'Surface-to-Air Missiles', 6960451, 'High-precision targeting for aerial threats', 763313);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (26978984, 'Stinger Missile', 'Surface-to-Air Missiles', 6287307, 'Armor-penetrating capability for ground targets', 284433);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (39862525, 'Iron Dome', 'Surface-to-Air Missiles', 6587945, 'Armor-penetrating capability for ground targets', 521931);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (56668763, 'S-400 Missile System', 'Anti-Tank Missiles', 4524958, 'High-precision targeting for aerial threats', 585178);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (26696031, 'SM-6 (Standard Missile-6)', 'Defense Systems', 6967998, 'Comprehensive protection and surveillance', 984447);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (74133872, 'Harpoon Missile', 'Defense Systems', 5191432, 'Comprehensive protection and surveillance', 102357);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (86717227, 'Patriot Missile System', 'Surface-to-Air Missiles', 2455633, 'High-precision targeting for aerial threats', 503777);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (48716725, 'Patriot Missile System', 'Anti-Tank Missiles', 2948580, 'Armor-penetrating capability for ground targets', 951979);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (35024086, 'Iron Dome', 'Anti-Tank Missiles', 436971, 'Comprehensive protection and surveillance', 222471);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (53726451, 'Harpoon Missile', 'Surface-to-Air Missiles', 2704067, 'Comprehensive protection and surveillance', 68647);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (42776326, 'THAAD (Terminal High Altitude Area Defense)', 'Surface-to-Air Missiles', 978766, 'Comprehensive protection and surveillance', 307630);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (62779835, 'Aegis Combat System', 'Anti-Tank Missiles', 580588, 'Armor-penetrating capability for ground targets', 773001);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (88170142, 'Iron Dome', 'Anti-Tank Missiles', 5762208, 'Armor-penetrating capability for ground targets', 136032);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (83730147, 'SM-6 (Standard Missile-6)', 'Defense Systems', 3218566, 'Armor-penetrating capability for ground targets', 140917);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (38203950, 'Iron Dome', 'Defense Systems', 8193198, 'Comprehensive protection and surveillance', 945071);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (52215121, 'S-400 Missile System', 'Anti-Tank Missiles', 8842043, 'Armor-penetrating capability for ground targets', 815093);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (19516405, 'Javelin Missile', 'Defense Systems', 8156269, 'High-precision targeting for aerial threats', 715139);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (99355318, 'Iron Dome', 'Surface-to-Air Missiles', 4692439, 'High-precision targeting for aerial threats', 149643);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (39077924, 'Patriot Missile System', 'Defense Systems', 8254356, 'Comprehensive protection and surveillance', 299085);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (30634130, 'Stinger Missile', 'Defense Systems', 8209864, 'Armor-penetrating capability for ground targets', 828318);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (88016981, 'Patriot Missile System', 'Surface-to-Air Missiles', 351581, 'Comprehensive protection and surveillance', 64362);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (25490673, 'S-400 Missile System', 'Defense Systems', 3616686, 'Comprehensive protection and surveillance', 346994);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (94362422, 'Hellfire Missile', 'Defense Systems', 3211264, 'Armor-penetrating capability for ground targets', 563504);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (89656829, 'Iron Dome', 'Anti-Tank Missiles', 4233028, 'Armor-penetrating capability for ground targets', 1032);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (12983031, 'S-400 Missile System', 'Anti-Tank Missiles', 6596332, 'Armor-penetrating capability for ground targets', 998537);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (44769668, 'SM-6 (Standard Missile-6)', 'Defense Systems', 8028882, 'Armor-penetrating capability for ground targets', 268157);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (93505630, 'Harpoon Missile', 'Defense Systems', 6374316, 'High-precision targeting for aerial threats', 494968);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (62290517, 'Stinger Missile', 'Defense Systems', 2492541, 'Armor-penetrating capability for ground targets', 727462);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (39492928, 'Stinger Missile', 'Surface-to-Air Missiles', 844129, 'Armor-penetrating capability for ground targets', 450970);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (61261918, 'S-400 Missile System', 'Surface-to-Air Missiles', 9070014, 'Armor-penetrating capability for ground targets', 905171);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (24662398, 'S-400 Missile System', 'Anti-Tank Missiles', 9076802, 'Armor-penetrating capability for ground targets', 477376);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (91933726, 'Harpoon Missile', 'Surface-to-Air Missiles', 1505143, 'High-precision targeting for aerial threats', 687788);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (74427412, 'Stinger Missile', 'Anti-Tank Missiles', 6237387, 'Armor-penetrating capability for ground targets', 694138);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (69789600, 'S-400 Missile System', 'Anti-Tank Missiles', 185068, 'Armor-penetrating capability for ground targets', 193249);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (13541897, 'Stinger Missile', 'Anti-Tank Missiles', 9930179, 'Armor-penetrating capability for ground targets', 398837);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (37005131, 'Aegis Combat System', 'Surface-to-Air Missiles', 3570772, 'Armor-penetrating capability for ground targets', 240713);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (43129750, 'Aegis Combat System', 'Anti-Tank Missiles', 9584485, 'High-precision targeting for aerial threats', 372897);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (80868862, 'Patriot Missile System', 'Surface-to-Air Missiles', 4367361, 'High-precision targeting for aerial threats', 809607);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (52880276, 'S-400 Missile System', 'Surface-to-Air Missiles', 7573095, 'Comprehensive protection and surveillance', 341123);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (51197453, 'S-400 Missile System', 'Defense Systems', 3963775, 'High-precision targeting for aerial threats', 128550);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (26690888, 'Stinger Missile', 'Defense Systems', 7630660, 'Comprehensive protection and surveillance', 350177);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (51276228, 'Patriot Missile System', 'Anti-Tank Missiles', 546633, 'Armor-penetrating capability for ground targets', 284796);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (52538318, 'Harpoon Missile', 'Anti-Tank Missiles', 6414162, 'Armor-penetrating capability for ground targets', 81627);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (89356370, 'Javelin Missile', 'Surface-to-Air Missiles', 7967867, 'Comprehensive protection and surveillance', 494795);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (89859608, 'Stinger Missile', 'Defense Systems', 6922656, 'Armor-penetrating capability for ground targets', 365193);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (90240003, 'Hellfire Missile', 'Defense Systems', 6520876, 'High-precision targeting for aerial threats', 426526);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (30224096, 'Harpoon Missile', 'Defense Systems', 5668481, 'Comprehensive protection and surveillance', 407811);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (48984418, 'Javelin Missile', 'Defense Systems', 6454841, 'Armor-penetrating capability for ground targets', 214204);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (69577687, 'Aegis Combat System', 'Surface-to-Air Missiles', 6967122, 'Armor-penetrating capability for ground targets', 504143);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (41256682, 'Aegis Combat System', 'Defense Systems', 1631928, 'Armor-penetrating capability for ground targets', 55997);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (82840627, 'THAAD (Terminal High Altitude Area Defense)', 'Surface-to-Air Missiles', 1387914, 'High-precision targeting for aerial threats', 244161);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (97369900, 'Hellfire Missile', 'Surface-to-Air Missiles', 9007035, 'Comprehensive protection and surveillance', 535376);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (44140050, 'Stinger Missile', 'Defense Systems', 6282765, 'Comprehensive protection and surveillance', 483415);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (59532354, 'Javelin Missile', 'Surface-to-Air Missiles', 5984801, 'Comprehensive protection and surveillance', 56725);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (48458535, 'S-400 Missile System', 'Surface-to-Air Missiles', 1485108, 'Armor-penetrating capability for ground targets', 591640);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (14340793, 'Aegis Combat System', 'Anti-Tank Missiles', 5883534, 'High-precision targeting for aerial threats', 35828);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (42979930, 'Patriot Missile System', 'Anti-Tank Missiles', 1646242, 'Comprehensive protection and surveillance', 745286);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (25049109, 'THAAD (Terminal High Altitude Area Defense)', 'Surface-to-Air Missiles', 9310771, 'Armor-penetrating capability for ground targets', 735872);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (28913698, 'Harpoon Missile', 'Surface-to-Air Missiles', 4251269, 'High-precision targeting for aerial threats', 279641);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (70643652, 'S-400 Missile System', 'Defense Systems', 7330138, 'Comprehensive protection and surveillance', 889573);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (77079019, 'Aegis Combat System', 'Defense Systems', 331811, 'Comprehensive protection and surveillance', 366129);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (41256443, 'THAAD (Terminal High Altitude Area Defense)', 'Defense Systems', 6874215, 'Armor-penetrating capability for ground targets', 498071);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (63029913, 'Harpoon Missile', 'Surface-to-Air Missiles', 9667683, 'Comprehensive protection and surveillance', 530442);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (21947518, 'SM-6 (Standard Missile-6)', 'Surface-to-Air Missiles', 1833073, 'High-precision targeting for aerial threats', 447198);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (40002629, 'Javelin Missile', 'Defense Systems', 5744731, 'Armor-penetrating capability for ground targets', 777112);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (39387669, 'SM-6 (Standard Missile-6)', 'Defense Systems', 3823193, 'Comprehensive protection and surveillance', 831759);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (30466546, 'Hellfire Missile', 'Surface-to-Air Missiles', 4110994, 'High-precision targeting for aerial threats', 336155);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (88472823, 'THAAD (Terminal High Altitude Area Defense)', 'Defense Systems', 1616443, 'Armor-penetrating capability for ground targets', 128445);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (19559845, 'THAAD (Terminal High Altitude Area Defense)', 'Surface-to-Air Missiles', 6148409, 'Comprehensive protection and surveillance', 297407);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (18401315, 'SM-6 (Standard Missile-6)', 'Surface-to-Air Missiles', 7783788, 'Comprehensive protection and surveillance', 608001);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (56191191, 'Harpoon Missile', 'Surface-to-Air Missiles', 7552221, 'High-precision targeting for aerial threats', 648184);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (50245297, 'Stinger Missile', 'Surface-to-Air Missiles', 7083454, 'Armor-penetrating capability for ground targets', 627284);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (30088684, 'THAAD (Terminal High Altitude Area Defense)', 'Defense Systems', 6085300, 'Armor-penetrating capability for ground targets', 479886);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (20547539, 'THAAD (Terminal High Altitude Area Defense)', 'Surface-to-Air Missiles', 9698190, 'High-precision targeting for aerial threats', 691820);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (65577326, 'S-400 Missile System', 'Surface-to-Air Missiles', 5049540, 'Armor-penetrating capability for ground targets', 379172);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (57974874, 'Javelin Missile', 'Surface-to-Air Missiles', 9001365, 'Armor-penetrating capability for ground targets', 429498);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (65366250, 'Stinger Missile', 'Defense Systems', 1491551, 'Comprehensive protection and surveillance', 269330);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (22559530, 'Stinger Missile', 'Anti-Tank Missiles', 2406533, 'High-precision targeting for aerial threats', 866023);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (20126969, 'Patriot Missile System', 'Anti-Tank Missiles', 134798, 'Comprehensive protection and surveillance', 217463);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (99559600, 'Hellfire Missile', 'Anti-Tank Missiles', 8630203, 'Armor-penetrating capability for ground targets', 642752);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (22143889, 'Hellfire Missile', 'Surface-to-Air Missiles', 7405404, 'High-precision targeting for aerial threats', 973129);
commit;
prompt 100 records committed...
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (12469913, 'Harpoon Missile', 'Surface-to-Air Missiles', 7272475, 'Armor-penetrating capability for ground targets', 67533);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (23818335, 'SM-6 (Standard Missile-6)', 'Anti-Tank Missiles', 1993792, 'Comprehensive protection and surveillance', 254044);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (12214534, 'Harpoon Missile', 'Surface-to-Air Missiles', 6295224, 'Comprehensive protection and surveillance', 139182);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (34307347, 'Stinger Missile', 'Defense Systems', 9569344, 'Armor-penetrating capability for ground targets', 44486);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (72052162, 'THAAD (Terminal High Altitude Area Defense)', 'Anti-Tank Missiles', 9852545, 'High-precision targeting for aerial threats', 936214);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (30078490, 'Iron Dome', 'Defense Systems', 5840293, 'Comprehensive protection and surveillance', 422010);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (40225662, 'Hellfire Missile', 'Surface-to-Air Missiles', 7903122, 'Comprehensive protection and surveillance', 10463);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (47661926, 'Aegis Combat System', 'Anti-Tank Missiles', 8225996, 'Armor-penetrating capability for ground targets', 678121);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (14886998, 'Hellfire Missile', 'Defense Systems', 2609222, 'High-precision targeting for aerial threats', 676200);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (49381009, 'Hellfire Missile', 'Anti-Tank Missiles', 6083817, 'High-precision targeting for aerial threats', 748507);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (48328796, 'Harpoon Missile', 'Surface-to-Air Missiles', 9801992, 'Comprehensive protection and surveillance', 335394);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (75342639, 'Harpoon Missile', 'Surface-to-Air Missiles', 5607773, 'Armor-penetrating capability for ground targets', 218472);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (20053802, 'Harpoon Missile', 'Defense Systems', 5967767, 'High-precision targeting for aerial threats', 229723);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (47468634, 'THAAD (Terminal High Altitude Area Defense)', 'Surface-to-Air Missiles', 2691150, 'High-precision targeting for aerial threats', 419190);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (90713485, 'THAAD (Terminal High Altitude Area Defense)', 'Surface-to-Air Missiles', 1585041, 'High-precision targeting for aerial threats', 259973);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (53849368, 'Iron Dome', 'Defense Systems', 6420274, 'High-precision targeting for aerial threats', 380400);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (11447018, 'Aegis Combat System', 'Surface-to-Air Missiles', 8316821, 'Comprehensive protection and surveillance', 763441);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (74200926, 'Aegis Combat System', 'Surface-to-Air Missiles', 741619, 'Comprehensive protection and surveillance', 655177);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (85651918, 'S-400 Missile System', 'Surface-to-Air Missiles', 6638044, 'Armor-penetrating capability for ground targets', 389975);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (19707019, 'Aegis Combat System', 'Surface-to-Air Missiles', 1619437, 'Comprehensive protection and surveillance', 282392);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (32717559, 'Javelin Missile', 'Defense Systems', 3152728, 'Armor-penetrating capability for ground targets', 467267);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (83026924, 'Stinger Missile', 'Anti-Tank Missiles', 3176117, 'High-precision targeting for aerial threats', 402499);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (35752835, 'Harpoon Missile', 'Surface-to-Air Missiles', 2030565, 'Comprehensive protection and surveillance', 496033);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (66750680, 'THAAD (Terminal High Altitude Area Defense)', 'Defense Systems', 4782431, 'Comprehensive protection and surveillance', 292262);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (87839213, 'Patriot Missile System', 'Anti-Tank Missiles', 4567629, 'Comprehensive protection and surveillance', 665697);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (71082803, 'Patriot Missile System', 'Anti-Tank Missiles', 6639880, 'Armor-penetrating capability for ground targets', 834055);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (73840426, 'Patriot Missile System', 'Defense Systems', 4850906, 'Comprehensive protection and surveillance', 531212);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (84035773, 'Iron Dome', 'Defense Systems', 2472311, 'Armor-penetrating capability for ground targets', 685357);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (77300053, 'Javelin Missile', 'Defense Systems', 1481297, 'Comprehensive protection and surveillance', 241636);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (89914525, 'Harpoon Missile', 'Anti-Tank Missiles', 419004, 'High-precision targeting for aerial threats', 664066);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (64458245, 'Aegis Combat System', 'Surface-to-Air Missiles', 8184827, 'Comprehensive protection and surveillance', 961090);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (84373216, 'Patriot Missile System', 'Surface-to-Air Missiles', 6696408, 'Armor-penetrating capability for ground targets', 115259);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (99918838, 'Stinger Missile', 'Surface-to-Air Missiles', 9016717, 'Armor-penetrating capability for ground targets', 372729);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (36825500, 'S-400 Missile System', 'Anti-Tank Missiles', 8070720, 'Comprehensive protection and surveillance', 275025);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (20998110, 'SM-6 (Standard Missile-6)', 'Anti-Tank Missiles', 4338006, 'High-precision targeting for aerial threats', 406337);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (43489575, 'THAAD (Terminal High Altitude Area Defense)', 'Defense Systems', 1558488, 'Comprehensive protection and surveillance', 896988);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (40286424, 'Stinger Missile', 'Defense Systems', 9119432, 'Comprehensive protection and surveillance', 580188);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (36849239, 'Iron Dome', 'Surface-to-Air Missiles', 3447425, 'Armor-penetrating capability for ground targets', 657154);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (78454014, 'Iron Dome', 'Defense Systems', 6202242, 'Armor-penetrating capability for ground targets', 597788);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (59812221, 'THAAD (Terminal High Altitude Area Defense)', 'Surface-to-Air Missiles', 1904641, 'Armor-penetrating capability for ground targets', 102704);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (61832164, 'Aegis Combat System', 'Anti-Tank Missiles', 8120620, 'Comprehensive protection and surveillance', 90119);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (65347015, 'Harpoon Missile', 'Defense Systems', 8014443, 'Comprehensive protection and surveillance', 160354);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (21801026, 'Javelin Missile', 'Anti-Tank Missiles', 7365426, 'High-precision targeting for aerial threats', 644027);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (24879490, 'Javelin Missile', 'Surface-to-Air Missiles', 6162934, 'High-precision targeting for aerial threats', 469912);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (25515323, 'Iron Dome', 'Anti-Tank Missiles', 3343934, 'Comprehensive protection and surveillance', 507353);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (71230512, 'SM-6 (Standard Missile-6)', 'Anti-Tank Missiles', 3161558, 'High-precision targeting for aerial threats', 58658);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (79999204, 'Hellfire Missile', 'Defense Systems', 9665246, 'High-precision targeting for aerial threats', 611462);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (64375833, 'Iron Dome', 'Surface-to-Air Missiles', 1776811, 'Comprehensive protection and surveillance', 122165);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (84141477, 'THAAD (Terminal High Altitude Area Defense)', 'Defense Systems', 7256087, 'Comprehensive protection and surveillance', 801770);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (60809489, 'Iron Dome', 'Defense Systems', 4008284, 'High-precision targeting for aerial threats', 927189);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (15622495, 'Iron Dome', 'Defense Systems', 9286649, 'High-precision targeting for aerial threats', 416905);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (39791976, 'Javelin Missile', 'Surface-to-Air Missiles', 3432237, 'High-precision targeting for aerial threats', 102265);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (22303921, 'THAAD (Terminal High Altitude Area Defense)', 'Surface-to-Air Missiles', 461191, 'Armor-penetrating capability for ground targets', 607130);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (52264429, 'THAAD (Terminal High Altitude Area Defense)', 'Defense Systems', 7602887, 'High-precision targeting for aerial threats', 831607);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (20112645, 'Harpoon Missile', 'Anti-Tank Missiles', 803056, 'Armor-penetrating capability for ground targets', 32647);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (90710076, 'Patriot Missile System', 'Surface-to-Air Missiles', 5278598, 'Comprehensive protection and surveillance', 717968);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (41950079, 'THAAD (Terminal High Altitude Area Defense)', 'Surface-to-Air Missiles', 1638835, 'High-precision targeting for aerial threats', 832403);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (80744202, 'Aegis Combat System', 'Surface-to-Air Missiles', 3615162, 'Armor-penetrating capability for ground targets', 330064);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (84658104, 'Aegis Combat System', 'Defense Systems', 9061313, 'Comprehensive protection and surveillance', 4039);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (57713878, 'Harpoon Missile', 'Defense Systems', 5543353, 'High-precision targeting for aerial threats', 700189);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (23572903, 'Javelin Missile', 'Anti-Tank Missiles', 6925930, 'Comprehensive protection and surveillance', 585590);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (74088715, 'Aegis Combat System', 'Surface-to-Air Missiles', 7922953, 'Armor-penetrating capability for ground targets', 287660);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (96697932, 'Iron Dome', 'Defense Systems', 410415, 'Comprehensive protection and surveillance', 279570);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (35923869, 'Iron Dome', 'Defense Systems', 4540426, 'High-precision targeting for aerial threats', 173699);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (53027287, 'Harpoon Missile', 'Defense Systems', 6642292, 'Comprehensive protection and surveillance', 410061);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (49176575, 'SM-6 (Standard Missile-6)', 'Defense Systems', 292431, 'High-precision targeting for aerial threats', 503392);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (32050706, 'Harpoon Missile', 'Defense Systems', 9873954, 'Comprehensive protection and surveillance', 353442);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (79157436, 'Javelin Missile', 'Defense Systems', 5772361, 'High-precision targeting for aerial threats', 440336);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (53971468, 'Aegis Combat System', 'Anti-Tank Missiles', 159973, 'High-precision targeting for aerial threats', 833373);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (88897737, 'SM-6 (Standard Missile-6)', 'Surface-to-Air Missiles', 3752109, 'High-precision targeting for aerial threats', 149611);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (62668426, 'Aegis Combat System', 'Anti-Tank Missiles', 9066342, 'High-precision targeting for aerial threats', 720654);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (44714020, 'Patriot Missile System', 'Anti-Tank Missiles', 326217, 'High-precision targeting for aerial threats', 574700);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (55933435, 'THAAD (Terminal High Altitude Area Defense)', 'Surface-to-Air Missiles', 8916353, 'High-precision targeting for aerial threats', 228606);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (99751170, 'Patriot Missile System', 'Surface-to-Air Missiles', 8660626, 'Armor-penetrating capability for ground targets', 23972);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (40015420, 'Patriot Missile System', 'Defense Systems', 9852763, 'Comprehensive protection and surveillance', 644573);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (28785276, 'Patriot Missile System', 'Surface-to-Air Missiles', 3863212, 'Comprehensive protection and surveillance', 832364);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (18002334, 'Harpoon Missile', 'Defense Systems', 8370975, 'High-precision targeting for aerial threats', 988188);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (70067503, 'Hellfire Missile', 'Surface-to-Air Missiles', 8768264, 'Armor-penetrating capability for ground targets', 613887);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (64072253, 'Iron Dome', 'Anti-Tank Missiles', 7752888, 'Armor-penetrating capability for ground targets', 237019);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (42490226, 'S-400 Missile System', 'Surface-to-Air Missiles', 7602134, 'Armor-penetrating capability for ground targets', 870571);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (18144872, 'Aegis Combat System', 'Surface-to-Air Missiles', 6606129, 'High-precision targeting for aerial threats', 10223);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (18856689, 'Iron Dome', 'Surface-to-Air Missiles', 772221, 'High-precision targeting for aerial threats', 973483);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (67964630, 'Patriot Missile System', 'Surface-to-Air Missiles', 2688335, 'Armor-penetrating capability for ground targets', 850836);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (98535418, 'Iron Dome', 'Defense Systems', 1696477, 'Armor-penetrating capability for ground targets', 781440);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (88146731, 'Harpoon Missile', 'Surface-to-Air Missiles', 2271187, 'High-precision targeting for aerial threats', 497318);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (85280659, 'S-400 Missile System', 'Anti-Tank Missiles', 6765636, 'Armor-penetrating capability for ground targets', 413047);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (38217305, 'Harpoon Missile', 'Surface-to-Air Missiles', 7973877, 'Armor-penetrating capability for ground targets', 784978);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (78500077, 'Javelin Missile', 'Anti-Tank Missiles', 1705344, 'Armor-penetrating capability for ground targets', 937670);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (54178963, 'Harpoon Missile', 'Surface-to-Air Missiles', 9970693, 'Armor-penetrating capability for ground targets', 67914);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (38750975, 'SM-6 (Standard Missile-6)', 'Defense Systems', 780367, 'Comprehensive protection and surveillance', 988);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (60632985, 'Iron Dome', 'Anti-Tank Missiles', 7952412, 'Comprehensive protection and surveillance', 302080);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (10746270, 'SM-6 (Standard Missile-6)', 'Anti-Tank Missiles', 8858096, 'Armor-penetrating capability for ground targets', 650739);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (12989406, 'Aegis Combat System', 'Defense Systems', 4596196, 'Armor-penetrating capability for ground targets', 180113);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (99651494, 'THAAD (Terminal High Altitude Area Defense)', 'Defense Systems', 6723503, 'Comprehensive protection and surveillance', 878283);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (11796239, 'Stinger Missile', 'Surface-to-Air Missiles', 2873663, 'Armor-penetrating capability for ground targets', 958541);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (38954053, 'Iron Dome', 'Surface-to-Air Missiles', 3112753, 'Comprehensive protection and surveillance', 641613);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (93719087, 'Iron Dome', 'Surface-to-Air Missiles', 2401835, 'Comprehensive protection and surveillance', 868004);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (10686013, 'Hellfire Missile', 'Anti-Tank Missiles', 1407652, 'Comprehensive protection and surveillance', 385434);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (66202401, 'Javelin Missile', 'Defense Systems', 2416644, 'Comprehensive protection and surveillance', 247100);
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (81281634, 'Javelin Missile', 'Anti-Tank Missiles', 8608134, 'High-precision targeting for aerial threats', 323943);
commit;
prompt 200 records committed...
insert into PRODUCT (productid, name, category, price, description, inventorycount)
values (1, 'Sample Product', 'Category A', 100, 'Description of Sample Product', 50);
commit;
prompt 201 records loaded
prompt Loading PART_OF...
insert into PART_OF (orderid, productid)
values (32481650, 44769668);
insert into PART_OF (orderid, productid)
values (43940072, 62779835);
insert into PART_OF (orderid, productid)
values (86672432, 24879490);
insert into PART_OF (orderid, productid)
values (59195808, 60632985);
insert into PART_OF (orderid, productid)
values (96798843, 84141477);
insert into PART_OF (orderid, productid)
values (87798520, 74133872);
insert into PART_OF (orderid, productid)
values (90949868, 42776326);
insert into PART_OF (orderid, productid)
values (48528200, 53971468);
insert into PART_OF (orderid, productid)
values (17220217, 49381009);
insert into PART_OF (orderid, productid)
values (39008956, 67964630);
insert into PART_OF (orderid, productid)
values (25584000, 30078490);
insert into PART_OF (orderid, productid)
values (73678322, 40015420);
insert into PART_OF (orderid, productid)
values (22501391, 89914525);
insert into PART_OF (orderid, productid)
values (14888608, 84035773);
insert into PART_OF (orderid, productid)
values (64160828, 25049109);
insert into PART_OF (orderid, productid)
values (46697598, 34307347);
insert into PART_OF (orderid, productid)
values (40461955, 30224096);
insert into PART_OF (orderid, productid)
values (37166599, 26690888);
insert into PART_OF (orderid, productid)
values (46222895, 99651494);
insert into PART_OF (orderid, productid)
values (81358060, 11447018);
insert into PART_OF (orderid, productid)
values (98703687, 80744202);
insert into PART_OF (orderid, productid)
values (15520884, 20053802);
insert into PART_OF (orderid, productid)
values (37166599, 37005131);
insert into PART_OF (orderid, productid)
values (32084160, 52215121);
insert into PART_OF (orderid, productid)
values (23169983, 30078490);
insert into PART_OF (orderid, productid)
values (24977793, 38217305);
insert into PART_OF (orderid, productid)
values (71508264, 98535418);
insert into PART_OF (orderid, productid)
values (55211525, 30088684);
insert into PART_OF (orderid, productid)
values (28362564, 59812221);
insert into PART_OF (orderid, productid)
values (59195808, 25490673);
insert into PART_OF (orderid, productid)
values (27340466, 32717559);
insert into PART_OF (orderid, productid)
values (27244804, 77079019);
insert into PART_OF (orderid, productid)
values (61625775, 56191191);
insert into PART_OF (orderid, productid)
values (56073570, 83730147);
insert into PART_OF (orderid, productid)
values (48568747, 48984418);
insert into PART_OF (orderid, productid)
values (62150938, 99751170);
insert into PART_OF (orderid, productid)
values (76158359, 53849368);
insert into PART_OF (orderid, productid)
values (83642274, 84035773);
insert into PART_OF (orderid, productid)
values (45496635, 99918838);
insert into PART_OF (orderid, productid)
values (49796873, 24879490);
insert into PART_OF (orderid, productid)
values (50162378, 89914525);
insert into PART_OF (orderid, productid)
values (86148845, 30078490);
insert into PART_OF (orderid, productid)
values (46348857, 22303921);
insert into PART_OF (orderid, productid)
values (39283565, 74133872);
insert into PART_OF (orderid, productid)
values (26764951, 44769668);
insert into PART_OF (orderid, productid)
values (38245386, 75342639);
insert into PART_OF (orderid, productid)
values (32436619, 79157436);
insert into PART_OF (orderid, productid)
values (73678322, 74088715);
insert into PART_OF (orderid, productid)
values (49767001, 48999849);
insert into PART_OF (orderid, productid)
values (96098609, 47468634);
insert into PART_OF (orderid, productid)
values (33105564, 20112645);
insert into PART_OF (orderid, productid)
values (48487980, 18002334);
insert into PART_OF (orderid, productid)
values (28362564, 42490226);
insert into PART_OF (orderid, productid)
values (84481920, 30634130);
insert into PART_OF (orderid, productid)
values (27202333, 20998110);
insert into PART_OF (orderid, productid)
values (56836563, 99355318);
insert into PART_OF (orderid, productid)
values (45496635, 77300053);
insert into PART_OF (orderid, productid)
values (27057960, 44714020);
insert into PART_OF (orderid, productid)
values (86672432, 30078490);
insert into PART_OF (orderid, productid)
values (73678322, 26696031);
insert into PART_OF (orderid, productid)
values (42193615, 12469913);
insert into PART_OF (orderid, productid)
values (61625775, 36849239);
insert into PART_OF (orderid, productid)
values (23169983, 60632985);
insert into PART_OF (orderid, productid)
values (98703687, 78500077);
insert into PART_OF (orderid, productid)
values (59195808, 26690888);
insert into PART_OF (orderid, productid)
values (71371841, 77079019);
insert into PART_OF (orderid, productid)
values (44660055, 63029913);
insert into PART_OF (orderid, productid)
values (58946225, 84373216);
insert into PART_OF (orderid, productid)
values (68241221, 91404530);
insert into PART_OF (orderid, productid)
values (83642274, 63029913);
insert into PART_OF (orderid, productid)
values (28823177, 13541897);
insert into PART_OF (orderid, productid)
values (87798520, 48984418);
insert into PART_OF (orderid, productid)
values (41423687, 41950079);
insert into PART_OF (orderid, productid)
values (34972793, 77300053);
insert into PART_OF (orderid, productid)
values (41812723, 88170142);
insert into PART_OF (orderid, productid)
values (16089827, 47468634);
insert into PART_OF (orderid, productid)
values (81358060, 70067503);
insert into PART_OF (orderid, productid)
values (71017467, 78454014);
insert into PART_OF (orderid, productid)
values (33797584, 42979930);
insert into PART_OF (orderid, productid)
values (71698994, 25049109);
insert into PART_OF (orderid, productid)
values (44901192, 42979930);
insert into PART_OF (orderid, productid)
values (16782726, 32050706);
insert into PART_OF (orderid, productid)
values (48805566, 75342639);
insert into PART_OF (orderid, productid)
values (54978245, 64072253);
insert into PART_OF (orderid, productid)
values (46222895, 52538318);
insert into PART_OF (orderid, productid)
values (43480666, 23818335);
insert into PART_OF (orderid, productid)
values (46697598, 64458245);
insert into PART_OF (orderid, productid)
values (41271233, 85217351);
insert into PART_OF (orderid, productid)
values (33105564, 47301842);
insert into PART_OF (orderid, productid)
values (94869357, 25049109);
insert into PART_OF (orderid, productid)
values (32794409, 41256443);
insert into PART_OF (orderid, productid)
values (11644533, 44769668);
insert into PART_OF (orderid, productid)
values (10498218, 89356370);
insert into PART_OF (orderid, productid)
values (38534334, 41950079);
insert into PART_OF (orderid, productid)
values (71698994, 94362422);
insert into PART_OF (orderid, productid)
values (27340466, 19707019);
insert into PART_OF (orderid, productid)
values (90949868, 72052162);
insert into PART_OF (orderid, productid)
values (37123734, 59532354);
insert into PART_OF (orderid, productid)
values (50211760, 37005131);
insert into PART_OF (orderid, productid)
values (90949868, 94362422);
commit;
prompt 100 records committed...
insert into PART_OF (orderid, productid)
values (35782292, 66750680);
insert into PART_OF (orderid, productid)
values (70221490, 60809489);
insert into PART_OF (orderid, productid)
values (24977793, 47661926);
insert into PART_OF (orderid, productid)
values (89282429, 99751170);
insert into PART_OF (orderid, productid)
values (48805566, 14886998);
insert into PART_OF (orderid, productid)
values (89793726, 91404530);
insert into PART_OF (orderid, productid)
values (17247861, 52264429);
insert into PART_OF (orderid, productid)
values (10847062, 17531192);
insert into PART_OF (orderid, productid)
values (40461955, 34307347);
insert into PART_OF (orderid, productid)
values (77256073, 88146731);
insert into PART_OF (orderid, productid)
values (92765749, 56668763);
insert into PART_OF (orderid, productid)
values (38534334, 84141477);
insert into PART_OF (orderid, productid)
values (32481650, 18144872);
insert into PART_OF (orderid, productid)
values (71371841, 83026924);
insert into PART_OF (orderid, productid)
values (44768545, 15622495);
insert into PART_OF (orderid, productid)
values (78875875, 18144872);
insert into PART_OF (orderid, productid)
values (67345461, 84488662);
insert into PART_OF (orderid, productid)
values (55156473, 18144872);
insert into PART_OF (orderid, productid)
values (70133273, 12214534);
insert into PART_OF (orderid, productid)
values (13039382, 47661926);
insert into PART_OF (orderid, productid)
values (98130466, 63029913);
insert into PART_OF (orderid, productid)
values (70133273, 53027287);
insert into PART_OF (orderid, productid)
values (11644533, 53726451);
insert into PART_OF (orderid, productid)
values (75298852, 38217305);
insert into PART_OF (orderid, productid)
values (95883854, 83026924);
insert into PART_OF (orderid, productid)
values (30612695, 60809489);
insert into PART_OF (orderid, productid)
values (46348857, 80744202);
insert into PART_OF (orderid, productid)
values (72132403, 24879490);
insert into PART_OF (orderid, productid)
values (59195808, 62779835);
insert into PART_OF (orderid, productid)
values (59195808, 89914525);
insert into PART_OF (orderid, productid)
values (50211760, 85280659);
insert into PART_OF (orderid, productid)
values (43940072, 12214534);
insert into PART_OF (orderid, productid)
values (59195808, 99355318);
insert into PART_OF (orderid, productid)
values (33105564, 61832164);
insert into PART_OF (orderid, productid)
values (70221490, 19559845);
insert into PART_OF (orderid, productid)
values (49767001, 39077924);
insert into PART_OF (orderid, productid)
values (20549357, 12983031);
insert into PART_OF (orderid, productid)
values (35627737, 19559845);
insert into PART_OF (orderid, productid)
values (86457534, 37005131);
insert into PART_OF (orderid, productid)
values (50999597, 84373216);
insert into PART_OF (orderid, productid)
values (16782726, 77079019);
insert into PART_OF (orderid, productid)
values (46056187, 77300053);
insert into PART_OF (orderid, productid)
values (16089827, 40002629);
insert into PART_OF (orderid, productid)
values (98238957, 38217305);
insert into PART_OF (orderid, productid)
values (39764009, 26978984);
insert into PART_OF (orderid, productid)
values (33105564, 86717227);
insert into PART_OF (orderid, productid)
values (56073570, 99918838);
insert into PART_OF (orderid, productid)
values (45766106, 25049109);
insert into PART_OF (orderid, productid)
values (21778797, 77079019);
insert into PART_OF (orderid, productid)
values (80012686, 40225662);
insert into PART_OF (orderid, productid)
values (69556806, 99651494);
insert into PART_OF (orderid, productid)
values (93238641, 69789600);
insert into PART_OF (orderid, productid)
values (79640672, 20112645);
insert into PART_OF (orderid, productid)
values (16160718, 67964630);
insert into PART_OF (orderid, productid)
values (17866964, 38203950);
insert into PART_OF (orderid, productid)
values (83642274, 12663198);
insert into PART_OF (orderid, productid)
values (70133273, 30224096);
insert into PART_OF (orderid, productid)
values (14395239, 23467437);
insert into PART_OF (orderid, productid)
values (63564977, 70067503);
insert into PART_OF (orderid, productid)
values (32794409, 66750680);
insert into PART_OF (orderid, productid)
values (98130466, 87839213);
insert into PART_OF (orderid, productid)
values (28269220, 62668426);
insert into PART_OF (orderid, productid)
values (68841810, 99651494);
insert into PART_OF (orderid, productid)
values (54978245, 30088684);
insert into PART_OF (orderid, productid)
values (89062047, 74427412);
insert into PART_OF (orderid, productid)
values (15520884, 18002334);
insert into PART_OF (orderid, productid)
values (69556806, 32050706);
insert into PART_OF (orderid, productid)
values (46697598, 99751170);
insert into PART_OF (orderid, productid)
values (22711863, 84141477);
insert into PART_OF (orderid, productid)
values (15864881, 89914525);
insert into PART_OF (orderid, productid)
values (87798520, 89656829);
insert into PART_OF (orderid, productid)
values (33797584, 61261918);
insert into PART_OF (orderid, productid)
values (68241221, 12469913);
insert into PART_OF (orderid, productid)
values (99283105, 65366250);
insert into PART_OF (orderid, productid)
values (22501391, 79157436);
insert into PART_OF (orderid, productid)
values (54978245, 54178963);
insert into PART_OF (orderid, productid)
values (62150938, 73840426);
insert into PART_OF (orderid, productid)
values (86457534, 39791976);
insert into PART_OF (orderid, productid)
values (43436009, 10215771);
insert into PART_OF (orderid, productid)
values (23169983, 12663198);
insert into PART_OF (orderid, productid)
values (38534334, 52880276);
insert into PART_OF (orderid, productid)
values (32794409, 25515323);
insert into PART_OF (orderid, productid)
values (48487980, 42979930);
insert into PART_OF (orderid, productid)
values (15864881, 34307347);
insert into PART_OF (orderid, productid)
values (25730382, 40286424);
insert into PART_OF (orderid, productid)
values (95883854, 42490226);
insert into PART_OF (orderid, productid)
values (26554668, 56191191);
insert into PART_OF (orderid, productid)
values (71508264, 12989406);
insert into PART_OF (orderid, productid)
values (98238957, 61832164);
insert into PART_OF (orderid, productid)
values (17901723, 66202401);
insert into PART_OF (orderid, productid)
values (45343624, 38954053);
insert into PART_OF (orderid, productid)
values (49796873, 32717559);
insert into PART_OF (orderid, productid)
values (13039382, 75342639);
insert into PART_OF (orderid, productid)
values (43436009, 71082803);
insert into PART_OF (orderid, productid)
values (48568747, 32717559);
insert into PART_OF (orderid, productid)
values (51601257, 74200926);
insert into PART_OF (orderid, productid)
values (68022210, 20126969);
insert into PART_OF (orderid, productid)
values (50162378, 22559530);
insert into PART_OF (orderid, productid)
values (1, 1);
commit;
prompt 199 records loaded
prompt Loading PAYMENT...
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (65289067, to_date('17-05-2022', 'dd-mm-yyyy'), 'trade', 410415, '52', 92123288);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (17151586, to_date('12-12-2022', 'dd-mm-yyyy'), 'trade', 3615162, '644', 39283565);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (52283451, to_date('11-06-2022', 'dd-mm-yyyy'), 'credit card', 4692439, '570', 15864881);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (75372585, to_date('10-11-2022', 'dd-mm-yyyy'), 'credit card', 3823193, '290', 22711863);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (63007960, to_date('24-03-2022', 'dd-mm-yyyy'), 'cash', 1491551, '596', 63564977);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (17701132, to_date('23-03-2023', 'dd-mm-yyyy'), 'stocks', 8028882, '286', 87798520);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (51860241, to_date('15-09-2022', 'dd-mm-yyyy'), 'credit card', 1481297, '558', 77256073);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (19039399, to_date('02-04-2022', 'dd-mm-yyyy'), 'stocks', 5772361, '718', 49885578);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (52307223, to_date('26-04-2023', 'dd-mm-yyyy'), 'credit card', 5762208, '695', 80012686);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (62078253, to_date('23-08-2022', 'dd-mm-yyyy'), 'stocks', 6723503, '410', 45911739);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (48251017, to_date('31-07-2022', 'dd-mm-yyyy'), 'trade', 7269388, '106', 93688442);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (43996479, to_date('17-03-2022', 'dd-mm-yyyy'), 'trade', 6925930, '90', 24491649);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (61040634, to_date('09-03-2023', 'dd-mm-yyyy'), 'credit card', 9061313, '557', 50162378);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (68784993, to_date('21-02-2022', 'dd-mm-yyyy'), 'cash', 3161558, '410', 17247861);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (62108703, to_date('25-11-2022', 'dd-mm-yyyy'), 'trade', 4692439, '214', 32159564);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (25196066, to_date('13-06-2022', 'dd-mm-yyyy'), 'trade', 2030565, '783', 15407639);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (71233189, to_date('21-02-2023', 'dd-mm-yyyy'), 'stocks', 8370975, '46', 38245386);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (70317537, to_date('05-02-2023', 'dd-mm-yyyy'), 'cash', 9076802, '990', 71698994);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (80424114, to_date('10-01-2022', 'dd-mm-yyyy'), 'stocks', 5967767, '151', 32159564);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (38772039, to_date('04-12-2022', 'dd-mm-yyyy'), 'trade', 9584485, '637', 72132403);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (73435272, to_date('19-06-2022', 'dd-mm-yyyy'), 'cash', 8070720, '848', 65592894);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (27541212, to_date('10-12-2022', 'dd-mm-yyyy'), 'cash', 8136904, '392', 10847062);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (50900953, to_date('19-01-2022', 'dd-mm-yyyy'), 'cash', 1481297, '604', 21778797);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (86414922, to_date('30-01-2022', 'dd-mm-yyyy'), 'trade', 3616686, '75', 15520884);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (61097657, to_date('24-04-2023', 'dd-mm-yyyy'), 'stocks', 9061313, '718', 38534334);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (94065483, to_date('08-09-2022', 'dd-mm-yyyy'), 'trade', 6085300, '522', 71653287);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (56330816, to_date('03-02-2023', 'dd-mm-yyyy'), 'stocks', 4850906, '897', 43436009);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (89746874, to_date('30-01-2023', 'dd-mm-yyyy'), 'cash', 6874215, '305', 48528200);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (24946511, to_date('26-04-2022', 'dd-mm-yyyy'), 'stocks', 3218566, '594', 22711863);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (70618958, to_date('22-07-2022', 'dd-mm-yyyy'), 'stocks', 9007035, '203', 68841810);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (38968190, to_date('08-11-2022', 'dd-mm-yyyy'), 'credit card', 3863212, '163', 55211525);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (64696699, to_date('04-10-2022', 'dd-mm-yyyy'), 'trade', 4367361, '536', 71508264);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (37358390, to_date('23-02-2022', 'dd-mm-yyyy'), 'stocks', 1616443, '825', 61218313);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (29424384, to_date('15-11-2022', 'dd-mm-yyyy'), 'stocks', 328811, '314', 45002614);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (64905452, to_date('16-11-2022', 'dd-mm-yyyy'), 'cash', 326217, '505', 82940119);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (25874840, to_date('02-03-2023', 'dd-mm-yyyy'), 'stocks', 8660626, '145', 96061311);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (66735241, to_date('08-02-2023', 'dd-mm-yyyy'), 'trade', 6282765, '362', 26554668);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (38573651, to_date('02-05-2022', 'dd-mm-yyyy'), 'stocks', 6454841, '15', 40461955);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (48447867, to_date('15-10-2022', 'dd-mm-yyyy'), 'stocks', 1904641, '247', 61625775);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (70948380, to_date('12-03-2023', 'dd-mm-yyyy'), 'cash', 6420274, '841', 61218313);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (61879402, to_date('20-09-2022', 'dd-mm-yyyy'), 'credit card', 6295224, '908', 42083601);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (66402787, to_date('25-11-2022', 'dd-mm-yyyy'), 'cash', 5607773, '889', 26764951);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (16488596, to_date('25-07-2022', 'dd-mm-yyyy'), 'credit card', 5984801, '63', 17866964);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (15016045, to_date('15-02-2022', 'dd-mm-yyyy'), 'credit card', 9070014, '912', 67345461);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (36368600, to_date('20-04-2023', 'dd-mm-yyyy'), 'cash', 1491551, '174', 97017792);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (65866962, to_date('26-09-2022', 'dd-mm-yyyy'), 'stocks', 9970693, '202', 80888742);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (12883685, to_date('05-02-2022', 'dd-mm-yyyy'), 'credit card', 9516154, '190', 68241221);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (14983198, to_date('19-03-2023', 'dd-mm-yyyy'), 'trade', 6922656, '361', 51601257);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (62930956, to_date('24-03-2022', 'dd-mm-yyyy'), 'cash', 3112753, '969', 46348857);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (58915486, to_date('13-06-2022', 'dd-mm-yyyy'), 'stocks', 1387914, '986', 45496635);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (92827075, to_date('14-02-2022', 'dd-mm-yyyy'), 'cash', 8014443, '613', 39008956);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (23936846, to_date('24-08-2022', 'dd-mm-yyyy'), 'cash', 4540426, '100', 29915313);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (87819978, to_date('23-02-2022', 'dd-mm-yyyy'), 'trade', 4008284, '503', 88692266);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (40866810, to_date('30-04-2023', 'dd-mm-yyyy'), 'stocks', 7272475, '348', 44660055);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (47225594, to_date('17-06-2022', 'dd-mm-yyyy'), 'credit card', 8608134, '264', 24977793);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (55520635, to_date('28-05-2022', 'dd-mm-yyyy'), 'cash', 4367361, '155', 89793726);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (15189566, to_date('13-08-2022', 'dd-mm-yyyy'), 'credit card', 3863212, '466', 23169983);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (64783525, to_date('18-12-2022', 'dd-mm-yyyy'), 'cash', 4367361, '540', 26764951);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (27073964, to_date('10-12-2022', 'dd-mm-yyyy'), 'trade', 4338006, '177', 70131212);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (88309851, to_date('19-03-2023', 'dd-mm-yyyy'), 'stocks', 1616443, '846', 45343624);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (61469011, to_date('24-04-2022', 'dd-mm-yyyy'), 'trade', 7573095, '289', 55211525);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (55847365, to_date('14-10-2022', 'dd-mm-yyyy'), 'credit card', 8070720, '239', 42567869);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (87829796, to_date('28-12-2022', 'dd-mm-yyyy'), 'trade', 6295224, '700', 35352016);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (60186422, to_date('16-10-2022', 'dd-mm-yyyy'), 'trade', 580588, '987', 80888742);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (29737996, to_date('15-08-2022', 'dd-mm-yyyy'), 'credit card', 5840293, '296', 15407639);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (75734201, to_date('04-05-2022', 'dd-mm-yyyy'), 'trade', 419004, '673', 32108471);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (93788591, to_date('15-07-2022', 'dd-mm-yyyy'), 'credit card', 9066342, '694', 29915313);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (42713917, to_date('30-01-2022', 'dd-mm-yyyy'), 'credit card', 4596196, '56', 70133273);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (24101591, to_date('29-03-2023', 'dd-mm-yyyy'), 'trade', 2455633, '901', 39008956);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (46989047, to_date('13-11-2022', 'dd-mm-yyyy'), 'stocks', 7630660, '853', 44901192);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (72458742, to_date('03-12-2022', 'dd-mm-yyyy'), 'cash', 1558488, '689', 17247861);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (55512544, to_date('06-03-2022', 'dd-mm-yyyy'), 'cash', 6696408, '357', 46056187);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (84065259, to_date('27-01-2023', 'dd-mm-yyyy'), 'trade', 6202242, '816', 46056187);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (17401057, to_date('23-11-2022', 'dd-mm-yyyy'), 'cash', 9016717, '731', 96098609);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (28936532, to_date('07-07-2022', 'dd-mm-yyyy'), 'credit card', 8120620, '96', 48805566);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (60634152, to_date('02-08-2022', 'dd-mm-yyyy'), 'trade', 3616686, '280', 46348857);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (88909854, to_date('30-06-2022', 'dd-mm-yyyy'), 'credit card', 9801992, '199', 27014259);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (64378526, to_date('16-02-2023', 'dd-mm-yyyy'), 'trade', 410415, '396', 85430038);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (30281134, to_date('29-11-2022', 'dd-mm-yyyy'), 'trade', 4367361, '366', 46056187);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (46937231, to_date('16-02-2022', 'dd-mm-yyyy'), 'cash', 2492541, '422', 11738054);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (22066619, to_date('30-11-2022', 'dd-mm-yyyy'), 'trade', 9930179, '850', 38245386);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (19323889, to_date('23-01-2022', 'dd-mm-yyyy'), 'credit card', 6287307, '259', 48568747);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (19889612, to_date('31-03-2023', 'dd-mm-yyyy'), 'trade', 6083817, '226', 21778797);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (24461913, to_date('11-07-2022', 'dd-mm-yyyy'), 'trade', 7630660, '806', 18563632);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (55492189, to_date('22-05-2022', 'dd-mm-yyyy'), 'credit card', 4338006, '448', 46348857);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (92008722, to_date('19-03-2022', 'dd-mm-yyyy'), 'stocks', 6516848, '249', 86672432);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (81871921, to_date('23-05-2022', 'dd-mm-yyyy'), 'cash', 8184827, '812', 23211833);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (18804967, to_date('26-08-2022', 'dd-mm-yyyy'), 'trade', 461191, '73', 28823177);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (94043590, to_date('06-03-2023', 'dd-mm-yyyy'), 'trade', 482226, '662', 17981118);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (54948742, to_date('14-01-2023', 'dd-mm-yyyy'), 'stocks', 6922656, '985', 85430038);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (75425908, to_date('24-07-2022', 'dd-mm-yyyy'), 'credit card', 1423691, '905', 89739640);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (65494807, to_date('14-02-2022', 'dd-mm-yyyy'), 'trade', 134798, '625', 23222894);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (39853236, to_date('07-01-2022', 'dd-mm-yyyy'), 'credit card', 4251269, '403', 48528200);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (47778805, to_date('13-03-2023', 'dd-mm-yyyy'), 'cash', 1776811, '10', 89282429);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (79212307, to_date('25-03-2022', 'dd-mm-yyyy'), 'credit card', 2873663, '89', 80012686);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (24366484, to_date('13-03-2022', 'dd-mm-yyyy'), 'trade', 5191432, '880', 92765749);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (56703935, to_date('05-01-2023', 'dd-mm-yyyy'), 'stocks', 351581, '963', 36319648);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (31627910, to_date('17-10-2022', 'dd-mm-yyyy'), 'trade', 3343934, '877', 23169983);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (25729745, to_date('16-05-2022', 'dd-mm-yyyy'), 'cash', 4072052, '914', 32794409);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (23936692, to_date('14-09-2022', 'dd-mm-yyyy'), 'stocks', 3447425, '417', 17901723);
commit;
prompt 100 records committed...
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (24403884, to_date('30-07-2022', 'dd-mm-yyyy'), 'credit card', 2903624, '258', 87798520);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (53494195, to_date('13-12-2022', 'dd-mm-yyyy'), 'credit card', 2455633, '472', 44768545);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (55689741, to_date('23-01-2022', 'dd-mm-yyyy'), 'credit card', 1696477, '173', 14395239);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (95778764, to_date('20-12-2022', 'dd-mm-yyyy'), 'credit card', 331811, '157', 38245386);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (73161669, to_date('03-05-2022', 'dd-mm-yyyy'), 'cash', 7903122, '935', 17220217);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (60619939, to_date('28-09-2022', 'dd-mm-yyyy'), 'credit card', 6414162, '84', 38245386);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (62391701, to_date('15-01-2022', 'dd-mm-yyyy'), 'trade', 7272475, '968', 38768910);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (78897675, to_date('16-09-2022', 'dd-mm-yyyy'), 'cash', 1993792, '568', 92660307);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (37961269, to_date('15-01-2022', 'dd-mm-yyyy'), 'cash', 6696408, '656', 92765749);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (74866562, to_date('05-10-2022', 'dd-mm-yyyy'), 'trade', 6282765, '646', 86457534);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (46097924, to_date('19-12-2022', 'dd-mm-yyyy'), 'trade', 6642292, '25', 44660055);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (64105040, to_date('18-12-2022', 'dd-mm-yyyy'), 'cash', 6967998, '864', 11738054);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (82937054, to_date('28-02-2023', 'dd-mm-yyyy'), 'trade', 6723503, '206', 32159564);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (97089623, to_date('21-01-2022', 'dd-mm-yyyy'), 'cash', 4850906, '936', 10407667);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (18408601, to_date('11-05-2022', 'dd-mm-yyyy'), 'credit card', 4072052, '748', 25790111);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (28394114, to_date('03-01-2023', 'dd-mm-yyyy'), 'trade', 9016717, '179', 58946225);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (65748782, to_date('19-02-2023', 'dd-mm-yyyy'), 'cash', 8028882, '707', 64160828);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (11513825, to_date('09-01-2023', 'dd-mm-yyyy'), 'trade', 5049540, '736', 42083601);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (86636809, to_date('18-02-2022', 'dd-mm-yyyy'), 'stocks', 8014443, '538', 73678322);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (99314794, to_date('08-08-2022', 'dd-mm-yyyy'), 'credit card', 741619, '719', 32084160);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (71956605, to_date('14-12-2022', 'dd-mm-yyyy'), 'cash', 4524958, '834', 46697598);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (30108008, to_date('07-01-2023', 'dd-mm-yyyy'), 'cash', 4540426, '25', 32935042);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (88183521, to_date('23-11-2022', 'dd-mm-yyyy'), 'credit card', 1646242, '876', 68241221);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (99348616, to_date('28-11-2022', 'dd-mm-yyyy'), 'trade', 7552221, '36', 54978245);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (49396061, to_date('20-09-2022', 'dd-mm-yyyy'), 'cash', 7973877, '960', 26554668);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (56960154, to_date('30-03-2023', 'dd-mm-yyyy'), 'credit card', 4072052, '157', 58946225);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (34912597, to_date('05-03-2022', 'dd-mm-yyyy'), 'cash', 8184827, '579', 32436619);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (80283759, to_date('30-01-2022', 'dd-mm-yyyy'), 'trade', 8136904, '115', 68241221);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (72553084, to_date('08-08-2022', 'dd-mm-yyyy'), 'credit card', 6516848, '375', 64160828);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (42652387, to_date('08-01-2023', 'dd-mm-yyyy'), 'stocks', 8370975, '84', 35880175);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (17525788, to_date('28-04-2023', 'dd-mm-yyyy'), 'credit card', 4524958, '939', 48528200);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (47590039, to_date('29-10-2022', 'dd-mm-yyyy'), 'trade', 8120620, '633', 17866964);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (66938995, to_date('25-05-2022', 'dd-mm-yyyy'), 'cash', 419004, '435', 39283565);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (68635970, to_date('11-01-2022', 'dd-mm-yyyy'), 'trade', 1558488, '504', 13868615);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (19937737, to_date('21-02-2023', 'dd-mm-yyyy'), 'credit card', 3161558, '951', 13868615);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (44793916, to_date('09-09-2022', 'dd-mm-yyyy'), 'cash', 6520876, '139', 17220217);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (73465507, to_date('12-06-2022', 'dd-mm-yyyy'), 'stocks', 3432237, '794', 97017792);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (71606307, to_date('22-07-2022', 'dd-mm-yyyy'), 'credit card', 7083454, '85', 56073570);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (93650977, to_date('02-02-2022', 'dd-mm-yyyy'), 'cash', 5191432, '476', 71653287);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (57853490, to_date('10-12-2022', 'dd-mm-yyyy'), 'cash', 3218566, '191', 38534334);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (62819722, to_date('21-03-2023', 'dd-mm-yyyy'), 'cash', 331811, '577', 38245386);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (17877943, to_date('02-06-2022', 'dd-mm-yyyy'), 'cash', 3176117, '603', 77256073);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (82130932, to_date('17-07-2022', 'dd-mm-yyyy'), 'credit card', 3823193, '426', 68022210);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (99533499, to_date('03-11-2022', 'dd-mm-yyyy'), 'stocks', 7602887, '598', 17866964);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (19839136, to_date('01-04-2022', 'dd-mm-yyyy'), 'credit card', 9310771, '545', 35627737);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (77759562, to_date('18-07-2022', 'dd-mm-yyyy'), 'trade', 6925930, '194', 24977793);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (65180916, to_date('22-01-2023', 'dd-mm-yyyy'), 'trade', 351581, '963', 41075811);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (23780326, to_date('19-03-2023', 'dd-mm-yyyy'), 'stocks', 1616443, '594', 15864881);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (27886631, to_date('04-01-2023', 'dd-mm-yyyy'), 'trade', 580588, '313', 37123734);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (79928992, to_date('23-07-2022', 'dd-mm-yyyy'), 'trade', 6420274, '473', 44768545);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (83317133, to_date('17-04-2023', 'dd-mm-yyyy'), 'credit card', 482226, '703', 96061311);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (60096990, to_date('15-01-2022', 'dd-mm-yyyy'), 'trade', 5883534, '12', 10511620);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (83225485, to_date('21-07-2022', 'dd-mm-yyyy'), 'stocks', 3343934, '510', 58946225);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (45808197, to_date('09-01-2023', 'dd-mm-yyyy'), 'credit card', 772221, '777', 50211760);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (42143680, to_date('26-03-2022', 'dd-mm-yyyy'), 'cash', 4850906, '855', 75298852);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (87918155, to_date('13-01-2022', 'dd-mm-yyyy'), 'trade', 9286649, '464', 55289191);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (89394361, to_date('12-01-2023', 'dd-mm-yyyy'), 'cash', 6287307, '994', 37123734);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (93938287, to_date('17-05-2022', 'dd-mm-yyyy'), 'cash', 7083454, '332', 22501391);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (66727541, to_date('09-02-2023', 'dd-mm-yyyy'), 'credit card', 2492541, '463', 98130466);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (80985121, to_date('25-03-2022', 'dd-mm-yyyy'), 'cash', 6925930, '570', 32084160);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (31582317, to_date('03-01-2022', 'dd-mm-yyyy'), 'cash', 9070014, '40', 63564977);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (74354507, to_date('18-02-2023', 'dd-mm-yyyy'), 'credit card', 9007035, '420', 87798520);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (45973594, to_date('08-05-2022', 'dd-mm-yyyy'), 'cash', 1616443, '545', 70131212);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (11720834, to_date('22-11-2022', 'dd-mm-yyyy'), 'trade', 8014443, '109', 24491649);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (61003800, to_date('24-08-2022', 'dd-mm-yyyy'), 'trade', 2691150, '466', 49796873);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (12961248, to_date('20-03-2022', 'dd-mm-yyyy'), 'stocks', 2271187, '601', 32159564);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (76999607, to_date('16-06-2022', 'dd-mm-yyyy'), 'credit card', 8608134, '322', 32481650);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (25604875, to_date('16-06-2022', 'dd-mm-yyyy'), 'cash', 7922953, '203', 96798843);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (39273648, to_date('08-09-2022', 'dd-mm-yyyy'), 'cash', 4251269, '913', 33797584);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (15907037, to_date('13-06-2022', 'dd-mm-yyyy'), 'trade', 9286649, '881', 92765749);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (99511237, to_date('12-04-2022', 'dd-mm-yyyy'), 'cash', 1696477, '376', 83642274);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (75548470, to_date('27-05-2022', 'dd-mm-yyyy'), 'trade', 6723503, '533', 36160443);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (72782088, to_date('26-04-2023', 'dd-mm-yyyy'), 'stocks', 3615162, '977', 92123288);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (83959545, to_date('16-11-2022', 'dd-mm-yyyy'), 'stocks', 8254356, '910', 92765749);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (70177032, to_date('30-03-2023', 'dd-mm-yyyy'), 'stocks', 5650110, '850', 83278061);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (96269484, to_date('15-11-2022', 'dd-mm-yyyy'), 'credit card', 8193198, '512', 42193615);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (57069739, to_date('13-02-2022', 'dd-mm-yyyy'), 'stocks', 3343934, '407', 17220217);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (16880582, to_date('24-04-2022', 'dd-mm-yyyy'), 'credit card', 9801992, '160', 97017792);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (47003433, to_date('23-04-2022', 'dd-mm-yyyy'), 'cash', 842169, '647', 68241221);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (88667422, to_date('04-04-2022', 'dd-mm-yyyy'), 'cash', 4008284, '465', 81371099);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (31202611, to_date('15-04-2023', 'dd-mm-yyyy'), 'stocks', 5278598, '278', 71017467);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (37801098, to_date('03-12-2022', 'dd-mm-yyyy'), 'trade', 9698190, '101', 17220217);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (93709768, to_date('01-03-2022', 'dd-mm-yyyy'), 'stocks', 6516848, '587', 81371099);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (24198431, to_date('29-01-2022', 'dd-mm-yyyy'), 'credit card', 6638044, '822', 69556806);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (82147105, to_date('04-08-2022', 'dd-mm-yyyy'), 'trade', 9016717, '210', 71017467);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (67596186, to_date('03-03-2023', 'dd-mm-yyyy'), 'stocks', 4233028, '417', 86148845);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (94103258, to_date('04-11-2022', 'dd-mm-yyyy'), 'credit card', 6148409, '619', 42083601);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (19250297, to_date('08-08-2022', 'dd-mm-yyyy'), 'credit card', 482226, '323', 28362564);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (69145011, to_date('26-11-2022', 'dd-mm-yyyy'), 'stocks', 185068, '528', 44606281);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (79260078, to_date('10-09-2022', 'dd-mm-yyyy'), 'stocks', 7573095, '188', 14395239);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (16454015, to_date('27-08-2022', 'dd-mm-yyyy'), 'stocks', 6322552, '10', 28823177);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (59517447, to_date('04-06-2022', 'dd-mm-yyyy'), 'stocks', 978766, '165', 34972793);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (68088510, to_date('01-03-2023', 'dd-mm-yyyy'), 'trade', 1904641, '475', 97017792);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (92281145, to_date('01-04-2023', 'dd-mm-yyyy'), 'trade', 6967998, '52', 20549357);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (87870040, to_date('21-01-2023', 'dd-mm-yyyy'), 'stocks', 3570772, '498', 10186094);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (84375951, to_date('09-01-2022', 'dd-mm-yyyy'), 'credit card', 9667683, '227', 71600752);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (95895174, to_date('09-04-2023', 'dd-mm-yyyy'), 'trade', 5772361, '373', 33797584);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (77016903, to_date('15-12-2022', 'dd-mm-yyyy'), 'cash', 3218566, '415', 50162378);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (68672225, to_date('11-12-2022', 'dd-mm-yyyy'), 'credit card', 5668481, '539', 41812723);
insert into PAYMENT (paymentid, paymentdate, paymentmethod, amount, transactionid, orderid)
values (71258516, to_date('17-01-2022', 'dd-mm-yyyy'), 'trade', 9584485, '248', 55156473);
commit;
prompt 200 records loaded
prompt Loading SUPPORT_TICKET...
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (14882967, 'Reliability of detection systems', 'Pending', to_date('16-07-2022', 'dd-mm-yyyy'), to_date('07-05-2023', 'dd-mm-yyyy'), 74742649, 54917654);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (67248686, 'Integration with existing defense systems', 'Open', to_date('24-03-2022', 'dd-mm-yyyy'), to_date('08-10-2023', 'dd-mm-yyyy'), 54088195, 81203133);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (30029492, 'Environmental adaptability', 'Escalated', to_date('30-04-2023', 'dd-mm-yyyy'), to_date('19-12-2023', 'dd-mm-yyyy'), 99979592, 64848868);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (29175739, 'Vulnerability to cyber attacks', 'Escalated', to_date('20-01-2022', 'dd-mm-yyyy'), to_date('10-07-2023', 'dd-mm-yyyy'), 69517856, 48696874);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (88799352, 'Communication latency', 'Pending', to_date('13-09-2022', 'dd-mm-yyyy'), to_date('19-06-2023', 'dd-mm-yyyy'), 28817809, 12054149);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (61628327, 'Supply chain security', 'Closed', to_date('02-03-2023', 'dd-mm-yyyy'), to_date('31-10-2023', 'dd-mm-yyyy'), 39370182, 12270385);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (58925739, 'Reliability of detection systems', 'Closed', to_date('27-05-2022', 'dd-mm-yyyy'), to_date('20-11-2023', 'dd-mm-yyyy'), 31021143, 92639077);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (64141853, 'Communication latency', 'Escalated', to_date('22-04-2022', 'dd-mm-yyyy'), to_date('13-08-2023', 'dd-mm-yyyy'), 78216572, 76805170);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (87525670, 'Integration with existing defense systems', 'Pending', to_date('31-03-2023', 'dd-mm-yyyy'), to_date('06-03-2024', 'dd-mm-yyyy'), 92642538, 63310475);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (26176467, 'False positives and negatives', 'Resolved', to_date('05-02-2022', 'dd-mm-yyyy'), to_date('15-12-2023', 'dd-mm-yyyy'), 75426354, 54917654);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (75677020, 'Interception accuracy', 'Open', to_date('04-05-2022', 'dd-mm-yyyy'), to_date('09-10-2023', 'dd-mm-yyyy'), 31021143, 45442845);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (78426480, 'Maintenance and operational costs', 'Resolved', to_date('21-03-2022', 'dd-mm-yyyy'), to_date('14-09-2023', 'dd-mm-yyyy'), 70266179, 95117510);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (59223712, 'Reliability of detection systems', 'Open', to_date('08-05-2022', 'dd-mm-yyyy'), to_date('06-03-2024', 'dd-mm-yyyy'), 96178588, 40981256);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (50026539, 'Integration with existing defense systems', 'Open', to_date('28-02-2023', 'dd-mm-yyyy'), to_date('27-05-2023', 'dd-mm-yyyy'), 87982560, 28015591);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (40859132, 'False positives and negatives', 'Open', to_date('29-03-2023', 'dd-mm-yyyy'), to_date('25-11-2023', 'dd-mm-yyyy'), 16752796, 92788888);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (37253922, 'Vulnerability to cyber attacks', 'Escalated', to_date('02-01-2023', 'dd-mm-yyyy'), to_date('17-07-2023', 'dd-mm-yyyy'), 62526376, 10670802);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (50254131, 'Integration with existing defense systems', 'Open', to_date('29-04-2022', 'dd-mm-yyyy'), to_date('26-03-2024', 'dd-mm-yyyy'), 35498377, 20780563);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (42343903, 'Supply chain security', 'Pending', to_date('28-09-2022', 'dd-mm-yyyy'), to_date('22-10-2023', 'dd-mm-yyyy'), 55818347, 39457119);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (48927611, 'Maintenance and operational costs', 'Pending', to_date('13-01-2023', 'dd-mm-yyyy'), to_date('25-09-2023', 'dd-mm-yyyy'), 33067757, 25470185);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (57412085, 'Operator training and human error', 'Pending', to_date('08-10-2022', 'dd-mm-yyyy'), to_date('10-06-2023', 'dd-mm-yyyy'), 17882271, 35455127);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (14536211, 'Interception accuracy', 'Pending', to_date('25-05-2022', 'dd-mm-yyyy'), to_date('25-12-2023', 'dd-mm-yyyy'), 77642002, 48696874);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (61338911, 'False positives and negatives', 'Escalated', to_date('17-06-2022', 'dd-mm-yyyy'), to_date('20-09-2023', 'dd-mm-yyyy'), 56882009, 81203133);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (80909992, 'Environmental adaptability', 'Closed', to_date('25-03-2022', 'dd-mm-yyyy'), to_date('26-03-2024', 'dd-mm-yyyy'), 64207208, 68009450);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (34942304, 'Operator training and human error', 'Resolved', to_date('06-02-2022', 'dd-mm-yyyy'), to_date('02-07-2023', 'dd-mm-yyyy'), 18675026, 97526793);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (16108294, 'Supply chain security', 'Pending', to_date('27-07-2022', 'dd-mm-yyyy'), to_date('12-05-2023', 'dd-mm-yyyy'), 19321854, 18217124);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (24969419, 'Maintenance and operational costs', 'Open', to_date('17-07-2022', 'dd-mm-yyyy'), to_date('11-05-2023', 'dd-mm-yyyy'), 83480577, 10670802);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (16639082, 'False positives and negatives', 'Closed', to_date('27-08-2022', 'dd-mm-yyyy'), to_date('30-07-2023', 'dd-mm-yyyy'), 99433231, 25441111);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (68502985, 'False positives and negatives', 'Resolved', to_date('04-03-2023', 'dd-mm-yyyy'), to_date('31-05-2023', 'dd-mm-yyyy'), 20113136, 91607447);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (32401092, 'Operator training and human error', 'Pending', to_date('22-09-2022', 'dd-mm-yyyy'), to_date('12-03-2024', 'dd-mm-yyyy'), 85682722, 18792965);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (39426508, 'Supply chain security', 'Resolved', to_date('17-03-2023', 'dd-mm-yyyy'), to_date('05-07-2023', 'dd-mm-yyyy'), 27373972, 46497757);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (79496008, 'Maintenance and operational costs', 'Resolved', to_date('26-02-2023', 'dd-mm-yyyy'), to_date('24-05-2023', 'dd-mm-yyyy'), 86843873, 80099462);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (45750835, 'Supply chain security', 'Resolved', to_date('18-11-2022', 'dd-mm-yyyy'), to_date('03-11-2023', 'dd-mm-yyyy'), 27399832, 76173383);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (37442646, 'False positives and negatives', 'Escalated', to_date('18-10-2022', 'dd-mm-yyyy'), to_date('03-10-2023', 'dd-mm-yyyy'), 81418452, 67606405);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (83997150, 'Supply chain security', 'Closed', to_date('03-03-2022', 'dd-mm-yyyy'), to_date('27-10-2023', 'dd-mm-yyyy'), 59743184, 58761637);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (19131770, 'Vulnerability to cyber attacks', 'Open', to_date('13-03-2022', 'dd-mm-yyyy'), to_date('25-12-2023', 'dd-mm-yyyy'), 54655982, 76805170);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (22583410, 'Supply chain security', 'Pending', to_date('18-03-2022', 'dd-mm-yyyy'), to_date('16-10-2023', 'dd-mm-yyyy'), 39313492, 63342886);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (76713674, 'Environmental adaptability', 'Resolved', to_date('17-02-2022', 'dd-mm-yyyy'), to_date('04-05-2023', 'dd-mm-yyyy'), 71110942, 10842068);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (63397587, 'Operator training and human error', 'Escalated', to_date('11-04-2023', 'dd-mm-yyyy'), to_date('23-12-2023', 'dd-mm-yyyy'), 55819347, 60957159);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (40136068, 'Maintenance and operational costs', 'Closed', to_date('03-01-2023', 'dd-mm-yyyy'), to_date('16-02-2024', 'dd-mm-yyyy'), 54748279, 28015591);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (77586753, 'Maintenance and operational costs', 'Escalated', to_date('07-06-2022', 'dd-mm-yyyy'), to_date('11-08-2023', 'dd-mm-yyyy'), 92665521, 28784273);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (67872053, 'Integration with existing defense systems', 'Open', to_date('18-03-2023', 'dd-mm-yyyy'), to_date('02-03-2024', 'dd-mm-yyyy'), 31021143, 40424418);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (91171155, 'Interception accuracy', 'Pending', to_date('09-06-2022', 'dd-mm-yyyy'), to_date('28-06-2023', 'dd-mm-yyyy'), 22900368, 15776023);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (27122135, 'Reliability of detection systems', 'Pending', to_date('06-09-2022', 'dd-mm-yyyy'), to_date('08-07-2023', 'dd-mm-yyyy'), 97578691, 18792965);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (56531849, 'Operator training and human error', 'Open', to_date('25-01-2023', 'dd-mm-yyyy'), to_date('21-05-2023', 'dd-mm-yyyy'), 42142840, 83387331);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (74065203, 'Maintenance and operational costs', 'Open', to_date('23-07-2022', 'dd-mm-yyyy'), to_date('15-02-2024', 'dd-mm-yyyy'), 38174594, 20927003);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (80244316, 'Maintenance and operational costs', 'Resolved', to_date('15-06-2022', 'dd-mm-yyyy'), to_date('03-02-2024', 'dd-mm-yyyy'), 85682722, 20780563);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (29196347, 'Vulnerability to cyber attacks', 'Closed', to_date('22-09-2022', 'dd-mm-yyyy'), to_date('09-11-2023', 'dd-mm-yyyy'), 62933363, 18217124);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (94263667, 'False positives and negatives', 'Open', to_date('29-01-2022', 'dd-mm-yyyy'), to_date('03-12-2023', 'dd-mm-yyyy'), 42142840, 51259353);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (19049099, 'Supply chain security', 'Closed', to_date('26-07-2022', 'dd-mm-yyyy'), to_date('09-03-2024', 'dd-mm-yyyy'), 34849605, 99957203);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (79234640, 'Communication latency', 'Escalated', to_date('25-03-2022', 'dd-mm-yyyy'), to_date('16-12-2023', 'dd-mm-yyyy'), 65891332, 61452332);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (39281344, 'Maintenance and operational costs', 'Closed', to_date('26-02-2023', 'dd-mm-yyyy'), to_date('20-02-2024', 'dd-mm-yyyy'), 19321854, 86198357);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (33826524, 'Communication latency', 'Open', to_date('30-03-2023', 'dd-mm-yyyy'), to_date('27-08-2023', 'dd-mm-yyyy'), 55818347, 10842068);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (85832687, 'Integration with existing defense systems', 'Escalated', to_date('30-06-2022', 'dd-mm-yyyy'), to_date('08-07-2023', 'dd-mm-yyyy'), 86054195, 14758552);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (25604494, 'Integration with existing defense systems', 'Escalated', to_date('30-01-2022', 'dd-mm-yyyy'), to_date('27-03-2024', 'dd-mm-yyyy'), 16354941, 38008634);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (96261408, 'Operator training and human error', 'Closed', to_date('05-06-2022', 'dd-mm-yyyy'), to_date('24-09-2023', 'dd-mm-yyyy'), 56882009, 25441111);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (25169530, 'Integration with existing defense systems', 'Resolved', to_date('28-08-2022', 'dd-mm-yyyy'), to_date('23-01-2024', 'dd-mm-yyyy'), 39313492, 97526793);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (93066430, 'Reliability of detection systems', 'Escalated', to_date('16-01-2023', 'dd-mm-yyyy'), to_date('08-08-2023', 'dd-mm-yyyy'), 86514668, 86972825);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (39254177, 'Maintenance and operational costs', 'Escalated', to_date('26-02-2023', 'dd-mm-yyyy'), to_date('25-08-2023', 'dd-mm-yyyy'), 83480577, 63542839);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (50418872, 'Maintenance and operational costs', 'Escalated', to_date('04-02-2023', 'dd-mm-yyyy'), to_date('24-03-2024', 'dd-mm-yyyy'), 19137978, 30319594);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (18275858, 'Interception accuracy', 'Pending', to_date('15-06-2022', 'dd-mm-yyyy'), to_date('27-06-2023', 'dd-mm-yyyy'), 92665521, 56227838);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (35893748, 'False positives and negatives', 'Open', to_date('12-01-2022', 'dd-mm-yyyy'), to_date('20-11-2023', 'dd-mm-yyyy'), 72930320, 26168416);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (62648268, 'False positives and negatives', 'Open', to_date('10-02-2022', 'dd-mm-yyyy'), to_date('13-02-2024', 'dd-mm-yyyy'), 54670908, 48525494);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (65130286, 'Maintenance and operational costs', 'Escalated', to_date('10-05-2022', 'dd-mm-yyyy'), to_date('08-03-2024', 'dd-mm-yyyy'), 54670908, 26125772);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (28059600, 'Vulnerability to cyber attacks', 'Resolved', to_date('24-02-2023', 'dd-mm-yyyy'), to_date('13-06-2023', 'dd-mm-yyyy'), 57352525, 81203133);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (40484102, 'Environmental adaptability', 'Escalated', to_date('29-11-2022', 'dd-mm-yyyy'), to_date('22-10-2023', 'dd-mm-yyyy'), 59933677, 86972825);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (16068918, 'Environmental adaptability', 'Escalated', to_date('02-05-2022', 'dd-mm-yyyy'), to_date('28-08-2023', 'dd-mm-yyyy'), 54103386, 44982031);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (70291095, 'Environmental adaptability', 'Open', to_date('26-07-2022', 'dd-mm-yyyy'), to_date('20-03-2024', 'dd-mm-yyyy'), 30556154, 32336221);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (10873942, 'Reliability of detection systems', 'Pending', to_date('05-01-2022', 'dd-mm-yyyy'), to_date('22-10-2023', 'dd-mm-yyyy'), 69372437, 41135368);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (73966461, 'Communication latency', 'Pending', to_date('29-05-2022', 'dd-mm-yyyy'), to_date('07-03-2024', 'dd-mm-yyyy'), 19137978, 71399259);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (39089852, 'Reliability of detection systems', 'Pending', to_date('26-03-2022', 'dd-mm-yyyy'), to_date('13-01-2024', 'dd-mm-yyyy'), 61171248, 92923016);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (95437592, 'Reliability of detection systems', 'Open', to_date('05-12-2022', 'dd-mm-yyyy'), to_date('05-02-2024', 'dd-mm-yyyy'), 33067757, 10389457);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (14974418, 'False positives and negatives', 'Open', to_date('09-10-2022', 'dd-mm-yyyy'), to_date('27-05-2023', 'dd-mm-yyyy'), 74677527, 70452684);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (43981920, 'Interception accuracy', 'Open', to_date('30-03-2022', 'dd-mm-yyyy'), to_date('14-04-2024', 'dd-mm-yyyy'), 72063537, 40981256);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (51864819, 'False positives and negatives', 'Closed', to_date('15-07-2022', 'dd-mm-yyyy'), to_date('26-11-2023', 'dd-mm-yyyy'), 33314613, 63342886);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (13034880, 'False positives and negatives', 'Resolved', to_date('25-10-2022', 'dd-mm-yyyy'), to_date('07-10-2023', 'dd-mm-yyyy'), 50467355, 63542839);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (29781003, 'Vulnerability to cyber attacks', 'Open', to_date('06-04-2022', 'dd-mm-yyyy'), to_date('02-01-2024', 'dd-mm-yyyy'), 16844774, 33591003);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (44574198, 'Communication latency', 'Escalated', to_date('08-08-2022', 'dd-mm-yyyy'), to_date('11-03-2024', 'dd-mm-yyyy'), 83480577, 42947560);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (52324247, 'Integration with existing defense systems', 'Pending', to_date('01-02-2023', 'dd-mm-yyyy'), to_date('04-06-2023', 'dd-mm-yyyy'), 32877721, 88442161);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (34899600, 'Reliability of detection systems', 'Escalated', to_date('08-07-2022', 'dd-mm-yyyy'), to_date('29-06-2023', 'dd-mm-yyyy'), 43265993, 84153294);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (61282769, 'Reliability of detection systems', 'Open', to_date('09-06-2022', 'dd-mm-yyyy'), to_date('19-09-2023', 'dd-mm-yyyy'), 85003854, 28834144);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (77636785, 'Supply chain security', 'Closed', to_date('16-01-2023', 'dd-mm-yyyy'), to_date('15-02-2024', 'dd-mm-yyyy'), 51638591, 16120175);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (67873854, 'Environmental adaptability', 'Closed', to_date('23-06-2022', 'dd-mm-yyyy'), to_date('05-08-2023', 'dd-mm-yyyy'), 63442847, 45826801);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (87226180, 'Environmental adaptability', 'Pending', to_date('07-04-2023', 'dd-mm-yyyy'), to_date('01-07-2023', 'dd-mm-yyyy'), 62218719, 28716947);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (83428878, 'Environmental adaptability', 'Resolved', to_date('17-02-2022', 'dd-mm-yyyy'), to_date('26-02-2024', 'dd-mm-yyyy'), 92665521, 25441111);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (41635474, 'Interception accuracy', 'Pending', to_date('09-05-2022', 'dd-mm-yyyy'), to_date('17-11-2023', 'dd-mm-yyyy'), 16596417, 52928864);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (52688957, 'Supply chain security', 'Pending', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('01-10-2023', 'dd-mm-yyyy'), 77642002, 18192279);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (82185343, 'Reliability of detection systems', 'Open', to_date('27-04-2022', 'dd-mm-yyyy'), to_date('30-10-2023', 'dd-mm-yyyy'), 86054195, 65968564);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (77849654, 'Reliability of detection systems', 'Resolved', to_date('04-01-2023', 'dd-mm-yyyy'), to_date('17-01-2024', 'dd-mm-yyyy'), 83177693, 59504229);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (81825037, 'False positives and negatives', 'Pending', to_date('08-07-2022', 'dd-mm-yyyy'), to_date('24-08-2023', 'dd-mm-yyyy'), 54088195, 63310475);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (44198239, 'Communication latency', 'Open', to_date('16-02-2023', 'dd-mm-yyyy'), to_date('06-01-2024', 'dd-mm-yyyy'), 89936499, 77375983);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (66563632, 'Reliability of detection systems', 'Closed', to_date('04-12-2022', 'dd-mm-yyyy'), to_date('22-04-2024', 'dd-mm-yyyy'), 30556154, 33120027);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (36751476, 'Vulnerability to cyber attacks', 'Escalated', to_date('17-01-2022', 'dd-mm-yyyy'), to_date('27-01-2024', 'dd-mm-yyyy'), 89241937, 57172755);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (68678788, 'Operator training and human error', 'Escalated', to_date('06-04-2022', 'dd-mm-yyyy'), to_date('25-09-2023', 'dd-mm-yyyy'), 70266179, 96081193);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (14850713, 'False positives and negatives', 'Open', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('31-08-2023', 'dd-mm-yyyy'), 99433231, 61080008);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (60412706, 'Supply chain security', 'Pending', to_date('27-04-2022', 'dd-mm-yyyy'), to_date('22-10-2023', 'dd-mm-yyyy'), 33314613, 58798436);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (96329260, 'Supply chain security', 'Escalated', to_date('16-12-2022', 'dd-mm-yyyy'), to_date('09-02-2024', 'dd-mm-yyyy'), 19792292, 40279638);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (53749795, 'Vulnerability to cyber attacks', 'Resolved', to_date('01-01-2022', 'dd-mm-yyyy'), to_date('14-01-2024', 'dd-mm-yyyy'), 56882009, 12471457);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (47759646, 'Reliability of detection systems', 'Closed', to_date('05-03-2022', 'dd-mm-yyyy'), to_date('11-08-2023', 'dd-mm-yyyy'), 59295976, 29471845);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (51177145, 'Reliability of detection systems', 'Closed', to_date('24-03-2022', 'dd-mm-yyyy'), to_date('19-03-2024', 'dd-mm-yyyy'), 20113136, 65252375);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (90540253, 'Vulnerability to cyber attacks', 'Pending', to_date('26-04-2022', 'dd-mm-yyyy'), to_date('01-03-2024', 'dd-mm-yyyy'), 34017820, 29260815);
commit;
prompt 100 records committed...
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (64682469, 'False positives and negatives', 'Escalated', to_date('21-04-2022', 'dd-mm-yyyy'), to_date('28-03-2024', 'dd-mm-yyyy'), 71358712, 48523546);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (47317184, 'Communication latency', 'Open', to_date('25-09-2022', 'dd-mm-yyyy'), to_date('14-07-2023', 'dd-mm-yyyy'), 91466324, 71399259);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (91269522, 'Reliability of detection systems', 'Resolved', to_date('29-12-2022', 'dd-mm-yyyy'), to_date('15-10-2023', 'dd-mm-yyyy'), 64207208, 21751206);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (87582926, 'Reliability of detection systems', 'Open', to_date('31-01-2022', 'dd-mm-yyyy'), to_date('13-09-2023', 'dd-mm-yyyy'), 54103386, 29260815);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (53593307, 'Supply chain security', 'Resolved', to_date('22-05-2022', 'dd-mm-yyyy'), to_date('07-02-2024', 'dd-mm-yyyy'), 16752796, 54569073);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (18373426, 'Vulnerability to cyber attacks', 'Escalated', to_date('19-02-2023', 'dd-mm-yyyy'), to_date('22-05-2023', 'dd-mm-yyyy'), 22900368, 99396967);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (19561496, 'Operator training and human error', 'Resolved', to_date('03-08-2022', 'dd-mm-yyyy'), to_date('24-10-2023', 'dd-mm-yyyy'), 56882009, 57661706);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (73924675, 'Supply chain security', 'Escalated', to_date('29-03-2022', 'dd-mm-yyyy'), to_date('09-02-2024', 'dd-mm-yyyy'), 61154579, 65252375);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (25539518, 'Communication latency', 'Resolved', to_date('09-10-2022', 'dd-mm-yyyy'), to_date('13-05-2023', 'dd-mm-yyyy'), 15593866, 86198357);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (80073705, 'Maintenance and operational costs', 'Pending', to_date('28-04-2023', 'dd-mm-yyyy'), to_date('25-03-2024', 'dd-mm-yyyy'), 90862878, 80099462);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (59759662, 'Operator training and human error', 'Escalated', to_date('06-02-2022', 'dd-mm-yyyy'), to_date('29-09-2023', 'dd-mm-yyyy'), 96178588, 40981256);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (33222114, 'Vulnerability to cyber attacks', 'Resolved', to_date('05-01-2022', 'dd-mm-yyyy'), to_date('11-07-2023', 'dd-mm-yyyy'), 31650026, 92639077);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (36294291, 'Maintenance and operational costs', 'Closed', to_date('01-04-2023', 'dd-mm-yyyy'), to_date('12-01-2024', 'dd-mm-yyyy'), 23720801, 25441111);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (32947823, 'Communication latency', 'Resolved', to_date('11-01-2022', 'dd-mm-yyyy'), to_date('26-08-2023', 'dd-mm-yyyy'), 16596417, 72012718);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (61134925, 'Communication latency', 'Closed', to_date('12-06-2022', 'dd-mm-yyyy'), to_date('29-03-2024', 'dd-mm-yyyy'), 54088195, 63342886);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (69977690, 'Environmental adaptability', 'Pending', to_date('15-08-2022', 'dd-mm-yyyy'), to_date('25-04-2024', 'dd-mm-yyyy'), 41522255, 57661706);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (41147454, 'Operator training and human error', 'Open', to_date('18-04-2022', 'dd-mm-yyyy'), to_date('21-02-2024', 'dd-mm-yyyy'), 17882271, 85894488);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (30344986, 'Reliability of detection systems', 'Closed', to_date('08-08-2022', 'dd-mm-yyyy'), to_date('06-04-2024', 'dd-mm-yyyy'), 86514668, 89845799);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (29574132, 'Supply chain security', 'Pending', to_date('17-07-2022', 'dd-mm-yyyy'), to_date('11-10-2023', 'dd-mm-yyyy'), 99433231, 16551905);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (70276377, 'Environmental adaptability', 'Pending', to_date('05-02-2022', 'dd-mm-yyyy'), to_date('28-10-2023', 'dd-mm-yyyy'), 85003854, 21006417);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (48950276, 'Interception accuracy', 'Resolved', to_date('30-01-2023', 'dd-mm-yyyy'), to_date('04-04-2024', 'dd-mm-yyyy'), 89799326, 39457119);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (57808196, 'Supply chain security', 'Open', to_date('21-04-2023', 'dd-mm-yyyy'), to_date('02-01-2024', 'dd-mm-yyyy'), 67214968, 52948447);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (29422727, 'Maintenance and operational costs', 'Closed', to_date('16-12-2022', 'dd-mm-yyyy'), to_date('28-09-2023', 'dd-mm-yyyy'), 17634484, 53490786);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (34446198, 'Integration with existing defense systems', 'Resolved', to_date('27-05-2022', 'dd-mm-yyyy'), to_date('03-04-2024', 'dd-mm-yyyy'), 65702533, 61080008);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (68123154, 'Integration with existing defense systems', 'Resolved', to_date('07-04-2022', 'dd-mm-yyyy'), to_date('15-04-2024', 'dd-mm-yyyy'), 84657835, 16551905);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (86481840, 'Maintenance and operational costs', 'Pending', to_date('26-06-2022', 'dd-mm-yyyy'), to_date('16-03-2024', 'dd-mm-yyyy'), 73291243, 11678217);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (79087165, 'Interception accuracy', 'Closed', to_date('02-01-2022', 'dd-mm-yyyy'), to_date('16-03-2024', 'dd-mm-yyyy'), 34849605, 68840671);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (78986326, 'Communication latency', 'Closed', to_date('29-09-2022', 'dd-mm-yyyy'), to_date('31-10-2023', 'dd-mm-yyyy'), 31650026, 53490786);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (73844950, 'Vulnerability to cyber attacks', 'Pending', to_date('08-04-2023', 'dd-mm-yyyy'), to_date('15-05-2023', 'dd-mm-yyyy'), 67214968, 30319594);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (89146238, 'Reliability of detection systems', 'Open', to_date('31-08-2022', 'dd-mm-yyyy'), to_date('16-09-2023', 'dd-mm-yyyy'), 21509784, 32430536);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (55865847, 'Vulnerability to cyber attacks', 'Open', to_date('21-03-2022', 'dd-mm-yyyy'), to_date('12-10-2023', 'dd-mm-yyyy'), 84360223, 14758552);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (27606515, 'Supply chain security', 'Escalated', to_date('03-09-2022', 'dd-mm-yyyy'), to_date('12-07-2023', 'dd-mm-yyyy'), 15593866, 86198357);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (68142703, 'Vulnerability to cyber attacks', 'Pending', to_date('08-01-2023', 'dd-mm-yyyy'), to_date('29-11-2023', 'dd-mm-yyyy'), 99979592, 16120175);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (29972894, 'Communication latency', 'Open', to_date('07-01-2022', 'dd-mm-yyyy'), to_date('16-06-2023', 'dd-mm-yyyy'), 85682722, 25441111);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (97977316, 'Environmental adaptability', 'Pending', to_date('22-12-2022', 'dd-mm-yyyy'), to_date('20-03-2024', 'dd-mm-yyyy'), 82793030, 26386141);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (63721602, 'Maintenance and operational costs', 'Pending', to_date('22-10-2022', 'dd-mm-yyyy'), to_date('16-01-2024', 'dd-mm-yyyy'), 87552354, 34179616);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (57100501, 'False positives and negatives', 'Escalated', to_date('21-06-2022', 'dd-mm-yyyy'), to_date('30-01-2024', 'dd-mm-yyyy'), 39403818, 13830308);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (51594193, 'Environmental adaptability', 'Resolved', to_date('09-03-2023', 'dd-mm-yyyy'), to_date('06-05-2023', 'dd-mm-yyyy'), 61456823, 64848868);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (34254472, 'Communication latency', 'Escalated', to_date('10-02-2023', 'dd-mm-yyyy'), to_date('18-09-2023', 'dd-mm-yyyy'), 39370182, 80318978);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (69244847, 'Integration with existing defense systems', 'Pending', to_date('19-02-2022', 'dd-mm-yyyy'), to_date('26-10-2023', 'dd-mm-yyyy'), 31021143, 51793598);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (61906229, 'Communication latency', 'Resolved', to_date('21-06-2022', 'dd-mm-yyyy'), to_date('03-04-2024', 'dd-mm-yyyy'), 54748279, 64365513);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (25581313, 'Reliability of detection systems', 'Resolved', to_date('08-04-2023', 'dd-mm-yyyy'), to_date('16-04-2024', 'dd-mm-yyyy'), 31417541, 52928864);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (84473554, 'Maintenance and operational costs', 'Escalated', to_date('24-03-2023', 'dd-mm-yyyy'), to_date('23-01-2024', 'dd-mm-yyyy'), 59279749, 81026262);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (67023843, 'Reliability of detection systems', 'Closed', to_date('29-01-2023', 'dd-mm-yyyy'), to_date('12-04-2024', 'dd-mm-yyyy'), 33133087, 74854868);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (32954964, 'Maintenance and operational costs', 'Pending', to_date('14-10-2022', 'dd-mm-yyyy'), to_date('10-04-2024', 'dd-mm-yyyy'), 50467355, 10670802);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (84924076, 'Interception accuracy', 'Pending', to_date('17-04-2022', 'dd-mm-yyyy'), to_date('05-10-2023', 'dd-mm-yyyy'), 17634484, 60180068);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (55786629, 'False positives and negatives', 'Resolved', to_date('13-01-2023', 'dd-mm-yyyy'), to_date('19-01-2024', 'dd-mm-yyyy'), 31650026, 29471845);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (66762756, 'Operator training and human error', 'Closed', to_date('10-08-2022', 'dd-mm-yyyy'), to_date('07-08-2023', 'dd-mm-yyyy'), 71358712, 54917654);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (98727756, 'Communication latency', 'Pending', to_date('30-05-2022', 'dd-mm-yyyy'), to_date('07-07-2023', 'dd-mm-yyyy'), 30556154, 40981256);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (89606516, 'Integration with existing defense systems', 'Open', to_date('17-08-2022', 'dd-mm-yyyy'), to_date('27-03-2024', 'dd-mm-yyyy'), 59743184, 48525494);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (43226358, 'Integration with existing defense systems', 'Escalated', to_date('31-08-2022', 'dd-mm-yyyy'), to_date('05-11-2023', 'dd-mm-yyyy'), 71061207, 86503833);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (66774650, 'Environmental adaptability', 'Resolved', to_date('14-07-2022', 'dd-mm-yyyy'), to_date('07-08-2023', 'dd-mm-yyyy'), 99979592, 64848868);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (73664559, 'Reliability of detection systems', 'Resolved', to_date('17-04-2022', 'dd-mm-yyyy'), to_date('04-02-2024', 'dd-mm-yyyy'), 20834380, 76173383);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (48871890, 'Communication latency', 'Pending', to_date('20-09-2022', 'dd-mm-yyyy'), to_date('11-05-2023', 'dd-mm-yyyy'), 19137978, 56090177);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (84751771, 'False positives and negatives', 'Open', to_date('12-08-2022', 'dd-mm-yyyy'), to_date('22-03-2024', 'dd-mm-yyyy'), 34849605, 61080008);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (86407629, 'Vulnerability to cyber attacks', 'Closed', to_date('01-01-2022', 'dd-mm-yyyy'), to_date('13-09-2023', 'dd-mm-yyyy'), 64103674, 56090177);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (51750041, 'False positives and negatives', 'Open', to_date('27-08-2022', 'dd-mm-yyyy'), to_date('26-09-2023', 'dd-mm-yyyy'), 17882271, 12270385);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (36270897, 'Reliability of detection systems', 'Open', to_date('06-03-2022', 'dd-mm-yyyy'), to_date('01-10-2023', 'dd-mm-yyyy'), 36812939, 32336221);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (23803808, 'Interception accuracy', 'Resolved', to_date('17-08-2022', 'dd-mm-yyyy'), to_date('03-11-2023', 'dd-mm-yyyy'), 31417541, 50974786);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (36488564, 'Reliability of detection systems', 'Resolved', to_date('19-04-2023', 'dd-mm-yyyy'), to_date('19-12-2023', 'dd-mm-yyyy'), 37207125, 38008634);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (65031041, 'Supply chain security', 'Pending', to_date('15-01-2022', 'dd-mm-yyyy'), to_date('13-02-2024', 'dd-mm-yyyy'), 94146730, 65968564);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (46086848, 'Interception accuracy', 'Resolved', to_date('22-04-2022', 'dd-mm-yyyy'), to_date('11-09-2023', 'dd-mm-yyyy'), 71061207, 37100134);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (44839379, 'Operator training and human error', 'Closed', to_date('09-11-2022', 'dd-mm-yyyy'), to_date('24-12-2023', 'dd-mm-yyyy'), 84360223, 26386141);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (67628147, 'False positives and negatives', 'Open', to_date('24-08-2022', 'dd-mm-yyyy'), to_date('24-08-2023', 'dd-mm-yyyy'), 36812939, 48696874);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (48784419, 'Supply chain security', 'Pending', to_date('15-11-2022', 'dd-mm-yyyy'), to_date('26-09-2023', 'dd-mm-yyyy'), 61456823, 40279638);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (82231541, 'Communication latency', 'Open', to_date('30-06-2022', 'dd-mm-yyyy'), to_date('28-03-2024', 'dd-mm-yyyy'), 28817809, 21561518);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (29812682, 'Integration with existing defense systems', 'Open', to_date('29-11-2022', 'dd-mm-yyyy'), to_date('27-05-2023', 'dd-mm-yyyy'), 33314613, 34547826);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (78731023, 'Operator training and human error', 'Escalated', to_date('27-01-2023', 'dd-mm-yyyy'), to_date('16-10-2023', 'dd-mm-yyyy'), 92355989, 53330905);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (27554040, 'Supply chain security', 'Closed', to_date('02-02-2022', 'dd-mm-yyyy'), to_date('27-07-2023', 'dd-mm-yyyy'), 36373252, 85894488);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (73205587, 'Environmental adaptability', 'Resolved', to_date('23-06-2022', 'dd-mm-yyyy'), to_date('16-05-2023', 'dd-mm-yyyy'), 87982560, 25441111);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (46072550, 'Integration with existing defense systems', 'Open', to_date('09-10-2022', 'dd-mm-yyyy'), to_date('18-04-2024', 'dd-mm-yyyy'), 34849605, 21325971);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (60554752, 'False positives and negatives', 'Pending', to_date('06-02-2023', 'dd-mm-yyyy'), to_date('03-11-2023', 'dd-mm-yyyy'), 23759349, 12125716);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (98775651, 'Vulnerability to cyber attacks', 'Escalated', to_date('10-11-2022', 'dd-mm-yyyy'), to_date('15-02-2024', 'dd-mm-yyyy'), 51957721, 98674817);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (39216944, 'Supply chain security', 'Closed', to_date('22-03-2022', 'dd-mm-yyyy'), to_date('05-05-2023', 'dd-mm-yyyy'), 72063537, 58761637);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (68644548, 'Integration with existing defense systems', 'Resolved', to_date('05-04-2023', 'dd-mm-yyyy'), to_date('31-05-2023', 'dd-mm-yyyy'), 59279749, 15776023);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (91661343, 'Supply chain security', 'Closed', to_date('13-12-2022', 'dd-mm-yyyy'), to_date('30-03-2024', 'dd-mm-yyyy'), 85889675, 74053824);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (83208405, 'Interception accuracy', 'Escalated', to_date('07-09-2022', 'dd-mm-yyyy'), to_date('12-08-2023', 'dd-mm-yyyy'), 60843836, 74854868);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (60051393, 'Reliability of detection systems', 'Closed', to_date('11-03-2022', 'dd-mm-yyyy'), to_date('06-04-2024', 'dd-mm-yyyy'), 19792292, 92724719);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (32366595, 'Maintenance and operational costs', 'Open', to_date('01-09-2022', 'dd-mm-yyyy'), to_date('18-11-2023', 'dd-mm-yyyy'), 86514668, 11449262);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (86605121, 'Maintenance and operational costs', 'Open', to_date('01-09-2022', 'dd-mm-yyyy'), to_date('15-07-2023', 'dd-mm-yyyy'), 95814419, 46497757);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (83891763, 'Reliability of detection systems', 'Resolved', to_date('24-07-2022', 'dd-mm-yyyy'), to_date('13-05-2023', 'dd-mm-yyyy'), 62933363, 84153294);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (64788733, 'Supply chain security', 'Pending', to_date('31-12-2022', 'dd-mm-yyyy'), to_date('30-07-2023', 'dd-mm-yyyy'), 10840739, 30057569);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (71846855, 'Environmental adaptability', 'Resolved', to_date('15-07-2022', 'dd-mm-yyyy'), to_date('25-04-2024', 'dd-mm-yyyy'), 74742649, 16305031);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (48700675, 'Supply chain security', 'Escalated', to_date('18-08-2022', 'dd-mm-yyyy'), to_date('26-05-2023', 'dd-mm-yyyy'), 94249883, 75222502);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (67846549, 'Operator training and human error', 'Pending', to_date('15-06-2022', 'dd-mm-yyyy'), to_date('14-09-2023', 'dd-mm-yyyy'), 83846105, 30319594);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (26958413, 'Reliability of detection systems', 'Escalated', to_date('03-08-2022', 'dd-mm-yyyy'), to_date('15-01-2024', 'dd-mm-yyyy'), 92535882, 68255934);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (19712630, 'Environmental adaptability', 'Closed', to_date('28-07-2022', 'dd-mm-yyyy'), to_date('17-03-2024', 'dd-mm-yyyy'), 81525413, 95607525);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (72214628, 'Vulnerability to cyber attacks', 'Closed', to_date('02-09-2022', 'dd-mm-yyyy'), to_date('25-08-2023', 'dd-mm-yyyy'), 62933363, 63310475);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (27238890, 'Vulnerability to cyber attacks', 'Open', to_date('26-02-2023', 'dd-mm-yyyy'), to_date('28-11-2023', 'dd-mm-yyyy'), 16354941, 76805170);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (91228383, 'Vulnerability to cyber attacks', 'Closed', to_date('19-07-2022', 'dd-mm-yyyy'), to_date('05-04-2024', 'dd-mm-yyyy'), 52321215, 40664733);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (46119033, 'Environmental adaptability', 'Closed', to_date('08-05-2022', 'dd-mm-yyyy'), to_date('08-09-2023', 'dd-mm-yyyy'), 27044249, 83387331);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (81324986, 'Interception accuracy', 'Pending', to_date('07-02-2023', 'dd-mm-yyyy'), to_date('09-03-2024', 'dd-mm-yyyy'), 28411817, 40279638);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (49225794, 'Vulnerability to cyber attacks', 'Open', to_date('22-01-2023', 'dd-mm-yyyy'), to_date('29-12-2023', 'dd-mm-yyyy'), 13629800, 50974786);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (90220880, 'Supply chain security', 'Open', to_date('12-06-2022', 'dd-mm-yyyy'), to_date('04-01-2024', 'dd-mm-yyyy'), 33133087, 21006417);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (24986168, 'Communication latency', 'Resolved', to_date('30-05-2022', 'dd-mm-yyyy'), to_date('25-02-2024', 'dd-mm-yyyy'), 64207208, 34179616);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (35691818, 'Maintenance and operational costs', 'Pending', to_date('24-02-2023', 'dd-mm-yyyy'), to_date('04-05-2023', 'dd-mm-yyyy'), 55819347, 37896029);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (96201124, 'Interception accuracy', 'Escalated', to_date('09-08-2022', 'dd-mm-yyyy'), to_date('22-05-2023', 'dd-mm-yyyy'), 52321215, 92724719);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (92548936, 'Supply chain security', 'Open', to_date('09-06-2022', 'dd-mm-yyyy'), to_date('06-10-2023', 'dd-mm-yyyy'), 63442847, 39457119);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (94933581, 'Environmental adaptability', 'Closed', to_date('11-02-2023', 'dd-mm-yyyy'), to_date('22-05-2023', 'dd-mm-yyyy'), 62526376, 25470185);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid)
values (94983015, 'Environmental adaptability', 'Pending', to_date('16-01-2022', 'dd-mm-yyyy'), to_date('22-02-2024', 'dd-mm-yyyy'), 96895448, 85894488);
commit;
prompt 200 records loaded
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
