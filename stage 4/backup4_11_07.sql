prompt PL/SQL Developer Export Tables for user SYS@XE
prompt Created by Dabush on Thursday, 11 July 2024
set feedback off
set define off

prompt Dropping ACCOUNT_MANAGER...
drop table ACCOUNT_MANAGER cascade constraints;
prompt Dropping CUSTOMERS...
drop table CUSTOMERS cascade constraints;
prompt Dropping AIR_ORDER...
drop table AIR_ORDER cascade constraints;
prompt Dropping RAW_MATERIALS...
drop table RAW_MATERIALS cascade constraints;
prompt Dropping CUSTOMER_RAW_MATERIALS...
drop table CUSTOMER_RAW_MATERIALS cascade constraints;
prompt Dropping MACHINE_MAINTENANCE...
drop table MACHINE_MAINTENANCE cascade constraints;
prompt Dropping MACHINES...
drop table MACHINES cascade constraints;
prompt Dropping ORDER_MACHINE...
drop table ORDER_MACHINE cascade constraints;
prompt Dropping TOOLS...
drop table TOOLS cascade constraints;
prompt Dropping ORDER_TOOL...
drop table ORDER_TOOL cascade constraints;
prompt Dropping PRODUCT...
drop table PRODUCT cascade constraints;
prompt Dropping PART_OF...
drop table PART_OF cascade constraints;
prompt Dropping PAYMENT...
drop table PAYMENT cascade constraints;
prompt Dropping PRODUCTION_ORDERS...
drop table PRODUCTION_ORDERS cascade constraints;
prompt Dropping SUPPORT_TICKET...
drop table SUPPORT_TICKET cascade constraints;
prompt Dropping SUPPORT_TICKET_TOOL...
drop table SUPPORT_TICKET_TOOL cascade constraints;
prompt Dropping WAREHOUSES...
drop table WAREHOUSES cascade constraints;
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

prompt Creating RAW_MATERIALS...
create table RAW_MATERIALS
(
  material_id       INTEGER not null,
  material_name     VARCHAR2(100) not null,
  quantity_in_stock INTEGER not null,
  supplier          VARCHAR2(100) not null
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
alter table RAW_MATERIALS
  add primary key (MATERIAL_ID)
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
alter table RAW_MATERIALS
  add constraint CHK_QUANTITY
  check (Quantity_in_Stock > 0);
alter table RAW_MATERIALS
  add constraint CHK_QUANTITY_POSITIVE
  check (Quantity_in_Stock > 0);

prompt Creating CUSTOMER_RAW_MATERIALS...
create table CUSTOMER_RAW_MATERIALS
(
  customer_id INTEGER not null,
  material_id INTEGER not null
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
alter table CUSTOMER_RAW_MATERIALS
  add primary key (CUSTOMER_ID, MATERIAL_ID)
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
alter table CUSTOMER_RAW_MATERIALS
  add foreign key (CUSTOMER_ID)
  references CUSTOMERS (CUSTOMERID);
alter table CUSTOMER_RAW_MATERIALS
  add foreign key (MATERIAL_ID)
  references RAW_MATERIALS (MATERIAL_ID);

prompt Creating MACHINE_MAINTENANCE...
create table MACHINE_MAINTENANCE
(
  maintenance_id   INTEGER not null,
  machine_id       INTEGER not null,
  maintenance_date DATE not null,
  maintenance_type VARCHAR2(100) not null,
  status           VARCHAR2(100) not null
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
alter table MACHINE_MAINTENANCE
  add primary key (MAINTENANCE_ID)
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

prompt Creating MACHINES...
create table MACHINES
(
  machine_id        INTEGER not null,
  machine_name      VARCHAR2(100) not null,
  installation_date DATE not null,
  status            VARCHAR2(100) default 'Active' not null,
  maintenance_id    INTEGER not null,
  customer_id       NUMBER(38)
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
alter table MACHINES
  add primary key (MACHINE_ID)
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
alter table MACHINES
  add constraint FK_CUSTOMER_ID foreign key (CUSTOMER_ID)
  references CUSTOMERS (CUSTOMERID);
alter table MACHINES
  add foreign key (MAINTENANCE_ID)
  references MACHINE_MAINTENANCE (MAINTENANCE_ID);

prompt Creating ORDER_MACHINE...
create table ORDER_MACHINE
(
  order_id   INTEGER not null,
  machine_id INTEGER not null
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
alter table ORDER_MACHINE
  add primary key (ORDER_ID, MACHINE_ID)
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
alter table ORDER_MACHINE
  add foreign key (ORDER_ID)
  references AIR_ORDER (ORDERID);
alter table ORDER_MACHINE
  add foreign key (MACHINE_ID)
  references MACHINES (MACHINE_ID);

prompt Creating TOOLS...
create table TOOLS
(
  tool_id          INTEGER not null,
  tool_name        VARCHAR2(100) not null,
  manufacture_date DATE not null,
  status           VARCHAR2(100) not null
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
alter table TOOLS
  add primary key (TOOL_ID)
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
alter table TOOLS
  add constraint CHK_MANUFACTURE_DATE
  check (Manufacture_Date > TO_DATE('2000-01-01', 'YYYY-MM-DD'));

prompt Creating ORDER_TOOL...
create table ORDER_TOOL
(
  order_id INTEGER not null,
  tool_id  INTEGER not null
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
alter table ORDER_TOOL
  add primary key (ORDER_ID, TOOL_ID)
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
alter table ORDER_TOOL
  add foreign key (ORDER_ID)
  references AIR_ORDER (ORDERID);
alter table ORDER_TOOL
  add foreign key (TOOL_ID)
  references TOOLS (TOOL_ID);

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

prompt Creating PRODUCTION_ORDERS...
create table PRODUCTION_ORDERS
(
  production_order_id INTEGER not null,
  tool_id             INTEGER not null,
  quantity            INTEGER not null,
  start_date          DATE not null,
  due_date            DATE not null,
  status              VARCHAR2(100) not null,
  account_manager_id  INTEGER
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
alter table PRODUCTION_ORDERS
  add primary key (PRODUCTION_ORDER_ID)
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
alter table PRODUCTION_ORDERS
  add constraint FK_ACCOUNT_MANAGER_ID foreign key (ACCOUNT_MANAGER_ID)
  references ACCOUNT_MANAGER (ACCOUNTMANAGERID);
alter table PRODUCTION_ORDERS
  add foreign key (TOOL_ID)
  references TOOLS (TOOL_ID);
alter table PRODUCTION_ORDERS
  add constraint CHK_START_DATE
  check (Start_Date <= Due_Date);

prompt Creating SUPPORT_TICKET...
create table SUPPORT_TICKET
(
  ticketid         NUMBER(38) not null,
  issuedescription VARCHAR2(4000) not null,
  status           VARCHAR2(50) not null,
  createddate      DATE not null,
  resolveddate     DATE,
  customerid       NUMBER(38),
  accountmanagerid NUMBER(38),
  machine_id       INTEGER
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
  add constraint FK_MACHINE_ID foreign key (MACHINE_ID)
  references MACHINES (MACHINE_ID);
alter table SUPPORT_TICKET
  add constraint FK_SUPPORT_TICKET foreign key (CUSTOMERID)
  references CUSTOMERS (CUSTOMERID);
alter table SUPPORT_TICKET
  add constraint FK_SUPPORT_TICKET2 foreign key (ACCOUNTMANAGERID)
  references ACCOUNT_MANAGER (ACCOUNTMANAGERID);
grant select, insert, update, delete, references, alter, index, debug, read on SUPPORT_TICKET to PUBLIC;

prompt Creating SUPPORT_TICKET_TOOL...
create table SUPPORT_TICKET_TOOL
(
  ticket_id INTEGER not null,
  tool_id   INTEGER not null
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
alter table SUPPORT_TICKET_TOOL
  add primary key (TICKET_ID, TOOL_ID)
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
alter table SUPPORT_TICKET_TOOL
  add foreign key (TICKET_ID)
  references SUPPORT_TICKET (TICKETID);
alter table SUPPORT_TICKET_TOOL
  add foreign key (TOOL_ID)
  references TOOLS (TOOL_ID);

prompt Creating WAREHOUSES...
create table WAREHOUSES
(
  warehouse_id       INTEGER not null,
  warehouse_location VARCHAR2(100) not null,
  capacity           INTEGER not null,
  current_quantity   INTEGER not null
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
alter table WAREHOUSES
  add primary key (WAREHOUSE_ID)
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

prompt Disabling triggers for ACCOUNT_MANAGER...
alter table ACCOUNT_MANAGER disable all triggers;
prompt Disabling triggers for CUSTOMERS...
alter table CUSTOMERS disable all triggers;
prompt Disabling triggers for AIR_ORDER...
alter table AIR_ORDER disable all triggers;
prompt Disabling triggers for RAW_MATERIALS...
alter table RAW_MATERIALS disable all triggers;
prompt Disabling triggers for CUSTOMER_RAW_MATERIALS...
alter table CUSTOMER_RAW_MATERIALS disable all triggers;
prompt Disabling triggers for MACHINE_MAINTENANCE...
alter table MACHINE_MAINTENANCE disable all triggers;
prompt Disabling triggers for MACHINES...
alter table MACHINES disable all triggers;
prompt Disabling triggers for ORDER_MACHINE...
alter table ORDER_MACHINE disable all triggers;
prompt Disabling triggers for TOOLS...
alter table TOOLS disable all triggers;
prompt Disabling triggers for ORDER_TOOL...
alter table ORDER_TOOL disable all triggers;
prompt Disabling triggers for PRODUCT...
alter table PRODUCT disable all triggers;
prompt Disabling triggers for PART_OF...
alter table PART_OF disable all triggers;
prompt Disabling triggers for PAYMENT...
alter table PAYMENT disable all triggers;
prompt Disabling triggers for PRODUCTION_ORDERS...
alter table PRODUCTION_ORDERS disable all triggers;
prompt Disabling triggers for SUPPORT_TICKET...
alter table SUPPORT_TICKET disable all triggers;
prompt Disabling triggers for SUPPORT_TICKET_TOOL...
alter table SUPPORT_TICKET_TOOL disable all triggers;
prompt Disabling triggers for WAREHOUSES...
alter table WAREHOUSES disable all triggers;
prompt Disabling foreign key constraints for CUSTOMERS...
alter table CUSTOMERS disable constraint FK_CUSTOMER;
prompt Disabling foreign key constraints for AIR_ORDER...
alter table AIR_ORDER disable constraint FK_ORDER_;
prompt Disabling foreign key constraints for CUSTOMER_RAW_MATERIALS...
alter table CUSTOMER_RAW_MATERIALS disable constraint SYS_C0010561;
alter table CUSTOMER_RAW_MATERIALS disable constraint SYS_C0010562;
prompt Disabling foreign key constraints for MACHINES...
alter table MACHINES disable constraint FK_CUSTOMER_ID;
alter table MACHINES disable constraint SYS_C0010518;
prompt Disabling foreign key constraints for ORDER_MACHINE...
alter table ORDER_MACHINE disable constraint SYS_C0010551;
alter table ORDER_MACHINE disable constraint SYS_C0010552;
prompt Disabling foreign key constraints for ORDER_TOOL...
alter table ORDER_TOOL disable constraint SYS_C0010556;
alter table ORDER_TOOL disable constraint SYS_C0010557;
prompt Disabling foreign key constraints for PART_OF...
alter table PART_OF disable constraint FK_PART_OF;
alter table PART_OF disable constraint FK_PART_OF2;
prompt Disabling foreign key constraints for PAYMENT...
alter table PAYMENT disable constraint FK_PAYMENT;
prompt Disabling foreign key constraints for PRODUCTION_ORDERS...
alter table PRODUCTION_ORDERS disable constraint FK_ACCOUNT_MANAGER_ID;
alter table PRODUCTION_ORDERS disable constraint SYS_C0010532;
prompt Disabling foreign key constraints for SUPPORT_TICKET...
alter table SUPPORT_TICKET disable constraint FK_MACHINE_ID;
alter table SUPPORT_TICKET disable constraint FK_SUPPORT_TICKET;
alter table SUPPORT_TICKET disable constraint FK_SUPPORT_TICKET2;
prompt Disabling foreign key constraints for SUPPORT_TICKET_TOOL...
alter table SUPPORT_TICKET_TOOL disable constraint SYS_C0010566;
alter table SUPPORT_TICKET_TOOL disable constraint SYS_C0010567;
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
values (31650026, 'USA', '71483902', 'slee@fmt.com', '39 Santana do parnaÃ­ba Road', 'ministry of defence', 32336221);
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
prompt Loading RAW_MATERIALS...
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (905776, 'Mendelevium', 3933, 'SpaceTech Ltd');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (160724, 'Praseodymium Boride', 7680, 'Spacecraft Materials');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (269974, 'Ytterbium Phosphide', 9031, 'Titan Manufacturing');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (519029, 'Terbium Oxide', 3710, 'Stellar Components');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (97901, 'Selenium', 8339, 'Comet Supplies Inc');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (346174, 'Gadolinium Carbide', 5443, 'Interstellar Supplies');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (663099, 'Samarium Aluminum Oxynitride', 4734, 'Cosmos Components');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (67101, 'Calcium Zirconate', 6731, 'OrbitMaterial Solutions');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (639075, 'Erbium Antimonide', 7336, 'Aerospace Components');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (333858, 'Scandium Sulfide', 4453, 'Cosmos Components');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (894220, 'Meitnerium', 234, 'ExoTech Ltd');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (851784, 'Osmium', 5061, 'Spacemakers Ltd');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (849231, 'Erbium Aluminum Oxide', 1845, 'AstroParts Ltd');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (768169, 'Gadolinium Carbide', 1745, 'GlobalTech Supplies');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (397037, 'Thulium Oxide', 4894, 'Galactic Materials');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (623432, 'Ytterbium Nitride', 2227, 'InterstellarTech Ltd');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (385215, 'Zirconium Oxide', 7016, 'AstroSupplies Corp');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (864789, 'Erbium Boride', 7179, 'RocketParts Corp');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (660915, 'Chromia', 1991, 'DeepSpace Parts Ltd');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (922432, 'Bohrium', 9265, 'SpaceInnovations Inc');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (678284, 'Ferrite', 1599, 'AeroParts Co');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (848192, 'Yttrium Aluminum Oxynitride', 2809, 'Galactic Innovations');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (668383, 'Molybdenum Boride', 8097, 'Exoplanet Supplies');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (516716, 'Vanadium Boride', 4091, 'Asteroid Components');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (371613, 'Samarium', 7327, 'Starship Components');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (389138, 'Dysprosium Boride', 2263, 'AeroMaterial Solutions');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (332633, 'Cobalt', 2445, 'AstroSupply Chain');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (839250, 'Lanthanum Aluminum Oxynitride', 888, 'Eclipse Materials');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (757787, 'Holmium', 8282, 'MilkyWay Materials');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (42178, 'Sodium Aluminum Oxide', 116, 'Zenith Parts Co');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (935022, 'Silicon', 6315, 'Constellation Materials');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (425543, 'Lead', 9470, 'AeroMaterial Solutions');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (216311, 'Zinc Silicate', 278, 'SpaceTech Ltd');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (683148, 'Yttrium Aluminum Oxide', 1266, 'DeepSpace Parts Ltd');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (562572, 'Neodymium Boride', 2396, 'Cosmos Parts Corp');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (351140, 'Scandium', 4660, 'StellarSupplies Inc');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (651097, 'Lanthanum Aluminum Oxide', 232, 'AeroParts Co');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (946680, 'Magnesium Silicate', 307, 'Spacetech Suppliers');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (545466, 'Ytterbium Aluminum Oxide', 4175, 'Celestech Supplies');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (669126, 'Ytterbium Phosphide', 5666, 'AstroBuild Ltd');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (927975, 'Antimony', 5539, 'Starship Supplies Inc');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (663691, 'Lithium Aluminum Oxide', 907, 'SpaceInnovations Inc');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (894555, 'Lutetium', 5300, 'Starship Supplies Inc');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (847626, 'Erbium Aluminum Oxide', 5459, 'InterstellarTech Ltd');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (312191, 'Silica', 3446, 'AeroParts Co');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (298886, 'Cerium Carbide', 5178, 'Orbital Manufacturing');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (738850, 'Tantalum Carbide', 8962, 'Nova Manufacturing');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (207304, 'Lanthanum Nitride', 140, 'GlobalTech Supplies');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (905900, 'Carbon Fiber', 431, 'SpaceMaterials Corp');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (388261, 'Ytterbium Phosphide', 3058, 'Galactic Materials');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (763030, 'Lanthanum', 7268, 'OrbitMaterial Solutions');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (358861, 'Titanium', 8324, 'Aerospace Parts Co');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (85675, 'Niobium', 1573, 'Aerospace Parts Co');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (976599, 'Cerium Silicide', 1680, 'InterstellarTech Ltd');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (644935, 'Yttrium Nitride', 615, 'Exoplanet Supplies');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (640539, 'Hassium', 508, 'AstroManufacturing Ltd');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (940000, 'Zirconium', 9934, 'Exospace Components');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (54978, 'Nickel Aluminide', 4750, 'SpaceComponent Solutions');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (493071, 'Dysprosium Antimonide', 7069, 'Constellation Materials');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (555620, 'Scandium Aluminum Oxynitride', 8450, 'Starlight Components');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (706778, 'Iron', 5922, 'OrbitalTech Solutions');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (998255, 'Yttrium Boride', 1921, 'Horizon Supplies');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (284107, 'Dysprosium Aluminum Oxynitride', 1732, 'SpaceTech Ltd');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (209923, 'Neodymium Aluminum Oxynitride', 4541, 'AstroTech Industries');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (210820, 'Cerium Arsenide', 6681, 'Titan Manufacturing');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (2587, 'Yttrium Antimonide', 8169, 'SpaceX Supplies');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (300376, 'Cerium Aluminum Oxynitride', 6127, 'Satellite Materials');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (749306, 'Scandium Sulfide', 1185, 'AstroManufacturing Inc');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (301354, 'Holmium Oxide', 5455, 'Interstellar Supply Chain');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (522911, 'Holmium Aluminum Oxide', 3166, 'Nova Components Inc');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (567375, 'Samarium Nitride', 7565, 'Planetary Materials');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (797167, 'Hassium', 168, 'OrbitTech Corp');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (289524, 'Praseodymium Oxide', 967, 'Celestial Innovations');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (710458, 'Titanium Boride', 657, 'Satellite Components Ltd');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (291268, 'Lutetium Oxide', 8523, 'Aerospace Components');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (891944, 'Zirconium Oxide', 2038, 'LunarTech Inc');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (385884, 'Tungsten', 6793, 'LunarTech Inc');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (850247, 'Scandium Oxide', 7835, 'LunarTech Inc');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (296377, 'Ytterbium Aluminum Oxynitride', 6021, 'RocketParts Corp');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (924613, 'Thulium Oxide', 5476, 'NovaParts Ltd');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (137905, 'Californium', 738, 'Galactic Supply Chain');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (798587, 'Lead', 4714, 'Aerospace Parts Co');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (462695, 'Niobium Carbide', 994, 'Spacetech Suppliers');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (576187, 'Thulium Sulfide', 6672, 'AeroMaterial Solutions');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (867470, 'Aluminum Oxynitride', 4212, 'Interstellar Supply Chain');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (420574, 'Plutonium', 3505, 'Nova Manufacturing');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (163373, 'Dysprosium Phosphide', 7668, 'OrbitMaterial Solutions');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (755222, 'Thulium Antimonide', 8702, 'Stellar Manufacturing');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (108380, 'Terbium Sulfide', 1600, 'Interstellar Supply Chain');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (27595, 'Terbium Oxide', 7994, 'Galaxy Innovations');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (702230, 'Lithium Aluminum Oxide', 2934, 'Eclipse Materials');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (35311, 'Strontium Aluminum Oxide', 903, 'SolarTech Supplies');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (43845, 'Darmstadtium', 9644, 'NovaParts Ltd');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (814822, 'Strontium Titanate', 2910, 'Stellar Components Inc');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (751248, 'Flerovium', 5726, 'AeroParts Co');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (92585, 'Cerium Boride', 8246, 'AstroTech Industries');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (943991, 'Tantalum', 6812, 'Galactic Supply Chain');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (298724, 'Praseodymium Phosphide', 3308, 'LunarTech Inc');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (788072, 'Scandium Arsenide', 6393, 'AstroTech Industries');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (143216, 'Dysprosium Aluminum Oxynitride', 709, 'TerraMaterials Ltd');
commit;
prompt 100 records committed...
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (603360, 'Thulium Oxide', 2677, 'AstroParts Ltd');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (754551, 'Praseodymium Carbide', 3939, 'Eclipse Materials');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (533514, 'Gadolinium Sulfide', 6074, 'Horizon Supplies');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (380914, 'Scandium Arsenide', 2660, 'Interstellar Supply Chain');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (778405, 'Silicon Carbide', 7291, 'Planetary Parts Ltd');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (197323, 'Titanium Aluminide', 7827, 'Cosmos Parts Corp');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (816058, 'Praseodymium Sulfide', 4606, 'Orbit Suppliers');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (259045, 'Tantalum Carbide', 9873, 'CelestialTech Corp');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (939171, 'Copper', 2240, 'SpaceInnovations Inc');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (977724, 'Holmium Phosphide', 757, 'Stellar Manufacturing');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (805288, 'Ruthenium', 6560, 'OrbitMaterial Solutions');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (992737, 'Lutetium Phosphide', 4374, 'Zenith Parts Co');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (372276, 'Neodymium Nitride', 6523, 'AeroMaterial Solutions');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (432879, 'Tantalum Carbide', 5539, 'Satellite Materials');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (224531, 'Ytterbium Antimonide', 3971, 'LunarTech Inc');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (255623, 'Neodymium Silicide', 2487, 'Intergalactic Materials');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (117895, 'Gadolinium Boride', 9857, 'RocketMaterials Inc');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (823285, 'Titanium Aluminide', 915, 'Titan Manufacturing');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (87079, 'Roentgenium', 1099, 'Interstellar Supplies');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (41704, 'Protactinium', 8650, 'Zenith Parts Co');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (115586, 'Neodymium Carbide', 8069, 'Nebula Parts Ltd');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (61404, 'Dysprosium Antimonide', 939, 'Satellite Components Ltd');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (368134, 'Samarium Phosphide', 2684, 'TerraMaterials Ltd');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (541272, 'Scandium Oxide', 6373, 'Nebula Parts Ltd');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (985575, 'Holmium', 7153, 'Stellar Manufacturing');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (474732, 'Lawrencium', 3423, 'InterstellarTech Ltd');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (442318, 'Kevlar', 3318, 'Nova Manufacturing');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (578410, 'Arsenic', 7615, 'Pulsar Components');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (466250, 'Lutetium Antimonide', 2644, 'Comet Supplies Inc');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (243311, 'Cerium Phosphide', 9315, 'Zenith Parts Co');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (521161, 'Samarium Silicide', 6821, 'Aerospace Components');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (48488, 'Terbium Phosphide', 2154, 'SpaceParts Solutions');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (851662, 'Holmium Oxide', 8993, 'Orbit Suppliers');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (837216, 'Boron Carbide', 2069, 'CelestialTech Corp');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (90611, 'Yttrium Nitride', 5617, 'Stellar Manufacturing');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (355665, 'Cadmium Telluride', 6970, 'Starship Components');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (429029, 'Yttrium Oxide', 8940, 'Titan Manufacturing');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (454066, 'Sodium', 7031, 'Comet Supplies Inc');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (348528, 'Gadolinium Boride', 108, 'SpaceComponent Solutions');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (850389, 'Calcium Titanate', 5611, 'Planetary Materials');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (916229, 'Calcium', 2893, 'InterSpace Materials');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (456515, 'Erbium Oxide', 798, 'Rocketry Solutions');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (642187, 'Vanadium', 8052, 'SpaceComponent Solutions');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (266901, 'Actinium', 7575, 'RocketMaterials Inc');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (899308, 'Barium Zirconate', 8303, 'TerraMaterials Ltd');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (809758, 'Titanium Aluminide', 609, 'SolarTech Supplies');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (653846, 'Calcium Aluminum Oxide', 8626, 'RocketTech Industries');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (389045, 'Dysprosium Aluminum Oxynitride', 6075, 'Eclipse Materials');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (414428, 'Silicon Aluminum Oxide', 2221, 'Interstellar Supply Chain');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (624997, 'Samarium Boride', 557, 'SpaceTech Ltd');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (101942, 'Titanium Nitride', 9638, 'Satellite Materials');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (874305, 'Lutetium Boride', 7244, 'Planetary Materials');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (705048, 'Praseodymium Nitride', 654, 'NovaParts Ltd');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (135916, 'Hafnium', 1610, 'Pulsar Components');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (275458, 'Livermorium', 7068, 'Comet Supplies Inc');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (64596, 'Sodium Niobate', 9343, 'Galaxy Innovations');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (4101, 'Ytterbium Phosphide', 1727, 'Aerospace Parts Co');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (578359, 'Tungsten Boride', 8186, 'Orbital Manufacturing');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (859802, 'Bismuth', 8207, 'MilkyWay Materials');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (28384, 'Ruthenium', 426, 'Intergalactic Materials');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (790452, 'Boron Aluminum Oxide', 1095, 'AstroParts Ltd');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (931437, 'Lanthanum Sulfide', 5999, 'Interstellar Supply Chain');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (486676, 'Strontium Zirconate', 6917, 'SolarParts Ltd');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (264798, 'Rhodium', 6215, 'RocketParts Corp');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (708009, 'Praseodymium Aluminum Oxynitride', 5672, 'AstroSupply Chain');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (323676, 'Holmium Silicide', 8119, 'Orbit Suppliers');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (171567, 'Terbium Aluminum Oxide', 3006, 'Interstellar Supply Chain');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (141135, 'Dysprosium Boride', 9470, 'DeepSpace Components');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (3216, 'Calcium', 3005, 'Aerospace Components');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (470513, 'Titanium', 4343, 'Nova Components Inc');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (751249, 'Livermorium', 1607, 'NovaParts Ltd');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (330350, 'Lanthanum Phosphide', 9367, 'NovaParts Ltd');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (962554, 'Neodymium Carbide', 653, 'SpaceMaterials Corp');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (111803, 'Chromia', 571, 'AstroBuild Ltd');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (321290, 'Scandium', 2549, 'SpaceTech Ltd');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (248569, 'Protactinium', 874, 'Celestech Supplies');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (350051, 'Scandium Carbide', 5561, 'Galaxy Innovations');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (449310, 'Gadolinium Arsenide', 8183, 'Comet Supplies Inc');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (673544, 'Thulium Aluminum Oxynitride', 9734, 'Starlight Components');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (492575, 'Silver', 4127, 'Stellar Components');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (844764, 'Praseodymium Boride', 3430, 'GlobalTech Supplies');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (584218, 'Barium Titanate', 3412, 'SpaceMaterials Corp');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (733656, 'Thulium Carbide', 507, 'Stellar Manufacturing');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (277322, 'Yttrium Sulfide', 3800, 'Orbit Suppliers');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (478297, 'Ytterbium Antimonide', 8100, 'Planetary Materials');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (954620, 'Neodymium Arsenide', 6718, 'Quantum Materials Co');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (998558, 'Sodium', 5042, 'MeteorTech Inc');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (873421, 'Ytterbium Sulfide', 8485, 'Stellar Components');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (72289, 'Hafnium Carbide', 915, 'SolarTech Supplies');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (773026, 'Erbium Boride', 2167, 'SpaceTech Ltd');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (973973, 'Indium', 5707, 'Cosmic Components');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (44655, 'Scandium Boride', 62, 'Interstellar Supply Chain');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (675918, 'Holmium Boride', 110, 'AstroTech Industries');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (463860, 'Iron', 6802, 'NovaParts Ltd');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (611912, 'Tungsten Disulfide', 6440, 'AeroParts Co');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (485462, 'Praseodymium Nitride', 3082, 'RocketParts Corp');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (3404, 'Praseodymium Arsenide', 176, 'Galaxy Innovations');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (100959, 'Neodymium Carbide', 19, 'SpaceComponent Solutions');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (748173, 'Lithium Aluminum Oxide', 2130, 'Interstellar Supplies');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (258453, 'Erbium Oxide', 4133, 'Exoplanet Supplies');
commit;
prompt 200 records committed...
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (871503, 'Samarium Aluminum Oxynitride', 1240, 'Stellar Components Inc');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (845072, 'Neodymium', 2945, 'RocketMaterials Inc');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (539848, 'Samarium Phosphide', 7988, 'ExoTech Ltd');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (231896, 'Silicon', 1219, 'SpaceTech Ltd');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (637012, 'Meitnerium', 8440, 'Starship Components');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (381368, 'Terbium Antimonide', 7808, 'AstroSupply Chain');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (902814, 'Boron Carbide', 8919, 'Orbit Suppliers');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (517227, 'Dysprosium Aluminum Oxynitride', 3138, 'Stellar Components Inc');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (634266, 'Rutherfordium', 1294, 'Aerospace Solutions');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (356924, 'Terbium Nitride', 7315, 'Spacecraft Materials');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (949239, 'Scandium Nitride', 8903, 'MilkyWay Materials');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (906545, 'Dysprosium Boride', 8852, 'Aerospace Parts Co');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (612639, 'Seaborgium', 3087, 'Galactic Innovations');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (818234, 'Iron Aluminide', 4027, 'SpaceComponent Solutions');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (425079, 'Zinc', 366, 'Pulsar Components');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (310114, 'Dysprosium Carbide', 6864, 'Pulsar Supplies Co');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (174046, 'Zinc', 231, 'Celestial Supplies Corp');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (648706, 'Antimony', 9734, 'Comet Supplies Inc');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (147579, 'Silicon', 3559, 'Aerospace Parts Co');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (193859, 'Niobium Carbide', 4592, 'LunarTech Inc');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (210438, 'Nobelium', 1655, 'AeroParts Co');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (6163, 'Meitnerium', 4828, 'OrbitTech Corp');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (442774, 'Dysprosium Boride', 5926, 'AstroParts Ltd');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (16873, 'Holmium Boride', 7748, 'Exospace Components');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (341306, 'Scandium Oxide', 8168, 'Stellar Components Inc');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (760337, 'Lead Zirconate', 7681, 'Horizon Supplies');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (582987, 'Thulium', 1486, 'InterstellarTech Ltd');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (668910, 'Ruthenium', 9708, 'AeroMaterial Solutions');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (351182, 'Thulium Aluminum Oxynitride', 1839, 'SpaceX Supplies');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (930380, 'Samarium Boride', 4018, 'Constellation Materials');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (224333, 'Ytterbium Aluminum Oxynitride', 205, 'Celestial Innovations');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (907890, 'Thallium', 888, 'Rocketry Parts Inc');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (627135, 'Gadolinium Aluminum Oxide', 5375, 'OrbitalTech Solutions');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (122358, 'Lanthanum Aluminum Oxynitride', 6292, 'Nova Components Inc');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (844210, 'Erbium Silicide', 7371, 'Galactic Materials');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (797397, 'Samarium Phosphide', 8124, 'LunarTech Inc');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (596275, 'Platinum', 1489, 'Celestech Supplies');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (966745, 'Bismuth', 3060, 'AstroSupply Chain');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (178813, 'Magnesium Aluminum Oxide', 2969, 'StellarTech Corp');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (144178, 'Gallium Arsenide', 4038, 'NovaParts Ltd');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (163248, 'Vanadium', 2282, 'Galaxy Innovations');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (555935, 'Terbium Silicide', 8359, 'ExoTech Ltd');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (660618, 'Lutetium Boride', 1056, 'Comet Supplies Inc');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (935643, 'Cerium Sulfide', 6421, 'Aerospace Parts Co');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (147742, 'Scandium Arsenide', 8613, 'Satellite Materials');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (881734, 'Scandium Silicide', 1075, 'Rocketry Tech Ltd');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (855896, 'Ytterbium Silicide', 9138, 'AeroMaterial Solutions');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (777369, 'Einsteinium', 7605, 'Galactic Supply Chain');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (721983, 'Neodymium Aluminum Oxide', 9474, 'Rocketry Solutions');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (272862, 'Gadolinium Silicide', 4329, 'RocketParts Corp');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (902204, 'Lutetium Boride', 7540, 'Quantum Parts Co');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (330596, 'Flerovium', 3836, 'MilkyWay Components');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (848235, 'Lanthanum Carbide', 1370, 'SpaceX Supplies');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (832452, 'Cerium Boride', 4840, 'OrbitTech Corp');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (945891, 'Holmium Nitride', 8788, 'Pulsar Components');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (749727, 'Silica', 4655, 'MilkyWay Components');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (716303, 'Uranium', 7691, 'Cosmic Components');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (875554, 'Titanium Boride', 2307, 'Intergalactic Materials');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (579591, 'Lanthanum Carbide', 6977, 'Celestech Supplies');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (119830, 'Erbium Aluminum Oxide', 2263, 'AstroSupply Chain');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (181031, 'Thulium Phosphide', 8083, 'OrbitalTech Solutions');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (366630, 'Erbium Boride', 8785, 'Planetary Parts Ltd');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (279730, 'Boron Nitride', 7153, 'StellarSupplies Inc');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (894136, 'Praseodymium Sulfide', 908, 'Planetary Materials');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (199800, 'Holmium Silicide', 7830, 'MilkyWay Materials');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (357055, 'Praseodymium Boride', 8054, 'RocketTech Industries');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (844022, 'Erbium Silicide', 4679, 'Exospace Components');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (331542, 'Terbium Antimonide', 6252, 'SpaceMaterials Corp');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (270030, 'Lithium', 7225, 'CelestialTech Corp');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (422621, 'Samarium Oxide', 5000, 'MeteorTech Inc');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (828971, 'Titanium Nitride', 4622, 'Intergalactic Materials');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (934107, 'Praseodymium', 4745, 'Starship Supplies Inc');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (866683, 'Cerium Arsenide', 945, 'Rocketry Tech Ltd');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (101031, 'Holmium Boride', 4986, 'Celestial Innovations');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (987368, 'Silicon', 1114, 'Planetary Materials');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (884556, 'Dysprosium Sulfide', 3006, 'RocketTech Industries');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (879759, 'Terbium Silicide', 7429, 'Celestial Innovations');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (329404, 'Samarium Silicide', 3229, 'Rocketry Solutions');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (705796, 'Darmstadtium', 6741, 'DeepSpace Parts Ltd');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (483776, 'Nihonium', 7197, 'MilkyWay Materials');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (51796, 'Terbium', 8247, 'MilkyWay Materials');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (881773, 'Palladium', 4176, 'Intergalactic Materials');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (442124, 'Tantalum Boride', 1906, 'CelestialTech Corp');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (588320, 'Thulium', 2390, 'Celestial Supplies Corp');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (415370, 'Steel', 7482, 'Cosmic Components');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (806585, 'Tungsten Disulfide', 874, 'Celestial Parts Ltd');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (163013, 'Neodymium', 4212, 'MilkyWay Components');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (47904, 'Yttrium Oxide', 1954, 'Exospace Components');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (730599, 'Thorium', 1100, 'AstroTech Industries');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (864200, 'Erbium Sulfide', 4353, 'SpaceParts Solutions');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (781410, 'Dysprosium Arsenide', 7834, 'Planetary Parts Ltd');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (142908, 'Fermium', 6922, 'Meteor Components Inc');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (922638, 'Scandium Phosphide', 6328, 'AstroSupplies Corp');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (964393, 'Iron Aluminide', 2993, 'Intergalactic Materials');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (594054, 'Dysprosium Sulfide', 2893, 'Quantum Materials Co');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (21877, 'Erbium Nitride', 5365, 'Celestial Supplies Corp');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (519183, 'Scandium Sulfide', 1027, 'Asteroid Components');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (603853, 'Neodymium Arsenide', 1903, 'Satellite Materials');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (718971, 'Lanthanum Boride', 4835, 'AstroBuild Ltd');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (139018, 'Cerium Sulfide', 1774, 'Nebula Parts Ltd');
commit;
prompt 300 records committed...
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (87966, 'Cerium Nitride', 3068, 'RocketTech Industries');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (303683, 'Holmium Silicide', 2298, 'AstroManufacturing Ltd');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (532978, 'Erbium Antimonide', 3799, 'Aerospace Solutions');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (691703, 'Boron', 6431, 'AstroSupplies Corp');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (674260, 'Gadolinium Boride', 9707, 'InterSpace Materials');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (46899, 'Arsenic', 868, 'AstroManufacturing Ltd');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (109178, 'Lawrencium', 4000, 'Galactic Innovations');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (57972, 'Strontium Zirconate', 4780, 'SpaceTech Ltd');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (238379, 'Praseodymium Phosphide', 6959, 'Celestial Parts Ltd');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (715932, 'Ferrite', 9161, 'Satellite Components Ltd');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (654466, 'Erbium Silicide', 3100, 'SpaceTech Ltd');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (234022, 'Ytterbium Sulfide', 6811, 'OrbitMaterial Solutions');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (93172, 'Chromia', 8974, 'SpaceX Supplies');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (530129, 'Samarium Sulfide', 2946, 'TerraMaterials Ltd');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (947025, 'Holmium Antimonide', 1580, 'NovaParts Ltd');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (271719, 'Calcium Aluminum Oxide', 6426, 'Starship Components');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (341529, 'Silver', 7412, 'Meteor Components Inc');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (483248, 'Thulium Aluminum Oxide', 1604, 'RocketMaterials Inc');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (773826, 'Lanthanum', 2122, 'Nebula Parts Ltd');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (716091, 'Lutetium Silicide', 819, 'DeepSpace Components');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (313879, 'Tin', 818, 'Spacetech Suppliers');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (780962, 'Gadolinium Silicide', 7491, 'Nova Components Inc');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (368133, 'Cerium Silicide', 8980, 'Celestech Supplies');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (42833, 'Boron Aluminum Oxide', 9854, 'Orbit Suppliers');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (5692, 'Thulium Nitride', 3998, 'MeteorTech Inc');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (278358, 'Terbium Carbide', 5314, 'GlobalTech Supplies');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (846992, 'Samarium Silicide', 7351, 'Interstellar Supply Chain');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (95799, 'Ytterbium Aluminum Oxynitride', 5430, 'RocketParts Corp');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (514973, 'Praseodymium Oxide', 7389, 'DeepSpace Parts Ltd');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (917438, 'Gallium Arsenide', 1513, 'CelestialTech Corp');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (648745, 'Dysprosium Carbide', 2758, 'Rocketry Solutions');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (524511, 'Cerium Antimonide', 864, 'StellarTech Corp');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (479769, 'Hafnium Carbide', 6441, 'Quantum Parts Co');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (164618, 'Ytterbium Phosphide', 3628, 'MilkyWay Components');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (970520, 'Gadolinium Antimonide', 422, 'AstroManufacturing Inc');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (221654, 'Neodymium Aluminum Oxide', 267, 'OrbitTech Corp');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (515666, 'Tantalum Carbide', 988, 'DeepSpace Components');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (448226, 'Praseodymium Sulfide', 9679, 'AstroTech Industries');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (205735, 'Thulium Sulfide', 4636, 'Meteor Components Inc');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (760577, 'Erbium Arsenide', 7914, 'Nova Components Inc');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (653288, 'Holmium Oxide', 4623, 'Planetary Parts Ltd');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (596006, 'Molybdenum Disulfide', 7540, 'Aerospace Components');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (381594, 'Ytterbium Sulfide', 8136, 'Pulsar Supplies Co');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (832793, 'Praseodymium', 7619, 'AstroSupplies Corp');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (775798, 'Dysprosium Arsenide', 4075, 'LunarSupplies Corp');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (272617, 'Cerium Boride', 4312, 'Comet Supplies Inc');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (596594, 'Neodymium Sulfide', 1484, 'AstroSupply Chain');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (685479, 'Nickel', 2113, 'Planetary Materials');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (56399, 'Samarium Aluminum Oxide', 8583, 'NovaParts Ltd');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (417128, 'Vanadium', 5702, 'Galactic Materials');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (458020, 'Nobelium', 2440, 'AstroParts Ltd');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (558977, 'Strontium Zirconate', 2422, 'AstroManufacturing Ltd');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (395832, 'Lanthanum Carbide', 9268, 'LunarParts Solutions');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (680527, 'Holmium Boride', 5392, 'Nova Manufacturing');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (519445, 'Copper', 5335, 'AstroTech Industries');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (124291, 'Rutherfordium', 7232, 'ExoTech Supplies');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (859878, 'Hafnium Boride', 8513, 'DeepSpace Components');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (863212, 'Praseodymium', 4420, 'AstroSupplies Corp');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (718231, 'Magnesium Silicate', 445, 'SolarTech Supplies');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (920590, 'Neodymium Silicide', 2274, 'GlobalTech Supplies');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (116858, 'Protactinium', 9337, 'StellarSupplies Inc');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (352499, 'Lanthanum', 553, 'Planetary Materials');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (813032, 'Dysprosium Boride', 3373, 'SolarTech Supplies');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (792710, 'Thulium Phosphide', 9694, 'MilkyWay Components');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (875128, 'Uranium', 4765, 'Meteor Components Inc');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (560114, 'Praseodymium Aluminum Oxynitride', 7660, 'Planetary Materials');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (821286, 'Terbium Nitride', 4415, 'Exospace Components');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (328646, 'Seaborgium', 7428, 'Galactic Innovations');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (320588, 'Neodymium', 7211, 'Aerospace Solutions');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (359700, 'Vanadium', 5089, 'OrbitTech Corp');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (456725, 'Thulium Arsenide', 7942, 'Spacecraft Supplies');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (297060, 'Antimony', 8580, 'TerraMaterials Ltd');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (554174, 'Boron Aluminum Oxide', 7845, 'OrbitTech Corp');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (524313, 'Gadolinium Oxide', 7040, 'DeepSpace Parts Ltd');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (566867, 'Terbium Phosphide', 1770, 'Rocketry Tech Ltd');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (84778, 'Selenium', 792, 'Comet Supplies Inc');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (29363, 'Aluminum Boride', 5975, 'Rocketry Tech Ltd');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (163923, 'Sodium Niobate', 1945, 'Constellation Materials');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (570519, 'Ytterbium Arsenide', 6540, 'OrbitMaterial Solutions');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (134289, 'Niobium', 5627, 'Stellar Components Inc');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (989667, 'Yttrium', 8416, 'GlobalTech Supplies');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (162913, 'Samarium Boride', 1837, 'Meteor Components Inc');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (895280, 'Terbium Aluminum Oxynitride', 5087, 'Cosmos Components');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (381247, 'Osmium', 7933, 'Spacetech Suppliers');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (906144, 'Ytterbium Aluminum Oxide', 8870, 'Starlight Components');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (617582, 'Silver', 1728, 'GlobalTech Supplies');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (415036, 'Scandium Nitride', 1822, 'Starship Supplies Inc');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (691970, 'Samarium Nitride', 5228, 'Cosmos Components');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (914886, 'Cerium Boride', 7296, 'Planetary Parts Ltd');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (273644, 'Thulium Aluminum Oxide', 8984, 'Nova Components Inc');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (887460, 'Americium', 2100, 'LunarParts Solutions');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (300940, 'Lithium', 7070, 'Pulsar Supplies Co');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (254524, 'Ytterbium Carbide', 9292, 'Starship Supplies Inc');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (963722, 'Erbium Silicide', 2697, 'SpaceTech Ltd');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (391518, 'Lanthanum Arsenide', 1599, 'AstroParts Ltd');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (248302, 'Californium', 4433, 'Meteor Components Inc');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (703729, 'Darmstadtium', 5462, 'Starlight Components');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (44860, 'Praseodymium Nitride', 3067, 'Starlight Components');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (764963, 'Thulium Boride', 5697, 'Spacetech Corp');
insert into RAW_MATERIALS (material_id, material_name, quantity_in_stock, supplier)
values (817367, 'Gadolinium', 9083, 'SolarParts Ltd');
commit;
prompt 400 records loaded
prompt Loading CUSTOMER_RAW_MATERIALS...
insert into CUSTOMER_RAW_MATERIALS (customer_id, material_id)
values (32420685, 768169);
insert into CUSTOMER_RAW_MATERIALS (customer_id, material_id)
values (83846105, 46899);
insert into CUSTOMER_RAW_MATERIALS (customer_id, material_id)
values (31417541, 566867);
insert into CUSTOMER_RAW_MATERIALS (customer_id, material_id)
values (52282046, 135916);
insert into CUSTOMER_RAW_MATERIALS (customer_id, material_id)
values (36373252, 947025);
insert into CUSTOMER_RAW_MATERIALS (customer_id, material_id)
values (1, 755222);
insert into CUSTOMER_RAW_MATERIALS (customer_id, material_id)
values (33133087, 970520);
insert into CUSTOMER_RAW_MATERIALS (customer_id, material_id)
values (60843836, 462695);
insert into CUSTOMER_RAW_MATERIALS (customer_id, material_id)
values (23720801, 899308);
insert into CUSTOMER_RAW_MATERIALS (customer_id, material_id)
values (23250655, 914886);
insert into CUSTOMER_RAW_MATERIALS (customer_id, material_id)
values (20113136, 541272);
insert into CUSTOMER_RAW_MATERIALS (customer_id, material_id)
values (27399832, 914886);
insert into CUSTOMER_RAW_MATERIALS (customer_id, material_id)
values (23250655, 162913);
insert into CUSTOMER_RAW_MATERIALS (customer_id, material_id)
values (37207125, 973973);
insert into CUSTOMER_RAW_MATERIALS (customer_id, material_id)
values (87552354, 947025);
insert into CUSTOMER_RAW_MATERIALS (customer_id, material_id)
values (59933677, 420574);
insert into CUSTOMER_RAW_MATERIALS (customer_id, material_id)
values (34948701, 914886);
insert into CUSTOMER_RAW_MATERIALS (customer_id, material_id)
values (51957721, 998558);
insert into CUSTOMER_RAW_MATERIALS (customer_id, material_id)
values (92665521, 296377);
insert into CUSTOMER_RAW_MATERIALS (customer_id, material_id)
values (23320965, 874305);
insert into CUSTOMER_RAW_MATERIALS (customer_id, material_id)
values (51638591, 680527);
insert into CUSTOMER_RAW_MATERIALS (customer_id, material_id)
values (86514668, 517227);
insert into CUSTOMER_RAW_MATERIALS (customer_id, material_id)
values (20834380, 92585);
insert into CUSTOMER_RAW_MATERIALS (customer_id, material_id)
values (25535209, 754551);
insert into CUSTOMER_RAW_MATERIALS (customer_id, material_id)
values (32420685, 519183);
insert into CUSTOMER_RAW_MATERIALS (customer_id, material_id)
values (96951684, 683148);
insert into CUSTOMER_RAW_MATERIALS (customer_id, material_id)
values (20191024, 678284);
insert into CUSTOMER_RAW_MATERIALS (customer_id, material_id)
values (97745277, 269974);
insert into CUSTOMER_RAW_MATERIALS (customer_id, material_id)
values (28740228, 313879);
insert into CUSTOMER_RAW_MATERIALS (customer_id, material_id)
values (71110942, 320588);
insert into CUSTOMER_RAW_MATERIALS (customer_id, material_id)
values (54088195, 301354);
insert into CUSTOMER_RAW_MATERIALS (customer_id, material_id)
values (47712085, 6163);
insert into CUSTOMER_RAW_MATERIALS (customer_id, material_id)
values (62218719, 603360);
insert into CUSTOMER_RAW_MATERIALS (customer_id, material_id)
values (54655982, 269974);
insert into CUSTOMER_RAW_MATERIALS (customer_id, material_id)
values (82736622, 221654);
insert into CUSTOMER_RAW_MATERIALS (customer_id, material_id)
values (20233702, 298724);
insert into CUSTOMER_RAW_MATERIALS (customer_id, material_id)
values (76928249, 517227);
insert into CUSTOMER_RAW_MATERIALS (customer_id, material_id)
values (62933363, 171567);
insert into CUSTOMER_RAW_MATERIALS (customer_id, material_id)
values (39313492, 181031);
insert into CUSTOMER_RAW_MATERIALS (customer_id, material_id)
values (54103386, 330350);
insert into CUSTOMER_RAW_MATERIALS (customer_id, material_id)
values (99433231, 706778);
insert into CUSTOMER_RAW_MATERIALS (customer_id, material_id)
values (60928528, 303683);
insert into CUSTOMER_RAW_MATERIALS (customer_id, material_id)
values (42423384, 234022);
insert into CUSTOMER_RAW_MATERIALS (customer_id, material_id)
values (69517856, 837216);
insert into CUSTOMER_RAW_MATERIALS (customer_id, material_id)
values (86054195, 42833);
insert into CUSTOMER_RAW_MATERIALS (customer_id, material_id)
values (33314613, 871503);
insert into CUSTOMER_RAW_MATERIALS (customer_id, material_id)
values (51638591, 524313);
insert into CUSTOMER_RAW_MATERIALS (customer_id, material_id)
values (17561794, 519029);
insert into CUSTOMER_RAW_MATERIALS (customer_id, material_id)
values (10840739, 660915);
insert into CUSTOMER_RAW_MATERIALS (customer_id, material_id)
values (84360223, 702230);
insert into CUSTOMER_RAW_MATERIALS (customer_id, material_id)
values (27044249, 773826);
insert into CUSTOMER_RAW_MATERIALS (customer_id, material_id)
values (94146730, 391518);
insert into CUSTOMER_RAW_MATERIALS (customer_id, material_id)
values (99979592, 516716);
insert into CUSTOMER_RAW_MATERIALS (customer_id, material_id)
values (40481802, 970520);
insert into CUSTOMER_RAW_MATERIALS (customer_id, material_id)
values (83480577, 749727);
insert into CUSTOMER_RAW_MATERIALS (customer_id, material_id)
values (82736622, 162913);
insert into CUSTOMER_RAW_MATERIALS (customer_id, material_id)
values (17963068, 922432);
insert into CUSTOMER_RAW_MATERIALS (customer_id, material_id)
values (23720801, 675918);
insert into CUSTOMER_RAW_MATERIALS (customer_id, material_id)
values (31650026, 381247);
insert into CUSTOMER_RAW_MATERIALS (customer_id, material_id)
values (10840739, 691703);
commit;
prompt 60 records loaded
prompt Loading MACHINE_MAINTENANCE...
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (99970, 46338, to_date('06-07-2007', 'dd-mm-yyyy'), 'Preventive Maintenance', 'On Hold');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (2415, 82546, to_date('23-05-2000', 'dd-mm-yyyy'), 'Overhaul Maintenance', 'Cancelled');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (50304, 81374, to_date('02-07-2016', 'dd-mm-yyyy'), 'Replacement Maintenance', 'Pending');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (36484, 27881, to_date('06-01-2003', 'dd-mm-yyyy'), 'Condition-Based Maintenance', 'On Hold');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (7001, 41078, to_date('30-03-2010', 'dd-mm-yyyy'), 'Condition-Based Maintenance', 'Pending');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (67057, 24065, to_date('02-10-2001', 'dd-mm-yyyy'), 'Emergency Maintenance', 'Pending');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (47493, 25910, to_date('27-06-2007', 'dd-mm-yyyy'), 'Emergency Maintenance', 'Cancelled');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (27470, 67179, to_date('04-06-2002', 'dd-mm-yyyy'), 'Scheduled Maintenance', 'Failed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (92681, 23122, to_date('23-06-2004', 'dd-mm-yyyy'), 'Condition-Based Maintenance', 'Pending');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (88944, 23993, to_date('14-03-2007', 'dd-mm-yyyy'), 'Corrective Maintenance', 'In Progress');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (82831, 24327, to_date('03-10-2017', 'dd-mm-yyyy'), 'Preventive Maintenance', 'In Progress');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (59730, 46252, to_date('07-01-2006', 'dd-mm-yyyy'), 'Inspection Maintenance', 'On Hold');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (90084, 71472, to_date('23-05-2023', 'dd-mm-yyyy'), 'Replacement Maintenance', 'Pending');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (12428, 27397, to_date('15-10-2020', 'dd-mm-yyyy'), 'Scheduled Maintenance', 'Completed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (61769, 39589, to_date('25-09-2015', 'dd-mm-yyyy'), 'Safety Checks', 'Pending');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (30877, 46193, to_date('04-10-2000', 'dd-mm-yyyy'), 'Scheduled Maintenance', 'In Progress');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (38388, 13249, to_date('30-12-2010', 'dd-mm-yyyy'), 'Preventive Maintenance', 'On Hold');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (2482, 14106, to_date('06-04-2006', 'dd-mm-yyyy'), 'Alignment Maintenance', 'Pending');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (17212, 48892, to_date('04-04-2007', 'dd-mm-yyyy'), 'Preventive Maintenance', 'On Hold');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (15536, 11702, to_date('27-02-2000', 'dd-mm-yyyy'), 'Inspection Maintenance', 'Cancelled');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (18079, 43439, to_date('08-05-2018', 'dd-mm-yyyy'), 'Inspection Maintenance', 'Cancelled');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (60250, 95186, to_date('26-04-2001', 'dd-mm-yyyy'), 'Predictive Maintenance', 'On Hold');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (83439, 7011, to_date('08-02-2008', 'dd-mm-yyyy'), 'Overhaul Maintenance', 'On Hold');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (33097, 58543, to_date('19-09-2015', 'dd-mm-yyyy'), 'Predictive Maintenance', 'Failed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (91325, 70519, to_date('11-10-2022', 'dd-mm-yyyy'), 'Inspection Maintenance', 'Pending');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (12909, 81009, to_date('13-10-2005', 'dd-mm-yyyy'), 'Unscheduled Maintenance', 'On Hold');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (8796, 3497, to_date('18-02-2009', 'dd-mm-yyyy'), 'Overhaul Maintenance', 'On Hold');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (70238, 54944, to_date('11-02-2021', 'dd-mm-yyyy'), 'Inspection Maintenance', 'Failed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (45967, 80145, to_date('25-10-2008', 'dd-mm-yyyy'), 'Preventive Maintenance', 'Pending');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (95033, 6821, to_date('22-10-2010', 'dd-mm-yyyy'), 'Alignment Maintenance', 'Cancelled');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (18087, 68404, to_date('24-08-2023', 'dd-mm-yyyy'), 'Overhaul Maintenance', 'Completed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (37925, 75339, to_date('15-03-2003', 'dd-mm-yyyy'), 'Replacement Maintenance', 'In Progress');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (66553, 34096, to_date('13-06-2019', 'dd-mm-yyyy'), 'Cleaning Maintenance', 'Failed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (63651, 26785, to_date('18-03-2014', 'dd-mm-yyyy'), 'Overhaul Maintenance', 'Failed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (60618, 6252, to_date('21-08-2000', 'dd-mm-yyyy'), 'Corrective Maintenance', 'On Hold');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (67574, 49936, to_date('20-12-2007', 'dd-mm-yyyy'), 'Cleaning Maintenance', 'Failed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (80866, 46659, to_date('04-04-2012', 'dd-mm-yyyy'), 'Cleaning Maintenance', 'Cancelled');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (14184, 12416, to_date('05-02-2017', 'dd-mm-yyyy'), 'Condition-Based Maintenance', 'Pending');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (4823, 62879, to_date('19-07-2017', 'dd-mm-yyyy'), 'Condition-Based Maintenance', 'Cancelled');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (76062, 58495, to_date('04-08-2023', 'dd-mm-yyyy'), 'Alignment Maintenance', 'Pending');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (55380, 5646, to_date('25-02-2009', 'dd-mm-yyyy'), 'Alignment Maintenance', 'On Hold');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (89445, 16338, to_date('19-11-2002', 'dd-mm-yyyy'), 'Overhaul Maintenance', 'In Progress');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (65396, 54914, to_date('03-02-2020', 'dd-mm-yyyy'), 'Replacement Maintenance', 'Pending');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (54266, 41808, to_date('13-09-2004', 'dd-mm-yyyy'), 'Emergency Maintenance', 'In Progress');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (38075, 30221, to_date('04-04-2002', 'dd-mm-yyyy'), 'Condition-Based Maintenance', 'In Progress');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (98902, 87319, to_date('25-10-2001', 'dd-mm-yyyy'), 'Inspection Maintenance', 'Pending');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (73902, 16516, to_date('16-11-2014', 'dd-mm-yyyy'), 'Cleaning Maintenance', 'Failed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (58833, 29277, to_date('26-12-2011', 'dd-mm-yyyy'), 'Safety Checks', 'Cancelled');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (72049, 82738, to_date('13-08-2020', 'dd-mm-yyyy'), 'Preventive Maintenance', 'Failed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (90370, 47513, to_date('04-03-2014', 'dd-mm-yyyy'), 'Calibration Maintenance', 'Completed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (28764, 43095, to_date('06-05-2018', 'dd-mm-yyyy'), 'Overhaul Maintenance', 'On Hold');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (11856, 6045, to_date('24-03-2015', 'dd-mm-yyyy'), 'Overhaul Maintenance', 'On Hold');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (28382, 76768, to_date('30-04-2000', 'dd-mm-yyyy'), 'Routine Maintenance', 'Pending');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (41337, 67841, to_date('26-03-2003', 'dd-mm-yyyy'), 'Routine Maintenance', 'Completed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (85591, 36697, to_date('02-10-2007', 'dd-mm-yyyy'), 'Safety Checks', 'Cancelled');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (38144, 68118, to_date('23-12-2017', 'dd-mm-yyyy'), 'Overhaul Maintenance', 'Failed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (31660, 48499, to_date('24-09-2018', 'dd-mm-yyyy'), 'Preventive Maintenance', 'In Progress');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (62113, 2463, to_date('10-02-2007', 'dd-mm-yyyy'), 'Inspection Maintenance', 'Failed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (73773, 82723, to_date('22-09-2005', 'dd-mm-yyyy'), 'Unscheduled Maintenance', 'In Progress');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (94790, 38912, to_date('21-11-2015', 'dd-mm-yyyy'), 'Corrective Maintenance', 'Failed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (76622, 83712, to_date('05-04-2019', 'dd-mm-yyyy'), 'Predictive Maintenance', 'Completed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (27973, 68256, to_date('04-09-2016', 'dd-mm-yyyy'), 'Calibration Maintenance', 'On Hold');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (50284, 12699, to_date('29-01-2004', 'dd-mm-yyyy'), 'Lubrication Maintenance', 'Cancelled');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (72694, 45663, to_date('03-12-2002', 'dd-mm-yyyy'), 'Scheduled Maintenance', 'Pending');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (59355, 17504, to_date('17-08-2007', 'dd-mm-yyyy'), 'Safety Checks', 'Pending');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (82497, 80266, to_date('19-07-2016', 'dd-mm-yyyy'), 'Inspection Maintenance', 'Pending');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (26628, 32754, to_date('01-07-2014', 'dd-mm-yyyy'), 'Unscheduled Maintenance', 'Failed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (74762, 79137, to_date('27-06-2005', 'dd-mm-yyyy'), 'Unscheduled Maintenance', 'In Progress');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (71477, 48956, to_date('01-12-2001', 'dd-mm-yyyy'), 'Safety Checks', 'Pending');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (79288, 79039, to_date('05-06-2016', 'dd-mm-yyyy'), 'Condition-Based Maintenance', 'Completed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (29870, 22522, to_date('19-09-2011', 'dd-mm-yyyy'), 'Unscheduled Maintenance', 'On Hold');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (439, 85079, to_date('12-09-2010', 'dd-mm-yyyy'), 'Scheduled Maintenance', 'Cancelled');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (30746, 37929, to_date('02-04-2009', 'dd-mm-yyyy'), 'Cleaning Maintenance', 'On Hold');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (54255, 10795, to_date('13-10-2001', 'dd-mm-yyyy'), 'Routine Maintenance', 'Failed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (83682, 34132, to_date('22-10-2020', 'dd-mm-yyyy'), 'Inspection Maintenance', 'In Progress');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (91289, 60840, to_date('19-10-2020', 'dd-mm-yyyy'), 'Scheduled Maintenance', 'Cancelled');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (46533, 76172, to_date('10-08-2019', 'dd-mm-yyyy'), 'Unscheduled Maintenance', 'Cancelled');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (45651, 46360, to_date('02-02-2003', 'dd-mm-yyyy'), 'Calibration Maintenance', 'Pending');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (20351, 45983, to_date('20-03-2006', 'dd-mm-yyyy'), 'Condition-Based Maintenance', 'Pending');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (17295, 55611, to_date('23-12-2015', 'dd-mm-yyyy'), 'Replacement Maintenance', 'On Hold');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (43594, 49946, to_date('17-06-2013', 'dd-mm-yyyy'), 'Calibration Maintenance', 'On Hold');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (4051, 49825, to_date('12-09-2008', 'dd-mm-yyyy'), 'Lubrication Maintenance', 'On Hold');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (59678, 51001, to_date('24-02-2018', 'dd-mm-yyyy'), 'Scheduled Maintenance', 'Failed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (8558, 97713, to_date('31-07-2021', 'dd-mm-yyyy'), 'Replacement Maintenance', 'Cancelled');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (92583, 36324, to_date('13-11-2009', 'dd-mm-yyyy'), 'Replacement Maintenance', 'Failed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (59464, 32825, to_date('29-06-2004', 'dd-mm-yyyy'), 'Cleaning Maintenance', 'In Progress');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (15709, 84044, to_date('29-12-2001', 'dd-mm-yyyy'), 'Condition-Based Maintenance', 'Pending');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (62109, 97379, to_date('24-12-2001', 'dd-mm-yyyy'), 'Overhaul Maintenance', 'On Hold');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (20740, 379, to_date('30-07-2019', 'dd-mm-yyyy'), 'Preventive Maintenance', 'Failed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (37753, 55417, to_date('03-06-2021', 'dd-mm-yyyy'), 'Unscheduled Maintenance', 'Pending');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (17240, 18166, to_date('20-04-2002', 'dd-mm-yyyy'), 'Preventive Maintenance', 'Completed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (78499, 98449, to_date('01-02-2005', 'dd-mm-yyyy'), 'Scheduled Maintenance', 'On Hold');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (1187, 85437, to_date('29-10-2013', 'dd-mm-yyyy'), 'Routine Maintenance', 'Cancelled');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (43567, 59470, to_date('31-01-2006', 'dd-mm-yyyy'), 'Preventive Maintenance', 'Cancelled');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (53022, 84404, to_date('20-01-2011', 'dd-mm-yyyy'), 'Lubrication Maintenance', 'Cancelled');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (7862, 77443, to_date('04-10-2003', 'dd-mm-yyyy'), 'Safety Checks', 'Failed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (44283, 13590, to_date('23-06-2001', 'dd-mm-yyyy'), 'Routine Maintenance', 'Pending');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (51960, 45519, to_date('11-06-2007', 'dd-mm-yyyy'), 'Alignment Maintenance', 'Pending');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (77618, 94802, to_date('14-10-2011', 'dd-mm-yyyy'), 'Cleaning Maintenance', 'Completed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (10134, 13422, to_date('06-02-2014', 'dd-mm-yyyy'), 'Emergency Maintenance', 'Completed');
commit;
prompt 100 records committed...
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (39466, 38631, to_date('06-01-2001', 'dd-mm-yyyy'), 'Predictive Maintenance', 'On Hold');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (75886, 29002, to_date('25-10-2002', 'dd-mm-yyyy'), 'Emergency Maintenance', 'Failed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (38834, 73331, to_date('09-03-2009', 'dd-mm-yyyy'), 'Cleaning Maintenance', 'Cancelled');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (59132, 77098, to_date('10-12-2020', 'dd-mm-yyyy'), 'Corrective Maintenance', 'Pending');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (21012, 18641, to_date('05-03-2012', 'dd-mm-yyyy'), 'Preventive Maintenance', 'In Progress');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (1771, 36842, to_date('08-04-2012', 'dd-mm-yyyy'), 'Inspection Maintenance', 'Failed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (12678, 24418, to_date('31-10-2007', 'dd-mm-yyyy'), 'Corrective Maintenance', 'Failed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (45155, 12614, to_date('06-06-2014', 'dd-mm-yyyy'), 'Cleaning Maintenance', 'In Progress');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (56169, 380, to_date('11-09-2001', 'dd-mm-yyyy'), 'Predictive Maintenance', 'Completed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (10326, 30290, to_date('13-07-2004', 'dd-mm-yyyy'), 'Unscheduled Maintenance', 'On Hold');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (56769, 93750, to_date('30-08-2005', 'dd-mm-yyyy'), 'Alignment Maintenance', 'Cancelled');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (55811, 10437, to_date('09-01-2016', 'dd-mm-yyyy'), 'Alignment Maintenance', 'Cancelled');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (79084, 32683, to_date('25-11-2019', 'dd-mm-yyyy'), 'Cleaning Maintenance', 'Failed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (24812, 64976, to_date('25-07-2015', 'dd-mm-yyyy'), 'Unscheduled Maintenance', 'In Progress');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (18144, 1064, to_date('25-10-2001', 'dd-mm-yyyy'), 'Inspection Maintenance', 'Completed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (39762, 94801, to_date('05-12-2001', 'dd-mm-yyyy'), 'Overhaul Maintenance', 'Pending');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (18971, 51048, to_date('11-09-2018', 'dd-mm-yyyy'), 'Emergency Maintenance', 'On Hold');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (53925, 24111, to_date('14-11-2018', 'dd-mm-yyyy'), 'Lubrication Maintenance', 'Completed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (56398, 49579, to_date('15-06-2000', 'dd-mm-yyyy'), 'Routine Maintenance', 'Pending');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (83055, 74148, to_date('08-02-2022', 'dd-mm-yyyy'), 'Cleaning Maintenance', 'Completed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (95954, 607, to_date('26-08-2003', 'dd-mm-yyyy'), 'Cleaning Maintenance', 'Completed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (21508, 85757, to_date('10-10-2004', 'dd-mm-yyyy'), 'Safety Checks', 'Pending');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (68090, 41796, to_date('22-03-2022', 'dd-mm-yyyy'), 'Emergency Maintenance', 'Pending');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (52749, 27979, to_date('08-01-2003', 'dd-mm-yyyy'), 'Overhaul Maintenance', 'On Hold');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (83026, 89655, to_date('22-09-2006', 'dd-mm-yyyy'), 'Cleaning Maintenance', 'Cancelled');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (252, 10137, to_date('22-08-2011', 'dd-mm-yyyy'), 'Unscheduled Maintenance', 'On Hold');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (23361, 56313, to_date('02-12-2020', 'dd-mm-yyyy'), 'Inspection Maintenance', 'Pending');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (87504, 28578, to_date('08-03-2000', 'dd-mm-yyyy'), 'Safety Checks', 'On Hold');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (57554, 90944, to_date('24-04-2020', 'dd-mm-yyyy'), 'Calibration Maintenance', 'Pending');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (91605, 57880, to_date('19-04-2002', 'dd-mm-yyyy'), 'Cleaning Maintenance', 'On Hold');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (50686, 65383, to_date('31-01-2017', 'dd-mm-yyyy'), 'Inspection Maintenance', 'Cancelled');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (39841, 21039, to_date('15-09-2016', 'dd-mm-yyyy'), 'Scheduled Maintenance', 'On Hold');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (3452, 41139, to_date('14-02-2022', 'dd-mm-yyyy'), 'Corrective Maintenance', 'In Progress');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (98534, 3888, to_date('29-06-2004', 'dd-mm-yyyy'), 'Safety Checks', 'In Progress');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (90777, 32906, to_date('23-03-2015', 'dd-mm-yyyy'), 'Condition-Based Maintenance', 'On Hold');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (19051, 75181, to_date('19-09-2012', 'dd-mm-yyyy'), 'Replacement Maintenance', 'Completed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (30727, 97863, to_date('07-01-2022', 'dd-mm-yyyy'), 'Unscheduled Maintenance', 'On Hold');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (99738, 10026, to_date('23-11-2021', 'dd-mm-yyyy'), 'Overhaul Maintenance', 'In Progress');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (48725, 48014, to_date('17-03-2003', 'dd-mm-yyyy'), 'Preventive Maintenance', 'Failed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (26949, 6774, to_date('05-02-2022', 'dd-mm-yyyy'), 'Replacement Maintenance', 'Pending');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (85184, 77274, to_date('18-12-2003', 'dd-mm-yyyy'), 'Inspection Maintenance', 'Cancelled');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (54277, 26707, to_date('31-01-2018', 'dd-mm-yyyy'), 'Preventive Maintenance', 'Pending');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (3008, 70457, to_date('01-09-2014', 'dd-mm-yyyy'), 'Routine Maintenance', 'Failed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (2144, 22690, to_date('12-06-2007', 'dd-mm-yyyy'), 'Overhaul Maintenance', 'Completed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (71619, 89639, to_date('03-01-2010', 'dd-mm-yyyy'), 'Routine Maintenance', 'On Hold');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (62992, 74308, to_date('17-10-2009', 'dd-mm-yyyy'), 'Preventive Maintenance', 'Cancelled');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (74894, 320, to_date('06-03-2012', 'dd-mm-yyyy'), 'Predictive Maintenance', 'Cancelled');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (60500, 69712, to_date('09-11-2003', 'dd-mm-yyyy'), 'Predictive Maintenance', 'Failed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (20166, 60801, to_date('14-05-2011', 'dd-mm-yyyy'), 'Scheduled Maintenance', 'On Hold');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (53649, 75714, to_date('11-05-2023', 'dd-mm-yyyy'), 'Replacement Maintenance', 'In Progress');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (61145, 76446, to_date('01-06-2006', 'dd-mm-yyyy'), 'Routine Maintenance', 'On Hold');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (65578, 83481, to_date('04-07-2021', 'dd-mm-yyyy'), 'Routine Maintenance', 'Cancelled');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (73075, 47889, to_date('24-08-2005', 'dd-mm-yyyy'), 'Calibration Maintenance', 'Pending');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (68110, 71557, to_date('13-02-2019', 'dd-mm-yyyy'), 'Emergency Maintenance', 'On Hold');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (15006, 25199, to_date('05-03-2023', 'dd-mm-yyyy'), 'Condition-Based Maintenance', 'Cancelled');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (71615, 22182, to_date('10-08-2012', 'dd-mm-yyyy'), 'Predictive Maintenance', 'In Progress');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (13031, 74644, to_date('24-09-2003', 'dd-mm-yyyy'), 'Emergency Maintenance', 'Cancelled');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (12987, 42232, to_date('12-05-2000', 'dd-mm-yyyy'), 'Inspection Maintenance', 'Failed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (80821, 77262, to_date('10-01-2008', 'dd-mm-yyyy'), 'Routine Maintenance', 'Completed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (8024, 7743, to_date('30-04-2015', 'dd-mm-yyyy'), 'Routine Maintenance', 'In Progress');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (91167, 65279, to_date('27-11-2014', 'dd-mm-yyyy'), 'Safety Checks', 'In Progress');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (94765, 52277, to_date('21-01-2005', 'dd-mm-yyyy'), 'Emergency Maintenance', 'In Progress');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (5701, 69722, to_date('26-04-2001', 'dd-mm-yyyy'), 'Replacement Maintenance', 'Completed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (47566, 85503, to_date('24-11-2007', 'dd-mm-yyyy'), 'Inspection Maintenance', 'Cancelled');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (90741, 56546, to_date('09-11-2005', 'dd-mm-yyyy'), 'Scheduled Maintenance', 'Pending');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (44094, 40551, to_date('29-07-2008', 'dd-mm-yyyy'), 'Safety Checks', 'Completed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (76668, 75570, to_date('30-01-2010', 'dd-mm-yyyy'), 'Calibration Maintenance', 'Completed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (25422, 38268, to_date('20-12-2019', 'dd-mm-yyyy'), 'Safety Checks', 'In Progress');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (87371, 92737, to_date('28-02-2007', 'dd-mm-yyyy'), 'Replacement Maintenance', 'Pending');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (58915, 4652, to_date('03-07-2011', 'dd-mm-yyyy'), 'Routine Maintenance', 'On Hold');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (56744, 27843, to_date('29-06-2017', 'dd-mm-yyyy'), 'Corrective Maintenance', 'Completed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (1313, 15695, to_date('23-05-2022', 'dd-mm-yyyy'), 'Emergency Maintenance', 'Pending');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (91813, 33265, to_date('17-11-2018', 'dd-mm-yyyy'), 'Emergency Maintenance', 'Completed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (21133, 53008, to_date('18-08-2016', 'dd-mm-yyyy'), 'Safety Checks', 'On Hold');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (18382, 30583, to_date('13-07-2000', 'dd-mm-yyyy'), 'Lubrication Maintenance', 'On Hold');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (81884, 64953, to_date('02-07-2010', 'dd-mm-yyyy'), 'Calibration Maintenance', 'Failed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (86179, 27535, to_date('26-11-2020', 'dd-mm-yyyy'), 'Replacement Maintenance', 'Cancelled');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (66510, 23092, to_date('29-04-2013', 'dd-mm-yyyy'), 'Preventive Maintenance', 'Failed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (97711, 73792, to_date('03-06-2000', 'dd-mm-yyyy'), 'Routine Maintenance', 'In Progress');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (45530, 73589, to_date('18-01-2006', 'dd-mm-yyyy'), 'Cleaning Maintenance', 'Pending');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (89559, 36792, to_date('10-09-2015', 'dd-mm-yyyy'), 'Replacement Maintenance', 'Failed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (12463, 89169, to_date('01-05-2021', 'dd-mm-yyyy'), 'Cleaning Maintenance', 'Cancelled');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (18021, 94587, to_date('07-07-2008', 'dd-mm-yyyy'), 'Preventive Maintenance', 'Cancelled');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (36842, 60536, to_date('01-12-2020', 'dd-mm-yyyy'), 'Corrective Maintenance', 'On Hold');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (13971, 7623, to_date('10-12-2012', 'dd-mm-yyyy'), 'Condition-Based Maintenance', 'Pending');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (73462, 8050, to_date('25-02-2012', 'dd-mm-yyyy'), 'Emergency Maintenance', 'Completed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (55910, 51729, to_date('25-03-2012', 'dd-mm-yyyy'), 'Cleaning Maintenance', 'Failed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (22880, 76203, to_date('27-09-2007', 'dd-mm-yyyy'), 'Inspection Maintenance', 'Cancelled');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (96580, 26809, to_date('09-12-2015', 'dd-mm-yyyy'), 'Routine Maintenance', 'Failed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (18723, 76257, to_date('05-03-2012', 'dd-mm-yyyy'), 'Overhaul Maintenance', 'Pending');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (48563, 5717, to_date('04-09-2023', 'dd-mm-yyyy'), 'Scheduled Maintenance', 'Failed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (28442, 97589, to_date('05-07-2020', 'dd-mm-yyyy'), 'Calibration Maintenance', 'Pending');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (19129, 12216, to_date('07-02-2003', 'dd-mm-yyyy'), 'Scheduled Maintenance', 'Completed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (51850, 97065, to_date('08-08-2001', 'dd-mm-yyyy'), 'Cleaning Maintenance', 'Pending');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (65564, 21640, to_date('20-07-2015', 'dd-mm-yyyy'), 'Calibration Maintenance', 'On Hold');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (92532, 29353, to_date('25-05-2022', 'dd-mm-yyyy'), 'Preventive Maintenance', 'Failed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (50506, 19401, to_date('07-06-2000', 'dd-mm-yyyy'), 'Condition-Based Maintenance', 'In Progress');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (17170, 80832, to_date('12-05-2021', 'dd-mm-yyyy'), 'Corrective Maintenance', 'On Hold');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (93709, 36971, to_date('04-01-2007', 'dd-mm-yyyy'), 'Cleaning Maintenance', 'On Hold');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (13199, 46767, to_date('06-10-2007', 'dd-mm-yyyy'), 'Inspection Maintenance', 'Cancelled');
commit;
prompt 200 records committed...
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (73404, 68634, to_date('06-06-2010', 'dd-mm-yyyy'), 'Condition-Based Maintenance', 'Cancelled');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (62381, 27076, to_date('31-01-2018', 'dd-mm-yyyy'), 'Alignment Maintenance', 'Completed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (8241, 61484, to_date('25-01-2020', 'dd-mm-yyyy'), 'Alignment Maintenance', 'On Hold');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (72943, 41522, to_date('27-08-2007', 'dd-mm-yyyy'), 'Routine Maintenance', 'Cancelled');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (80991, 22017, to_date('16-02-2001', 'dd-mm-yyyy'), 'Corrective Maintenance', 'Failed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (12265, 61721, to_date('25-04-2019', 'dd-mm-yyyy'), 'Preventive Maintenance', 'Failed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (28942, 1496, to_date('06-03-2017', 'dd-mm-yyyy'), 'Cleaning Maintenance', 'On Hold');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (61887, 56287, to_date('29-09-2009', 'dd-mm-yyyy'), 'Calibration Maintenance', 'Failed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (54539, 65383, to_date('23-11-2020', 'dd-mm-yyyy'), 'Alignment Maintenance', 'Failed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (33103, 27968, to_date('13-01-2013', 'dd-mm-yyyy'), 'Condition-Based Maintenance', 'Failed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (84535, 25598, to_date('16-08-2008', 'dd-mm-yyyy'), 'Preventive Maintenance', 'Completed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (40873, 18980, to_date('26-12-2021', 'dd-mm-yyyy'), 'Safety Checks', 'Completed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (57954, 74678, to_date('27-07-2006', 'dd-mm-yyyy'), 'Predictive Maintenance', 'Completed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (92508, 54198, to_date('08-09-2015', 'dd-mm-yyyy'), 'Inspection Maintenance', 'Pending');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (33823, 14101, to_date('06-05-2020', 'dd-mm-yyyy'), 'Lubrication Maintenance', 'Failed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (11699, 12683, to_date('29-12-2010', 'dd-mm-yyyy'), 'Scheduled Maintenance', 'Cancelled');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (10128, 71492, to_date('09-08-2010', 'dd-mm-yyyy'), 'Emergency Maintenance', 'Cancelled');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (44364, 47384, to_date('17-09-2002', 'dd-mm-yyyy'), 'Lubrication Maintenance', 'Completed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (16995, 59336, to_date('17-10-2002', 'dd-mm-yyyy'), 'Inspection Maintenance', 'In Progress');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (86664, 42144, to_date('08-05-2004', 'dd-mm-yyyy'), 'Alignment Maintenance', 'In Progress');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (21070, 97444, to_date('03-11-2018', 'dd-mm-yyyy'), 'Inspection Maintenance', 'Failed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (93526, 85412, to_date('19-11-2005', 'dd-mm-yyyy'), 'Unscheduled Maintenance', 'Cancelled');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (35555, 9039, to_date('04-07-2007', 'dd-mm-yyyy'), 'Condition-Based Maintenance', 'Cancelled');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (74631, 82790, to_date('03-12-2003', 'dd-mm-yyyy'), 'Preventive Maintenance', 'Completed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (2738, 62102, to_date('27-06-2000', 'dd-mm-yyyy'), 'Replacement Maintenance', 'Failed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (20025, 6777, to_date('05-06-2015', 'dd-mm-yyyy'), 'Condition-Based Maintenance', 'On Hold');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (84300, 69974, to_date('11-12-2003', 'dd-mm-yyyy'), 'Lubrication Maintenance', 'Pending');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (25762, 23205, to_date('30-04-2011', 'dd-mm-yyyy'), 'Emergency Maintenance', 'In Progress');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (90514, 44121, to_date('08-01-2022', 'dd-mm-yyyy'), 'Condition-Based Maintenance', 'Pending');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (67404, 21070, to_date('01-02-2003', 'dd-mm-yyyy'), 'Emergency Maintenance', 'Failed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (83782, 14021, to_date('20-04-2011', 'dd-mm-yyyy'), 'Unscheduled Maintenance', 'Failed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (2146, 36993, to_date('08-09-2016', 'dd-mm-yyyy'), 'Replacement Maintenance', 'Pending');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (36274, 50297, to_date('07-07-2022', 'dd-mm-yyyy'), 'Scheduled Maintenance', 'Completed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (24921, 88712, to_date('04-05-2004', 'dd-mm-yyyy'), 'Routine Maintenance', 'Cancelled');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (86698, 53858, to_date('30-10-2001', 'dd-mm-yyyy'), 'Emergency Maintenance', 'Failed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (66488, 44986, to_date('04-10-2023', 'dd-mm-yyyy'), 'Calibration Maintenance', 'Cancelled');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (58954, 62217, to_date('21-02-2006', 'dd-mm-yyyy'), 'Lubrication Maintenance', 'Pending');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (58275, 43361, to_date('02-10-2011', 'dd-mm-yyyy'), 'Lubrication Maintenance', 'Failed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (56647, 80497, to_date('14-05-2022', 'dd-mm-yyyy'), 'Lubrication Maintenance', 'Completed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (6058, 53710, to_date('07-08-2022', 'dd-mm-yyyy'), 'Replacement Maintenance', 'In Progress');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (63600, 25193, to_date('22-05-2021', 'dd-mm-yyyy'), 'Calibration Maintenance', 'Cancelled');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (68567, 55427, to_date('18-09-2013', 'dd-mm-yyyy'), 'Calibration Maintenance', 'On Hold');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (42678, 79798, to_date('31-08-2002', 'dd-mm-yyyy'), 'Emergency Maintenance', 'Completed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (34068, 81065, to_date('21-11-2018', 'dd-mm-yyyy'), 'Safety Checks', 'On Hold');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (64789, 59165, to_date('21-08-2022', 'dd-mm-yyyy'), 'Unscheduled Maintenance', 'Pending');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (84156, 60144, to_date('19-08-2014', 'dd-mm-yyyy'), 'Corrective Maintenance', 'Completed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (98090, 70180, to_date('21-02-2021', 'dd-mm-yyyy'), 'Scheduled Maintenance', 'Pending');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (35692, 5145, to_date('02-01-2019', 'dd-mm-yyyy'), 'Preventive Maintenance', 'Pending');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (75400, 96274, to_date('04-10-2003', 'dd-mm-yyyy'), 'Preventive Maintenance', 'Failed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (15128, 98629, to_date('06-09-2022', 'dd-mm-yyyy'), 'Preventive Maintenance', 'On Hold');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (16900, 28721, to_date('13-09-2004', 'dd-mm-yyyy'), 'Inspection Maintenance', 'On Hold');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (50897, 97141, to_date('05-01-2020', 'dd-mm-yyyy'), 'Inspection Maintenance', 'Completed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (46645, 74773, to_date('17-04-2007', 'dd-mm-yyyy'), 'Unscheduled Maintenance', 'Failed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (25034, 45369, to_date('19-04-2021', 'dd-mm-yyyy'), 'Condition-Based Maintenance', 'In Progress');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (86415, 97811, to_date('18-03-2005', 'dd-mm-yyyy'), 'Preventive Maintenance', 'In Progress');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (11275, 24270, to_date('03-09-2011', 'dd-mm-yyyy'), 'Calibration Maintenance', 'Pending');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (70303, 43979, to_date('29-11-2002', 'dd-mm-yyyy'), 'Scheduled Maintenance', 'Pending');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (99619, 20560, to_date('02-07-2018', 'dd-mm-yyyy'), 'Lubrication Maintenance', 'Completed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (79379, 89569, to_date('24-04-2017', 'dd-mm-yyyy'), 'Preventive Maintenance', 'Completed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (73071, 33649, to_date('08-08-2003', 'dd-mm-yyyy'), 'Overhaul Maintenance', 'On Hold');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (79115, 59941, to_date('14-09-2018', 'dd-mm-yyyy'), 'Emergency Maintenance', 'Completed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (17198, 10763, to_date('25-02-2010', 'dd-mm-yyyy'), 'Inspection Maintenance', 'Cancelled');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (34083, 30193, to_date('16-02-2012', 'dd-mm-yyyy'), 'Inspection Maintenance', 'Completed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (13588, 53074, to_date('10-09-2000', 'dd-mm-yyyy'), 'Preventive Maintenance', 'Failed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (6242, 76532, to_date('26-12-2002', 'dd-mm-yyyy'), 'Cleaning Maintenance', 'Failed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (50378, 46288, to_date('04-05-2011', 'dd-mm-yyyy'), 'Routine Maintenance', 'Pending');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (95914, 11446, to_date('24-07-2003', 'dd-mm-yyyy'), 'Inspection Maintenance', 'Cancelled');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (83155, 69628, to_date('16-12-2023', 'dd-mm-yyyy'), 'Corrective Maintenance', 'Pending');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (89754, 61619, to_date('22-03-2004', 'dd-mm-yyyy'), 'Emergency Maintenance', 'On Hold');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (53829, 8756, to_date('08-12-2003', 'dd-mm-yyyy'), 'Corrective Maintenance', 'Failed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (18770, 41454, to_date('26-09-2017', 'dd-mm-yyyy'), 'Calibration Maintenance', 'Cancelled');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (29862, 72055, to_date('13-11-2015', 'dd-mm-yyyy'), 'Calibration Maintenance', 'Pending');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (33076, 93036, to_date('02-09-2014', 'dd-mm-yyyy'), 'Unscheduled Maintenance', 'Failed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (17765, 67274, to_date('11-07-2014', 'dd-mm-yyyy'), 'Overhaul Maintenance', 'On Hold');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (49763, 12014, to_date('13-04-2010', 'dd-mm-yyyy'), 'Replacement Maintenance', 'Cancelled');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (39212, 67843, to_date('09-05-2003', 'dd-mm-yyyy'), 'Calibration Maintenance', 'In Progress');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (57319, 14020, to_date('03-06-2005', 'dd-mm-yyyy'), 'Predictive Maintenance', 'Failed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (91836, 66662, to_date('04-10-2014', 'dd-mm-yyyy'), 'Cleaning Maintenance', 'Pending');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (45675, 24580, to_date('03-01-2022', 'dd-mm-yyyy'), 'Lubrication Maintenance', 'On Hold');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (55930, 10957, to_date('03-08-2009', 'dd-mm-yyyy'), 'Corrective Maintenance', 'On Hold');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (6457, 52806, to_date('29-05-2014', 'dd-mm-yyyy'), 'Corrective Maintenance', 'On Hold');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (9131, 16170, to_date('27-04-2014', 'dd-mm-yyyy'), 'Predictive Maintenance', 'Completed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (94577, 42147, to_date('01-09-2005', 'dd-mm-yyyy'), 'Emergency Maintenance', 'Cancelled');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (80067, 1144, to_date('28-08-2003', 'dd-mm-yyyy'), 'Cleaning Maintenance', 'In Progress');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (91260, 36078, to_date('15-01-2011', 'dd-mm-yyyy'), 'Lubrication Maintenance', 'Failed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (64941, 52111, to_date('06-08-2002', 'dd-mm-yyyy'), 'Calibration Maintenance', 'In Progress');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (41073, 59183, to_date('16-05-2010', 'dd-mm-yyyy'), 'Calibration Maintenance', 'On Hold');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (54621, 40766, to_date('31-03-2015', 'dd-mm-yyyy'), 'Calibration Maintenance', 'In Progress');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (82946, 50949, to_date('03-02-2011', 'dd-mm-yyyy'), 'Preventive Maintenance', 'On Hold');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (30026, 72875, to_date('07-03-2001', 'dd-mm-yyyy'), 'Lubrication Maintenance', 'Pending');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (38581, 6828, to_date('02-05-2000', 'dd-mm-yyyy'), 'Condition-Based Maintenance', 'Cancelled');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (86840, 60087, to_date('30-06-2019', 'dd-mm-yyyy'), 'Preventive Maintenance', 'Cancelled');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (92466, 35162, to_date('09-06-2009', 'dd-mm-yyyy'), 'Overhaul Maintenance', 'On Hold');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (3013, 69724, to_date('01-05-2015', 'dd-mm-yyyy'), 'Safety Checks', 'On Hold');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (77117, 35525, to_date('13-07-2006', 'dd-mm-yyyy'), 'Safety Checks', 'Pending');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (70413, 46953, to_date('09-02-2019', 'dd-mm-yyyy'), 'Predictive Maintenance', 'On Hold');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (96381, 209, to_date('14-04-2000', 'dd-mm-yyyy'), 'Predictive Maintenance', 'Completed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (31661, 1841, to_date('12-07-2014', 'dd-mm-yyyy'), 'Predictive Maintenance', 'On Hold');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (59996, 42291, to_date('29-11-2019', 'dd-mm-yyyy'), 'Alignment Maintenance', 'Failed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (717, 41805, to_date('16-11-2012', 'dd-mm-yyyy'), 'Safety Checks', 'Completed');
commit;
prompt 300 records committed...
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (95253, 17037, to_date('17-07-2000', 'dd-mm-yyyy'), 'Emergency Maintenance', 'On Hold');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (57655, 89044, to_date('28-03-2006', 'dd-mm-yyyy'), 'Corrective Maintenance', 'Pending');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (27897, 34792, to_date('18-10-2000', 'dd-mm-yyyy'), 'Unscheduled Maintenance', 'On Hold');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (328, 83964, to_date('18-09-2001', 'dd-mm-yyyy'), 'Cleaning Maintenance', 'Cancelled');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (15494, 19049, to_date('26-11-2021', 'dd-mm-yyyy'), 'Unscheduled Maintenance', 'Completed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (64618, 20626, to_date('02-01-2009', 'dd-mm-yyyy'), 'Alignment Maintenance', 'Pending');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (53729, 49430, to_date('06-02-2001', 'dd-mm-yyyy'), 'Cleaning Maintenance', 'Completed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (96967, 20120, to_date('05-05-2021', 'dd-mm-yyyy'), 'Alignment Maintenance', 'Failed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (90609, 2072, to_date('26-04-2015', 'dd-mm-yyyy'), 'Cleaning Maintenance', 'Completed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (34043, 3722, to_date('09-01-2001', 'dd-mm-yyyy'), 'Emergency Maintenance', 'Failed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (56739, 65619, to_date('05-12-2017', 'dd-mm-yyyy'), 'Preventive Maintenance', 'In Progress');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (21081, 10965, to_date('05-10-2004', 'dd-mm-yyyy'), 'Condition-Based Maintenance', 'Failed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (82776, 25986, to_date('08-06-2009', 'dd-mm-yyyy'), 'Lubrication Maintenance', 'Cancelled');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (38812, 99698, to_date('06-04-2022', 'dd-mm-yyyy'), 'Lubrication Maintenance', 'Completed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (9294, 83439, to_date('14-04-2019', 'dd-mm-yyyy'), 'Routine Maintenance', 'Failed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (15228, 96911, to_date('08-08-2003', 'dd-mm-yyyy'), 'Safety Checks', 'Completed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (30686, 47702, to_date('12-09-2022', 'dd-mm-yyyy'), 'Unscheduled Maintenance', 'Cancelled');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (29009, 21936, to_date('03-05-2014', 'dd-mm-yyyy'), 'Inspection Maintenance', 'On Hold');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (34769, 56860, to_date('08-06-2012', 'dd-mm-yyyy'), 'Overhaul Maintenance', 'On Hold');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (72480, 8828, to_date('04-07-2007', 'dd-mm-yyyy'), 'Preventive Maintenance', 'Pending');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (34599, 40177, to_date('20-08-2006', 'dd-mm-yyyy'), 'Cleaning Maintenance', 'Failed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (89698, 93494, to_date('11-03-2020', 'dd-mm-yyyy'), 'Lubrication Maintenance', 'On Hold');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (19998, 99714, to_date('30-07-2007', 'dd-mm-yyyy'), 'Corrective Maintenance', 'On Hold');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (46014, 34733, to_date('02-09-2022', 'dd-mm-yyyy'), 'Preventive Maintenance', 'On Hold');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (14541, 77143, to_date('22-01-2012', 'dd-mm-yyyy'), 'Condition-Based Maintenance', 'Pending');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (75374, 88077, to_date('09-10-2003', 'dd-mm-yyyy'), 'Unscheduled Maintenance', 'On Hold');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (90705, 6616, to_date('07-06-2023', 'dd-mm-yyyy'), 'Routine Maintenance', 'On Hold');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (97073, 78381, to_date('21-08-2020', 'dd-mm-yyyy'), 'Alignment Maintenance', 'Cancelled');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (2579, 88258, to_date('24-09-2007', 'dd-mm-yyyy'), 'Lubrication Maintenance', 'On Hold');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (50741, 2722, to_date('23-09-2019', 'dd-mm-yyyy'), 'Calibration Maintenance', 'Failed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (23366, 56002, to_date('30-05-2023', 'dd-mm-yyyy'), 'Safety Checks', 'Failed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (73505, 70683, to_date('09-07-2022', 'dd-mm-yyyy'), 'Scheduled Maintenance', 'On Hold');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (55126, 14346, to_date('27-02-2011', 'dd-mm-yyyy'), 'Replacement Maintenance', 'Completed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (92543, 35681, to_date('25-05-2005', 'dd-mm-yyyy'), 'Predictive Maintenance', 'On Hold');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (91924, 87501, to_date('10-12-2012', 'dd-mm-yyyy'), 'Lubrication Maintenance', 'Failed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (36048, 19896, to_date('10-09-2013', 'dd-mm-yyyy'), 'Corrective Maintenance', 'Pending');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (96193, 17426, to_date('14-02-2021', 'dd-mm-yyyy'), 'Preventive Maintenance', 'Failed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (32115, 67910, to_date('28-01-2009', 'dd-mm-yyyy'), 'Replacement Maintenance', 'In Progress');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (72823, 70795, to_date('15-08-2006', 'dd-mm-yyyy'), 'Routine Maintenance', 'Completed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (74559, 11518, to_date('17-03-2014', 'dd-mm-yyyy'), 'Alignment Maintenance', 'Pending');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (27539, 25213, to_date('04-08-2015', 'dd-mm-yyyy'), 'Cleaning Maintenance', 'In Progress');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (43332, 71603, to_date('08-10-2018', 'dd-mm-yyyy'), 'Corrective Maintenance', 'In Progress');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (56760, 8177, to_date('04-10-2011', 'dd-mm-yyyy'), 'Emergency Maintenance', 'Completed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (81377, 93829, to_date('02-12-2011', 'dd-mm-yyyy'), 'Routine Maintenance', 'On Hold');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (66651, 14777, to_date('05-08-2020', 'dd-mm-yyyy'), 'Overhaul Maintenance', 'Pending');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (5673, 94222, to_date('08-07-2001', 'dd-mm-yyyy'), 'Emergency Maintenance', 'Pending');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (40626, 37986, to_date('07-01-2013', 'dd-mm-yyyy'), 'Calibration Maintenance', 'Cancelled');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (73992, 10019, to_date('14-07-2023', 'dd-mm-yyyy'), 'Corrective Maintenance', 'Cancelled');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (98503, 65055, to_date('01-10-2021', 'dd-mm-yyyy'), 'Calibration Maintenance', 'Failed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (97056, 91450, to_date('12-06-2001', 'dd-mm-yyyy'), 'Lubrication Maintenance', 'Failed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (98057, 31115, to_date('22-09-2020', 'dd-mm-yyyy'), 'Scheduled Maintenance', 'Completed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (84224, 62820, to_date('07-09-2002', 'dd-mm-yyyy'), 'Routine Maintenance', 'In Progress');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (52008, 32892, to_date('04-01-2000', 'dd-mm-yyyy'), 'Safety Checks', 'Cancelled');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (96155, 7505, to_date('23-08-2006', 'dd-mm-yyyy'), 'Calibration Maintenance', 'Failed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (52036, 97760, to_date('20-06-2011', 'dd-mm-yyyy'), 'Preventive Maintenance', 'In Progress');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (56096, 22615, to_date('27-02-2016', 'dd-mm-yyyy'), 'Inspection Maintenance', 'Pending');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (37123, 32308, to_date('10-04-2019', 'dd-mm-yyyy'), 'Alignment Maintenance', 'Failed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (98869, 26260, to_date('30-12-2020', 'dd-mm-yyyy'), 'Cleaning Maintenance', 'Failed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (97980, 46626, to_date('15-08-2003', 'dd-mm-yyyy'), 'Cleaning Maintenance', 'Failed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (19581, 14926, to_date('13-05-2011', 'dd-mm-yyyy'), 'Replacement Maintenance', 'Completed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (3534, 21673, to_date('06-07-2011', 'dd-mm-yyyy'), 'Safety Checks', 'Failed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (78649, 41594, to_date('18-02-2015', 'dd-mm-yyyy'), 'Condition-Based Maintenance', 'Cancelled');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (50757, 63747, to_date('17-06-2012', 'dd-mm-yyyy'), 'Calibration Maintenance', 'On Hold');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (32416, 48242, to_date('03-04-2016', 'dd-mm-yyyy'), 'Cleaning Maintenance', 'Completed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (6862, 28485, to_date('28-12-2014', 'dd-mm-yyyy'), 'Routine Maintenance', 'Failed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (45347, 20430, to_date('13-07-2012', 'dd-mm-yyyy'), 'Corrective Maintenance', 'Cancelled');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (14065, 3135, to_date('07-06-2019', 'dd-mm-yyyy'), 'Lubrication Maintenance', 'In Progress');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (7175, 68117, to_date('22-09-2010', 'dd-mm-yyyy'), 'Safety Checks', 'Failed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (93326, 66427, to_date('29-03-2019', 'dd-mm-yyyy'), 'Lubrication Maintenance', 'Completed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (82301, 56870, to_date('09-01-2021', 'dd-mm-yyyy'), 'Emergency Maintenance', 'Completed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (95610, 6420, to_date('18-03-2000', 'dd-mm-yyyy'), 'Safety Checks', 'In Progress');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (65774, 48468, to_date('01-09-2010', 'dd-mm-yyyy'), 'Cleaning Maintenance', 'Cancelled');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (38798, 24398, to_date('23-05-2016', 'dd-mm-yyyy'), 'Corrective Maintenance', 'Completed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (66321, 40899, to_date('14-09-2005', 'dd-mm-yyyy'), 'Inspection Maintenance', 'Cancelled');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (16526, 93696, to_date('23-03-2014', 'dd-mm-yyyy'), 'Unscheduled Maintenance', 'In Progress');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (88614, 56023, to_date('29-10-2023', 'dd-mm-yyyy'), 'Preventive Maintenance', 'Cancelled');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (3188, 32205, to_date('07-07-2000', 'dd-mm-yyyy'), 'Replacement Maintenance', 'Completed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (278, 90062, to_date('20-06-2009', 'dd-mm-yyyy'), 'Calibration Maintenance', 'In Progress');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (88463, 92738, to_date('17-03-2004', 'dd-mm-yyyy'), 'Replacement Maintenance', 'Pending');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (50539, 48853, to_date('07-07-2022', 'dd-mm-yyyy'), 'Safety Checks', 'In Progress');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (86107, 32607, to_date('26-07-2022', 'dd-mm-yyyy'), 'Cleaning Maintenance', 'Failed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (12970, 17577, to_date('26-03-2005', 'dd-mm-yyyy'), 'Routine Maintenance', 'On Hold');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (56805, 98779, to_date('12-06-2016', 'dd-mm-yyyy'), 'Scheduled Maintenance', 'On Hold');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (60788, 94917, to_date('24-05-2012', 'dd-mm-yyyy'), 'Cleaning Maintenance', 'On Hold');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (94731, 14385, to_date('25-07-2006', 'dd-mm-yyyy'), 'Scheduled Maintenance', 'Failed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (5975, 35304, to_date('02-01-2006', 'dd-mm-yyyy'), 'Inspection Maintenance', 'Pending');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (33415, 82055, to_date('26-04-2022', 'dd-mm-yyyy'), 'Scheduled Maintenance', 'Failed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (49154, 21571, to_date('12-05-2018', 'dd-mm-yyyy'), 'Predictive Maintenance', 'In Progress');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (59810, 86141, to_date('31-08-2022', 'dd-mm-yyyy'), 'Safety Checks', 'Pending');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (52149, 15021, to_date('29-11-2004', 'dd-mm-yyyy'), 'Cleaning Maintenance', 'Cancelled');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (67386, 85281, to_date('08-10-2015', 'dd-mm-yyyy'), 'Emergency Maintenance', 'Cancelled');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (65511, 31964, to_date('26-09-2006', 'dd-mm-yyyy'), 'Lubrication Maintenance', 'In Progress');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (60755, 95510, to_date('13-09-2014', 'dd-mm-yyyy'), 'Predictive Maintenance', 'Completed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (75481, 56435, to_date('27-04-2019', 'dd-mm-yyyy'), 'Safety Checks', 'In Progress');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (27217, 78259, to_date('07-05-2011', 'dd-mm-yyyy'), 'Lubrication Maintenance', 'Pending');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (84908, 49275, to_date('04-11-2008', 'dd-mm-yyyy'), 'Corrective Maintenance', 'Pending');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (45760, 23457, to_date('05-11-2001', 'dd-mm-yyyy'), 'Unscheduled Maintenance', 'Completed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (66982, 35368, to_date('20-02-2015', 'dd-mm-yyyy'), 'Lubrication Maintenance', 'Completed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (92840, 61805, to_date('27-05-2005', 'dd-mm-yyyy'), 'Routine Maintenance', 'Failed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (35426, 74711, to_date('09-02-2021', 'dd-mm-yyyy'), 'Alignment Maintenance', 'On Hold');
commit;
prompt 400 records loaded
prompt Loading MACHINES...
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (34970, 'Leak Testing Machine', to_date('01-12-2001', 'dd-mm-yyyy'), 'Operational', 65774, 83846105);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (61740, 'Welding and Cutting Machine', to_date('15-07-2020', 'dd-mm-yyyy'), 'Operational', 37925, 96835597);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (82030, 'Wire Drawing Machine', to_date('20-03-2015', 'dd-mm-yyyy'), 'Operational', 14184, 45349098);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (18319, 'Laser Welding Machine', to_date('27-04-2015', 'dd-mm-yyyy'), 'Operational', 64789, 83177693);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (59674, 'Hardness Testing Machine', to_date('26-12-2007', 'dd-mm-yyyy'), 'Operational', 88944, 16354941);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (28600, 'Horizontal Boring Mill', to_date('27-02-2017', 'dd-mm-yyyy'), 'Operational', 44283, 99005237);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (44229, 'Grit Blasting Machine', to_date('06-04-2023', 'dd-mm-yyyy'), 'Operational', 31660, 45349098);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (45423, 'Assembly Machine', to_date('03-04-2012', 'dd-mm-yyyy'), 'Operational', 9131, 11410646);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (35983, 'Acoustic Testing Machine', to_date('12-08-2012', 'dd-mm-yyyy'), 'Operational', 62992, 84657835);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (75094, 'Punch Press', to_date('27-02-2007', 'dd-mm-yyyy'), 'Operational', 27470, 17882271);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (8710, 'Rheo-Microscopy Machine', to_date('15-05-2018', 'dd-mm-yyyy'), 'Operational', 46533, 43756556);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (64064, 'Metallurgical Testing Machine', to_date('08-02-2002', 'dd-mm-yyyy'), 'Operational', 99970, 13629800);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (17418, 'Thread Rolling Machine', to_date('17-11-2011', 'dd-mm-yyyy'), 'Operational', 79288, 39313492);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (41040, 'Alignment Machine', to_date('23-04-2018', 'dd-mm-yyyy'), 'Operational', 16995, 20113136);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (80521, 'Chemical Testing Machine', to_date('15-05-2013', 'dd-mm-yyyy'), 'Operational', 73404, 85003854);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (25015, 'Wire Bender', to_date('06-12-2012', 'dd-mm-yyyy'), 'Operational', 2415, 92665521);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (84342, 'Plate Bender', to_date('05-08-2020', 'dd-mm-yyyy'), 'Operational', 83439, 71110942);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (91899, 'Rebar Bender', to_date('24-01-2009', 'dd-mm-yyyy'), 'Operational', 12463, 74243613);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (25766, 'Metallurgical Testing Machine', to_date('07-08-2006', 'dd-mm-yyyy'), 'Operational', 78499, 71611157);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (75269, 'Pipe Rolling Machine', to_date('19-03-2022', 'dd-mm-yyyy'), 'Operational', 76622, 13629800);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (13090, 'Water Jet Cutter', to_date('18-11-2017', 'dd-mm-yyyy'), 'Operational', 95954, 20191024);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (43016, 'Thermogravimetric Analysis Machine', to_date('25-09-2009', 'dd-mm-yyyy'), 'Operational', 67404, 17561794);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (36489, 'Rheo-Raman', to_date('10-05-2014', 'dd-mm-yyyy'), 'Operational', 65774, 73291243);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (46170, 'Mechanical Press', to_date('01-02-2017', 'dd-mm-yyyy'), 'Operational', 52008, 68401747);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (970, 'Scratch Testing Machine', to_date('12-12-2018', 'dd-mm-yyyy'), 'Operational', 72049, 51957721);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (66839, 'Drilling and Tapping Machine', to_date('11-06-2004', 'dd-mm-yyyy'), 'Operational', 95610, 30556154);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (49669, 'Physical Testing Machine', to_date('27-01-2018', 'dd-mm-yyyy'), 'Operational', 59132, 37207125);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (42284, 'Stamping Machine', to_date('23-12-2001', 'dd-mm-yyyy'), 'Operational', 91813, 51638591);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (60553, 'Subtractive Manufacturing Machine', to_date('29-03-2009', 'dd-mm-yyyy'), 'Operational', 17170, 59743184);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (66512, 'Quenching Machine', to_date('01-12-2019', 'dd-mm-yyyy'), 'Operational', 98090, 84360223);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (88329, 'Pipe Making Machine', to_date('26-08-2020', 'dd-mm-yyyy'), 'Operational', 71477, 86054195);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (75504, 'Thermogravimetric Analysis Machine', to_date('12-03-2008', 'dd-mm-yyyy'), 'Operational', 91325, 48576763);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (76989, 'Wear Testing Machine', to_date('21-05-2009', 'dd-mm-yyyy'), 'Operational', 15128, 34849605);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (63732, 'Rod Drawing Machine', to_date('14-08-2001', 'dd-mm-yyyy'), 'Operational', 58954, 20233702);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (68128, 'Tube Drawing Machine', to_date('21-12-2022', 'dd-mm-yyyy'), 'Operational', 96967, 54748279);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (64087, 'Rheo-Microscopy Machine', to_date('07-03-2013', 'dd-mm-yyyy'), 'Operational', 38581, 90862878);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (7219, 'Stress Rupture Testing Machine', to_date('09-06-2007', 'dd-mm-yyyy'), 'Operational', 89698, 18675026);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (7014, 'Transfer Molding Machine', to_date('26-05-2004', 'dd-mm-yyyy'), 'Operational', 75400, 78624858);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (85675, 'Calibration Machine', to_date('01-11-2010', 'dd-mm-yyyy'), 'Operational', 252, 15326270);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (63829, 'Non-Destructive Testing Machine', to_date('15-07-2004', 'dd-mm-yyyy'), 'Operational', 79288, 91104836);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (82018, 'Burst Testing Machine', to_date('24-02-2004', 'dd-mm-yyyy'), 'Operational', 56769, 99005237);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (30066, 'Pipe Drawing Machine', to_date('05-09-2011', 'dd-mm-yyyy'), 'Operational', 28382, 37207125);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (62041, 'Vertical Boring Mill', to_date('17-12-2008', 'dd-mm-yyyy'), 'Operational', 64789, 11056490);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (23548, 'Engraving Machine', to_date('13-12-2021', 'dd-mm-yyyy'), 'Operational', 66553, 62526376);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (96814, 'Rheo-Spectroscopy Machine', to_date('14-11-2014', 'dd-mm-yyyy'), 'Operational', 76622, 68401747);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (14940, 'Dynamic Mechanical Analysis Machine', to_date('15-05-2023', 'dd-mm-yyyy'), 'Operational', 18021, 78216572);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (39860, 'Router Table', to_date('05-09-2000', 'dd-mm-yyyy'), 'Operational', 64618, 11311183);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (82080, 'Assembly Machine', to_date('18-02-2016', 'dd-mm-yyyy'), 'Operational', 64789, 25535209);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (2207, 'Rotational Molding Machine', to_date('01-09-2021', 'dd-mm-yyyy'), 'Operational', 89445, 37207125);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (39653, 'Thermal Shock Testing Machine', to_date('23-08-2002', 'dd-mm-yyyy'), 'Operational', 12463, 65702533);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (57501, 'Subtractive Manufacturing Machine', to_date('20-11-2021', 'dd-mm-yyyy'), 'Operational', 98534, 48870120);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (48955, 'Flow Testing Machine', to_date('01-12-2017', 'dd-mm-yyyy'), 'Operational', 37925, 17561794);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (30130, 'Pipe Rolling Machine', to_date('26-04-2019', 'dd-mm-yyyy'), 'Operational', 43567, 97578691);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (14983, 'Leveling Machine', to_date('21-08-2021', 'dd-mm-yyyy'), 'Operational', 1187, 72930320);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (48718, 'Dynamic Mechanical Analysis Machine', to_date('29-12-2023', 'dd-mm-yyyy'), 'Operational', 54255, 61456823);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (35965, 'Boring Mill', to_date('18-08-2012', 'dd-mm-yyyy'), 'Operational', 59355, 73291243);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (16607, 'Surface Treatment Machine', to_date('15-10-2016', 'dd-mm-yyyy'), 'Operational', 94790, 43756556);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (40091, 'Extensional Rheometer', to_date('04-04-2016', 'dd-mm-yyyy'), 'Operational', 59464, 27373972);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (41228, 'Testing Machine', to_date('09-05-2018', 'dd-mm-yyyy'), 'Operational', 64618, 21498697);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (31786, 'Bar Bender', to_date('07-11-2000', 'dd-mm-yyyy'), 'Operational', 27539, 17561794);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (7010, 'Gear Shaping Machine', to_date('13-11-2005', 'dd-mm-yyyy'), 'Operational', 78499, 17963068);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (31698, 'Heat Capacity Testing Machine', to_date('09-03-2006', 'dd-mm-yyyy'), 'Operational', 33097, 73291243);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (52650, 'Electroplating Machine', to_date('09-12-2012', 'dd-mm-yyyy'), 'Operational', 86179, 23250655);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (36862, 'Machining and Assembly Machine', to_date('14-09-2012', 'dd-mm-yyyy'), 'Operational', 43332, 43856352);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (54790, 'Radial Arm Saw', to_date('23-06-2010', 'dd-mm-yyyy'), 'Operational', 64941, 59279749);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (6474, 'Foam Cutting Machine', to_date('28-03-2010', 'dd-mm-yyyy'), 'Operational', 23366, 43322564);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (7250, 'Tube Drawing Machine', to_date('15-10-2001', 'dd-mm-yyyy'), 'Operational', 3534, 81525413);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (729, 'Thread Rolling Machine', to_date('19-10-2016', 'dd-mm-yyyy'), 'Operational', 98902, 44272847);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (49594, 'Spline Cutting Machine', to_date('26-05-2000', 'dd-mm-yyyy'), 'Operational', 34769, 92854052);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (21335, 'Rheo-WAXS', to_date('01-03-2021', 'dd-mm-yyyy'), 'Operational', 53925, 27399832);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (21917, 'Cylindrical Grinder', to_date('16-11-2009', 'dd-mm-yyyy'), 'Operational', 73505, 39313492);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (28966, 'Drilling Machine', to_date('09-12-2006', 'dd-mm-yyyy'), 'Operational', 27217, 71611157);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (35715, 'Spline Rolling Machine', to_date('31-12-2010', 'dd-mm-yyyy'), 'Operational', 71615, 96835597);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (1351, 'Thermal Shock Testing Machine', to_date('18-01-2002', 'dd-mm-yyyy'), 'Operational', 55930, 30061988);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (34825, 'Thermal Cycling Testing Machine', to_date('19-01-2010', 'dd-mm-yyyy'), 'Operational', 73505, 90745803);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (51962, 'Machining Center', to_date('24-09-2003', 'dd-mm-yyyy'), 'Operational', 19051, 62218719);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (6812, 'Compression Molding Machine', to_date('08-07-2000', 'dd-mm-yyyy'), 'Operational', 34769, 34849605);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (9922, 'Engraving Machine', to_date('30-05-2016', 'dd-mm-yyyy'), 'Operational', 41073, 84657835);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (75199, 'Pressure Testing Machine', to_date('01-09-2014', 'dd-mm-yyyy'), 'Operational', 12678, 37031324);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (72691, 'Residual Stress Testing Machine', to_date('20-03-2002', 'dd-mm-yyyy'), 'Operational', 92532, 89241937);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (87840, 'Wire Rolling Machine', to_date('28-08-2014', 'dd-mm-yyyy'), 'Operational', 54277, 17126069);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (40941, 'Machining and Assembly Machine', to_date('27-02-2010', 'dd-mm-yyyy'), 'Operational', 58833, 48576763);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (97633, 'Transfer Molding Machine', to_date('26-06-2002', 'dd-mm-yyyy'), 'Operational', 49154, 81969040);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (35672, 'Heat Treating Machine', to_date('31-08-2022', 'dd-mm-yyyy'), 'Operational', 38144, 47712085);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (40122, 'Bar Drawing Machine', to_date('02-01-2010', 'dd-mm-yyyy'), 'Operational', 55910, 95814419);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (37608, 'Thermoforming Machine', to_date('22-06-2017', 'dd-mm-yyyy'), 'Operational', 28442, 83177693);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (29403, 'Thermogravimetric Analysis Machine', to_date('12-07-2019', 'dd-mm-yyyy'), 'Operational', 15228, 74243613);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (84315, 'Extensional Rheometer', to_date('13-08-2019', 'dd-mm-yyyy'), 'Operational', 56096, 85682722);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (50498, 'Swiss Machine', to_date('18-12-2013', 'dd-mm-yyyy'), 'Operational', 72480, 99005237);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (67595, 'Laser Cutter', to_date('24-10-2008', 'dd-mm-yyyy'), 'Operational', 1313, 87982560);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (4195, 'Label Making Machine', to_date('30-06-2006', 'dd-mm-yyyy'), 'Operational', 11699, 92665521);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (98828, 'Machining Center', to_date('02-05-2010', 'dd-mm-yyyy'), 'Operational', 10128, 43856352);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (90506, 'Lathe', to_date('13-10-2008', 'dd-mm-yyyy'), 'Operational', 95610, 97259537);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (9246, 'Calibration Machine', to_date('09-02-2021', 'dd-mm-yyyy'), 'Operational', 8241, 39403818);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (80710, 'Tube Rolling Machine', to_date('03-05-2015', 'dd-mm-yyyy'), 'Operational', 68110, 56727091);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (31881, 'Spline Rolling Machine', to_date('18-10-2021', 'dd-mm-yyyy'), 'Operational', 6058, 88868162);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (56507, 'Bar Drawing Machine', to_date('11-05-2013', 'dd-mm-yyyy'), 'Operational', 39212, 22900368);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (28499, 'Shearing Machine', to_date('20-04-2016', 'dd-mm-yyyy'), 'Operational', 4051, 77642002);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (69557, 'Annealing Machine', to_date('24-08-2019', 'dd-mm-yyyy'), 'Operational', 56744, 30556154);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (84208, 'Plate Bender', to_date('22-04-2013', 'dd-mm-yyyy'), 'Operational', 5975, 83480577);
commit;
prompt 100 records committed...
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (26712, 'Optical Testing Machine', to_date('14-05-2002', 'dd-mm-yyyy'), 'Operational', 44364, 67214968);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (51224, 'Grinding Machine', to_date('29-04-2000', 'dd-mm-yyyy'), 'Operational', 64618, 54748279);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (16890, 'Tenoner', to_date('24-06-2017', 'dd-mm-yyyy'), 'Operational', 18770, 86155159);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (87344, 'Panel Folding Machine', to_date('24-11-2009', 'dd-mm-yyyy'), 'Operational', 15536, 47712085);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (96039, 'Wire EDM', to_date('01-06-2004', 'dd-mm-yyyy'), 'Operational', 44364, 54670908);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (60644, 'Hardening Machine', to_date('17-09-2004', 'dd-mm-yyyy'), 'Operational', 35555, 34424868);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (18220, 'Turning Center', to_date('23-03-2003', 'dd-mm-yyyy'), 'Operational', 99619, 86054195);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (85670, 'Testing Machine', to_date('19-08-2015', 'dd-mm-yyyy'), 'Operational', 45347, 63442847);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (74742, 'Stress Relieving Machine', to_date('23-10-2006', 'dd-mm-yyyy'), 'Operational', 86698, 51638591);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (74559, 'Honing Machine', to_date('14-11-2018', 'dd-mm-yyyy'), 'Operational', 90370, 32591990);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (60844, 'Table Saw', to_date('01-03-2015', 'dd-mm-yyyy'), 'Operational', 8241, 54088195);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (89132, 'Brazing Machine', to_date('22-10-2022', 'dd-mm-yyyy'), 'Operational', 43567, 32877721);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (47052, 'Drilling and Tapping Machine', to_date('29-05-2003', 'dd-mm-yyyy'), 'Operational', 55910, 59743184);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (93058, 'Thread Rolling Machine', to_date('19-04-2010', 'dd-mm-yyyy'), 'Operational', 17765, 67214968);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (42281, 'Dovetailer', to_date('01-06-2007', 'dd-mm-yyyy'), 'Operational', 50757, 97745277);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (54756, 'Thermal Cycling Testing Machine', to_date('21-04-2008', 'dd-mm-yyyy'), 'Operational', 30877, 41522255);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (19470, 'Reaming Machine', to_date('09-08-2015', 'dd-mm-yyyy'), 'Operational', 19129, 52282046);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (49466, 'Slitter Rewinder', to_date('21-11-2010', 'dd-mm-yyyy'), 'Operational', 2415, 16844774);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (94041, 'Grinding and Polishing Machine', to_date('14-06-2011', 'dd-mm-yyyy'), 'Operational', 28442, 51957721);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (60608, 'Peening Machine', to_date('06-08-2006', 'dd-mm-yyyy'), 'Operational', 98902, 23759349);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (87362, 'Painting Machine', to_date('31-05-2000', 'dd-mm-yyyy'), 'Operational', 92508, 64207208);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (27063, 'Pipe Rolling Machine', to_date('01-12-2023', 'dd-mm-yyyy'), 'Operational', 45530, 70266179);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (3013, 'Thermal Conductivity Testing Machine', to_date('24-12-2009', 'dd-mm-yyyy'), 'Operational', 38075, 97578691);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (12050, 'Tenoner', to_date('04-02-2004', 'dd-mm-yyyy'), 'Operational', 66651, 89799326);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (85131, 'Shot Peening Machine', to_date('15-11-2018', 'dd-mm-yyyy'), 'Operational', 83155, 88868162);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (9509, 'Gear Grinding Machine', to_date('05-09-2022', 'dd-mm-yyyy'), 'Operational', 87504, 71061207);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (1847, 'Thermal Fatigue Testing Machine', to_date('13-07-2019', 'dd-mm-yyyy'), 'Operational', 6862, 77642002);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (67261, 'Tumbling Machine', to_date('21-07-2009', 'dd-mm-yyyy'), 'Operational', 92466, 16354941);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (55864, 'Tube Making Machine', to_date('26-04-2004', 'dd-mm-yyyy'), 'Operational', 73462, 65892682);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (37600, 'Injection Molding Machine', to_date('22-03-2009', 'dd-mm-yyyy'), 'Operational', 60788, 15326270);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (85748, 'Corrosion Testing Machine', to_date('10-08-2010', 'dd-mm-yyyy'), 'Operational', 94577, 48870120);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (21486, 'Creep Testing Machine', to_date('19-07-2004', 'dd-mm-yyyy'), 'Operational', 9294, 16354941);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (66412, 'Leak Testing Machine', to_date('12-11-2005', 'dd-mm-yyyy'), 'Operational', 13588, 61154579);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (58603, 'Flexural Testing Machine', to_date('09-05-2019', 'dd-mm-yyyy'), 'Operational', 87504, 54655982);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (77214, 'Rheo-Dielectric Machine', to_date('27-02-2017', 'dd-mm-yyyy'), 'Operational', 7862, 43756556);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (88249, 'Additive Manufacturing Machine', to_date('16-10-2019', 'dd-mm-yyyy'), 'Operational', 65578, 67214968);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (62026, 'Bead Blasting Machine', to_date('16-03-2021', 'dd-mm-yyyy'), 'Operational', 47493, 63442847);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (71780, 'Additive Manufacturing Machine', to_date('13-10-2008', 'dd-mm-yyyy'), 'Operational', 96381, 13867485);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (88912, 'Reaming Machine', to_date('11-11-2018', 'dd-mm-yyyy'), 'Operational', 97980, 34793536);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (82244, 'Panel Folding Machine', to_date('29-05-2005', 'dd-mm-yyyy'), 'Operational', 87504, 90862878);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (8976, 'Resistance Welding Machine', to_date('06-05-2021', 'dd-mm-yyyy'), 'Operational', 3188, 59933677);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (37295, 'Foam Cutting Machine', to_date('03-08-2023', 'dd-mm-yyyy'), 'Operational', 90514, 95561954);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (45656, 'Peeling Machine', to_date('09-12-2009', 'dd-mm-yyyy'), 'Operational', 55126, 43599881);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (33549, 'Leveling Machine', to_date('23-04-2009', 'dd-mm-yyyy'), 'Operational', 55910, 94146730);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (98597, 'Coating Machine', to_date('11-11-2007', 'dd-mm-yyyy'), 'Operational', 38812, 64103674);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (40685, 'Dynamic Mechanical Analysis Machine', to_date('01-01-2008', 'dd-mm-yyyy'), 'Operational', 84224, 33067757);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (51384, 'Tapping Machine', to_date('24-01-2002', 'dd-mm-yyyy'), 'Operational', 43567, 42423384);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (87897, 'Compression Testing Machine', to_date('06-10-2007', 'dd-mm-yyyy'), 'Operational', 39466, 43756556);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (11203, 'Cut-off Saw', to_date('20-05-2021', 'dd-mm-yyyy'), 'Operational', 13199, 31417541);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (30084, 'Impact Testing Machine', to_date('13-10-2000', 'dd-mm-yyyy'), 'Operational', 73404, 59295976);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (12110, 'Residual Stress Testing Machine', to_date('12-01-2003', 'dd-mm-yyyy'), 'Operational', 29862, 81969040);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (72661, 'Leak Testing Machine', to_date('16-04-2010', 'dd-mm-yyyy'), 'Operational', 18770, 20113136);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (63291, 'Slitter Rewinder', to_date('03-11-2001', 'dd-mm-yyyy'), 'Operational', 4051, 76928249);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (68390, 'Surface Treatment Machine', to_date('24-03-2013', 'dd-mm-yyyy'), 'Operational', 95914, 85003854);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (50750, 'Swiss Machine', to_date('05-10-2018', 'dd-mm-yyyy'), 'Operational', 27539, 74048849);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (33245, 'Wire EDM', to_date('22-01-2011', 'dd-mm-yyyy'), 'Operational', 3188, 20191024);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (86495, 'Compression Testing Machine', to_date('03-03-2007', 'dd-mm-yyyy'), 'Operational', 12463, 20113136);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (67565, 'Destructive Testing Machine', to_date('05-12-2015', 'dd-mm-yyyy'), 'Operational', 55380, 34017820);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (74805, 'Shearing Machine', to_date('05-05-2012', 'dd-mm-yyyy'), 'Operational', 59355, 41522255);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (69579, 'Stamping Press', to_date('30-10-2012', 'dd-mm-yyyy'), 'Operational', 10128, 22900368);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (11712, 'Label Making Machine', to_date('19-01-2007', 'dd-mm-yyyy'), 'Operational', 8024, 87982560);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (97240, 'Cutting Machine', to_date('10-06-2011', 'dd-mm-yyyy'), 'Operational', 57655, 91104836);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (82789, 'Coating Machine', to_date('27-08-2023', 'dd-mm-yyyy'), 'Operational', 59464, 91104836);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (27398, 'Pipe Rolling Machine', to_date('17-08-2019', 'dd-mm-yyyy'), 'Operational', 91289, 34849605);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (56831, 'Thermal Shock Testing Machine', to_date('07-05-2010', 'dd-mm-yyyy'), 'Operational', 58833, 20233702);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (84836, 'Leveling Machine', to_date('01-01-2008', 'dd-mm-yyyy'), 'Operational', 86179, 92355989);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (20382, 'Reaming Machine', to_date('30-03-2011', 'dd-mm-yyyy'), 'Operational', 45347, 61456823);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (23992, 'Spline Cutting Machine', to_date('27-03-2020', 'dd-mm-yyyy'), 'Operational', 2146, 59743184);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (41535, 'Rheology Testing Machine', to_date('30-10-2018', 'dd-mm-yyyy'), 'Operational', 28442, 86514668);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (49370, 'Reaming Machine', to_date('08-05-2003', 'dd-mm-yyyy'), 'Operational', 82831, 45349098);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (22217, 'Cutting Machine', to_date('26-01-2016', 'dd-mm-yyyy'), 'Operational', 97711, 81418452);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (13117, 'Laser Welding Machine', to_date('06-09-2014', 'dd-mm-yyyy'), 'Operational', 57655, 23486725);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (77566, 'Optical Testing Machine', to_date('03-11-2001', 'dd-mm-yyyy'), 'Operational', 93526, 81418452);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (36139, 'Rheo-Dielectric Machine', to_date('11-11-2021', 'dd-mm-yyyy'), 'Operational', 11275, 16596417);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (256, 'Router Table', to_date('02-10-2004', 'dd-mm-yyyy'), 'Operational', 93709, 47712085);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (18752, 'Destructive Testing Machine', to_date('08-10-2021', 'dd-mm-yyyy'), 'Operational', 83055, 55819347);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (7938, 'Scratch Testing Machine', to_date('07-07-2020', 'dd-mm-yyyy'), 'Operational', 7862, 31650026);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (44478, 'Tube Bender', to_date('23-01-2014', 'dd-mm-yyyy'), 'Operational', 86107, 81418452);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (64679, 'Rheology Testing Machine', to_date('29-11-2003', 'dd-mm-yyyy'), 'Operational', 12987, 63442847);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (92396, 'EDM Machine', to_date('07-11-2011', 'dd-mm-yyyy'), 'Operational', 12987, 71460396);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (93493, 'Environmental Testing Machine', to_date('07-03-2012', 'dd-mm-yyyy'), 'Operational', 89445, 55818347);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (65761, 'Panel Bender', to_date('26-08-2009', 'dd-mm-yyyy'), 'Operational', 82497, 16354941);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (88236, 'Thermal Cycling Testing Machine', to_date('08-04-2015', 'dd-mm-yyyy'), 'Operational', 48725, 99433231);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (73581, 'Rotational Molding Machine', to_date('02-12-2002', 'dd-mm-yyyy'), 'Operational', 94731, 77642002);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (70279, 'Mechanical Press', to_date('19-07-2023', 'dd-mm-yyyy'), 'Operational', 33097, 34948701);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (73853, 'Cutting Machine', to_date('18-03-2009', 'dd-mm-yyyy'), 'Operational', 56096, 20113136);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (49991, 'Wire EDM', to_date('08-02-2023', 'dd-mm-yyyy'), 'Operational', 2579, 21498697);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (58302, 'Cut-off Saw', to_date('06-03-2012', 'dd-mm-yyyy'), 'Operational', 12463, 74243613);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (26145, 'Fracture Testing Machine', to_date('06-05-2007', 'dd-mm-yyyy'), 'Operational', 91289, 63442847);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (35184, 'Boring and Milling Machine', to_date('27-08-2017', 'dd-mm-yyyy'), 'Operational', 10326, 92642538);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (19394, 'Fatigue Crack Growth Testing Machine', to_date('27-09-2003', 'dd-mm-yyyy'), 'Operational', 46533, 30556154);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (5036, 'Vibratory Finishing Machine', to_date('05-03-2017', 'dd-mm-yyyy'), 'Operational', 39841, 68401747);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (70026, 'Threading Machine', to_date('04-01-2007', 'dd-mm-yyyy'), 'Operational', 25034, 35498377);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (30644, 'Thread Rolling Machine', to_date('06-08-2004', 'dd-mm-yyyy'), 'Operational', 63600, 20315447);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (66632, 'Rheo-IR', to_date('24-07-2020', 'dd-mm-yyyy'), 'Operational', 9131, 54103386);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (33056, 'Non-Destructive Testing Machine', to_date('29-08-2014', 'dd-mm-yyyy'), 'Operational', 56096, 78624858);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (92343, 'Milling and Drilling Machine', to_date('23-01-2000', 'dd-mm-yyyy'), 'Operational', 43567, 86514668);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (6481, 'Die Cutting Machine', to_date('21-09-2014', 'dd-mm-yyyy'), 'Operational', 16526, 65892682);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (10178, 'Slitter Rewinder', to_date('22-05-2014', 'dd-mm-yyyy'), 'Operational', 20740, 15585992);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (92711, 'Thermomechanical Analysis Machine', to_date('13-04-2007', 'dd-mm-yyyy'), 'Operational', 39212, 34424868);
commit;
prompt 200 records committed...
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (39940, 'Thermoforming Machine', to_date('28-09-2020', 'dd-mm-yyyy'), 'Operational', 95954, 56727091);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (96386, 'Tensile Testing Machine', to_date('02-05-2009', 'dd-mm-yyyy'), 'Operational', 53925, 28411817);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (37488, 'Bending Machine', to_date('13-08-2008', 'dd-mm-yyyy'), 'Operational', 97980, 21509784);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (12372, 'Knurling Machine', to_date('27-03-2018', 'dd-mm-yyyy'), 'Operational', 96193, 39370182);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (54017, 'Compression Testing Machine', to_date('28-08-2012', 'dd-mm-yyyy'), 'Operational', 90514, 86514668);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (81965, 'Laser Cutter', to_date('22-02-2010', 'dd-mm-yyyy'), 'Operational', 89445, 86155159);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (59781, 'Carton Making Machine', to_date('01-12-2014', 'dd-mm-yyyy'), 'Operational', 56398, 93869133);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (51713, 'Stamping Machine', to_date('02-01-2000', 'dd-mm-yyyy'), 'Operational', 31660, 18675026);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (44497, 'Bar Drawing Machine', to_date('25-11-2019', 'dd-mm-yyyy'), 'Operational', 1771, 72063537);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (83771, 'Rod Rolling Machine', to_date('27-06-2018', 'dd-mm-yyyy'), 'Operational', 57655, 13629800);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (86840, 'Tempering Machine', to_date('02-01-2011', 'dd-mm-yyyy'), 'Operational', 37925, 91104836);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (16044, 'Annealing Machine', to_date('24-04-2013', 'dd-mm-yyyy'), 'Operational', 73902, 62933363);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (99241, 'Cylindrical Grinder', to_date('23-05-2011', 'dd-mm-yyyy'), 'Operational', 54266, 23320965);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (91, 'Laser Cutter', to_date('14-01-2005', 'dd-mm-yyyy'), 'Operational', 20740, 77642002);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (32762, 'Roll Forming Machine', to_date('11-03-2008', 'dd-mm-yyyy'), 'Operational', 91260, 16596417);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (11356, 'Vibratory Finishing Machine', to_date('28-05-2002', 'dd-mm-yyyy'), 'Operational', 63600, 62933363);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (51577, 'Bead Blasting Machine', to_date('12-01-2007', 'dd-mm-yyyy'), 'Operational', 54539, 87552354);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (35675, 'Cryogenic Treatment Machine', to_date('17-03-2007', 'dd-mm-yyyy'), 'Operational', 6242, 54670908);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (88612, 'Assembly Machine', to_date('13-04-2016', 'dd-mm-yyyy'), 'Operational', 43332, 92887180);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (44777, 'Stress Rupture Testing Machine', to_date('18-10-2010', 'dd-mm-yyyy'), 'Operational', 11275, 17634484);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (54554, 'Thermal Conductivity Testing Machine', to_date('03-04-2004', 'dd-mm-yyyy'), 'Operational', 12970, 92355989);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (87596, 'Hydrogen Embrittlement Testing Machine', to_date('04-04-2017', 'dd-mm-yyyy'), 'Operational', 29862, 74072275);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (22906, 'Coating Machine', to_date('20-06-2007', 'dd-mm-yyyy'), 'Operational', 73992, 59279749);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (133, 'Vibratory Finishing Machine', to_date('08-08-2007', 'dd-mm-yyyy'), 'Operational', 92681, 63861534);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (35387, 'Coating Machine', to_date('31-08-2001', 'dd-mm-yyyy'), 'Operational', 34068, 94249883);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (80426, 'Flexural Testing Machine', to_date('19-05-2022', 'dd-mm-yyyy'), 'Operational', 64789, 64103674);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (95858, 'Pouch Making Machine', to_date('26-10-2010', 'dd-mm-yyyy'), 'Operational', 10128, 54748279);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (43281, 'Rheo-IR', to_date('31-07-2012', 'dd-mm-yyyy'), 'Operational', 65564, 54748279);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (28504, 'Optical Testing Machine', to_date('01-05-2014', 'dd-mm-yyyy'), 'Operational', 36842, 83846105);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (67909, 'Flexural Testing Machine', to_date('04-10-2011', 'dd-mm-yyyy'), 'Operational', 66488, 54655982);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (98346, 'Boring Mill', to_date('26-01-2019', 'dd-mm-yyyy'), 'Operational', 39841, 74677527);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (36926, 'Horizontal Boring Mill', to_date('10-01-2014', 'dd-mm-yyyy'), 'Operational', 94765, 44272847);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (10646, 'Stamping Press', to_date('22-05-2005', 'dd-mm-yyyy'), 'Operational', 80067, 60843836);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (43335, 'Pouch Making Machine', to_date('09-10-2011', 'dd-mm-yyyy'), 'Operational', 24921, 31650026);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (51508, 'Honing Machine', to_date('19-03-2019', 'dd-mm-yyyy'), 'Operational', 40626, 34948701);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (69597, 'Rod Drawing Machine', to_date('04-08-2019', 'dd-mm-yyyy'), 'Operational', 50741, 27399832);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (86457, 'Boring and Milling Machine', to_date('06-08-2000', 'dd-mm-yyyy'), 'Operational', 19581, 12074999);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (25788, 'Electron Beam Welding Machine', to_date('04-07-2000', 'dd-mm-yyyy'), 'Operational', 52749, 34424868);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (27931, 'Hardness Testing Machine', to_date('14-08-2008', 'dd-mm-yyyy'), 'Operational', 95954, 31417541);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (28463, 'Bar Rolling Machine', to_date('19-03-2010', 'dd-mm-yyyy'), 'Operational', 73902, 16285988);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (98006, 'Differential Scanning Calorimetry Machine', to_date('31-05-2010', 'dd-mm-yyyy'), 'Operational', 56398, 51957721);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (14462, 'Wire Bender', to_date('25-08-2014', 'dd-mm-yyyy'), 'Operational', 86698, 69372437);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (80355, 'Thermal Expansion Testing Machine', to_date('07-04-2008', 'dd-mm-yyyy'), 'Operational', 15709, 74742649);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (70692, 'Milling and Drilling Machine', to_date('08-04-2005', 'dd-mm-yyyy'), 'Operational', 76668, 65892682);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (56655, 'Honing and Lapping Machine', to_date('10-04-2014', 'dd-mm-yyyy'), 'Operational', 91289, 77642002);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (28226, 'Spline Rolling Machine', to_date('15-11-2023', 'dd-mm-yyyy'), 'Operational', 19051, 65891332);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (88838, 'Tapping Machine', to_date('19-09-2018', 'dd-mm-yyyy'), 'Operational', 83682, 33314613);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (73030, 'Thermal Fatigue Testing Machine', to_date('12-01-2021', 'dd-mm-yyyy'), 'Operational', 83055, 55818347);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (20746, 'Tenoner', to_date('31-08-2003', 'dd-mm-yyyy'), 'Operational', 92532, 73291243);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (72642, 'Wire EDM', to_date('08-12-2017', 'dd-mm-yyyy'), 'Operational', 50506, 36812939);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (62306, 'Press Brake', to_date('10-06-2014', 'dd-mm-yyyy'), 'Operational', 95253, 38174594);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (64289, 'Bead Blasting Machine', to_date('13-08-2022', 'dd-mm-yyyy'), 'Operational', 12909, 92535882);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (67513, 'Spline Rolling Machine', to_date('21-08-2014', 'dd-mm-yyyy'), 'Operational', 97073, 10840739);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (1598, 'Bar Rolling Machine', to_date('01-07-2013', 'dd-mm-yyyy'), 'Operational', 56647, 16596417);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (55446, 'Fatigue Crack Growth Testing Machine', to_date('27-02-2006', 'dd-mm-yyyy'), 'Operational', 10134, 61137958);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (70435, 'Turning and Milling Machine', to_date('27-06-2023', 'dd-mm-yyyy'), 'Operational', 50741, 62218719);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (32683, 'Bead Blasting Machine', to_date('11-05-2014', 'dd-mm-yyyy'), 'Operational', 39762, 42142840);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (65764, 'Thermoforming Machine', to_date('09-11-2005', 'dd-mm-yyyy'), 'Operational', 94765, 99005237);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (86863, 'Vibration Testing Machine', to_date('16-10-2014', 'dd-mm-yyyy'), 'Operational', 57655, 94249883);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (26957, 'Router', to_date('10-09-2012', 'dd-mm-yyyy'), 'Operational', 24812, 18675026);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (16178, 'Bar Drawing Machine', to_date('10-05-2016', 'dd-mm-yyyy'), 'Operational', 85591, 23720801);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (65056, 'Edge Banding Machine', to_date('17-09-2016', 'dd-mm-yyyy'), 'Operational', 42678, 71460396);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (69446, 'Peeling Machine', to_date('20-08-2022', 'dd-mm-yyyy'), 'Operational', 92466, 67214968);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (38215, 'Boring Mill', to_date('14-12-2019', 'dd-mm-yyyy'), 'Operational', 7175, 35281037);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (77370, 'Honing Machine', to_date('26-01-2013', 'dd-mm-yyyy'), 'Operational', 50539, 30556154);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (47284, 'Lapping Machine', to_date('25-01-2011', 'dd-mm-yyyy'), 'Operational', 18723, 27044249);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (88875, 'Assembly Machine', to_date('08-06-2021', 'dd-mm-yyyy'), 'Operational', 47566, 61137958);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (88441, 'Facing Machine', to_date('24-08-2010', 'dd-mm-yyyy'), 'Operational', 43594, 59279749);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (68335, 'Thermal Cycling Testing Machine', to_date('27-04-2016', 'dd-mm-yyyy'), 'Operational', 50284, 18675026);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (20182, 'Wire Drawing Machine', to_date('30-05-2014', 'dd-mm-yyyy'), 'Operational', 9131, 72930320);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (91215, 'Cold Saw', to_date('06-12-2018', 'dd-mm-yyyy'), 'Operational', 38812, 35498377);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (34098, 'Microhardness Testing Machine', to_date('18-12-2004', 'dd-mm-yyyy'), 'Operational', 44364, 61171248);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (78514, 'Resistance Welding Machine', to_date('03-05-2022', 'dd-mm-yyyy'), 'Operational', 92583, 52282046);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (69006, 'Spline Cutting Machine', to_date('19-04-2023', 'dd-mm-yyyy'), 'Operational', 5701, 54748279);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (65526, 'Plate Bender', to_date('05-07-2015', 'dd-mm-yyyy'), 'Operational', 91289, 65610666);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (32258, 'Laser Welding Machine', to_date('17-03-2005', 'dd-mm-yyyy'), 'Operational', 18144, 39403818);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (89259, 'Milling and Drilling Machine', to_date('19-12-2011', 'dd-mm-yyyy'), 'Operational', 55930, 86514668);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (96883, 'Rheo-IR', to_date('12-06-2004', 'dd-mm-yyyy'), 'Operational', 20351, 12074999);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (32430, 'Finishing Machine', to_date('17-08-2016', 'dd-mm-yyyy'), 'Operational', 52036, 48870120);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (84717, 'Tapping Machine', to_date('20-06-2017', 'dd-mm-yyyy'), 'Operational', 17295, 23759349);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (61660, 'Rheo-SAXS', to_date('11-09-2006', 'dd-mm-yyyy'), 'Operational', 21508, 70266179);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (30105, 'Thermal Shock Testing Machine', to_date('30-06-2019', 'dd-mm-yyyy'), 'Operational', 67386, 70266179);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (74575, 'Thermogravimetric Analysis Machine', to_date('06-08-2008', 'dd-mm-yyyy'), 'Operational', 5975, 96835597);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (2520, 'Quenching Machine', to_date('24-09-2003', 'dd-mm-yyyy'), 'Operational', 17295, 19792292);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (6123, 'Capillary Rheometer', to_date('03-02-2015', 'dd-mm-yyyy'), 'Operational', 85591, 61137958);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (55544, 'Roll Forming Machine', to_date('09-07-2014', 'dd-mm-yyyy'), 'Operational', 10326, 19792292);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (69931, 'Swiss Machine', to_date('29-04-2023', 'dd-mm-yyyy'), 'Operational', 82301, 20344983);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (20568, 'Wire EDM', to_date('04-08-2014', 'dd-mm-yyyy'), 'Operational', 49763, 92854052);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (7118, 'Rotational Molding Machine', to_date('20-04-2022', 'dd-mm-yyyy'), 'Operational', 46014, 65702533);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (82396, 'Tensile Testing Machine', to_date('19-06-2019', 'dd-mm-yyyy'), 'Operational', 45675, 36373252);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (13853, 'Horizontal Boring Mill', to_date('19-09-2015', 'dd-mm-yyyy'), 'Operational', 80067, 62218719);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (17031, 'Thermogravimetric Analysis Machine', to_date('06-09-2014', 'dd-mm-yyyy'), 'Operational', 78499, 92665521);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (1546, 'Powder Coating Machine', to_date('20-03-2013', 'dd-mm-yyyy'), 'Operational', 96193, 44272847);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (45419, 'Punching Machine', to_date('29-07-2020', 'dd-mm-yyyy'), 'Operational', 79288, 16752796);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (40848, 'Friction Stir Welding Machine', to_date('23-04-2003', 'dd-mm-yyyy'), 'Operational', 88463, 89936499);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (17219, 'Deburring Machine', to_date('28-11-2022', 'dd-mm-yyyy'), 'Operational', 30877, 12074999);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (34146, 'Router Table', to_date('24-12-2001', 'dd-mm-yyyy'), 'Operational', 21081, 35498377);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (91862, 'Router', to_date('03-01-2023', 'dd-mm-yyyy'), 'Operational', 56647, 51638591);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (82000, 'Melt Flow Indexer', to_date('01-10-2011', 'dd-mm-yyyy'), 'Operational', 19051, 73291243);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (86618, 'Surface Grinder', to_date('06-09-2019', 'dd-mm-yyyy'), 'Operational', 96967, 54088195);
commit;
prompt 300 records committed...
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (38405, 'Wire Saw', to_date('18-05-2022', 'dd-mm-yyyy'), 'Operational', 36842, 81525413);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (19286, '3D Printer', to_date('06-09-2010', 'dd-mm-yyyy'), 'Operational', 54621, 54670908);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (18960, 'Electrical Testing Machine', to_date('16-10-2023', 'dd-mm-yyyy'), 'Operational', 58954, 96951684);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (42776, 'Thermal Fatigue Testing Machine', to_date('17-03-2015', 'dd-mm-yyyy'), 'Operational', 37925, 85889675);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (16379, 'Stress Rupture Testing Machine', to_date('27-10-2015', 'dd-mm-yyyy'), 'Operational', 44094, 39313492);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (56427, 'Anodizing Machine', to_date('24-07-2020', 'dd-mm-yyyy'), 'Operational', 7001, 23720801);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (20464, 'Thermal Expansion Testing Machine', to_date('26-05-2015', 'dd-mm-yyyy'), 'Operational', 28442, 65610666);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (40718, 'Anodizing Machine', to_date('02-01-2007', 'dd-mm-yyyy'), 'Operational', 41073, 72063537);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (15888, 'Impact Testing Machine', to_date('24-06-2015', 'dd-mm-yyyy'), 'Operational', 65511, 16285988);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (4343, 'Induction Hardening Machine', to_date('08-06-2002', 'dd-mm-yyyy'), 'Operational', 328, 56727091);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (72312, 'Tensile Testing Machine', to_date('03-08-2000', 'dd-mm-yyyy'), 'Operational', 27973, 34793536);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (11591, 'Friction Stir Welding Machine', to_date('01-10-2016', 'dd-mm-yyyy'), 'Operational', 59132, 62218719);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (28507, 'Punch Press', to_date('30-03-2023', 'dd-mm-yyyy'), 'Operational', 64789, 99433231);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (79974, 'High Cycle Fatigue Testing Machine', to_date('09-05-2005', 'dd-mm-yyyy'), 'Operational', 62113, 89241937);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (36735, 'Lathe', to_date('25-08-2012', 'dd-mm-yyyy'), 'Operational', 96967, 19137978);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (59211, 'Leveling Machine', to_date('06-08-2018', 'dd-mm-yyyy'), 'Operational', 17212, 23486725);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (56796, 'Surface Grinder', to_date('07-02-2014', 'dd-mm-yyyy'), 'Operational', 29009, 76928249);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (29355, 'Stress Rupture Testing Machine', to_date('03-11-2013', 'dd-mm-yyyy'), 'Operational', 96193, 51638591);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (2093, 'Hydraulic Press', to_date('04-05-2003', 'dd-mm-yyyy'), 'Operational', 62113, 97578691);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (44221, 'Tube Bender', to_date('19-01-2009', 'dd-mm-yyyy'), 'Operational', 93326, 17634484);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (24206, 'Finishing Machine', to_date('01-08-2004', 'dd-mm-yyyy'), 'Operational', 48563, 52282046);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (2627, 'Acoustic Testing Machine', to_date('05-01-2011', 'dd-mm-yyyy'), 'Operational', 51850, 90862878);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (8845, 'Buffing Machine', to_date('17-09-2007', 'dd-mm-yyyy'), 'Operational', 38075, 59743184);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (10513, 'Dynamic Mechanical Analysis Machine', to_date('06-08-2018', 'dd-mm-yyyy'), 'Operational', 99970, 82793030);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (26098, 'Rotational Rheometer', to_date('09-11-2007', 'dd-mm-yyyy'), 'Operational', 57954, 99433231);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (8058, 'Resistance Welding Machine', to_date('15-09-2011', 'dd-mm-yyyy'), 'Operational', 39841, 13629800);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (62735, 'Viscometer', to_date('10-03-2016', 'dd-mm-yyyy'), 'Operational', 38144, 97745277);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (33644, 'Threading Machine', to_date('15-02-2015', 'dd-mm-yyyy'), 'Operational', 27897, 28411817);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (45315, 'Knurling Machine', to_date('02-03-2016', 'dd-mm-yyyy'), 'Operational', 72823, 74048849);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (87265, 'Subtractive Manufacturing Machine', to_date('29-09-2006', 'dd-mm-yyyy'), 'Operational', 52149, 81525413);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (71103, 'Friction Stir Welding Machine', to_date('25-06-2009', 'dd-mm-yyyy'), 'Operational', 56805, 11311183);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (95901, 'Flow Testing Machine', to_date('05-05-2015', 'dd-mm-yyyy'), 'Operational', 25034, 56727091);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (80738, 'High Cycle Fatigue Testing Machine', to_date('08-03-2013', 'dd-mm-yyyy'), 'Operational', 86107, 97415593);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (78799, 'Subtractive Manufacturing Machine', to_date('11-07-2005', 'dd-mm-yyyy'), 'Operational', 43567, 73291243);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (63298, 'Brazing Machine', to_date('08-01-2018', 'dd-mm-yyyy'), 'Operational', 91813, 95814419);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (17717, 'Hardening Machine', to_date('06-04-2006', 'dd-mm-yyyy'), 'Operational', 18087, 33314613);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (62272, 'Edge Rounding Machine', to_date('23-11-2000', 'dd-mm-yyyy'), 'Operational', 19581, 99005237);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (62307, 'Corrosion Testing Machine', to_date('11-12-2009', 'dd-mm-yyyy'), 'Operational', 30727, 11056490);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (81094, 'Leak Testing Machine', to_date('29-06-2001', 'dd-mm-yyyy'), 'Operational', 34769, 86054195);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (114, 'Pipe Drawing Machine', to_date('23-11-2004', 'dd-mm-yyyy'), 'Operational', 12987, 75426354);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (50690, 'Strain Testing Machine', to_date('14-09-2007', 'dd-mm-yyyy'), 'Operational', 15006, 71358712);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (443, 'Turning and Milling Machine', to_date('21-11-2022', 'dd-mm-yyyy'), 'Operational', 59464, 74677527);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (50077, 'Alignment Machine', to_date('18-02-2022', 'dd-mm-yyyy'), 'Operational', 60500, 17882271);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (57885, 'Roll Forming Machine', to_date('19-04-2014', 'dd-mm-yyyy'), 'Operational', 96967, 54103386);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (45787, 'Foam Cutting Machine', to_date('22-04-2002', 'dd-mm-yyyy'), 'Operational', 75374, 72930320);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (20724, 'Anodizing Machine', to_date('09-05-2008', 'dd-mm-yyyy'), 'Operational', 28442, 57352525);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (67915, 'Welding Machine', to_date('14-05-2015', 'dd-mm-yyyy'), 'Operational', 73773, 47712085);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (48171, 'Mechanical Press', to_date('21-01-2000', 'dd-mm-yyyy'), 'Operational', 91260, 65610666);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (51259, 'Spindle Moulder', to_date('11-01-2004', 'dd-mm-yyyy'), 'Operational', 12428, 87982560);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (4513, 'Circular Saw', to_date('08-05-2014', 'dd-mm-yyyy'), 'Operational', 90514, 48870120);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (70471, 'Cylindrical Grinder', to_date('16-06-2003', 'dd-mm-yyyy'), 'Operational', 96381, 32420685);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (24145, 'Panel Bender', to_date('17-05-2017', 'dd-mm-yyyy'), 'Operational', 59730, 42142840);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (69774, 'Grit Blasting Machine', to_date('05-03-2014', 'dd-mm-yyyy'), 'Operational', 36048, 51638591);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (75318, 'Hardness Testing Machine', to_date('11-09-2003', 'dd-mm-yyyy'), 'Operational', 252, 92642538);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (61673, 'Thermoforming Machine', to_date('06-10-2019', 'dd-mm-yyyy'), 'Operational', 27539, 97415593);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (68473, 'Cut-off Saw', to_date('13-11-2000', 'dd-mm-yyyy'), 'Operational', 16526, 39313492);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (26640, 'Extrusion Machine', to_date('08-02-2023', 'dd-mm-yyyy'), 'Operational', 16900, 35498377);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (3596, 'Knurling Machine', to_date('01-11-2023', 'dd-mm-yyyy'), 'Operational', 14541, 35498377);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (18102, 'Pipe Making Machine', to_date('01-04-2001', 'dd-mm-yyyy'), 'Operational', 67386, 54088195);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (86257, 'Microhardness Testing Machine', to_date('14-03-2007', 'dd-mm-yyyy'), 'Operational', 79379, 42142840);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (45533, 'Edge Rounding Machine', to_date('29-07-2017', 'dd-mm-yyyy'), 'Operational', 98869, 99979592);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (70246, 'Hardness Testing Machine', to_date('24-10-2008', 'dd-mm-yyyy'), 'Operational', 27470, 94249883);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (4221, 'Tumbling Machine', to_date('04-11-2008', 'dd-mm-yyyy'), 'Operational', 20025, 23250655);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (62130, 'Punch Press', to_date('27-08-2002', 'dd-mm-yyyy'), 'Operational', 21508, 63442847);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (24717, 'Lapping Machine', to_date('13-01-2015', 'dd-mm-yyyy'), 'Operational', 3188, 78216572);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (55987, 'Abrasion Testing Machine', to_date('08-07-2000', 'dd-mm-yyyy'), 'Operational', 15006, 87552354);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (59181, 'Sheet Metal Bender', to_date('23-04-2013', 'dd-mm-yyyy'), 'Operational', 30686, 65610666);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (11204, 'Blow Molding Machine', to_date('28-10-2021', 'dd-mm-yyyy'), 'Operational', 16900, 54103386);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (87176, 'Thermomechanical Analysis Machine', to_date('18-06-2013', 'dd-mm-yyyy'), 'Operational', 50284, 89936499);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (48793, 'Thermal Shock Testing Machine', to_date('26-04-2022', 'dd-mm-yyyy'), 'Operational', 64789, 84657835);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (41155, 'Fatigue Testing Machine', to_date('21-03-2002', 'dd-mm-yyyy'), 'Operational', 45967, 23486725);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (78548, 'Burst Testing Machine', to_date('03-07-2017', 'dd-mm-yyyy'), 'Operational', 55126, 31417541);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (3126, 'Electrical Testing Machine', to_date('26-05-2015', 'dd-mm-yyyy'), 'Operational', 68567, 61154579);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (86589, 'Heat Treating Machine', to_date('23-03-2020', 'dd-mm-yyyy'), 'Operational', 19998, 90745803);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (40124, 'Tenoner', to_date('02-09-2017', 'dd-mm-yyyy'), 'Operational', 97073, 47712085);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (66899, 'Rheo-Spectroscopy Machine', to_date('25-11-2023', 'dd-mm-yyyy'), 'Operational', 50757, 84360223);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (8311, 'Carton Making Machine', to_date('04-10-2002', 'dd-mm-yyyy'), 'Operational', 63600, 21346943);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (77391, 'Hardness Testing Machine', to_date('19-09-2004', 'dd-mm-yyyy'), 'Operational', 63651, 17963068);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (95056, 'Thermal Testing Machine', to_date('24-05-2004', 'dd-mm-yyyy'), 'Operational', 18971, 90745803);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (97267, 'Table Saw', to_date('26-04-2013', 'dd-mm-yyyy'), 'Operational', 1187, 89799326);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (66551, 'Non-Destructive Testing Machine', to_date('04-02-2009', 'dd-mm-yyyy'), 'Operational', 33097, 97745277);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (64062, 'Leak Testing Machine', to_date('25-04-2004', 'dd-mm-yyyy'), 'Operational', 39841, 17963068);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (76423, 'Counterboring Machine', to_date('22-10-2001', 'dd-mm-yyyy'), 'Operational', 82946, 54655982);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (32155, 'Rheo-Spectroscopy Machine', to_date('11-06-2008', 'dd-mm-yyyy'), 'Operational', 78649, 61137958);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (49964, 'Creep Testing Machine', to_date('01-12-2009', 'dd-mm-yyyy'), 'Operational', 278, 92355989);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (25900, 'Reaming Machine', to_date('27-01-2000', 'dd-mm-yyyy'), 'Operational', 45155, 32877721);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (19980, 'Plate Bender', to_date('27-09-2019', 'dd-mm-yyyy'), 'Operational', 78499, 62933363);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (16048, 'Punching Machine', to_date('23-04-2010', 'dd-mm-yyyy'), 'Operational', 85184, 32877721);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (35287, 'Tenoner', to_date('30-08-2005', 'dd-mm-yyyy'), 'Operational', 98902, 32420685);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (34218, 'Hardness Testing Machine', to_date('29-01-2016', 'dd-mm-yyyy'), 'Operational', 18144, 54655982);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (22758, 'Vacuum Testing Machine', to_date('04-05-2023', 'dd-mm-yyyy'), 'Operational', 4823, 37316644);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (12888, 'Noise Testing Machine', to_date('12-02-2004', 'dd-mm-yyyy'), 'Operational', 76622, 13629800);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (39769, 'Pipe Making Machine', to_date('04-01-2006', 'dd-mm-yyyy'), 'Operational', 65511, 91466324);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (4125, 'Panel Bender', to_date('14-02-2019', 'dd-mm-yyyy'), 'Operational', 10128, 21346943);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (37199, 'Creep Testing Machine', to_date('02-12-2002', 'dd-mm-yyyy'), 'Operational', 73902, 87982560);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (45202, 'Bar Rolling Machine', to_date('06-01-2023', 'dd-mm-yyyy'), 'Operational', 82497, 23720801);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (45036, 'Sheet Metal Bender', to_date('05-02-2014', 'dd-mm-yyyy'), 'Operational', 33103, 67214968);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (9674, 'Cut-off Saw', to_date('14-08-2006', 'dd-mm-yyyy'), 'Operational', 91605, 60843836);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (24369, 'Heat Treating Machine', to_date('24-03-2014', 'dd-mm-yyyy'), 'Operational', 25034, 36373252);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id, customer_id)
values (64580, 'Physical Testing Machine', to_date('19-12-2015', 'dd-mm-yyyy'), 'Operational', 18723, 61137958);
commit;
prompt 400 records loaded
prompt Loading ORDER_MACHINE...
insert into ORDER_MACHINE (order_id, machine_id)
values (24977793, 21486);
insert into ORDER_MACHINE (order_id, machine_id)
values (94869357, 45036);
insert into ORDER_MACHINE (order_id, machine_id)
values (14888608, 76989);
insert into ORDER_MACHINE (order_id, machine_id)
values (77256073, 54554);
insert into ORDER_MACHINE (order_id, machine_id)
values (28362564, 49594);
insert into ORDER_MACHINE (order_id, machine_id)
values (32935042, 59211);
insert into ORDER_MACHINE (order_id, machine_id)
values (14395239, 28226);
insert into ORDER_MACHINE (order_id, machine_id)
values (17247861, 49669);
insert into ORDER_MACHINE (order_id, machine_id)
values (30612695, 89259);
insert into ORDER_MACHINE (order_id, machine_id)
values (61218313, 45419);
insert into ORDER_MACHINE (order_id, machine_id)
values (13868615, 47052);
insert into ORDER_MACHINE (order_id, machine_id)
values (41812723, 83771);
insert into ORDER_MACHINE (order_id, machine_id)
values (45496635, 47052);
insert into ORDER_MACHINE (order_id, machine_id)
values (94869357, 96039);
insert into ORDER_MACHINE (order_id, machine_id)
values (37123734, 83771);
insert into ORDER_MACHINE (order_id, machine_id)
values (77256073, 29403);
insert into ORDER_MACHINE (order_id, machine_id)
values (10498218, 56831);
insert into ORDER_MACHINE (order_id, machine_id)
values (44660055, 67595);
insert into ORDER_MACHINE (order_id, machine_id)
values (56836563, 62307);
insert into ORDER_MACHINE (order_id, machine_id)
values (17220217, 91862);
insert into ORDER_MACHINE (order_id, machine_id)
values (76125747, 49370);
insert into ORDER_MACHINE (order_id, machine_id)
values (45343624, 97240);
insert into ORDER_MACHINE (order_id, machine_id)
values (90949868, 17418);
insert into ORDER_MACHINE (order_id, machine_id)
values (86672432, 34825);
insert into ORDER_MACHINE (order_id, machine_id)
values (46348857, 62306);
insert into ORDER_MACHINE (order_id, machine_id)
values (55211525, 1351);
insert into ORDER_MACHINE (order_id, machine_id)
values (14888608, 73581);
insert into ORDER_MACHINE (order_id, machine_id)
values (68022210, 23992);
insert into ORDER_MACHINE (order_id, machine_id)
values (17901723, 37608);
insert into ORDER_MACHINE (order_id, machine_id)
values (50211760, 45533);
insert into ORDER_MACHINE (order_id, machine_id)
values (69556806, 51962);
insert into ORDER_MACHINE (order_id, machine_id)
values (21778797, 8845);
insert into ORDER_MACHINE (order_id, machine_id)
values (16160718, 22758);
insert into ORDER_MACHINE (order_id, machine_id)
values (96542903, 62307);
insert into ORDER_MACHINE (order_id, machine_id)
values (72580041, 30644);
insert into ORDER_MACHINE (order_id, machine_id)
values (65592894, 39653);
insert into ORDER_MACHINE (order_id, machine_id)
values (35352016, 32683);
insert into ORDER_MACHINE (order_id, machine_id)
values (10511620, 73030);
insert into ORDER_MACHINE (order_id, machine_id)
values (16782726, 66412);
insert into ORDER_MACHINE (order_id, machine_id)
values (32935042, 13090);
insert into ORDER_MACHINE (order_id, machine_id)
values (48324694, 66412);
insert into ORDER_MACHINE (order_id, machine_id)
values (78875875, 64580);
insert into ORDER_MACHINE (order_id, machine_id)
values (45002614, 11591);
insert into ORDER_MACHINE (order_id, machine_id)
values (10511620, 95056);
insert into ORDER_MACHINE (order_id, machine_id)
values (71698994, 98828);
insert into ORDER_MACHINE (order_id, machine_id)
values (72580041, 68390);
insert into ORDER_MACHINE (order_id, machine_id)
values (86457534, 8311);
insert into ORDER_MACHINE (order_id, machine_id)
values (50162378, 86863);
insert into ORDER_MACHINE (order_id, machine_id)
values (97017792, 16048);
insert into ORDER_MACHINE (order_id, machine_id)
values (14395239, 9674);
insert into ORDER_MACHINE (order_id, machine_id)
values (82940119, 73853);
insert into ORDER_MACHINE (order_id, machine_id)
values (49767001, 49594);
insert into ORDER_MACHINE (order_id, machine_id)
values (34535393, 36735);
insert into ORDER_MACHINE (order_id, machine_id)
values (45343624, 19470);
insert into ORDER_MACHINE (order_id, machine_id)
values (28269220, 67261);
insert into ORDER_MACHINE (order_id, machine_id)
values (68022210, 36139);
insert into ORDER_MACHINE (order_id, machine_id)
values (71371841, 89259);
insert into ORDER_MACHINE (order_id, machine_id)
values (29915313, 35983);
insert into ORDER_MACHINE (order_id, machine_id)
values (54978245, 18102);
commit;
prompt 59 records loaded
prompt Loading TOOLS...
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (99420, 'Out of Service', to_date('02-08-2003', 'dd-mm-yyyy'), 'In Repair');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (78747, 'In Use', to_date('17-06-2014', 'dd-mm-yyyy'), 'Available');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (76762, 'Available', to_date('24-07-2011', 'dd-mm-yyyy'), 'Discarded');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (81538, 'Available', to_date('09-02-2011', 'dd-mm-yyyy'), 'In Repair');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (26882, 'Available', to_date('30-08-2001', 'dd-mm-yyyy'), 'Out of Service');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (676, 'In Repair', to_date('11-03-2003', 'dd-mm-yyyy'), 'In Use');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (34574, 'Under Maintenance', to_date('15-03-2014', 'dd-mm-yyyy'), 'In Use');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (35973, 'Reserved', to_date('14-08-2020', 'dd-mm-yyyy'), 'In Repair');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (48215, 'Discarded', to_date('19-12-2005', 'dd-mm-yyyy'), 'Reserved');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (49944, 'Available', to_date('08-07-2004', 'dd-mm-yyyy'), 'In Repair');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (29566, 'Under Maintenance', to_date('20-01-2005', 'dd-mm-yyyy'), 'Out of Service');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (95736, 'Reserved', to_date('18-10-2022', 'dd-mm-yyyy'), 'In Use');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (9829, 'Under Maintenance', to_date('16-03-2015', 'dd-mm-yyyy'), 'Reserved');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (51307, 'Discarded', to_date('23-03-2019', 'dd-mm-yyyy'), 'Reserved');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (51949, 'Reserved', to_date('13-08-2005', 'dd-mm-yyyy'), 'In Repair');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (59853, 'Reserved', to_date('06-01-2008', 'dd-mm-yyyy'), 'In Repair');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (19170, 'Out of Service', to_date('17-04-2010', 'dd-mm-yyyy'), 'In Use');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (76491, 'Under Maintenance', to_date('29-11-2017', 'dd-mm-yyyy'), 'Out of Service');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (49840, 'Under Maintenance', to_date('07-11-2000', 'dd-mm-yyyy'), 'Available');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (21190, 'Out of Service', to_date('30-09-2001', 'dd-mm-yyyy'), 'Under Maintenance');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (38466, 'In Repair', to_date('12-11-2012', 'dd-mm-yyyy'), 'Under Maintenance');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (37946, 'In Use', to_date('15-07-2023', 'dd-mm-yyyy'), 'Out of Service');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (23018, 'Discarded', to_date('06-09-2021', 'dd-mm-yyyy'), 'Reserved');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (60216, 'In Use', to_date('17-01-2003', 'dd-mm-yyyy'), 'Under Maintenance');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (78483, 'Under Maintenance', to_date('05-10-2023', 'dd-mm-yyyy'), 'Out of Service');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (82594, 'Discarded', to_date('17-11-2001', 'dd-mm-yyyy'), 'Discarded');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (16673, 'Under Maintenance', to_date('28-06-2011', 'dd-mm-yyyy'), 'Discarded');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (38746, 'In Repair', to_date('18-01-2019', 'dd-mm-yyyy'), 'Available');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (92272, 'Reserved', to_date('12-07-2009', 'dd-mm-yyyy'), 'In Use');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (85581, 'Reserved', to_date('22-01-2016', 'dd-mm-yyyy'), 'Reserved');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (15153, 'Reserved', to_date('14-08-2004', 'dd-mm-yyyy'), 'Reserved');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (93691, 'Discarded', to_date('24-06-2003', 'dd-mm-yyyy'), 'In Repair');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (68918, 'Reserved', to_date('06-12-2008', 'dd-mm-yyyy'), 'Out of Service');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (44023, 'Out of Service', to_date('11-01-2021', 'dd-mm-yyyy'), 'Under Maintenance');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (35717, 'Out of Service', to_date('17-11-2016', 'dd-mm-yyyy'), 'In Repair');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (30813, 'Reserved', to_date('25-02-2011', 'dd-mm-yyyy'), 'Under Maintenance');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (27291, 'In Repair', to_date('13-06-2023', 'dd-mm-yyyy'), 'Out of Service');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (70761, 'Available', to_date('01-02-2018', 'dd-mm-yyyy'), 'Under Maintenance');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (22285, 'Under Maintenance', to_date('12-01-2008', 'dd-mm-yyyy'), 'In Repair');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (18469, 'Discarded', to_date('18-06-2016', 'dd-mm-yyyy'), 'Available');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (9797, 'Out of Service', to_date('03-10-2003', 'dd-mm-yyyy'), 'Under Maintenance');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (88109, 'In Use', to_date('11-05-2017', 'dd-mm-yyyy'), 'Under Maintenance');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (39186, 'Available', to_date('21-04-2012', 'dd-mm-yyyy'), 'Reserved');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (81364, 'Reserved', to_date('23-11-2019', 'dd-mm-yyyy'), 'Reserved');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (76126, 'Reserved', to_date('02-04-2004', 'dd-mm-yyyy'), 'In Use');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (21601, 'In Use', to_date('21-04-2000', 'dd-mm-yyyy'), 'In Repair');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (64910, 'Under Maintenance', to_date('20-11-2004', 'dd-mm-yyyy'), 'In Use');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (94302, 'In Repair', to_date('08-07-2010', 'dd-mm-yyyy'), 'Under Maintenance');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (97005, 'Out of Service', to_date('18-07-2001', 'dd-mm-yyyy'), 'Available');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (93745, 'Available', to_date('25-03-2002', 'dd-mm-yyyy'), 'In Use');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (85857, 'Reserved', to_date('05-06-2008', 'dd-mm-yyyy'), 'Out of Service');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (75934, 'In Repair', to_date('26-06-2000', 'dd-mm-yyyy'), 'In Repair');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (47946, 'Reserved', to_date('12-12-2000', 'dd-mm-yyyy'), 'Available');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (17774, 'Out of Service', to_date('05-10-2002', 'dd-mm-yyyy'), 'Out of Service');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (90087, 'In Repair', to_date('16-07-2007', 'dd-mm-yyyy'), 'Out of Service');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (82507, 'Out of Service', to_date('16-07-2011', 'dd-mm-yyyy'), 'In Repair');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (2994, 'Available', to_date('28-12-2022', 'dd-mm-yyyy'), 'Reserved');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (91389, 'Out of Service', to_date('17-05-2008', 'dd-mm-yyyy'), 'In Repair');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (61071, 'In Repair', to_date('15-04-2007', 'dd-mm-yyyy'), 'In Repair');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (1620, 'Discarded', to_date('03-07-2013', 'dd-mm-yyyy'), 'Discarded');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (28480, 'Under Maintenance', to_date('30-11-2017', 'dd-mm-yyyy'), 'In Use');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (90519, 'Reserved', to_date('18-11-2014', 'dd-mm-yyyy'), 'Available');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (71437, 'Reserved', to_date('15-09-2019', 'dd-mm-yyyy'), 'In Repair');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (45964, 'In Use', to_date('17-10-2006', 'dd-mm-yyyy'), 'Out of Service');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (76772, 'Out of Service', to_date('01-03-2020', 'dd-mm-yyyy'), 'Under Maintenance');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (63061, 'Out of Service', to_date('02-12-2017', 'dd-mm-yyyy'), 'In Use');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (76728, 'Reserved', to_date('16-04-2002', 'dd-mm-yyyy'), 'Available');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (47081, 'In Use', to_date('28-11-2008', 'dd-mm-yyyy'), 'In Use');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (80021, 'Available', to_date('27-11-2014', 'dd-mm-yyyy'), 'Discarded');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (22636, 'Available', to_date('21-06-2023', 'dd-mm-yyyy'), 'In Repair');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (9143, 'In Repair', to_date('28-06-2012', 'dd-mm-yyyy'), 'Discarded');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (49111, 'Out of Service', to_date('06-12-2016', 'dd-mm-yyyy'), 'Out of Service');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (43914, 'Discarded', to_date('04-07-2020', 'dd-mm-yyyy'), 'Available');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (42340, 'Reserved', to_date('06-05-2010', 'dd-mm-yyyy'), 'Discarded');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (71292, 'Discarded', to_date('24-03-2002', 'dd-mm-yyyy'), 'Available');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (2540, 'Out of Service', to_date('13-01-2018', 'dd-mm-yyyy'), 'Discarded');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (41424, 'Available', to_date('20-01-2003', 'dd-mm-yyyy'), 'Reserved');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (48488, 'In Use', to_date('12-09-2012', 'dd-mm-yyyy'), 'Under Maintenance');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (29949, 'Out of Service', to_date('14-05-2020', 'dd-mm-yyyy'), 'In Repair');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (57952, 'In Use', to_date('22-12-2023', 'dd-mm-yyyy'), 'Discarded');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (6557, 'Under Maintenance', to_date('02-11-2006', 'dd-mm-yyyy'), 'Discarded');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (14371, 'Under Maintenance', to_date('09-07-2010', 'dd-mm-yyyy'), 'In Use');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (9792, 'Available', to_date('03-04-2007', 'dd-mm-yyyy'), 'In Repair');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (59781, 'Discarded', to_date('04-08-2009', 'dd-mm-yyyy'), 'Out of Service');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (28106, 'In Repair', to_date('10-11-2020', 'dd-mm-yyyy'), 'Under Maintenance');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (54000, 'Available', to_date('15-02-2012', 'dd-mm-yyyy'), 'Discarded');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (87163, 'In Repair', to_date('07-03-2021', 'dd-mm-yyyy'), 'Available');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (40055, 'Under Maintenance', to_date('25-04-2019', 'dd-mm-yyyy'), 'Discarded');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (43399, 'In Use', to_date('06-05-2013', 'dd-mm-yyyy'), 'Under Maintenance');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (15861, 'In Repair', to_date('04-09-2016', 'dd-mm-yyyy'), 'Reserved');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (83815, 'Discarded', to_date('28-11-2008', 'dd-mm-yyyy'), 'In Use');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (12152, 'In Repair', to_date('28-08-2009', 'dd-mm-yyyy'), 'Reserved');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (32048, 'Available', to_date('18-03-2014', 'dd-mm-yyyy'), 'Under Maintenance');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (76660, 'Reserved', to_date('02-09-2000', 'dd-mm-yyyy'), 'Available');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (60659, 'Available', to_date('28-02-2008', 'dd-mm-yyyy'), 'Discarded');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (64546, 'Discarded', to_date('21-09-2003', 'dd-mm-yyyy'), 'Available');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (9701, 'In Use', to_date('06-08-2005', 'dd-mm-yyyy'), 'In Use');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (35078, 'Under Maintenance', to_date('09-06-2000', 'dd-mm-yyyy'), 'Reserved');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (11515, 'Available', to_date('09-02-2014', 'dd-mm-yyyy'), 'In Use');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (54561, 'Available', to_date('09-09-2005', 'dd-mm-yyyy'), 'Available');
commit;
prompt 100 records committed...
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (21791, 'Reserved', to_date('09-05-2004', 'dd-mm-yyyy'), 'Out of Service');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (5518, 'Under Maintenance', to_date('23-08-2002', 'dd-mm-yyyy'), 'Under Maintenance');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (56866, 'Under Maintenance', to_date('24-11-2013', 'dd-mm-yyyy'), 'Out of Service');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (2118, 'In Repair', to_date('05-05-2011', 'dd-mm-yyyy'), 'In Repair');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (37286, 'Available', to_date('15-07-2000', 'dd-mm-yyyy'), 'Discarded');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (11855, 'Out of Service', to_date('16-10-2002', 'dd-mm-yyyy'), 'In Repair');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (37605, 'In Repair', to_date('17-02-2021', 'dd-mm-yyyy'), 'In Use');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (83482, 'Under Maintenance', to_date('12-07-2018', 'dd-mm-yyyy'), 'Available');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (42441, 'In Use', to_date('03-12-2015', 'dd-mm-yyyy'), 'Under Maintenance');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (81187, 'Reserved', to_date('19-09-2015', 'dd-mm-yyyy'), 'Discarded');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (8783, 'In Use', to_date('16-05-2014', 'dd-mm-yyyy'), 'In Use');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (25022, 'Under Maintenance', to_date('12-09-2013', 'dd-mm-yyyy'), 'Available');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (34543, 'Under Maintenance', to_date('26-06-2018', 'dd-mm-yyyy'), 'In Use');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (37585, 'In Use', to_date('04-02-2014', 'dd-mm-yyyy'), 'Out of Service');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (33362, 'In Repair', to_date('23-08-2019', 'dd-mm-yyyy'), 'Discarded');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (96949, 'Reserved', to_date('18-05-2006', 'dd-mm-yyyy'), 'Out of Service');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (15665, 'Discarded', to_date('02-12-2004', 'dd-mm-yyyy'), 'In Use');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (95842, 'Under Maintenance', to_date('09-12-2010', 'dd-mm-yyyy'), 'In Repair');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (75965, 'Under Maintenance', to_date('04-12-2000', 'dd-mm-yyyy'), 'In Repair');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (7076, 'In Repair', to_date('07-09-2015', 'dd-mm-yyyy'), 'In Repair');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (86417, 'Discarded', to_date('17-02-2011', 'dd-mm-yyyy'), 'In Use');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (55225, 'Discarded', to_date('04-02-2022', 'dd-mm-yyyy'), 'Available');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (96625, 'Out of Service', to_date('04-09-2014', 'dd-mm-yyyy'), 'Out of Service');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (94559, 'Discarded', to_date('26-10-2008', 'dd-mm-yyyy'), 'Reserved');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (39694, 'Out of Service', to_date('23-09-2002', 'dd-mm-yyyy'), 'Reserved');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (93222, 'Discarded', to_date('28-09-2004', 'dd-mm-yyyy'), 'Discarded');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (44535, 'Out of Service', to_date('16-04-2004', 'dd-mm-yyyy'), 'Discarded');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (23658, 'Under Maintenance', to_date('27-07-2007', 'dd-mm-yyyy'), 'Under Maintenance');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (54423, 'Out of Service', to_date('16-07-2005', 'dd-mm-yyyy'), 'Available');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (59294, 'Available', to_date('26-11-2011', 'dd-mm-yyyy'), 'In Use');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (51797, 'Discarded', to_date('23-08-2002', 'dd-mm-yyyy'), 'In Repair');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (77473, 'Available', to_date('23-10-2002', 'dd-mm-yyyy'), 'Under Maintenance');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (89318, 'Out of Service', to_date('06-02-2020', 'dd-mm-yyyy'), 'Reserved');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (68626, 'Discarded', to_date('04-12-2010', 'dd-mm-yyyy'), 'In Use');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (27175, 'Available', to_date('24-07-2022', 'dd-mm-yyyy'), 'In Repair');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (51708, 'Under Maintenance', to_date('01-01-2013', 'dd-mm-yyyy'), 'Available');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (76631, 'Discarded', to_date('27-02-2008', 'dd-mm-yyyy'), 'In Repair');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (95873, 'Reserved', to_date('02-01-2014', 'dd-mm-yyyy'), 'In Use');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (49841, 'Available', to_date('02-05-2019', 'dd-mm-yyyy'), 'Reserved');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (48411, 'In Repair', to_date('08-09-2022', 'dd-mm-yyyy'), 'Under Maintenance');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (15896, 'Out of Service', to_date('03-03-2023', 'dd-mm-yyyy'), 'Available');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (68917, 'Out of Service', to_date('31-08-2016', 'dd-mm-yyyy'), 'Available');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (63130, 'Reserved', to_date('17-03-2021', 'dd-mm-yyyy'), 'Reserved');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (69730, 'Available', to_date('31-12-2016', 'dd-mm-yyyy'), 'Discarded');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (67681, 'In Repair', to_date('19-10-2004', 'dd-mm-yyyy'), 'Available');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (62608, 'Discarded', to_date('09-04-2008', 'dd-mm-yyyy'), 'Reserved');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (68285, 'Under Maintenance', to_date('26-11-2019', 'dd-mm-yyyy'), 'Available');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (11659, 'Under Maintenance', to_date('27-02-2016', 'dd-mm-yyyy'), 'Under Maintenance');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (47342, 'Out of Service', to_date('08-06-2005', 'dd-mm-yyyy'), 'Discarded');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (92520, 'Out of Service', to_date('08-07-2006', 'dd-mm-yyyy'), 'Under Maintenance');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (18210, 'Discarded', to_date('01-02-2005', 'dd-mm-yyyy'), 'Under Maintenance');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (57790, 'Under Maintenance', to_date('17-12-2013', 'dd-mm-yyyy'), 'In Repair');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (18769, 'Out of Service', to_date('29-08-2008', 'dd-mm-yyyy'), 'Available');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (8703, 'In Repair', to_date('09-12-2019', 'dd-mm-yyyy'), 'In Repair');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (11219, 'In Repair', to_date('22-11-2022', 'dd-mm-yyyy'), 'Reserved');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (73063, 'Under Maintenance', to_date('20-04-2012', 'dd-mm-yyyy'), 'Under Maintenance');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (88137, 'In Repair', to_date('12-10-2011', 'dd-mm-yyyy'), 'Out of Service');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (89424, 'Reserved', to_date('27-05-2010', 'dd-mm-yyyy'), 'In Repair');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (84784, 'Discarded', to_date('01-06-2018', 'dd-mm-yyyy'), 'Available');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (97516, 'Discarded', to_date('27-08-2007', 'dd-mm-yyyy'), 'In Repair');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (97656, 'Under Maintenance', to_date('21-04-2012', 'dd-mm-yyyy'), 'Under Maintenance');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (34928, 'Out of Service', to_date('14-08-2023', 'dd-mm-yyyy'), 'Under Maintenance');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (9293, 'Discarded', to_date('18-03-2014', 'dd-mm-yyyy'), 'Out of Service');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (40035, 'In Use', to_date('31-07-2001', 'dd-mm-yyyy'), 'In Use');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (19324, 'Under Maintenance', to_date('17-06-2018', 'dd-mm-yyyy'), 'In Use');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (61179, 'Discarded', to_date('17-08-2007', 'dd-mm-yyyy'), 'In Use');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (81786, 'Discarded', to_date('17-10-2000', 'dd-mm-yyyy'), 'Discarded');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (72100, 'Discarded', to_date('24-03-2011', 'dd-mm-yyyy'), 'Available');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (48669, 'In Use', to_date('05-09-2011', 'dd-mm-yyyy'), 'Reserved');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (93615, 'Discarded', to_date('21-04-2015', 'dd-mm-yyyy'), 'Available');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (19721, 'In Use', to_date('22-02-2019', 'dd-mm-yyyy'), 'Under Maintenance');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (21545, 'In Use', to_date('29-10-2007', 'dd-mm-yyyy'), 'Available');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (98507, 'Out of Service', to_date('07-02-2005', 'dd-mm-yyyy'), 'Reserved');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (60897, 'In Repair', to_date('12-11-2022', 'dd-mm-yyyy'), 'Discarded');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (12627, 'In Use', to_date('19-11-2020', 'dd-mm-yyyy'), 'Under Maintenance');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (30085, 'In Repair', to_date('02-08-2000', 'dd-mm-yyyy'), 'Under Maintenance');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (33510, 'In Use', to_date('17-06-2004', 'dd-mm-yyyy'), 'Discarded');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (26282, 'Out of Service', to_date('09-05-2006', 'dd-mm-yyyy'), 'Available');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (28128, 'Available', to_date('30-03-2016', 'dd-mm-yyyy'), 'Available');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (59855, 'Reserved', to_date('19-09-2002', 'dd-mm-yyyy'), 'In Repair');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (93253, 'In Use', to_date('03-03-2006', 'dd-mm-yyyy'), 'Discarded');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (75618, 'Reserved', to_date('21-12-2019', 'dd-mm-yyyy'), 'In Use');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (66416, 'Discarded', to_date('17-06-2003', 'dd-mm-yyyy'), 'Discarded');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (27172, 'In Use', to_date('01-04-2022', 'dd-mm-yyyy'), 'In Use');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (75512, 'Under Maintenance', to_date('09-07-2005', 'dd-mm-yyyy'), 'In Repair');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (39314, 'Available', to_date('16-11-2007', 'dd-mm-yyyy'), 'Available');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (71881, 'Under Maintenance', to_date('02-06-2021', 'dd-mm-yyyy'), 'In Use');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (14097, 'In Use', to_date('05-09-2021', 'dd-mm-yyyy'), 'Reserved');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (14486, 'Reserved', to_date('19-12-2000', 'dd-mm-yyyy'), 'Discarded');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (43127, 'Discarded', to_date('03-11-2012', 'dd-mm-yyyy'), 'Out of Service');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (60342, 'Out of Service', to_date('15-04-2017', 'dd-mm-yyyy'), 'Reserved');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (26123, 'Reserved', to_date('17-03-2018', 'dd-mm-yyyy'), 'Under Maintenance');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (61198, 'In Use', to_date('26-11-2006', 'dd-mm-yyyy'), 'Discarded');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (95719, 'In Use', to_date('13-02-2023', 'dd-mm-yyyy'), 'In Repair');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (66465, 'Under Maintenance', to_date('24-04-2003', 'dd-mm-yyyy'), 'Reserved');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (48525, 'Discarded', to_date('30-09-2003', 'dd-mm-yyyy'), 'Available');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (32396, 'In Use', to_date('22-01-2000', 'dd-mm-yyyy'), 'Reserved');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (82420, 'Reserved', to_date('28-11-2006', 'dd-mm-yyyy'), 'Discarded');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (37514, 'Under Maintenance', to_date('29-04-2019', 'dd-mm-yyyy'), 'Out of Service');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (40117, 'Out of Service', to_date('31-05-2003', 'dd-mm-yyyy'), 'Under Maintenance');
commit;
prompt 200 records committed...
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (4298, 'Under Maintenance', to_date('31-12-2001', 'dd-mm-yyyy'), 'Available');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (58963, 'In Repair', to_date('16-11-2018', 'dd-mm-yyyy'), 'In Use');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (27102, 'Available', to_date('02-04-2023', 'dd-mm-yyyy'), 'Under Maintenance');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (26995, 'In Use', to_date('17-01-2014', 'dd-mm-yyyy'), 'Reserved');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (6345, 'In Repair', to_date('15-08-2017', 'dd-mm-yyyy'), 'In Use');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (45244, 'In Repair', to_date('23-08-2018', 'dd-mm-yyyy'), 'Available');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (88935, 'Out of Service', to_date('05-08-2021', 'dd-mm-yyyy'), 'Discarded');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (96291, 'In Repair', to_date('07-09-2014', 'dd-mm-yyyy'), 'Reserved');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (14953, 'Discarded', to_date('01-09-2021', 'dd-mm-yyyy'), 'Reserved');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (19071, 'Reserved', to_date('20-04-2001', 'dd-mm-yyyy'), 'Available');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (70574, 'In Repair', to_date('13-12-2007', 'dd-mm-yyyy'), 'Reserved');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (89923, 'Reserved', to_date('30-01-2001', 'dd-mm-yyyy'), 'Out of Service');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (47259, 'Under Maintenance', to_date('18-03-2017', 'dd-mm-yyyy'), 'Reserved');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (9908, 'Reserved', to_date('23-11-2007', 'dd-mm-yyyy'), 'Reserved');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (7173, 'In Repair', to_date('28-06-2021', 'dd-mm-yyyy'), 'In Repair');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (98344, 'In Use', to_date('17-03-2020', 'dd-mm-yyyy'), 'In Use');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (54711, 'Under Maintenance', to_date('13-03-2003', 'dd-mm-yyyy'), 'Out of Service');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (66295, 'Under Maintenance', to_date('13-03-2023', 'dd-mm-yyyy'), 'In Repair');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (92690, 'Under Maintenance', to_date('04-02-2006', 'dd-mm-yyyy'), 'Discarded');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (88657, 'Discarded', to_date('10-05-2012', 'dd-mm-yyyy'), 'Out of Service');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (8337, 'In Use', to_date('10-12-2001', 'dd-mm-yyyy'), 'Discarded');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (89521, 'In Use', to_date('10-02-2005', 'dd-mm-yyyy'), 'Out of Service');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (8767, 'Reserved', to_date('02-09-2005', 'dd-mm-yyyy'), 'Available');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (52764, 'Under Maintenance', to_date('07-09-2015', 'dd-mm-yyyy'), 'Discarded');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (52098, 'Available', to_date('30-06-2014', 'dd-mm-yyyy'), 'Out of Service');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (89389, 'Reserved', to_date('16-08-2006', 'dd-mm-yyyy'), 'In Repair');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (66920, 'Reserved', to_date('24-06-2004', 'dd-mm-yyyy'), 'In Repair');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (44663, 'Under Maintenance', to_date('24-07-2001', 'dd-mm-yyyy'), 'Available');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (84660, 'Reserved', to_date('20-09-2007', 'dd-mm-yyyy'), 'Discarded');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (62686, 'Out of Service', to_date('20-02-2008', 'dd-mm-yyyy'), 'Out of Service');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (33137, 'Under Maintenance', to_date('29-08-2001', 'dd-mm-yyyy'), 'Reserved');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (58073, 'Reserved', to_date('25-01-2016', 'dd-mm-yyyy'), 'Discarded');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (36368, 'In Repair', to_date('09-12-2003', 'dd-mm-yyyy'), 'Available');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (93882, 'Discarded', to_date('25-09-2008', 'dd-mm-yyyy'), 'Available');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (20622, 'Out of Service', to_date('13-09-2012', 'dd-mm-yyyy'), 'In Repair');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (65795, 'Out of Service', to_date('03-04-2012', 'dd-mm-yyyy'), 'Under Maintenance');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (26726, 'Under Maintenance', to_date('08-06-2008', 'dd-mm-yyyy'), 'Available');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (92546, 'In Repair', to_date('27-01-2014', 'dd-mm-yyyy'), 'Out of Service');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (28618, 'In Repair', to_date('20-04-2017', 'dd-mm-yyyy'), 'Reserved');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (12604, 'Available', to_date('07-01-2015', 'dd-mm-yyyy'), 'Available');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (58151, 'Discarded', to_date('14-12-2019', 'dd-mm-yyyy'), 'Available');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (87095, 'Discarded', to_date('26-11-2022', 'dd-mm-yyyy'), 'Discarded');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (36151, 'Discarded', to_date('14-11-2017', 'dd-mm-yyyy'), 'In Repair');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (8995, 'Reserved', to_date('03-08-2011', 'dd-mm-yyyy'), 'In Use');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (9718, 'Under Maintenance', to_date('10-03-2017', 'dd-mm-yyyy'), 'Discarded');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (18544, 'Discarded', to_date('24-07-2013', 'dd-mm-yyyy'), 'Out of Service');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (95782, 'In Use', to_date('11-01-2002', 'dd-mm-yyyy'), 'In Repair');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (24938, 'Under Maintenance', to_date('10-01-2010', 'dd-mm-yyyy'), 'Available');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (30912, 'Available', to_date('26-04-2017', 'dd-mm-yyyy'), 'In Use');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (34253, 'Out of Service', to_date('20-06-2002', 'dd-mm-yyyy'), 'Available');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (27362, 'In Use', to_date('11-02-2001', 'dd-mm-yyyy'), 'Out of Service');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (83624, 'Under Maintenance', to_date('25-09-2001', 'dd-mm-yyyy'), 'Under Maintenance');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (35381, 'Reserved', to_date('16-06-2014', 'dd-mm-yyyy'), 'Out of Service');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (81681, 'In Repair', to_date('16-08-2006', 'dd-mm-yyyy'), 'In Use');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (11769, 'In Repair', to_date('01-09-2004', 'dd-mm-yyyy'), 'Discarded');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (55219, 'Discarded', to_date('14-12-2019', 'dd-mm-yyyy'), 'Out of Service');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (94678, 'Discarded', to_date('13-03-2014', 'dd-mm-yyyy'), 'Reserved');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (2137, 'In Use', to_date('16-02-2006', 'dd-mm-yyyy'), 'Discarded');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (84672, 'Out of Service', to_date('11-12-2018', 'dd-mm-yyyy'), 'In Repair');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (50610, 'Discarded', to_date('01-04-2006', 'dd-mm-yyyy'), 'In Repair');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (32023, 'Discarded', to_date('01-02-2020', 'dd-mm-yyyy'), 'Under Maintenance');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (24524, 'Under Maintenance', to_date('28-08-2002', 'dd-mm-yyyy'), 'Out of Service');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (30274, 'Reserved', to_date('28-05-2005', 'dd-mm-yyyy'), 'Reserved');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (33255, 'Available', to_date('31-10-2007', 'dd-mm-yyyy'), 'Under Maintenance');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (87822, 'Out of Service', to_date('24-02-2004', 'dd-mm-yyyy'), 'In Repair');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (72239, 'Under Maintenance', to_date('17-07-2012', 'dd-mm-yyyy'), 'Discarded');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (34808, 'Discarded', to_date('25-03-2020', 'dd-mm-yyyy'), 'Under Maintenance');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (61754, 'Available', to_date('23-09-2020', 'dd-mm-yyyy'), 'In Repair');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (11540, 'In Use', to_date('29-11-2012', 'dd-mm-yyyy'), 'Reserved');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (10122, 'In Repair', to_date('19-07-2005', 'dd-mm-yyyy'), 'Discarded');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (61927, 'In Repair', to_date('06-03-2020', 'dd-mm-yyyy'), 'In Repair');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (87498, 'Reserved', to_date('20-12-2013', 'dd-mm-yyyy'), 'In Repair');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (23731, 'Available', to_date('17-02-2010', 'dd-mm-yyyy'), 'In Repair');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (47642, 'Out of Service', to_date('25-07-2009', 'dd-mm-yyyy'), 'Discarded');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (9622, 'Discarded', to_date('30-04-2007', 'dd-mm-yyyy'), 'Out of Service');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (87087, 'Reserved', to_date('01-08-2011', 'dd-mm-yyyy'), 'In Use');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (94484, 'In Use', to_date('08-08-2016', 'dd-mm-yyyy'), 'Out of Service');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (10581, 'In Repair', to_date('11-07-2007', 'dd-mm-yyyy'), 'Available');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (8971, 'Out of Service', to_date('25-05-2008', 'dd-mm-yyyy'), 'In Use');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (2755, 'Out of Service', to_date('24-03-2023', 'dd-mm-yyyy'), 'Discarded');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (39304, 'Out of Service', to_date('02-08-2013', 'dd-mm-yyyy'), 'Reserved');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (6064, 'Out of Service', to_date('10-06-2014', 'dd-mm-yyyy'), 'In Use');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (33336, 'Under Maintenance', to_date('23-10-2015', 'dd-mm-yyyy'), 'Reserved');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (4959, 'Available', to_date('25-11-2011', 'dd-mm-yyyy'), 'Reserved');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (12850, 'Available', to_date('20-04-2001', 'dd-mm-yyyy'), 'In Use');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (16319, 'Out of Service', to_date('30-11-2015', 'dd-mm-yyyy'), 'Out of Service');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (92115, 'Discarded', to_date('16-03-2022', 'dd-mm-yyyy'), 'In Use');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (86129, 'Under Maintenance', to_date('06-06-2000', 'dd-mm-yyyy'), 'Discarded');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (2694, 'Reserved', to_date('04-06-2009', 'dd-mm-yyyy'), 'Discarded');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (92416, 'Available', to_date('18-08-2002', 'dd-mm-yyyy'), 'Discarded');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (24492, 'Reserved', to_date('06-12-2006', 'dd-mm-yyyy'), 'Out of Service');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (54419, 'Available', to_date('26-12-2009', 'dd-mm-yyyy'), 'Reserved');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (23068, 'Out of Service', to_date('08-08-2011', 'dd-mm-yyyy'), 'Reserved');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (48027, 'In Use', to_date('10-11-2004', 'dd-mm-yyyy'), 'Discarded');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (93184, 'Available', to_date('19-07-2018', 'dd-mm-yyyy'), 'In Use');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (27454, 'Available', to_date('27-07-2022', 'dd-mm-yyyy'), 'Available');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (8615, 'Discarded', to_date('08-12-2007', 'dd-mm-yyyy'), 'Discarded');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (53170, 'In Repair', to_date('18-12-2006', 'dd-mm-yyyy'), 'Reserved');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (78195, 'Reserved', to_date('27-04-2017', 'dd-mm-yyyy'), 'In Repair');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (26082, 'Out of Service', to_date('08-07-2015', 'dd-mm-yyyy'), 'Available');
commit;
prompt 300 records committed...
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (8136, 'Out of Service', to_date('26-06-2011', 'dd-mm-yyyy'), 'Out of Service');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (27960, 'Reserved', to_date('19-11-2005', 'dd-mm-yyyy'), 'Available');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (70564, 'Available', to_date('26-09-2005', 'dd-mm-yyyy'), 'Out of Service');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (68123, 'Discarded', to_date('02-01-2020', 'dd-mm-yyyy'), 'Available');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (78342, 'Under Maintenance', to_date('10-10-2010', 'dd-mm-yyyy'), 'Reserved');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (36361, 'Reserved', to_date('26-08-2021', 'dd-mm-yyyy'), 'In Use');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (66114, 'Reserved', to_date('26-12-2014', 'dd-mm-yyyy'), 'In Use');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (62121, 'Reserved', to_date('17-07-2011', 'dd-mm-yyyy'), 'Discarded');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (77609, 'In Use', to_date('16-04-2004', 'dd-mm-yyyy'), 'Under Maintenance');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (79933, 'Reserved', to_date('19-11-2011', 'dd-mm-yyyy'), 'Discarded');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (59204, 'Available', to_date('21-06-2019', 'dd-mm-yyyy'), 'Available');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (1092, 'Out of Service', to_date('23-06-2016', 'dd-mm-yyyy'), 'Available');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (59718, 'Under Maintenance', to_date('24-12-2010', 'dd-mm-yyyy'), 'In Repair');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (91585, 'Available', to_date('12-04-2002', 'dd-mm-yyyy'), 'Available');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (36478, 'Available', to_date('21-04-2019', 'dd-mm-yyyy'), 'Out of Service');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (56275, 'In Repair', to_date('28-06-2002', 'dd-mm-yyyy'), 'Available');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (67612, 'Discarded', to_date('30-09-2008', 'dd-mm-yyyy'), 'Under Maintenance');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (29324, 'Out of Service', to_date('15-02-2001', 'dd-mm-yyyy'), 'Discarded');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (70614, 'Discarded', to_date('23-10-2002', 'dd-mm-yyyy'), 'Out of Service');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (70880, 'Out of Service', to_date('06-02-2009', 'dd-mm-yyyy'), 'Discarded');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (27143, 'In Repair', to_date('18-12-2016', 'dd-mm-yyyy'), 'Available');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (70003, 'Under Maintenance', to_date('19-10-2009', 'dd-mm-yyyy'), 'Out of Service');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (14078, 'Available', to_date('10-01-2005', 'dd-mm-yyyy'), 'Out of Service');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (53843, 'Discarded', to_date('01-03-2014', 'dd-mm-yyyy'), 'Under Maintenance');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (40825, 'In Use', to_date('16-12-2010', 'dd-mm-yyyy'), 'Out of Service');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (3075, 'Available', to_date('05-04-2009', 'dd-mm-yyyy'), 'Under Maintenance');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (92868, 'In Repair', to_date('15-03-2022', 'dd-mm-yyyy'), 'Discarded');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (73570, 'Out of Service', to_date('13-05-2016', 'dd-mm-yyyy'), 'Under Maintenance');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (81581, 'In Repair', to_date('07-07-2004', 'dd-mm-yyyy'), 'In Repair');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (24337, 'Reserved', to_date('20-07-2018', 'dd-mm-yyyy'), 'Reserved');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (272, 'Discarded', to_date('17-04-2022', 'dd-mm-yyyy'), 'Out of Service');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (51690, 'Reserved', to_date('26-09-2021', 'dd-mm-yyyy'), 'Reserved');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (86494, 'In Repair', to_date('22-05-2012', 'dd-mm-yyyy'), 'Reserved');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (29687, 'Out of Service', to_date('20-04-2009', 'dd-mm-yyyy'), 'Discarded');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (90604, 'Reserved', to_date('19-06-2003', 'dd-mm-yyyy'), 'Under Maintenance');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (56805, 'Discarded', to_date('19-02-2006', 'dd-mm-yyyy'), 'Available');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (50559, 'Reserved', to_date('15-10-2012', 'dd-mm-yyyy'), 'Reserved');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (8871, 'Discarded', to_date('26-03-2012', 'dd-mm-yyyy'), 'Available');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (72974, 'Out of Service', to_date('06-08-2004', 'dd-mm-yyyy'), 'Out of Service');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (98239, 'Out of Service', to_date('06-10-2021', 'dd-mm-yyyy'), 'Under Maintenance');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (20429, 'In Repair', to_date('22-11-2005', 'dd-mm-yyyy'), 'Discarded');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (39229, 'In Use', to_date('26-08-2007', 'dd-mm-yyyy'), 'Under Maintenance');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (5020, 'In Repair', to_date('14-10-2019', 'dd-mm-yyyy'), 'Available');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (19792, 'Out of Service', to_date('27-08-2015', 'dd-mm-yyyy'), 'Discarded');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (88166, 'In Use', to_date('29-04-2000', 'dd-mm-yyyy'), 'Available');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (79451, 'Reserved', to_date('09-12-2007', 'dd-mm-yyyy'), 'Available');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (86666, 'Discarded', to_date('29-10-2008', 'dd-mm-yyyy'), 'Reserved');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (93480, 'Under Maintenance', to_date('03-03-2008', 'dd-mm-yyyy'), 'Out of Service');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (84997, 'In Use', to_date('10-09-2023', 'dd-mm-yyyy'), 'In Use');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (63327, 'Discarded', to_date('28-01-2020', 'dd-mm-yyyy'), 'Reserved');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (53875, 'Out of Service', to_date('27-09-2003', 'dd-mm-yyyy'), 'In Repair');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (13299, 'Available', to_date('12-07-2007', 'dd-mm-yyyy'), 'In Use');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (75056, 'In Use', to_date('13-01-2013', 'dd-mm-yyyy'), 'Discarded');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (93490, 'Out of Service', to_date('14-02-2008', 'dd-mm-yyyy'), 'In Use');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (72391, 'Out of Service', to_date('28-03-2023', 'dd-mm-yyyy'), 'Under Maintenance');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (88962, 'Discarded', to_date('04-04-2020', 'dd-mm-yyyy'), 'Discarded');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (49135, 'Discarded', to_date('20-05-2017', 'dd-mm-yyyy'), 'Reserved');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (35174, 'In Repair', to_date('21-09-2023', 'dd-mm-yyyy'), 'Out of Service');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (31496, 'Under Maintenance', to_date('05-04-2011', 'dd-mm-yyyy'), 'Reserved');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (39659, 'Reserved', to_date('30-09-2013', 'dd-mm-yyyy'), 'In Repair');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (18441, 'Out of Service', to_date('16-03-2016', 'dd-mm-yyyy'), 'Discarded');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (9958, 'Under Maintenance', to_date('11-08-2000', 'dd-mm-yyyy'), 'Discarded');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (37754, 'Available', to_date('14-06-2015', 'dd-mm-yyyy'), 'Out of Service');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (87798, 'In Repair', to_date('15-09-2022', 'dd-mm-yyyy'), 'Reserved');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (15155, 'Reserved', to_date('13-01-2013', 'dd-mm-yyyy'), 'Out of Service');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (16040, 'In Repair', to_date('17-02-2020', 'dd-mm-yyyy'), 'Out of Service');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (59095, 'Out of Service', to_date('22-12-2005', 'dd-mm-yyyy'), 'In Repair');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (75062, 'Reserved', to_date('27-03-2011', 'dd-mm-yyyy'), 'In Repair');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (22438, 'Discarded', to_date('21-01-2022', 'dd-mm-yyyy'), 'Available');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (54515, 'Reserved', to_date('18-04-2021', 'dd-mm-yyyy'), 'Reserved');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (91201, 'Available', to_date('06-06-2020', 'dd-mm-yyyy'), 'In Use');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (81559, 'Reserved', to_date('24-10-2011', 'dd-mm-yyyy'), 'Out of Service');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (68013, 'Out of Service', to_date('22-11-2002', 'dd-mm-yyyy'), 'Out of Service');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (88146, 'Discarded', to_date('09-01-2012', 'dd-mm-yyyy'), 'Out of Service');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (75039, 'Available', to_date('18-06-2007', 'dd-mm-yyyy'), 'Reserved');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (42074, 'Available', to_date('29-03-2017', 'dd-mm-yyyy'), 'In Repair');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (63160, 'Out of Service', to_date('18-06-2019', 'dd-mm-yyyy'), 'Discarded');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (84290, 'Discarded', to_date('10-09-2020', 'dd-mm-yyyy'), 'Out of Service');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (27404, 'In Repair', to_date('03-02-2016', 'dd-mm-yyyy'), 'Discarded');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (72449, 'Discarded', to_date('30-10-2010', 'dd-mm-yyyy'), 'Available');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (28627, 'Discarded', to_date('06-07-2000', 'dd-mm-yyyy'), 'Available');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (30715, 'In Use', to_date('28-02-2006', 'dd-mm-yyyy'), 'Available');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (21439, 'Out of Service', to_date('03-06-2001', 'dd-mm-yyyy'), 'Available');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (5814, 'Reserved', to_date('06-08-2007', 'dd-mm-yyyy'), 'Out of Service');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (88387, 'In Use', to_date('19-02-2014', 'dd-mm-yyyy'), 'Reserved');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (29345, 'In Repair', to_date('30-03-2012', 'dd-mm-yyyy'), 'In Use');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (80385, 'Reserved', to_date('26-02-2003', 'dd-mm-yyyy'), 'Available');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (86330, 'In Use', to_date('09-10-2016', 'dd-mm-yyyy'), 'Available');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (63389, 'Discarded', to_date('04-04-2014', 'dd-mm-yyyy'), 'Reserved');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (90019, 'Out of Service', to_date('19-03-2010', 'dd-mm-yyyy'), 'Out of Service');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (71330, 'Discarded', to_date('25-01-2012', 'dd-mm-yyyy'), 'Reserved');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (62947, 'In Use', to_date('20-04-2004', 'dd-mm-yyyy'), 'Under Maintenance');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (65297, 'In Use', to_date('19-02-2019', 'dd-mm-yyyy'), 'In Repair');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (24236, 'Reserved', to_date('20-04-2005', 'dd-mm-yyyy'), 'Discarded');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (98961, 'Under Maintenance', to_date('10-07-2004', 'dd-mm-yyyy'), 'In Repair');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (83150, 'Available', to_date('03-05-2023', 'dd-mm-yyyy'), 'Discarded');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (90255, 'Under Maintenance', to_date('13-11-2001', 'dd-mm-yyyy'), 'Discarded');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (38902, 'In Repair', to_date('17-03-2023', 'dd-mm-yyyy'), 'Available');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (99310, 'Out of Service', to_date('22-12-2000', 'dd-mm-yyyy'), 'Reserved');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (86706, 'Reserved', to_date('26-09-2008', 'dd-mm-yyyy'), 'Reserved');
commit;
prompt 400 records loaded
prompt Loading ORDER_TOOL...
insert into ORDER_TOOL (order_id, tool_id)
values (13868615, 61071);
insert into ORDER_TOOL (order_id, tool_id)
values (99283105, 26882);
insert into ORDER_TOOL (order_id, tool_id)
values (87988358, 48525);
insert into ORDER_TOOL (order_id, tool_id)
values (14395239, 9908);
insert into ORDER_TOOL (order_id, tool_id)
values (23211833, 49841);
insert into ORDER_TOOL (order_id, tool_id)
values (65592894, 55225);
insert into ORDER_TOOL (order_id, tool_id)
values (79125714, 51307);
insert into ORDER_TOOL (order_id, tool_id)
values (75626743, 9143);
insert into ORDER_TOOL (order_id, tool_id)
values (41423687, 89389);
insert into ORDER_TOOL (order_id, tool_id)
values (15864881, 26995);
insert into ORDER_TOOL (order_id, tool_id)
values (72580041, 86129);
insert into ORDER_TOOL (order_id, tool_id)
values (91194300, 272);
insert into ORDER_TOOL (order_id, tool_id)
values (69556806, 66416);
insert into ORDER_TOOL (order_id, tool_id)
values (76125747, 26882);
insert into ORDER_TOOL (order_id, tool_id)
values (86672432, 76126);
insert into ORDER_TOOL (order_id, tool_id)
values (83642274, 37605);
insert into ORDER_TOOL (order_id, tool_id)
values (39008956, 32023);
insert into ORDER_TOOL (order_id, tool_id)
values (45911739, 51708);
insert into ORDER_TOOL (order_id, tool_id)
values (32794409, 66920);
insert into ORDER_TOOL (order_id, tool_id)
values (83642274, 77609);
insert into ORDER_TOOL (order_id, tool_id)
values (45911739, 73063);
insert into ORDER_TOOL (order_id, tool_id)
values (42083601, 83150);
insert into ORDER_TOOL (order_id, tool_id)
values (26764951, 11769);
insert into ORDER_TOOL (order_id, tool_id)
values (92123288, 63160);
insert into ORDER_TOOL (order_id, tool_id)
values (54978245, 14486);
insert into ORDER_TOOL (order_id, tool_id)
values (27340466, 62686);
insert into ORDER_TOOL (order_id, tool_id)
values (54978245, 63160);
insert into ORDER_TOOL (order_id, tool_id)
values (67345461, 92272);
insert into ORDER_TOOL (order_id, tool_id)
values (11738054, 28106);
insert into ORDER_TOOL (order_id, tool_id)
values (28823177, 94484);
insert into ORDER_TOOL (order_id, tool_id)
values (90949868, 82507);
insert into ORDER_TOOL (order_id, tool_id)
values (71600752, 9293);
insert into ORDER_TOOL (order_id, tool_id)
values (32935042, 9797);
insert into ORDER_TOOL (order_id, tool_id)
values (88692266, 55225);
insert into ORDER_TOOL (order_id, tool_id)
values (10847062, 81364);
insert into ORDER_TOOL (order_id, tool_id)
values (71017467, 54561);
insert into ORDER_TOOL (order_id, tool_id)
values (64160828, 71881);
insert into ORDER_TOOL (order_id, tool_id)
values (16089827, 81364);
insert into ORDER_TOOL (order_id, tool_id)
values (59195808, 44663);
insert into ORDER_TOOL (order_id, tool_id)
values (42567869, 6345);
insert into ORDER_TOOL (order_id, tool_id)
values (28823177, 66114);
insert into ORDER_TOOL (order_id, tool_id)
values (96061311, 79451);
insert into ORDER_TOOL (order_id, tool_id)
values (40461955, 72391);
insert into ORDER_TOOL (order_id, tool_id)
values (46222895, 87822);
insert into ORDER_TOOL (order_id, tool_id)
values (86148845, 29345);
insert into ORDER_TOOL (order_id, tool_id)
values (25790111, 59855);
insert into ORDER_TOOL (order_id, tool_id)
values (23169983, 88935);
insert into ORDER_TOOL (order_id, tool_id)
values (14395239, 1092);
insert into ORDER_TOOL (order_id, tool_id)
values (33105564, 70761);
insert into ORDER_TOOL (order_id, tool_id)
values (69556806, 77473);
insert into ORDER_TOOL (order_id, tool_id)
values (49885578, 14371);
insert into ORDER_TOOL (order_id, tool_id)
values (16089827, 76631);
insert into ORDER_TOOL (order_id, tool_id)
values (10511620, 50559);
insert into ORDER_TOOL (order_id, tool_id)
values (46697598, 22285);
insert into ORDER_TOOL (order_id, tool_id)
values (51601257, 2540);
insert into ORDER_TOOL (order_id, tool_id)
values (92123288, 49841);
insert into ORDER_TOOL (order_id, tool_id)
values (46023720, 89521);
insert into ORDER_TOOL (order_id, tool_id)
values (22501391, 93480);
insert into ORDER_TOOL (order_id, tool_id)
values (96798843, 86330);
insert into ORDER_TOOL (order_id, tool_id)
values (46056187, 37754);
commit;
prompt 60 records loaded
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
values (1, 1);
insert into PART_OF (orderid, productid)
values (10498218, 89356370);
insert into PART_OF (orderid, productid)
values (10847062, 17531192);
insert into PART_OF (orderid, productid)
values (11644533, 44769668);
insert into PART_OF (orderid, productid)
values (11644533, 53726451);
insert into PART_OF (orderid, productid)
values (13039382, 47661926);
insert into PART_OF (orderid, productid)
values (13039382, 75342639);
insert into PART_OF (orderid, productid)
values (14395239, 23467437);
insert into PART_OF (orderid, productid)
values (14888608, 84035773);
insert into PART_OF (orderid, productid)
values (15520884, 18002334);
insert into PART_OF (orderid, productid)
values (15520884, 20053802);
insert into PART_OF (orderid, productid)
values (15864881, 34307347);
insert into PART_OF (orderid, productid)
values (15864881, 89914525);
insert into PART_OF (orderid, productid)
values (16089827, 40002629);
insert into PART_OF (orderid, productid)
values (16089827, 47468634);
insert into PART_OF (orderid, productid)
values (16160718, 67964630);
insert into PART_OF (orderid, productid)
values (16782726, 32050706);
insert into PART_OF (orderid, productid)
values (16782726, 77079019);
insert into PART_OF (orderid, productid)
values (17220217, 49381009);
insert into PART_OF (orderid, productid)
values (17247861, 52264429);
insert into PART_OF (orderid, productid)
values (17866964, 38203950);
insert into PART_OF (orderid, productid)
values (17901723, 66202401);
insert into PART_OF (orderid, productid)
values (20549357, 12983031);
insert into PART_OF (orderid, productid)
values (21778797, 77079019);
insert into PART_OF (orderid, productid)
values (22501391, 79157436);
insert into PART_OF (orderid, productid)
values (22501391, 89914525);
insert into PART_OF (orderid, productid)
values (22711863, 84141477);
insert into PART_OF (orderid, productid)
values (23169983, 12663198);
insert into PART_OF (orderid, productid)
values (23169983, 30078490);
insert into PART_OF (orderid, productid)
values (23169983, 60632985);
insert into PART_OF (orderid, productid)
values (24977793, 38217305);
insert into PART_OF (orderid, productid)
values (24977793, 47661926);
insert into PART_OF (orderid, productid)
values (25584000, 30078490);
insert into PART_OF (orderid, productid)
values (25730382, 40286424);
insert into PART_OF (orderid, productid)
values (26554668, 56191191);
insert into PART_OF (orderid, productid)
values (26764951, 44769668);
insert into PART_OF (orderid, productid)
values (27057960, 44714020);
insert into PART_OF (orderid, productid)
values (27202333, 20998110);
insert into PART_OF (orderid, productid)
values (27244804, 77079019);
insert into PART_OF (orderid, productid)
values (27340466, 19707019);
insert into PART_OF (orderid, productid)
values (27340466, 32717559);
insert into PART_OF (orderid, productid)
values (28269220, 62668426);
insert into PART_OF (orderid, productid)
values (28362564, 42490226);
insert into PART_OF (orderid, productid)
values (28362564, 59812221);
insert into PART_OF (orderid, productid)
values (28823177, 13541897);
insert into PART_OF (orderid, productid)
values (30612695, 60809489);
insert into PART_OF (orderid, productid)
values (32084160, 52215121);
insert into PART_OF (orderid, productid)
values (32436619, 79157436);
insert into PART_OF (orderid, productid)
values (32481650, 18144872);
insert into PART_OF (orderid, productid)
values (32481650, 44769668);
insert into PART_OF (orderid, productid)
values (32794409, 25515323);
insert into PART_OF (orderid, productid)
values (32794409, 41256443);
insert into PART_OF (orderid, productid)
values (32794409, 66750680);
insert into PART_OF (orderid, productid)
values (33105564, 20112645);
insert into PART_OF (orderid, productid)
values (33105564, 47301842);
insert into PART_OF (orderid, productid)
values (33105564, 61832164);
insert into PART_OF (orderid, productid)
values (33105564, 86717227);
insert into PART_OF (orderid, productid)
values (33797584, 42979930);
insert into PART_OF (orderid, productid)
values (33797584, 61261918);
insert into PART_OF (orderid, productid)
values (34972793, 77300053);
insert into PART_OF (orderid, productid)
values (35627737, 19559845);
insert into PART_OF (orderid, productid)
values (35782292, 66750680);
insert into PART_OF (orderid, productid)
values (37123734, 59532354);
insert into PART_OF (orderid, productid)
values (37166599, 26690888);
insert into PART_OF (orderid, productid)
values (37166599, 37005131);
insert into PART_OF (orderid, productid)
values (38245386, 75342639);
insert into PART_OF (orderid, productid)
values (38534334, 41950079);
insert into PART_OF (orderid, productid)
values (38534334, 52880276);
insert into PART_OF (orderid, productid)
values (38534334, 84141477);
insert into PART_OF (orderid, productid)
values (39008956, 67964630);
insert into PART_OF (orderid, productid)
values (39283565, 74133872);
insert into PART_OF (orderid, productid)
values (39764009, 26978984);
insert into PART_OF (orderid, productid)
values (40461955, 30224096);
insert into PART_OF (orderid, productid)
values (40461955, 34307347);
insert into PART_OF (orderid, productid)
values (41271233, 85217351);
insert into PART_OF (orderid, productid)
values (41423687, 41950079);
insert into PART_OF (orderid, productid)
values (41812723, 88170142);
insert into PART_OF (orderid, productid)
values (42193615, 12469913);
insert into PART_OF (orderid, productid)
values (43436009, 10215771);
insert into PART_OF (orderid, productid)
values (43436009, 71082803);
insert into PART_OF (orderid, productid)
values (43480666, 23818335);
insert into PART_OF (orderid, productid)
values (43940072, 12214534);
insert into PART_OF (orderid, productid)
values (43940072, 62779835);
insert into PART_OF (orderid, productid)
values (44660055, 63029913);
insert into PART_OF (orderid, productid)
values (44768545, 15622495);
insert into PART_OF (orderid, productid)
values (44901192, 42979930);
insert into PART_OF (orderid, productid)
values (45343624, 38954053);
insert into PART_OF (orderid, productid)
values (45496635, 77300053);
insert into PART_OF (orderid, productid)
values (45496635, 99918838);
insert into PART_OF (orderid, productid)
values (45766106, 25049109);
insert into PART_OF (orderid, productid)
values (46056187, 77300053);
insert into PART_OF (orderid, productid)
values (46222895, 52538318);
insert into PART_OF (orderid, productid)
values (46222895, 99651494);
insert into PART_OF (orderid, productid)
values (46348857, 22303921);
insert into PART_OF (orderid, productid)
values (46348857, 80744202);
insert into PART_OF (orderid, productid)
values (46697598, 34307347);
insert into PART_OF (orderid, productid)
values (46697598, 64458245);
insert into PART_OF (orderid, productid)
values (46697598, 99751170);
insert into PART_OF (orderid, productid)
values (48487980, 18002334);
insert into PART_OF (orderid, productid)
values (48487980, 42979930);
commit;
prompt 100 records committed...
insert into PART_OF (orderid, productid)
values (48528200, 53971468);
insert into PART_OF (orderid, productid)
values (48568747, 32717559);
insert into PART_OF (orderid, productid)
values (48568747, 48984418);
insert into PART_OF (orderid, productid)
values (48805566, 14886998);
insert into PART_OF (orderid, productid)
values (48805566, 75342639);
insert into PART_OF (orderid, productid)
values (49767001, 39077924);
insert into PART_OF (orderid, productid)
values (49767001, 48999849);
insert into PART_OF (orderid, productid)
values (49796873, 24879490);
insert into PART_OF (orderid, productid)
values (49796873, 32717559);
insert into PART_OF (orderid, productid)
values (50162378, 22559530);
insert into PART_OF (orderid, productid)
values (50162378, 89914525);
insert into PART_OF (orderid, productid)
values (50211760, 37005131);
insert into PART_OF (orderid, productid)
values (50211760, 85280659);
insert into PART_OF (orderid, productid)
values (50999597, 84373216);
insert into PART_OF (orderid, productid)
values (51601257, 74200926);
insert into PART_OF (orderid, productid)
values (54978245, 30088684);
insert into PART_OF (orderid, productid)
values (54978245, 54178963);
insert into PART_OF (orderid, productid)
values (54978245, 64072253);
insert into PART_OF (orderid, productid)
values (55156473, 18144872);
insert into PART_OF (orderid, productid)
values (55211525, 30088684);
insert into PART_OF (orderid, productid)
values (56073570, 83730147);
insert into PART_OF (orderid, productid)
values (56073570, 99918838);
insert into PART_OF (orderid, productid)
values (56836563, 99355318);
insert into PART_OF (orderid, productid)
values (58946225, 84373216);
insert into PART_OF (orderid, productid)
values (59195808, 25490673);
insert into PART_OF (orderid, productid)
values (59195808, 26690888);
insert into PART_OF (orderid, productid)
values (59195808, 60632985);
insert into PART_OF (orderid, productid)
values (59195808, 62779835);
insert into PART_OF (orderid, productid)
values (59195808, 89914525);
insert into PART_OF (orderid, productid)
values (59195808, 99355318);
insert into PART_OF (orderid, productid)
values (61625775, 36849239);
insert into PART_OF (orderid, productid)
values (61625775, 56191191);
insert into PART_OF (orderid, productid)
values (62150938, 73840426);
insert into PART_OF (orderid, productid)
values (62150938, 99751170);
insert into PART_OF (orderid, productid)
values (63564977, 70067503);
insert into PART_OF (orderid, productid)
values (64160828, 25049109);
insert into PART_OF (orderid, productid)
values (67345461, 84488662);
insert into PART_OF (orderid, productid)
values (68022210, 20126969);
insert into PART_OF (orderid, productid)
values (68241221, 12469913);
insert into PART_OF (orderid, productid)
values (68241221, 91404530);
insert into PART_OF (orderid, productid)
values (68841810, 99651494);
insert into PART_OF (orderid, productid)
values (69556806, 32050706);
insert into PART_OF (orderid, productid)
values (69556806, 99651494);
insert into PART_OF (orderid, productid)
values (70133273, 12214534);
insert into PART_OF (orderid, productid)
values (70133273, 30224096);
insert into PART_OF (orderid, productid)
values (70133273, 53027287);
insert into PART_OF (orderid, productid)
values (70221490, 19559845);
insert into PART_OF (orderid, productid)
values (70221490, 60809489);
insert into PART_OF (orderid, productid)
values (71017467, 78454014);
insert into PART_OF (orderid, productid)
values (71371841, 77079019);
insert into PART_OF (orderid, productid)
values (71371841, 83026924);
insert into PART_OF (orderid, productid)
values (71508264, 12989406);
insert into PART_OF (orderid, productid)
values (71508264, 98535418);
insert into PART_OF (orderid, productid)
values (71698994, 25049109);
insert into PART_OF (orderid, productid)
values (71698994, 94362422);
insert into PART_OF (orderid, productid)
values (72132403, 24879490);
insert into PART_OF (orderid, productid)
values (73678322, 26696031);
insert into PART_OF (orderid, productid)
values (73678322, 40015420);
insert into PART_OF (orderid, productid)
values (73678322, 74088715);
insert into PART_OF (orderid, productid)
values (75298852, 38217305);
insert into PART_OF (orderid, productid)
values (76158359, 53849368);
insert into PART_OF (orderid, productid)
values (77256073, 88146731);
insert into PART_OF (orderid, productid)
values (78875875, 18144872);
insert into PART_OF (orderid, productid)
values (79640672, 20112645);
insert into PART_OF (orderid, productid)
values (80012686, 40225662);
insert into PART_OF (orderid, productid)
values (81358060, 11447018);
insert into PART_OF (orderid, productid)
values (81358060, 70067503);
insert into PART_OF (orderid, productid)
values (83642274, 12663198);
insert into PART_OF (orderid, productid)
values (83642274, 63029913);
insert into PART_OF (orderid, productid)
values (83642274, 84035773);
insert into PART_OF (orderid, productid)
values (84481920, 30634130);
insert into PART_OF (orderid, productid)
values (86148845, 30078490);
insert into PART_OF (orderid, productid)
values (86457534, 37005131);
insert into PART_OF (orderid, productid)
values (86457534, 39791976);
insert into PART_OF (orderid, productid)
values (86672432, 24879490);
insert into PART_OF (orderid, productid)
values (86672432, 30078490);
insert into PART_OF (orderid, productid)
values (87798520, 48984418);
insert into PART_OF (orderid, productid)
values (87798520, 74133872);
insert into PART_OF (orderid, productid)
values (87798520, 89656829);
insert into PART_OF (orderid, productid)
values (89062047, 74427412);
insert into PART_OF (orderid, productid)
values (89282429, 99751170);
insert into PART_OF (orderid, productid)
values (89793726, 91404530);
insert into PART_OF (orderid, productid)
values (90949868, 42776326);
insert into PART_OF (orderid, productid)
values (90949868, 72052162);
insert into PART_OF (orderid, productid)
values (90949868, 94362422);
insert into PART_OF (orderid, productid)
values (92765749, 56668763);
insert into PART_OF (orderid, productid)
values (93238641, 69789600);
insert into PART_OF (orderid, productid)
values (94869357, 25049109);
insert into PART_OF (orderid, productid)
values (95883854, 42490226);
insert into PART_OF (orderid, productid)
values (95883854, 83026924);
insert into PART_OF (orderid, productid)
values (96098609, 47468634);
insert into PART_OF (orderid, productid)
values (96798843, 84141477);
insert into PART_OF (orderid, productid)
values (98130466, 63029913);
insert into PART_OF (orderid, productid)
values (98130466, 87839213);
insert into PART_OF (orderid, productid)
values (98238957, 38217305);
insert into PART_OF (orderid, productid)
values (98238957, 61832164);
insert into PART_OF (orderid, productid)
values (98703687, 78500077);
insert into PART_OF (orderid, productid)
values (98703687, 80744202);
insert into PART_OF (orderid, productid)
values (99283105, 65366250);
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
prompt Loading PRODUCTION_ORDERS...
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (492514, 92546, 340, to_date('24-11-2009', 'dd-mm-yyyy'), to_date('24-11-2022', 'dd-mm-yyyy'), 'Pending', 76173383);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (78998, 66416, 234, to_date('11-08-2000', 'dd-mm-yyyy'), to_date('25-01-2029', 'dd-mm-yyyy'), 'On Hold', 13830308);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (366443, 89389, 181, to_date('20-08-2008', 'dd-mm-yyyy'), to_date('04-10-2027', 'dd-mm-yyyy'), 'Shipped', 95594631);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (925056, 19324, 243, to_date('10-02-2011', 'dd-mm-yyyy'), to_date('19-02-2022', 'dd-mm-yyyy'), 'Shipped', 88442161);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (201650, 8971, 334, to_date('31-05-2000', 'dd-mm-yyyy'), to_date('23-11-2026', 'dd-mm-yyyy'), 'Pending', 82822656);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (690158, 54000, 187, to_date('06-05-2005', 'dd-mm-yyyy'), to_date('23-10-2023', 'dd-mm-yyyy'), 'Shipped', 76448429);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (341870, 26726, 24, to_date('08-07-2016', 'dd-mm-yyyy'), to_date('13-09-2025', 'dd-mm-yyyy'), 'Completed', 86198357);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (88171, 68285, 324, to_date('20-06-2009', 'dd-mm-yyyy'), to_date('27-08-2023', 'dd-mm-yyyy'), 'Shipped', 55883122);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (109906, 35381, 74, to_date('26-11-2012', 'dd-mm-yyyy'), to_date('14-06-2025', 'dd-mm-yyyy'), 'Completed', 93645798);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (765722, 72449, 483, to_date('29-08-2019', 'dd-mm-yyyy'), to_date('21-04-2024', 'dd-mm-yyyy'), 'Pending', 58391234);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (66764, 90087, 344, to_date('09-04-2008', 'dd-mm-yyyy'), to_date('26-08-2031', 'dd-mm-yyyy'), 'Shipped', 39457119);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (649351, 49111, 160, to_date('18-08-2019', 'dd-mm-yyyy'), to_date('28-10-2024', 'dd-mm-yyyy'), 'Completed', 60976032);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (349933, 59294, 246, to_date('08-07-2002', 'dd-mm-yyyy'), to_date('14-08-2031', 'dd-mm-yyyy'), 'Pending', 38008634);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (887926, 88137, 220, to_date('24-08-2006', 'dd-mm-yyyy'), to_date('26-03-2028', 'dd-mm-yyyy'), 'Shipped', 76448429);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (636344, 27404, 230, to_date('06-07-2010', 'dd-mm-yyyy'), to_date('13-10-2026', 'dd-mm-yyyy'), 'Processing', 81513420);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (655801, 26882, 47, to_date('27-07-2008', 'dd-mm-yyyy'), to_date('15-04-2027', 'dd-mm-yyyy'), 'On Hold', 21006417);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (683526, 23731, 420, to_date('03-08-2003', 'dd-mm-yyyy'), to_date('31-12-2025', 'dd-mm-yyyy'), 'On Hold', 53490786);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (881156, 91201, 313, to_date('27-06-2009', 'dd-mm-yyyy'), to_date('27-05-2031', 'dd-mm-yyyy'), 'On Hold', 91607447);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (624858, 93490, 98, to_date('29-04-2000', 'dd-mm-yyyy'), to_date('22-12-2029', 'dd-mm-yyyy'), 'Completed', 60281327);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (718866, 2994, 158, to_date('22-08-2010', 'dd-mm-yyyy'), to_date('28-01-2021', 'dd-mm-yyyy'), 'On Hold', 50974786);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (305847, 47259, 253, to_date('25-04-2014', 'dd-mm-yyyy'), to_date('14-08-2023', 'dd-mm-yyyy'), 'Shipped', 27921692);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (726756, 76491, 311, to_date('13-03-2014', 'dd-mm-yyyy'), to_date('14-02-2029', 'dd-mm-yyyy'), 'Shipped', 14758552);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (482042, 26282, 233, to_date('21-11-2004', 'dd-mm-yyyy'), to_date('08-12-2027', 'dd-mm-yyyy'), 'Pending', 35665486);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (18624, 98961, 152, to_date('04-08-2008', 'dd-mm-yyyy'), to_date('02-07-2024', 'dd-mm-yyyy'), 'Completed', 42785299);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (400761, 57790, 284, to_date('21-07-2017', 'dd-mm-yyyy'), to_date('30-12-2025', 'dd-mm-yyyy'), 'Processing', 12240369);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (561583, 27362, 55, to_date('24-03-2012', 'dd-mm-yyyy'), to_date('30-11-2023', 'dd-mm-yyyy'), 'Pending', 59504229);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (345748, 1620, 127, to_date('25-10-2000', 'dd-mm-yyyy'), to_date('08-06-2026', 'dd-mm-yyyy'), 'Completed', 61452332);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (28553, 93490, 73, to_date('19-08-2005', 'dd-mm-yyyy'), to_date('17-12-2031', 'dd-mm-yyyy'), 'Completed', 88226991);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (218951, 78195, 476, to_date('25-12-2004', 'dd-mm-yyyy'), to_date('02-11-2031', 'dd-mm-yyyy'), 'Shipped', 77375983);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (220921, 23018, 32, to_date('02-10-2017', 'dd-mm-yyyy'), to_date('27-07-2027', 'dd-mm-yyyy'), 'Pending', 33591003);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (167032, 85857, 144, to_date('25-12-2011', 'dd-mm-yyyy'), to_date('01-10-2028', 'dd-mm-yyyy'), 'Completed', 79467005);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (41485, 30274, 410, to_date('08-03-2018', 'dd-mm-yyyy'), to_date('30-03-2029', 'dd-mm-yyyy'), 'Pending', 97158353);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (253485, 96625, 31, to_date('01-09-2013', 'dd-mm-yyyy'), to_date('18-01-2029', 'dd-mm-yyyy'), 'Completed', 85894488);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (833255, 18769, 390, to_date('04-09-2000', 'dd-mm-yyyy'), to_date('15-07-2025', 'dd-mm-yyyy'), 'Processing', 38452053);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (141913, 12627, 58, to_date('30-10-2003', 'dd-mm-yyyy'), to_date('11-09-2023', 'dd-mm-yyyy'), 'Pending', 34547826);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (397582, 6557, 168, to_date('19-05-2000', 'dd-mm-yyyy'), to_date('13-09-2026', 'dd-mm-yyyy'), 'Pending', 48524665);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (614744, 63389, 287, to_date('06-11-2005', 'dd-mm-yyyy'), to_date('27-01-2024', 'dd-mm-yyyy'), 'Completed', 40424418);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (304096, 59853, 150, to_date('01-12-2006', 'dd-mm-yyyy'), to_date('08-08-2023', 'dd-mm-yyyy'), 'Shipped', 67097118);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (320198, 88657, 383, to_date('08-03-2018', 'dd-mm-yyyy'), to_date('16-02-2030', 'dd-mm-yyyy'), 'Processing', 42785299);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (709990, 48669, 361, to_date('20-05-2017', 'dd-mm-yyyy'), to_date('19-01-2021', 'dd-mm-yyyy'), 'Shipped', 61452332);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (616452, 88657, 333, to_date('24-11-2010', 'dd-mm-yyyy'), to_date('18-03-2029', 'dd-mm-yyyy'), 'Pending', 91787136);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (930283, 90019, 234, to_date('11-02-2015', 'dd-mm-yyyy'), to_date('09-06-2029', 'dd-mm-yyyy'), 'On Hold', 34547826);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (675065, 92272, 73, to_date('24-08-2018', 'dd-mm-yyyy'), to_date('23-05-2028', 'dd-mm-yyyy'), 'Shipped', 54302713);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (389965, 24337, 235, to_date('20-01-2000', 'dd-mm-yyyy'), to_date('19-03-2029', 'dd-mm-yyyy'), 'On Hold', 92923016);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (689016, 48488, 184, to_date('29-05-2004', 'dd-mm-yyyy'), to_date('04-10-2024', 'dd-mm-yyyy'), 'Completed', 86198357);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (544017, 39659, 29, to_date('16-11-2017', 'dd-mm-yyyy'), to_date('25-07-2031', 'dd-mm-yyyy'), 'Shipped', 21561518);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (165880, 83482, 49, to_date('03-03-2004', 'dd-mm-yyyy'), to_date('13-03-2025', 'dd-mm-yyyy'), 'Processing', 78667587);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (821415, 51949, 369, to_date('29-08-2013', 'dd-mm-yyyy'), to_date('20-02-2021', 'dd-mm-yyyy'), 'Shipped', 34179616);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (130838, 63160, 479, to_date('28-10-2019', 'dd-mm-yyyy'), to_date('17-06-2023', 'dd-mm-yyyy'), 'On Hold', 20780563);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (133382, 54515, 466, to_date('07-01-2000', 'dd-mm-yyyy'), to_date('01-02-2031', 'dd-mm-yyyy'), 'Pending', 93645798);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (903287, 42340, 13, to_date('16-02-2017', 'dd-mm-yyyy'), to_date('26-06-2023', 'dd-mm-yyyy'), 'Pending', 74053824);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (960034, 11769, 81, to_date('08-10-2018', 'dd-mm-yyyy'), to_date('12-12-2028', 'dd-mm-yyyy'), 'Completed', 14758552);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (742938, 92416, 419, to_date('18-01-2011', 'dd-mm-yyyy'), to_date('12-06-2027', 'dd-mm-yyyy'), 'Processing', 86198357);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (15457, 93490, 255, to_date('10-06-2010', 'dd-mm-yyyy'), to_date('11-01-2021', 'dd-mm-yyyy'), 'Completed', 99396967);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (456276, 83624, 488, to_date('22-01-2009', 'dd-mm-yyyy'), to_date('31-07-2027', 'dd-mm-yyyy'), 'Pending', 61452332);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (848691, 70003, 218, to_date('09-07-2017', 'dd-mm-yyyy'), to_date('14-09-2024', 'dd-mm-yyyy'), 'On Hold', 95607525);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (665041, 61198, 394, to_date('11-10-2008', 'dd-mm-yyyy'), to_date('30-05-2024', 'dd-mm-yyyy'), 'Shipped', 24714985);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (616945, 50610, 228, to_date('16-10-2005', 'dd-mm-yyyy'), to_date('04-09-2023', 'dd-mm-yyyy'), 'On Hold', 12930124);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (313164, 97005, 325, to_date('15-05-2013', 'dd-mm-yyyy'), to_date('14-08-2031', 'dd-mm-yyyy'), 'Completed', 40601624);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (508067, 87095, 210, to_date('02-02-2004', 'dd-mm-yyyy'), to_date('13-05-2030', 'dd-mm-yyyy'), 'Processing', 80521010);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (736069, 91585, 448, to_date('05-01-2014', 'dd-mm-yyyy'), to_date('05-05-2030', 'dd-mm-yyyy'), 'Shipped', 58304446);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (129705, 53170, 155, to_date('02-02-2015', 'dd-mm-yyyy'), to_date('28-05-2026', 'dd-mm-yyyy'), 'Shipped', 77375983);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (782489, 9958, 98, to_date('16-08-2008', 'dd-mm-yyyy'), to_date('02-01-2027', 'dd-mm-yyyy'), 'Processing', 63542839);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (350964, 22636, 333, to_date('30-08-2006', 'dd-mm-yyyy'), to_date('19-10-2030', 'dd-mm-yyyy'), 'Shipped', 84618355);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (478379, 87798, 331, to_date('09-03-2000', 'dd-mm-yyyy'), to_date('30-07-2024', 'dd-mm-yyyy'), 'Pending', 16195422);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (284778, 2137, 279, to_date('26-11-2019', 'dd-mm-yyyy'), to_date('07-02-2025', 'dd-mm-yyyy'), 'Completed', 57172755);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (933159, 34574, 209, to_date('27-03-2001', 'dd-mm-yyyy'), to_date('29-02-2024', 'dd-mm-yyyy'), 'Pending', 16486624);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (630226, 70880, 387, to_date('22-03-2016', 'dd-mm-yyyy'), to_date('25-07-2025', 'dd-mm-yyyy'), 'Processing', 38452053);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (109089, 98344, 383, to_date('21-10-2002', 'dd-mm-yyyy'), to_date('30-09-2027', 'dd-mm-yyyy'), 'Processing', 85894488);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (533446, 26882, 55, to_date('11-10-2019', 'dd-mm-yyyy'), to_date('08-04-2021', 'dd-mm-yyyy'), 'Completed', 58391234);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (642933, 26726, 7, to_date('17-02-2008', 'dd-mm-yyyy'), to_date('02-10-2023', 'dd-mm-yyyy'), 'Completed', 84618355);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (239281, 48488, 376, to_date('14-10-2016', 'dd-mm-yyyy'), to_date('28-07-2029', 'dd-mm-yyyy'), 'Completed', 34547826);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (63455, 26123, 338, to_date('25-09-2003', 'dd-mm-yyyy'), to_date('27-07-2030', 'dd-mm-yyyy'), 'Shipped', 54302713);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (661399, 39304, 89, to_date('17-05-2004', 'dd-mm-yyyy'), to_date('12-07-2029', 'dd-mm-yyyy'), 'Processing', 25470185);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (371180, 27404, 111, to_date('21-07-2017', 'dd-mm-yyyy'), to_date('09-05-2027', 'dd-mm-yyyy'), 'Shipped', 85894488);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (855730, 35973, 484, to_date('04-01-2007', 'dd-mm-yyyy'), to_date('25-02-2027', 'dd-mm-yyyy'), 'Pending', 67606405);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (996199, 79451, 87, to_date('11-04-2011', 'dd-mm-yyyy'), to_date('09-01-2028', 'dd-mm-yyyy'), 'Completed', 52928864);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (181664, 56866, 18, to_date('01-12-2013', 'dd-mm-yyyy'), to_date('12-08-2023', 'dd-mm-yyyy'), 'Completed', 56090177);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (469934, 97516, 495, to_date('01-11-2011', 'dd-mm-yyyy'), to_date('26-08-2024', 'dd-mm-yyyy'), 'Completed', 92923016);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (757846, 1092, 481, to_date('27-03-2015', 'dd-mm-yyyy'), to_date('26-01-2028', 'dd-mm-yyyy'), 'Completed', 48262283);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (985362, 91201, 289, to_date('23-05-2019', 'dd-mm-yyyy'), to_date('11-01-2028', 'dd-mm-yyyy'), 'Processing', 77375983);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (138049, 23068, 229, to_date('23-10-2013', 'dd-mm-yyyy'), to_date('28-09-2031', 'dd-mm-yyyy'), 'On Hold', 14647959);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (995385, 1092, 187, to_date('22-06-2005', 'dd-mm-yyyy'), to_date('08-04-2027', 'dd-mm-yyyy'), 'Processing', 76640553);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (94917, 19324, 191, to_date('26-06-2014', 'dd-mm-yyyy'), to_date('19-05-2031', 'dd-mm-yyyy'), 'Completed', 1);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (506139, 24938, 199, to_date('27-09-2007', 'dd-mm-yyyy'), to_date('21-11-2024', 'dd-mm-yyyy'), 'Pending', 92724719);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (974214, 72449, 495, to_date('02-05-2008', 'dd-mm-yyyy'), to_date('01-08-2021', 'dd-mm-yyyy'), 'Completed', 48134079);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (4092, 92520, 148, to_date('13-06-2009', 'dd-mm-yyyy'), to_date('17-06-2027', 'dd-mm-yyyy'), 'Processing', 33120027);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (202171, 11219, 453, to_date('22-04-2011', 'dd-mm-yyyy'), to_date('19-06-2028', 'dd-mm-yyyy'), 'Processing', 48379600);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (587226, 8783, 454, to_date('09-02-2003', 'dd-mm-yyyy'), to_date('07-08-2031', 'dd-mm-yyyy'), 'On Hold', 12471457);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (48848, 8995, 218, to_date('04-07-2005', 'dd-mm-yyyy'), to_date('17-09-2031', 'dd-mm-yyyy'), 'Completed', 55527141);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (892354, 20429, 48, to_date('29-11-2001', 'dd-mm-yyyy'), to_date('22-06-2024', 'dd-mm-yyyy'), 'Shipped', 48696874);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (113887, 60659, 256, to_date('03-06-2002', 'dd-mm-yyyy'), to_date('12-03-2021', 'dd-mm-yyyy'), 'On Hold', 25441111);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (552506, 43399, 244, to_date('15-09-2004', 'dd-mm-yyyy'), to_date('03-04-2026', 'dd-mm-yyyy'), 'Pending', 67606405);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (424318, 52764, 224, to_date('30-11-2005', 'dd-mm-yyyy'), to_date('27-11-2026', 'dd-mm-yyyy'), 'Pending', 68009450);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (383804, 9797, 83, to_date('22-09-2004', 'dd-mm-yyyy'), to_date('19-03-2025', 'dd-mm-yyyy'), 'Processing', 54302713);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (763826, 23018, 242, to_date('30-09-2009', 'dd-mm-yyyy'), to_date('09-07-2028', 'dd-mm-yyyy'), 'On Hold', 74898238);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (552517, 78483, 119, to_date('26-04-2007', 'dd-mm-yyyy'), to_date('24-09-2024', 'dd-mm-yyyy'), 'Pending', 24714985);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (770409, 96625, 258, to_date('03-02-2012', 'dd-mm-yyyy'), to_date('09-02-2022', 'dd-mm-yyyy'), 'Shipped', 24093550);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (771207, 97516, 68, to_date('16-01-2019', 'dd-mm-yyyy'), to_date('28-10-2022', 'dd-mm-yyyy'), 'Shipped', 55983169);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (998405, 28618, 366, to_date('14-11-2015', 'dd-mm-yyyy'), to_date('25-01-2031', 'dd-mm-yyyy'), 'On Hold', 95607525);
commit;
prompt 100 records committed...
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (649156, 23658, 419, to_date('26-08-2019', 'dd-mm-yyyy'), to_date('07-12-2025', 'dd-mm-yyyy'), 'Completed', 21006417);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (600466, 61754, 11, to_date('09-02-2001', 'dd-mm-yyyy'), to_date('15-05-2031', 'dd-mm-yyyy'), 'Processing', 97042332);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (850480, 11219, 456, to_date('28-09-2003', 'dd-mm-yyyy'), to_date('19-01-2022', 'dd-mm-yyyy'), 'On Hold', 35665486);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (376533, 35078, 137, to_date('19-12-2000', 'dd-mm-yyyy'), to_date('16-07-2026', 'dd-mm-yyyy'), 'Completed', 35455127);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (447804, 9701, 191, to_date('16-10-2019', 'dd-mm-yyyy'), to_date('07-08-2028', 'dd-mm-yyyy'), 'Processing', 35665486);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (337511, 72239, 337, to_date('09-02-2019', 'dd-mm-yyyy'), to_date('28-09-2028', 'dd-mm-yyyy'), 'Pending', 18792965);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (186219, 65795, 198, to_date('05-07-2005', 'dd-mm-yyyy'), to_date('07-01-2028', 'dd-mm-yyyy'), 'Pending', 92923016);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (173189, 40035, 96, to_date('05-05-2003', 'dd-mm-yyyy'), to_date('18-04-2028', 'dd-mm-yyyy'), 'Pending', 67606405);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (988530, 71330, 95, to_date('24-12-2008', 'dd-mm-yyyy'), to_date('24-01-2025', 'dd-mm-yyyy'), 'Shipped', 20927003);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (833695, 23018, 417, to_date('05-10-2009', 'dd-mm-yyyy'), to_date('28-11-2025', 'dd-mm-yyyy'), 'On Hold', 16551905);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (319871, 28128, 351, to_date('08-12-2016', 'dd-mm-yyyy'), to_date('20-07-2026', 'dd-mm-yyyy'), 'Shipped', 11678217);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (717021, 94302, 419, to_date('29-04-2003', 'dd-mm-yyyy'), to_date('29-11-2028', 'dd-mm-yyyy'), 'Pending', 12471457);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (932920, 99420, 404, to_date('21-12-2009', 'dd-mm-yyyy'), to_date('19-12-2027', 'dd-mm-yyyy'), 'Processing', 53330905);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (247052, 42441, 133, to_date('21-04-2014', 'dd-mm-yyyy'), to_date('16-09-2031', 'dd-mm-yyyy'), 'On Hold', 12240369);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (920066, 39314, 101, to_date('07-05-2004', 'dd-mm-yyyy'), to_date('17-05-2029', 'dd-mm-yyyy'), 'Pending', 54917654);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (343480, 61198, 354, to_date('09-04-2018', 'dd-mm-yyyy'), to_date('08-12-2027', 'dd-mm-yyyy'), 'Processing', 58304446);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (992917, 89923, 66, to_date('03-12-2004', 'dd-mm-yyyy'), to_date('27-08-2025', 'dd-mm-yyyy'), 'Shipped', 35455127);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (85898, 56275, 188, to_date('20-06-2015', 'dd-mm-yyyy'), to_date('01-08-2028', 'dd-mm-yyyy'), 'On Hold', 96081193);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (834417, 93745, 413, to_date('07-03-2009', 'dd-mm-yyyy'), to_date('03-01-2021', 'dd-mm-yyyy'), 'On Hold', 68009450);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (335927, 72391, 147, to_date('23-11-2019', 'dd-mm-yyyy'), to_date('05-12-2029', 'dd-mm-yyyy'), 'Processing', 14647959);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (776144, 16319, 18, to_date('02-04-2004', 'dd-mm-yyyy'), to_date('18-03-2024', 'dd-mm-yyyy'), 'Completed', 63542839);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (536116, 90255, 447, to_date('09-04-2010', 'dd-mm-yyyy'), to_date('10-08-2030', 'dd-mm-yyyy'), 'Shipped', 80099462);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (316450, 34253, 323, to_date('27-12-2005', 'dd-mm-yyyy'), to_date('29-06-2027', 'dd-mm-yyyy'), 'Completed', 24312332);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (326201, 49135, 18, to_date('20-06-2004', 'dd-mm-yyyy'), to_date('09-04-2025', 'dd-mm-yyyy'), 'Completed', 95117510);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (867393, 7173, 382, to_date('23-12-2003', 'dd-mm-yyyy'), to_date('25-09-2025', 'dd-mm-yyyy'), 'Shipped', 78667587);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (389527, 21190, 56, to_date('04-09-2002', 'dd-mm-yyyy'), to_date('04-04-2024', 'dd-mm-yyyy'), 'Pending', 12270385);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (15290, 32396, 114, to_date('27-11-2019', 'dd-mm-yyyy'), to_date('07-07-2031', 'dd-mm-yyyy'), 'On Hold', 59504229);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (249964, 19071, 173, to_date('21-06-2009', 'dd-mm-yyyy'), to_date('11-12-2028', 'dd-mm-yyyy'), 'Shipped', 73232830);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (732044, 30715, 316, to_date('08-03-2017', 'dd-mm-yyyy'), to_date('31-03-2028', 'dd-mm-yyyy'), 'Processing', 97158353);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (36303, 24236, 389, to_date('10-02-2014', 'dd-mm-yyyy'), to_date('05-08-2028', 'dd-mm-yyyy'), 'On Hold', 11449262);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (378418, 82594, 73, to_date('07-06-2018', 'dd-mm-yyyy'), to_date('20-04-2029', 'dd-mm-yyyy'), 'Processing', 65252375);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (875100, 72239, 45, to_date('14-03-2018', 'dd-mm-yyyy'), to_date('21-03-2023', 'dd-mm-yyyy'), 'Completed', 91607447);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (776342, 77473, 54, to_date('14-02-2014', 'dd-mm-yyyy'), to_date('22-08-2024', 'dd-mm-yyyy'), 'Completed', 53490786);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (200672, 27172, 177, to_date('12-01-2007', 'dd-mm-yyyy'), to_date('02-02-2025', 'dd-mm-yyyy'), 'Shipped', 74898238);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (596459, 68917, 345, to_date('06-10-2016', 'dd-mm-yyyy'), to_date('28-11-2026', 'dd-mm-yyyy'), 'Pending', 95607525);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (564346, 87095, 440, to_date('01-04-2012', 'dd-mm-yyyy'), to_date('06-12-2021', 'dd-mm-yyyy'), 'Shipped', 51259353);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (816798, 89923, 305, to_date('04-04-2000', 'dd-mm-yyyy'), to_date('16-01-2026', 'dd-mm-yyyy'), 'Shipped', 57662757);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (252682, 61179, 206, to_date('16-11-2016', 'dd-mm-yyyy'), to_date('05-02-2031', 'dd-mm-yyyy'), 'Processing', 48525494);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (814226, 68285, 302, to_date('17-01-2013', 'dd-mm-yyyy'), to_date('02-06-2022', 'dd-mm-yyyy'), 'Completed', 35092710);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (363203, 78195, 172, to_date('26-07-2011', 'dd-mm-yyyy'), to_date('27-06-2022', 'dd-mm-yyyy'), 'Shipped', 12471457);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (828219, 8615, 146, to_date('17-07-2003', 'dd-mm-yyyy'), to_date('31-01-2031', 'dd-mm-yyyy'), 'Processing', 97526793);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (447947, 42441, 386, to_date('16-05-2017', 'dd-mm-yyyy'), to_date('31-12-2030', 'dd-mm-yyyy'), 'Completed', 42947560);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (408203, 34808, 127, to_date('16-07-2015', 'dd-mm-yyyy'), to_date('07-08-2027', 'dd-mm-yyyy'), 'Completed', 92923016);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (49044, 66416, 15, to_date('18-04-2004', 'dd-mm-yyyy'), to_date('31-10-2029', 'dd-mm-yyyy'), 'On Hold', 55527141);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (948344, 65297, 293, to_date('07-06-2002', 'dd-mm-yyyy'), to_date('11-03-2023', 'dd-mm-yyyy'), 'Shipped', 92639077);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (98399, 52764, 257, to_date('30-08-2010', 'dd-mm-yyyy'), to_date('06-10-2023', 'dd-mm-yyyy'), 'Pending', 45826801);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (541449, 33510, 302, to_date('18-01-2009', 'dd-mm-yyyy'), to_date('02-06-2023', 'dd-mm-yyyy'), 'Pending', 40664733);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (980831, 24492, 237, to_date('14-02-2017', 'dd-mm-yyyy'), to_date('14-09-2024', 'dd-mm-yyyy'), 'Completed', 68009450);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (932187, 87822, 113, to_date('06-08-2001', 'dd-mm-yyyy'), to_date('12-05-2023', 'dd-mm-yyyy'), 'Completed', 19789687);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (299724, 91585, 372, to_date('30-03-2005', 'dd-mm-yyyy'), to_date('07-03-2025', 'dd-mm-yyyy'), 'Processing', 20837013);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (674318, 16673, 302, to_date('09-10-2004', 'dd-mm-yyyy'), to_date('18-04-2022', 'dd-mm-yyyy'), 'On Hold', 14758552);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (796595, 18544, 171, to_date('02-05-2011', 'dd-mm-yyyy'), to_date('09-12-2024', 'dd-mm-yyyy'), 'Completed', 47246458);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (225427, 56275, 420, to_date('13-01-2014', 'dd-mm-yyyy'), to_date('04-05-2024', 'dd-mm-yyyy'), 'On Hold', 38179588);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (318117, 49944, 96, to_date('27-04-2017', 'dd-mm-yyyy'), to_date('07-03-2026', 'dd-mm-yyyy'), 'On Hold', 73232830);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (743504, 93490, 25, to_date('03-10-2013', 'dd-mm-yyyy'), to_date('06-03-2030', 'dd-mm-yyyy'), 'On Hold', 55133153);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (578589, 21439, 237, to_date('10-08-2009', 'dd-mm-yyyy'), to_date('12-06-2023', 'dd-mm-yyyy'), 'Completed', 48524665);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (423377, 54423, 228, to_date('14-04-2016', 'dd-mm-yyyy'), to_date('03-04-2030', 'dd-mm-yyyy'), 'Shipped', 93580069);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (119891, 80021, 316, to_date('01-05-2019', 'dd-mm-yyyy'), to_date('11-04-2027', 'dd-mm-yyyy'), 'Shipped', 85894488);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (980712, 87087, 159, to_date('06-07-2017', 'dd-mm-yyyy'), to_date('13-03-2025', 'dd-mm-yyyy'), 'On Hold', 72012718);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (334599, 85857, 347, to_date('27-07-2011', 'dd-mm-yyyy'), to_date('25-07-2021', 'dd-mm-yyyy'), 'Shipped', 12240369);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (502478, 35078, 266, to_date('23-07-2017', 'dd-mm-yyyy'), to_date('29-03-2025', 'dd-mm-yyyy'), 'Pending', 12930124);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (627532, 66295, 130, to_date('07-12-2010', 'dd-mm-yyyy'), to_date('29-07-2031', 'dd-mm-yyyy'), 'Pending', 32430536);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (327451, 19721, 192, to_date('10-02-2003', 'dd-mm-yyyy'), to_date('12-07-2021', 'dd-mm-yyyy'), 'Completed', 70452684);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (224129, 8871, 5, to_date('28-11-2001', 'dd-mm-yyyy'), to_date('24-06-2028', 'dd-mm-yyyy'), 'Processing', 83720497);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (693100, 15896, 204, to_date('03-07-2013', 'dd-mm-yyyy'), to_date('05-12-2031', 'dd-mm-yyyy'), 'Completed', 20780563);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (898115, 26123, 314, to_date('27-01-2005', 'dd-mm-yyyy'), to_date('13-11-2021', 'dd-mm-yyyy'), 'Completed', 89463328);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (909417, 61071, 397, to_date('19-12-2017', 'dd-mm-yyyy'), to_date('07-01-2029', 'dd-mm-yyyy'), 'On Hold', 90609320);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (96884, 76126, 384, to_date('02-09-2017', 'dd-mm-yyyy'), to_date('04-11-2026', 'dd-mm-yyyy'), 'Completed', 60922255);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (536182, 87498, 29, to_date('05-07-2006', 'dd-mm-yyyy'), to_date('15-04-2021', 'dd-mm-yyyy'), 'Completed', 39457119);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (517135, 70003, 77, to_date('18-05-2005', 'dd-mm-yyyy'), to_date('02-02-2023', 'dd-mm-yyyy'), 'Completed', 68840671);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (905260, 28128, 175, to_date('27-07-2004', 'dd-mm-yyyy'), to_date('10-06-2022', 'dd-mm-yyyy'), 'Completed', 97375479);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (708435, 83624, 258, to_date('27-03-2011', 'dd-mm-yyyy'), to_date('11-08-2023', 'dd-mm-yyyy'), 'Completed', 95377982);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (889390, 26282, 447, to_date('22-01-2001', 'dd-mm-yyyy'), to_date('23-06-2024', 'dd-mm-yyyy'), 'On Hold', 35665486);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (805404, 81581, 320, to_date('21-06-2002', 'dd-mm-yyyy'), to_date('04-12-2028', 'dd-mm-yyyy'), 'Shipped', 82822656);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (400392, 72449, 371, to_date('27-06-2011', 'dd-mm-yyyy'), to_date('01-03-2024', 'dd-mm-yyyy'), 'Pending', 95377982);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (672456, 34808, 285, to_date('11-06-2002', 'dd-mm-yyyy'), to_date('22-07-2026', 'dd-mm-yyyy'), 'Shipped', 64848868);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (348279, 19792, 263, to_date('30-03-2013', 'dd-mm-yyyy'), to_date('29-04-2025', 'dd-mm-yyyy'), 'Processing', 42785299);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (239746, 50559, 188, to_date('17-03-2004', 'dd-mm-yyyy'), to_date('02-04-2027', 'dd-mm-yyyy'), 'On Hold', 16305031);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (588956, 99310, 79, to_date('16-04-2009', 'dd-mm-yyyy'), to_date('27-12-2030', 'dd-mm-yyyy'), 'Completed', 27921692);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (984764, 82594, 419, to_date('29-10-2012', 'dd-mm-yyyy'), to_date('23-05-2022', 'dd-mm-yyyy'), 'Pending', 34179616);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (386164, 79451, 396, to_date('17-06-2001', 'dd-mm-yyyy'), to_date('22-01-2026', 'dd-mm-yyyy'), 'Processing', 76990088);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (463277, 30912, 267, to_date('15-11-2018', 'dd-mm-yyyy'), to_date('04-06-2024', 'dd-mm-yyyy'), 'On Hold', 76640553);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (455255, 9829, 148, to_date('30-05-2009', 'dd-mm-yyyy'), to_date('08-07-2031', 'dd-mm-yyyy'), 'Pending', 60281327);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (847380, 17774, 164, to_date('31-05-2000', 'dd-mm-yyyy'), to_date('05-08-2024', 'dd-mm-yyyy'), 'Pending', 21325971);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (432707, 22636, 145, to_date('21-07-2007', 'dd-mm-yyyy'), to_date('17-08-2023', 'dd-mm-yyyy'), 'Completed', 89463328);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (985387, 79933, 483, to_date('15-06-2016', 'dd-mm-yyyy'), to_date('13-08-2027', 'dd-mm-yyyy'), 'Processing', 93645798);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (478184, 30274, 54, to_date('12-01-2008', 'dd-mm-yyyy'), to_date('24-07-2030', 'dd-mm-yyyy'), 'Processing', 16195422);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (692871, 23658, 200, to_date('04-03-2008', 'dd-mm-yyyy'), to_date('13-04-2022', 'dd-mm-yyyy'), 'Completed', 32336221);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (214392, 9293, 261, to_date('16-07-2016', 'dd-mm-yyyy'), to_date('21-08-2026', 'dd-mm-yyyy'), 'Pending', 44982031);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (507595, 39314, 42, to_date('03-01-2019', 'dd-mm-yyyy'), to_date('05-05-2026', 'dd-mm-yyyy'), 'Shipped', 72012718);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (397509, 21601, 329, to_date('11-08-2003', 'dd-mm-yyyy'), to_date('31-01-2028', 'dd-mm-yyyy'), 'On Hold', 67097118);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (122674, 68285, 215, to_date('03-05-2001', 'dd-mm-yyyy'), to_date('13-04-2031', 'dd-mm-yyyy'), 'Shipped', 98494608);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (18810, 91585, 72, to_date('12-06-2012', 'dd-mm-yyyy'), to_date('19-06-2024', 'dd-mm-yyyy'), 'Shipped', 65968564);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (969833, 23731, 167, to_date('05-04-2007', 'dd-mm-yyyy'), to_date('07-11-2022', 'dd-mm-yyyy'), 'Pending', 33591003);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (170963, 9958, 216, to_date('21-05-2002', 'dd-mm-yyyy'), to_date('28-08-2027', 'dd-mm-yyyy'), 'Completed', 64365513);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (471806, 62608, 416, to_date('01-04-2002', 'dd-mm-yyyy'), to_date('28-02-2026', 'dd-mm-yyyy'), 'Completed', 63310475);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (959951, 16040, 408, to_date('12-12-2019', 'dd-mm-yyyy'), to_date('13-10-2026', 'dd-mm-yyyy'), 'Processing', 1);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (978261, 30813, 34, to_date('11-01-2019', 'dd-mm-yyyy'), to_date('28-05-2028', 'dd-mm-yyyy'), 'On Hold', 92788888);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (50926, 51797, 366, to_date('15-06-2000', 'dd-mm-yyyy'), to_date('18-05-2028', 'dd-mm-yyyy'), 'Shipped', 64848868);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (366832, 77473, 186, to_date('22-07-2007', 'dd-mm-yyyy'), to_date('30-04-2029', 'dd-mm-yyyy'), 'Completed', 48523546);
commit;
prompt 200 records committed...
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (95305, 33362, 46, to_date('28-01-2014', 'dd-mm-yyyy'), to_date('22-01-2027', 'dd-mm-yyyy'), 'Completed', 59504229);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (540648, 19170, 47, to_date('12-12-2008', 'dd-mm-yyyy'), to_date('20-07-2029', 'dd-mm-yyyy'), 'Shipped', 98494608);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (736022, 34808, 462, to_date('15-06-2018', 'dd-mm-yyyy'), to_date('03-08-2025', 'dd-mm-yyyy'), 'Processing', 34179616);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (850629, 15155, 356, to_date('28-08-2019', 'dd-mm-yyyy'), to_date('24-11-2024', 'dd-mm-yyyy'), 'Completed', 99957203);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (501799, 9792, 318, to_date('15-12-2005', 'dd-mm-yyyy'), to_date('02-01-2029', 'dd-mm-yyyy'), 'Processing', 42947560);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (222751, 93745, 181, to_date('29-10-2014', 'dd-mm-yyyy'), to_date('29-01-2022', 'dd-mm-yyyy'), 'On Hold', 18792965);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (385730, 18469, 238, to_date('05-08-2009', 'dd-mm-yyyy'), to_date('10-11-2026', 'dd-mm-yyyy'), 'Completed', 34547826);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (971399, 272, 168, to_date('04-05-2001', 'dd-mm-yyyy'), to_date('14-03-2029', 'dd-mm-yyyy'), 'Completed', 55527141);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (828799, 38746, 25, to_date('23-12-2019', 'dd-mm-yyyy'), to_date('23-12-2028', 'dd-mm-yyyy'), 'On Hold', 89463328);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (109594, 60342, 22, to_date('20-05-2005', 'dd-mm-yyyy'), to_date('22-04-2026', 'dd-mm-yyyy'), 'Shipped', 87294530);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (101969, 11515, 134, to_date('04-02-2007', 'dd-mm-yyyy'), to_date('30-03-2026', 'dd-mm-yyyy'), 'Completed', 53171946);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (746625, 70564, 277, to_date('16-07-2004', 'dd-mm-yyyy'), to_date('15-06-2026', 'dd-mm-yyyy'), 'Completed', 1);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (647234, 8337, 307, to_date('15-01-2011', 'dd-mm-yyyy'), to_date('17-01-2023', 'dd-mm-yyyy'), 'Completed', 14087170);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (316697, 33137, 271, to_date('11-07-2003', 'dd-mm-yyyy'), to_date('23-04-2026', 'dd-mm-yyyy'), 'Pending', 48524665);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (256684, 70614, 31, to_date('12-10-2013', 'dd-mm-yyyy'), to_date('25-11-2025', 'dd-mm-yyyy'), 'Processing', 83720497);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (321477, 11219, 230, to_date('12-03-2005', 'dd-mm-yyyy'), to_date('11-06-2021', 'dd-mm-yyyy'), 'Completed', 70452684);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (75050, 69730, 70, to_date('15-10-2019', 'dd-mm-yyyy'), to_date('05-05-2029', 'dd-mm-yyyy'), 'On Hold', 47246458);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (372467, 8703, 414, to_date('28-09-2010', 'dd-mm-yyyy'), to_date('10-01-2021', 'dd-mm-yyyy'), 'On Hold', 96081193);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (526566, 93691, 336, to_date('25-04-2000', 'dd-mm-yyyy'), to_date('16-08-2024', 'dd-mm-yyyy'), 'Shipped', 84618355);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (839825, 54515, 6, to_date('02-06-2010', 'dd-mm-yyyy'), to_date('19-07-2026', 'dd-mm-yyyy'), 'On Hold', 45826801);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (301840, 14371, 43, to_date('14-05-2004', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Completed', 80099462);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (687385, 36368, 370, to_date('03-11-2004', 'dd-mm-yyyy'), to_date('23-04-2022', 'dd-mm-yyyy'), 'Pending', 40279638);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (451182, 68918, 190, to_date('27-09-2015', 'dd-mm-yyyy'), to_date('15-05-2025', 'dd-mm-yyyy'), 'Shipped', 37100134);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (599992, 30912, 61, to_date('30-03-2015', 'dd-mm-yyyy'), to_date('03-04-2028', 'dd-mm-yyyy'), 'Completed', 67606405);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (551851, 88109, 76, to_date('16-03-2012', 'dd-mm-yyyy'), to_date('19-05-2029', 'dd-mm-yyyy'), 'On Hold', 92639077);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (789475, 47946, 38, to_date('15-09-2003', 'dd-mm-yyyy'), to_date('11-04-2025', 'dd-mm-yyyy'), 'Completed', 14647959);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (794931, 12627, 437, to_date('21-03-2014', 'dd-mm-yyyy'), to_date('08-09-2028', 'dd-mm-yyyy'), 'Pending', 99957203);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (481453, 98239, 156, to_date('14-02-2001', 'dd-mm-yyyy'), to_date('10-06-2021', 'dd-mm-yyyy'), 'Completed', 39457119);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (677345, 47642, 128, to_date('09-04-2009', 'dd-mm-yyyy'), to_date('24-11-2025', 'dd-mm-yyyy'), 'Processing', 42947560);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (939286, 44535, 169, to_date('27-05-2006', 'dd-mm-yyyy'), to_date('22-08-2024', 'dd-mm-yyyy'), 'On Hold', 28784273);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (267076, 60216, 482, to_date('02-05-2019', 'dd-mm-yyyy'), to_date('30-03-2028', 'dd-mm-yyyy'), 'On Hold', 64365513);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (716526, 27143, 394, to_date('23-03-2000', 'dd-mm-yyyy'), to_date('02-01-2021', 'dd-mm-yyyy'), 'Completed', 95377982);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (162093, 18441, 114, to_date('16-05-2009', 'dd-mm-yyyy'), to_date('18-10-2023', 'dd-mm-yyyy'), 'Completed', 95607525);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (4771, 5518, 64, to_date('28-10-2000', 'dd-mm-yyyy'), to_date('18-10-2028', 'dd-mm-yyyy'), 'Completed', 67718134);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (766292, 87822, 188, to_date('27-12-2000', 'dd-mm-yyyy'), to_date('18-04-2022', 'dd-mm-yyyy'), 'Completed', 64848868);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (70253, 82507, 102, to_date('11-03-2009', 'dd-mm-yyyy'), to_date('12-09-2022', 'dd-mm-yyyy'), 'Completed', 83720497);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (796883, 27291, 69, to_date('06-08-2004', 'dd-mm-yyyy'), to_date('06-03-2026', 'dd-mm-yyyy'), 'Completed', 26168416);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (23434, 90519, 47, to_date('20-10-2006', 'dd-mm-yyyy'), to_date('25-06-2024', 'dd-mm-yyyy'), 'Shipped', 40424418);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (62226, 30715, 412, to_date('08-06-2017', 'dd-mm-yyyy'), to_date('18-12-2028', 'dd-mm-yyyy'), 'Processing', 10389457);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (612067, 56805, 85, to_date('11-09-2014', 'dd-mm-yyyy'), to_date('20-11-2024', 'dd-mm-yyyy'), 'Shipped', 63292865);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (579476, 24236, 336, to_date('19-08-2009', 'dd-mm-yyyy'), to_date('07-09-2030', 'dd-mm-yyyy'), 'Pending', 50974786);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (775333, 18210, 54, to_date('10-05-2001', 'dd-mm-yyyy'), to_date('29-08-2023', 'dd-mm-yyyy'), 'On Hold', 15776023);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (473263, 28627, 260, to_date('27-04-2016', 'dd-mm-yyyy'), to_date('25-12-2025', 'dd-mm-yyyy'), 'Shipped', 37589679);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (665118, 9797, 311, to_date('04-06-2013', 'dd-mm-yyyy'), to_date('14-04-2025', 'dd-mm-yyyy'), 'On Hold', 29471845);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (320214, 97516, 79, to_date('05-07-2008', 'dd-mm-yyyy'), to_date('04-06-2021', 'dd-mm-yyyy'), 'Shipped', 68255934);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (623334, 19170, 464, to_date('13-04-2003', 'dd-mm-yyyy'), to_date('11-02-2024', 'dd-mm-yyyy'), 'Pending', 80099462);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (489558, 30715, 293, to_date('26-07-2003', 'dd-mm-yyyy'), to_date('09-02-2029', 'dd-mm-yyyy'), 'On Hold', 97526793);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (430938, 6557, 270, to_date('31-08-2011', 'dd-mm-yyyy'), to_date('10-09-2026', 'dd-mm-yyyy'), 'Processing', 37589679);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (234211, 8615, 250, to_date('11-09-2019', 'dd-mm-yyyy'), to_date('11-11-2026', 'dd-mm-yyyy'), 'Shipped', 44982031);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (789649, 70614, 104, to_date('24-12-2002', 'dd-mm-yyyy'), to_date('23-06-2028', 'dd-mm-yyyy'), 'Shipped', 14758552);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (20996, 96625, 97, to_date('18-04-2002', 'dd-mm-yyyy'), to_date('30-03-2029', 'dd-mm-yyyy'), 'Completed', 99957203);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (826381, 27454, 211, to_date('10-07-2002', 'dd-mm-yyyy'), to_date('08-10-2021', 'dd-mm-yyyy'), 'On Hold', 21006417);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (777856, 81364, 479, to_date('27-02-2000', 'dd-mm-yyyy'), to_date('12-01-2024', 'dd-mm-yyyy'), 'Completed', 53490786);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (980031, 39694, 86, to_date('02-05-2008', 'dd-mm-yyyy'), to_date('27-01-2022', 'dd-mm-yyyy'), 'Completed', 93645798);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (489851, 61198, 367, to_date('31-10-2001', 'dd-mm-yyyy'), to_date('06-01-2031', 'dd-mm-yyyy'), 'Pending', 10389457);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (534208, 76631, 174, to_date('09-11-2006', 'dd-mm-yyyy'), to_date('29-10-2021', 'dd-mm-yyyy'), 'Completed', 25586438);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (913156, 26123, 458, to_date('23-03-2009', 'dd-mm-yyyy'), to_date('22-05-2027', 'dd-mm-yyyy'), 'Completed', 33591003);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (618374, 92546, 289, to_date('08-08-2014', 'dd-mm-yyyy'), to_date('09-10-2024', 'dd-mm-yyyy'), 'Pending', 32336221);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (454341, 79933, 267, to_date('13-01-2011', 'dd-mm-yyyy'), to_date('27-10-2023', 'dd-mm-yyyy'), 'On Hold', 48262283);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (918261, 54561, 112, to_date('26-08-2013', 'dd-mm-yyyy'), to_date('08-01-2022', 'dd-mm-yyyy'), 'Pending', 58798436);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (478764, 82507, 132, to_date('24-04-2007', 'dd-mm-yyyy'), to_date('07-07-2024', 'dd-mm-yyyy'), 'Processing', 53948112);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (869173, 78342, 244, to_date('30-01-2009', 'dd-mm-yyyy'), to_date('13-06-2021', 'dd-mm-yyyy'), 'Completed', 12537331);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (705086, 16673, 317, to_date('22-03-2009', 'dd-mm-yyyy'), to_date('29-05-2024', 'dd-mm-yyyy'), 'On Hold', 81026262);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (219423, 49841, 193, to_date('17-01-2004', 'dd-mm-yyyy'), to_date('23-07-2021', 'dd-mm-yyyy'), 'Completed', 32336221);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (209134, 42340, 235, to_date('18-01-2002', 'dd-mm-yyyy'), to_date('24-11-2024', 'dd-mm-yyyy'), 'Processing', 99957203);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (872581, 81786, 171, to_date('03-07-2014', 'dd-mm-yyyy'), to_date('10-12-2027', 'dd-mm-yyyy'), 'Processing', 42947560);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (807670, 22636, 121, to_date('18-08-2008', 'dd-mm-yyyy'), to_date('29-07-2030', 'dd-mm-yyyy'), 'Pending', 64365513);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (468960, 39659, 315, to_date('25-12-2000', 'dd-mm-yyyy'), to_date('27-11-2026', 'dd-mm-yyyy'), 'Processing', 73232830);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (946268, 60897, 340, to_date('26-03-2009', 'dd-mm-yyyy'), to_date('28-06-2031', 'dd-mm-yyyy'), 'Completed', 98674817);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (578075, 53843, 470, to_date('12-02-2003', 'dd-mm-yyyy'), to_date('18-06-2026', 'dd-mm-yyyy'), 'Completed', 20780563);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (550710, 36368, 76, to_date('30-07-2009', 'dd-mm-yyyy'), to_date('16-03-2026', 'dd-mm-yyyy'), 'Shipped', 30993385);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (623594, 85857, 8, to_date('12-03-2000', 'dd-mm-yyyy'), to_date('15-04-2030', 'dd-mm-yyyy'), 'Processing', 97375479);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (274123, 45964, 236, to_date('03-06-2012', 'dd-mm-yyyy'), to_date('30-07-2029', 'dd-mm-yyyy'), 'Shipped', 58798436);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (185632, 67681, 417, to_date('10-09-2010', 'dd-mm-yyyy'), to_date('31-10-2028', 'dd-mm-yyyy'), 'Processing', 39457119);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (143884, 22438, 401, to_date('27-10-2013', 'dd-mm-yyyy'), to_date('01-02-2029', 'dd-mm-yyyy'), 'Pending', 24312332);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (687815, 58151, 435, to_date('04-02-2006', 'dd-mm-yyyy'), to_date('09-08-2026', 'dd-mm-yyyy'), 'Processing', 27145721);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (427200, 93222, 63, to_date('24-03-2007', 'dd-mm-yyyy'), to_date('21-08-2029', 'dd-mm-yyyy'), 'Pending', 84650888);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (385224, 86666, 366, to_date('01-11-2019', 'dd-mm-yyyy'), to_date('16-06-2026', 'dd-mm-yyyy'), 'Shipped', 93645798);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (876619, 24337, 438, to_date('10-11-2008', 'dd-mm-yyyy'), to_date('22-07-2025', 'dd-mm-yyyy'), 'On Hold', 67718134);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (47734, 48027, 183, to_date('17-12-2003', 'dd-mm-yyyy'), to_date('09-08-2027', 'dd-mm-yyyy'), 'On Hold', 92923016);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (832045, 63327, 187, to_date('26-02-2002', 'dd-mm-yyyy'), to_date('21-01-2029', 'dd-mm-yyyy'), 'Completed', 63216870);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (787298, 71881, 395, to_date('10-09-2015', 'dd-mm-yyyy'), to_date('07-10-2024', 'dd-mm-yyyy'), 'Processing', 67606405);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (898213, 19721, 296, to_date('25-01-2003', 'dd-mm-yyyy'), to_date('23-03-2030', 'dd-mm-yyyy'), 'Shipped', 22742162);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (876033, 54419, 116, to_date('13-03-2003', 'dd-mm-yyyy'), to_date('28-01-2028', 'dd-mm-yyyy'), 'On Hold', 50205766);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (850378, 21601, 91, to_date('12-03-2014', 'dd-mm-yyyy'), to_date('31-10-2022', 'dd-mm-yyyy'), 'Pending', 89463328);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (357219, 11659, 150, to_date('26-01-2006', 'dd-mm-yyyy'), to_date('19-09-2021', 'dd-mm-yyyy'), 'On Hold', 96081193);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (176959, 89424, 38, to_date('04-11-2004', 'dd-mm-yyyy'), to_date('15-04-2027', 'dd-mm-yyyy'), 'Pending', 48524665);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (78052, 90019, 484, to_date('25-08-2004', 'dd-mm-yyyy'), to_date('18-06-2031', 'dd-mm-yyyy'), 'On Hold', 12125716);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (392846, 11540, 292, to_date('24-02-2015', 'dd-mm-yyyy'), to_date('13-04-2028', 'dd-mm-yyyy'), 'On Hold', 20780563);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (774904, 22636, 346, to_date('07-10-2014', 'dd-mm-yyyy'), to_date('05-01-2021', 'dd-mm-yyyy'), 'Completed', 53330905);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (347624, 28627, 107, to_date('23-03-2010', 'dd-mm-yyyy'), to_date('07-05-2030', 'dd-mm-yyyy'), 'Completed', 26386141);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (198102, 68013, 57, to_date('11-08-2013', 'dd-mm-yyyy'), to_date('01-12-2026', 'dd-mm-yyyy'), 'Processing', 67097118);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (782926, 33255, 133, to_date('23-01-2015', 'dd-mm-yyyy'), to_date('14-11-2025', 'dd-mm-yyyy'), 'Pending', 40601624);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (775935, 35973, 443, to_date('09-05-2003', 'dd-mm-yyyy'), to_date('14-02-2031', 'dd-mm-yyyy'), 'Pending', 56090177);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (606123, 37754, 247, to_date('04-08-2016', 'dd-mm-yyyy'), to_date('23-09-2027', 'dd-mm-yyyy'), 'Shipped', 84292030);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (252355, 72449, 412, to_date('13-04-2004', 'dd-mm-yyyy'), to_date('26-11-2030', 'dd-mm-yyyy'), 'On Hold', 48524665);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (626785, 66416, 357, to_date('29-04-2013', 'dd-mm-yyyy'), to_date('13-01-2025', 'dd-mm-yyyy'), 'On Hold', 61452332);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (729228, 72100, 413, to_date('03-02-2011', 'dd-mm-yyyy'), to_date('03-03-2028', 'dd-mm-yyyy'), 'Processing', 58798436);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (993979, 25022, 466, to_date('25-10-2016', 'dd-mm-yyyy'), to_date('10-05-2028', 'dd-mm-yyyy'), 'Pending', 37589679);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (653934, 51949, 343, to_date('30-11-2000', 'dd-mm-yyyy'), to_date('01-01-2023', 'dd-mm-yyyy'), 'Pending', 63342886);
commit;
prompt 300 records committed...
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (826701, 2540, 358, to_date('25-06-2011', 'dd-mm-yyyy'), to_date('11-09-2028', 'dd-mm-yyyy'), 'Processing', 30993385);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (935128, 66920, 432, to_date('26-06-2001', 'dd-mm-yyyy'), to_date('07-11-2030', 'dd-mm-yyyy'), 'Processing', 63681411);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (693369, 9622, 306, to_date('06-07-2016', 'dd-mm-yyyy'), to_date('03-02-2023', 'dd-mm-yyyy'), 'On Hold', 63292865);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (398316, 11659, 232, to_date('29-09-2018', 'dd-mm-yyyy'), to_date('30-10-2023', 'dd-mm-yyyy'), 'Pending', 48525494);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (51065, 63327, 441, to_date('08-03-2004', 'dd-mm-yyyy'), to_date('06-03-2021', 'dd-mm-yyyy'), 'Completed', 39457119);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (13969, 52098, 382, to_date('31-01-2011', 'dd-mm-yyyy'), to_date('02-10-2028', 'dd-mm-yyyy'), 'Shipped', 86198357);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (245968, 18769, 126, to_date('09-10-2004', 'dd-mm-yyyy'), to_date('24-02-2026', 'dd-mm-yyyy'), 'Completed', 98494608);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (885898, 56805, 245, to_date('27-08-2014', 'dd-mm-yyyy'), to_date('12-06-2026', 'dd-mm-yyyy'), 'Shipped', 20780563);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (315244, 93882, 463, to_date('24-06-2009', 'dd-mm-yyyy'), to_date('06-02-2025', 'dd-mm-yyyy'), 'Completed', 12471457);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (664813, 30085, 239, to_date('21-08-2019', 'dd-mm-yyyy'), to_date('11-07-2031', 'dd-mm-yyyy'), 'Shipped', 27921692);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (476892, 84672, 315, to_date('12-10-2002', 'dd-mm-yyyy'), to_date('01-09-2031', 'dd-mm-yyyy'), 'Pending', 60281327);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (208044, 11659, 405, to_date('26-04-2003', 'dd-mm-yyyy'), to_date('30-10-2021', 'dd-mm-yyyy'), 'On Hold', 93724646);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (270437, 15155, 385, to_date('13-11-2007', 'dd-mm-yyyy'), to_date('30-12-2021', 'dd-mm-yyyy'), 'Pending', 48525494);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (673842, 59781, 387, to_date('02-08-2009', 'dd-mm-yyyy'), to_date('15-06-2028', 'dd-mm-yyyy'), 'Processing', 86198357);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (858739, 35078, 291, to_date('17-12-2014', 'dd-mm-yyyy'), to_date('29-06-2021', 'dd-mm-yyyy'), 'Completed', 55983169);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (315880, 9797, 188, to_date('03-12-2018', 'dd-mm-yyyy'), to_date('31-08-2023', 'dd-mm-yyyy'), 'Shipped', 93645798);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (881581, 21791, 59, to_date('29-12-2008', 'dd-mm-yyyy'), to_date('02-12-2024', 'dd-mm-yyyy'), 'Processing', 26386141);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (493557, 51307, 101, to_date('06-12-2017', 'dd-mm-yyyy'), to_date('19-07-2027', 'dd-mm-yyyy'), 'Completed', 74053824);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (501619, 16040, 2, to_date('07-04-2018', 'dd-mm-yyyy'), to_date('12-02-2029', 'dd-mm-yyyy'), 'Shipped', 45826801);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (533354, 2994, 148, to_date('09-08-2010', 'dd-mm-yyyy'), to_date('23-05-2031', 'dd-mm-yyyy'), 'Completed', 76990088);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (369733, 56866, 135, to_date('06-08-2013', 'dd-mm-yyyy'), to_date('24-04-2026', 'dd-mm-yyyy'), 'Completed', 48523546);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (795731, 84672, 461, to_date('16-08-2008', 'dd-mm-yyyy'), to_date('28-05-2025', 'dd-mm-yyyy'), 'Pending', 79467005);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (874680, 75039, 390, to_date('18-09-2000', 'dd-mm-yyyy'), to_date('13-05-2025', 'dd-mm-yyyy'), 'Shipped', 42947560);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (914854, 676, 214, to_date('22-07-2001', 'dd-mm-yyyy'), to_date('24-04-2026', 'dd-mm-yyyy'), 'Processing', 51259353);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (920868, 95842, 56, to_date('10-01-2011', 'dd-mm-yyyy'), to_date('29-09-2030', 'dd-mm-yyyy'), 'Pending', 60976032);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (947098, 59855, 321, to_date('07-02-2014', 'dd-mm-yyyy'), to_date('17-11-2023', 'dd-mm-yyyy'), 'On Hold', 87294530);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (974999, 66416, 10, to_date('29-12-2013', 'dd-mm-yyyy'), to_date('15-12-2031', 'dd-mm-yyyy'), 'Completed', 86503833);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (981084, 19170, 316, to_date('08-12-2018', 'dd-mm-yyyy'), to_date('30-03-2029', 'dd-mm-yyyy'), 'Completed', 33591003);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (997286, 9908, 326, to_date('01-10-2005', 'dd-mm-yyyy'), to_date('31-10-2031', 'dd-mm-yyyy'), 'Completed', 32336221);
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status, account_manager_id)
values (999707, 29566, 391, to_date('11-01-2017', 'dd-mm-yyyy'), to_date('24-02-2026', 'dd-mm-yyyy'), 'Processing', 63035913);
commit;
prompt 330 records loaded
prompt Loading SUPPORT_TICKET...
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (14882967, 'Reliability of detection systems', 'Pending', to_date('16-07-2022', 'dd-mm-yyyy'), to_date('07-05-2023', 'dd-mm-yyyy'), 74742649, 54917654, 40124);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (67248686, 'Integration with existing defense systems', 'Open', to_date('24-03-2022', 'dd-mm-yyyy'), to_date('08-10-2023', 'dd-mm-yyyy'), 54088195, 81203133, 99241);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (30029492, 'Environmental adaptability', 'Escalated', to_date('30-04-2023', 'dd-mm-yyyy'), to_date('19-12-2023', 'dd-mm-yyyy'), 99979592, 64848868, 82244);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (29175739, 'Vulnerability to cyber attacks', 'Escalated', to_date('20-01-2022', 'dd-mm-yyyy'), to_date('10-07-2023', 'dd-mm-yyyy'), 69517856, 48696874, 51577);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (88799352, 'Communication latency', 'Pending', to_date('13-09-2022', 'dd-mm-yyyy'), to_date('19-06-2023', 'dd-mm-yyyy'), 28817809, 12054149, 51224);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (61628327, 'Supply chain security', 'Closed', to_date('02-03-2023', 'dd-mm-yyyy'), to_date('31-10-2023', 'dd-mm-yyyy'), 39370182, 12270385, 35287);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (58925739, 'Reliability of detection systems', 'Closed', to_date('27-05-2022', 'dd-mm-yyyy'), to_date('20-11-2023', 'dd-mm-yyyy'), 31021143, 92639077, 2207);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (64141853, 'Communication latency', 'Escalated', to_date('22-04-2022', 'dd-mm-yyyy'), to_date('13-08-2023', 'dd-mm-yyyy'), 78216572, 76805170, 1351);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (87525670, 'Integration with existing defense systems', 'Pending', to_date('31-03-2023', 'dd-mm-yyyy'), to_date('06-03-2024', 'dd-mm-yyyy'), 92642538, 63310475, 19394);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (26176467, 'False positives and negatives', 'Resolved', to_date('05-02-2022', 'dd-mm-yyyy'), to_date('15-12-2023', 'dd-mm-yyyy'), 75426354, 54917654, 40122);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (75677020, 'Interception accuracy', 'Open', to_date('04-05-2022', 'dd-mm-yyyy'), to_date('09-10-2023', 'dd-mm-yyyy'), 31021143, 45442845, 27398);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (78426480, 'Maintenance and operational costs', 'Resolved', to_date('21-03-2022', 'dd-mm-yyyy'), to_date('14-09-2023', 'dd-mm-yyyy'), 70266179, 95117510, 10646);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (59223712, 'Reliability of detection systems', 'Open', to_date('08-05-2022', 'dd-mm-yyyy'), to_date('06-03-2024', 'dd-mm-yyyy'), 96178588, 40981256, 60553);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (50026539, 'Integration with existing defense systems', 'Open', to_date('28-02-2023', 'dd-mm-yyyy'), to_date('27-05-2023', 'dd-mm-yyyy'), 87982560, 28015591, 85670);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (40859132, 'False positives and negatives', 'Open', to_date('29-03-2023', 'dd-mm-yyyy'), to_date('25-11-2023', 'dd-mm-yyyy'), 16752796, 92788888, 51962);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (37253922, 'Vulnerability to cyber attacks', 'Escalated', to_date('02-01-2023', 'dd-mm-yyyy'), to_date('17-07-2023', 'dd-mm-yyyy'), 62526376, 10670802, 87344);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (50254131, 'Integration with existing defense systems', 'Open', to_date('29-04-2022', 'dd-mm-yyyy'), to_date('26-03-2024', 'dd-mm-yyyy'), 35498377, 20780563, 35672);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (42343903, 'Supply chain security', 'Pending', to_date('28-09-2022', 'dd-mm-yyyy'), to_date('22-10-2023', 'dd-mm-yyyy'), 55818347, 39457119, 38215);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (48927611, 'Maintenance and operational costs', 'Pending', to_date('13-01-2023', 'dd-mm-yyyy'), to_date('25-09-2023', 'dd-mm-yyyy'), 33067757, 25470185, 35675);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (57412085, 'Operator training and human error', 'Pending', to_date('08-10-2022', 'dd-mm-yyyy'), to_date('10-06-2023', 'dd-mm-yyyy'), 17882271, 35455127, 50690);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (14536211, 'Interception accuracy', 'Pending', to_date('25-05-2022', 'dd-mm-yyyy'), to_date('25-12-2023', 'dd-mm-yyyy'), 77642002, 48696874, 14940);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (61338911, 'False positives and negatives', 'Escalated', to_date('17-06-2022', 'dd-mm-yyyy'), to_date('20-09-2023', 'dd-mm-yyyy'), 56882009, 81203133, 6474);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (80909992, 'Environmental adaptability', 'Closed', to_date('25-03-2022', 'dd-mm-yyyy'), to_date('26-03-2024', 'dd-mm-yyyy'), 64207208, 68009450, 8311);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (34942304, 'Operator training and human error', 'Resolved', to_date('06-02-2022', 'dd-mm-yyyy'), to_date('02-07-2023', 'dd-mm-yyyy'), 18675026, 97526793, 85748);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (16108294, 'Supply chain security', 'Pending', to_date('27-07-2022', 'dd-mm-yyyy'), to_date('12-05-2023', 'dd-mm-yyyy'), 19321854, 18217124, 50690);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (24969419, 'Maintenance and operational costs', 'Open', to_date('17-07-2022', 'dd-mm-yyyy'), to_date('11-05-2023', 'dd-mm-yyyy'), 83480577, 10670802, 83771);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (16639082, 'False positives and negatives', 'Closed', to_date('27-08-2022', 'dd-mm-yyyy'), to_date('30-07-2023', 'dd-mm-yyyy'), 99433231, 25441111, 17717);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (68502985, 'False positives and negatives', 'Resolved', to_date('04-03-2023', 'dd-mm-yyyy'), to_date('31-05-2023', 'dd-mm-yyyy'), 20113136, 91607447, 20182);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (32401092, 'Operator training and human error', 'Pending', to_date('22-09-2022', 'dd-mm-yyyy'), to_date('12-03-2024', 'dd-mm-yyyy'), 85682722, 18792965, 47284);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (39426508, 'Supply chain security', 'Resolved', to_date('17-03-2023', 'dd-mm-yyyy'), to_date('05-07-2023', 'dd-mm-yyyy'), 27373972, 46497757, 51713);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (79496008, 'Maintenance and operational costs', 'Resolved', to_date('26-02-2023', 'dd-mm-yyyy'), to_date('24-05-2023', 'dd-mm-yyyy'), 86843873, 80099462, 87840);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (45750835, 'Supply chain security', 'Resolved', to_date('18-11-2022', 'dd-mm-yyyy'), to_date('03-11-2023', 'dd-mm-yyyy'), 27399832, 76173383, 11204);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (37442646, 'False positives and negatives', 'Escalated', to_date('18-10-2022', 'dd-mm-yyyy'), to_date('03-10-2023', 'dd-mm-yyyy'), 81418452, 67606405, 45787);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (83997150, 'Supply chain security', 'Closed', to_date('03-03-2022', 'dd-mm-yyyy'), to_date('27-10-2023', 'dd-mm-yyyy'), 59743184, 58761637, 61660);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (19131770, 'Vulnerability to cyber attacks', 'Open', to_date('13-03-2022', 'dd-mm-yyyy'), to_date('25-12-2023', 'dd-mm-yyyy'), 54655982, 76805170, 62041);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (22583410, 'Supply chain security', 'Pending', to_date('18-03-2022', 'dd-mm-yyyy'), to_date('16-10-2023', 'dd-mm-yyyy'), 39313492, 63342886, 72642);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (76713674, 'Environmental adaptability', 'Resolved', to_date('17-02-2022', 'dd-mm-yyyy'), to_date('04-05-2023', 'dd-mm-yyyy'), 71110942, 10842068, 82000);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (63397587, 'Operator training and human error', 'Escalated', to_date('11-04-2023', 'dd-mm-yyyy'), to_date('23-12-2023', 'dd-mm-yyyy'), 55819347, 60957159, 83771);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (40136068, 'Maintenance and operational costs', 'Closed', to_date('03-01-2023', 'dd-mm-yyyy'), to_date('16-02-2024', 'dd-mm-yyyy'), 54748279, 28015591, 80521);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (77586753, 'Maintenance and operational costs', 'Escalated', to_date('07-06-2022', 'dd-mm-yyyy'), to_date('11-08-2023', 'dd-mm-yyyy'), 92665521, 28784273, 25015);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (67872053, 'Integration with existing defense systems', 'Open', to_date('18-03-2023', 'dd-mm-yyyy'), to_date('02-03-2024', 'dd-mm-yyyy'), 31021143, 40424418, 13090);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (91171155, 'Interception accuracy', 'Pending', to_date('09-06-2022', 'dd-mm-yyyy'), to_date('28-06-2023', 'dd-mm-yyyy'), 22900368, 15776023, 32155);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (27122135, 'Reliability of detection systems', 'Pending', to_date('06-09-2022', 'dd-mm-yyyy'), to_date('08-07-2023', 'dd-mm-yyyy'), 97578691, 18792965, 93058);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (56531849, 'Operator training and human error', 'Open', to_date('25-01-2023', 'dd-mm-yyyy'), to_date('21-05-2023', 'dd-mm-yyyy'), 42142840, 83387331, 88249);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (74065203, 'Maintenance and operational costs', 'Open', to_date('23-07-2022', 'dd-mm-yyyy'), to_date('15-02-2024', 'dd-mm-yyyy'), 38174594, 20927003, 98006);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (80244316, 'Maintenance and operational costs', 'Resolved', to_date('15-06-2022', 'dd-mm-yyyy'), to_date('03-02-2024', 'dd-mm-yyyy'), 85682722, 20780563, 24369);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (29196347, 'Vulnerability to cyber attacks', 'Closed', to_date('22-09-2022', 'dd-mm-yyyy'), to_date('09-11-2023', 'dd-mm-yyyy'), 62933363, 18217124, 85675);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (94263667, 'False positives and negatives', 'Open', to_date('29-01-2022', 'dd-mm-yyyy'), to_date('03-12-2023', 'dd-mm-yyyy'), 42142840, 51259353, 41040);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (19049099, 'Supply chain security', 'Closed', to_date('26-07-2022', 'dd-mm-yyyy'), to_date('09-03-2024', 'dd-mm-yyyy'), 34849605, 99957203, 78548);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (79234640, 'Communication latency', 'Escalated', to_date('25-03-2022', 'dd-mm-yyyy'), to_date('16-12-2023', 'dd-mm-yyyy'), 65891332, 61452332, 83771);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (39281344, 'Maintenance and operational costs', 'Closed', to_date('26-02-2023', 'dd-mm-yyyy'), to_date('20-02-2024', 'dd-mm-yyyy'), 19321854, 86198357, 66512);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (33826524, 'Communication latency', 'Open', to_date('30-03-2023', 'dd-mm-yyyy'), to_date('27-08-2023', 'dd-mm-yyyy'), 55818347, 10842068, 93058);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (85832687, 'Integration with existing defense systems', 'Escalated', to_date('30-06-2022', 'dd-mm-yyyy'), to_date('08-07-2023', 'dd-mm-yyyy'), 86054195, 14758552, 31881);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (25604494, 'Integration with existing defense systems', 'Escalated', to_date('30-01-2022', 'dd-mm-yyyy'), to_date('27-03-2024', 'dd-mm-yyyy'), 16354941, 38008634, 96039);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (96261408, 'Operator training and human error', 'Closed', to_date('05-06-2022', 'dd-mm-yyyy'), to_date('24-09-2023', 'dd-mm-yyyy'), 56882009, 25441111, 16379);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (25169530, 'Integration with existing defense systems', 'Resolved', to_date('28-08-2022', 'dd-mm-yyyy'), to_date('23-01-2024', 'dd-mm-yyyy'), 39313492, 97526793, 35715);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (93066430, 'Reliability of detection systems', 'Escalated', to_date('16-01-2023', 'dd-mm-yyyy'), to_date('08-08-2023', 'dd-mm-yyyy'), 86514668, 86972825, 32258);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (39254177, 'Maintenance and operational costs', 'Escalated', to_date('26-02-2023', 'dd-mm-yyyy'), to_date('25-08-2023', 'dd-mm-yyyy'), 83480577, 63542839, 63291);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (50418872, 'Maintenance and operational costs', 'Escalated', to_date('04-02-2023', 'dd-mm-yyyy'), to_date('24-03-2024', 'dd-mm-yyyy'), 19137978, 30319594, 12372);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (18275858, 'Interception accuracy', 'Pending', to_date('15-06-2022', 'dd-mm-yyyy'), to_date('27-06-2023', 'dd-mm-yyyy'), 92665521, 56227838, 16044);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (35893748, 'False positives and negatives', 'Open', to_date('12-01-2022', 'dd-mm-yyyy'), to_date('20-11-2023', 'dd-mm-yyyy'), 72930320, 26168416, 70692);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (62648268, 'False positives and negatives', 'Open', to_date('10-02-2022', 'dd-mm-yyyy'), to_date('13-02-2024', 'dd-mm-yyyy'), 54670908, 48525494, 63298);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (65130286, 'Maintenance and operational costs', 'Escalated', to_date('10-05-2022', 'dd-mm-yyyy'), to_date('08-03-2024', 'dd-mm-yyyy'), 54670908, 26125772, 92343);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (28059600, 'Vulnerability to cyber attacks', 'Resolved', to_date('24-02-2023', 'dd-mm-yyyy'), to_date('13-06-2023', 'dd-mm-yyyy'), 57352525, 81203133, 256);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (40484102, 'Environmental adaptability', 'Escalated', to_date('29-11-2022', 'dd-mm-yyyy'), to_date('22-10-2023', 'dd-mm-yyyy'), 59933677, 86972825, 6474);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (16068918, 'Environmental adaptability', 'Escalated', to_date('02-05-2022', 'dd-mm-yyyy'), to_date('28-08-2023', 'dd-mm-yyyy'), 54103386, 44982031, 39940);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (70291095, 'Environmental adaptability', 'Open', to_date('26-07-2022', 'dd-mm-yyyy'), to_date('20-03-2024', 'dd-mm-yyyy'), 30556154, 32336221, 38215);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (10873942, 'Reliability of detection systems', 'Pending', to_date('05-01-2022', 'dd-mm-yyyy'), to_date('22-10-2023', 'dd-mm-yyyy'), 69372437, 41135368, 65056);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (73966461, 'Communication latency', 'Pending', to_date('29-05-2022', 'dd-mm-yyyy'), to_date('07-03-2024', 'dd-mm-yyyy'), 19137978, 71399259, 72661);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (39089852, 'Reliability of detection systems', 'Pending', to_date('26-03-2022', 'dd-mm-yyyy'), to_date('13-01-2024', 'dd-mm-yyyy'), 61171248, 92923016, 69557);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (95437592, 'Reliability of detection systems', 'Open', to_date('05-12-2022', 'dd-mm-yyyy'), to_date('05-02-2024', 'dd-mm-yyyy'), 33067757, 10389457, 72661);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (14974418, 'False positives and negatives', 'Open', to_date('09-10-2022', 'dd-mm-yyyy'), to_date('27-05-2023', 'dd-mm-yyyy'), 74677527, 70452684, 34825);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (43981920, 'Interception accuracy', 'Open', to_date('30-03-2022', 'dd-mm-yyyy'), to_date('14-04-2024', 'dd-mm-yyyy'), 72063537, 40981256, 3596);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (51864819, 'False positives and negatives', 'Closed', to_date('15-07-2022', 'dd-mm-yyyy'), to_date('26-11-2023', 'dd-mm-yyyy'), 33314613, 63342886, 56427);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (13034880, 'False positives and negatives', 'Resolved', to_date('25-10-2022', 'dd-mm-yyyy'), to_date('07-10-2023', 'dd-mm-yyyy'), 50467355, 63542839, 1598);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (29781003, 'Vulnerability to cyber attacks', 'Open', to_date('06-04-2022', 'dd-mm-yyyy'), to_date('02-01-2024', 'dd-mm-yyyy'), 16844774, 33591003, 64289);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (44574198, 'Communication latency', 'Escalated', to_date('08-08-2022', 'dd-mm-yyyy'), to_date('11-03-2024', 'dd-mm-yyyy'), 83480577, 42947560, 59181);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (52324247, 'Integration with existing defense systems', 'Pending', to_date('01-02-2023', 'dd-mm-yyyy'), to_date('04-06-2023', 'dd-mm-yyyy'), 32877721, 88442161, 9674);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (34899600, 'Reliability of detection systems', 'Escalated', to_date('08-07-2022', 'dd-mm-yyyy'), to_date('29-06-2023', 'dd-mm-yyyy'), 43265993, 84153294, 62735);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (61282769, 'Reliability of detection systems', 'Open', to_date('09-06-2022', 'dd-mm-yyyy'), to_date('19-09-2023', 'dd-mm-yyyy'), 85003854, 28834144, 86618);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (77636785, 'Supply chain security', 'Closed', to_date('16-01-2023', 'dd-mm-yyyy'), to_date('15-02-2024', 'dd-mm-yyyy'), 51638591, 16120175, 64289);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (67873854, 'Environmental adaptability', 'Closed', to_date('23-06-2022', 'dd-mm-yyyy'), to_date('05-08-2023', 'dd-mm-yyyy'), 63442847, 45826801, 65526);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (87226180, 'Environmental adaptability', 'Pending', to_date('07-04-2023', 'dd-mm-yyyy'), to_date('01-07-2023', 'dd-mm-yyyy'), 62218719, 28716947, 1351);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (83428878, 'Environmental adaptability', 'Resolved', to_date('17-02-2022', 'dd-mm-yyyy'), to_date('26-02-2024', 'dd-mm-yyyy'), 92665521, 25441111, 37295);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (41635474, 'Interception accuracy', 'Pending', to_date('09-05-2022', 'dd-mm-yyyy'), to_date('17-11-2023', 'dd-mm-yyyy'), 16596417, 52928864, 10178);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (52688957, 'Supply chain security', 'Pending', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('01-10-2023', 'dd-mm-yyyy'), 77642002, 18192279, 63291);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (82185343, 'Reliability of detection systems', 'Open', to_date('27-04-2022', 'dd-mm-yyyy'), to_date('30-10-2023', 'dd-mm-yyyy'), 86054195, 65968564, 37600);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (77849654, 'Reliability of detection systems', 'Resolved', to_date('04-01-2023', 'dd-mm-yyyy'), to_date('17-01-2024', 'dd-mm-yyyy'), 83177693, 59504229, 69446);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (81825037, 'False positives and negatives', 'Pending', to_date('08-07-2022', 'dd-mm-yyyy'), to_date('24-08-2023', 'dd-mm-yyyy'), 54088195, 63310475, 7250);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (44198239, 'Communication latency', 'Open', to_date('16-02-2023', 'dd-mm-yyyy'), to_date('06-01-2024', 'dd-mm-yyyy'), 89936499, 77375983, 59211);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (66563632, 'Reliability of detection systems', 'Closed', to_date('04-12-2022', 'dd-mm-yyyy'), to_date('22-04-2024', 'dd-mm-yyyy'), 30556154, 33120027, 86457);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (36751476, 'Vulnerability to cyber attacks', 'Escalated', to_date('17-01-2022', 'dd-mm-yyyy'), to_date('27-01-2024', 'dd-mm-yyyy'), 89241937, 57172755, 91899);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (68678788, 'Operator training and human error', 'Escalated', to_date('06-04-2022', 'dd-mm-yyyy'), to_date('25-09-2023', 'dd-mm-yyyy'), 70266179, 96081193, 67909);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (14850713, 'False positives and negatives', 'Open', to_date('02-04-2022', 'dd-mm-yyyy'), to_date('31-08-2023', 'dd-mm-yyyy'), 99433231, 61080008, 7250);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (60412706, 'Supply chain security', 'Pending', to_date('27-04-2022', 'dd-mm-yyyy'), to_date('22-10-2023', 'dd-mm-yyyy'), 33314613, 58798436, 6812);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (96329260, 'Supply chain security', 'Escalated', to_date('16-12-2022', 'dd-mm-yyyy'), to_date('09-02-2024', 'dd-mm-yyyy'), 19792292, 40279638, 47052);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (53749795, 'Vulnerability to cyber attacks', 'Resolved', to_date('01-01-2022', 'dd-mm-yyyy'), to_date('14-01-2024', 'dd-mm-yyyy'), 56882009, 12471457, 13853);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (47759646, 'Reliability of detection systems', 'Closed', to_date('05-03-2022', 'dd-mm-yyyy'), to_date('11-08-2023', 'dd-mm-yyyy'), 59295976, 29471845, 92711);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (51177145, 'Reliability of detection systems', 'Closed', to_date('24-03-2022', 'dd-mm-yyyy'), to_date('19-03-2024', 'dd-mm-yyyy'), 20113136, 65252375, 68335);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (90540253, 'Vulnerability to cyber attacks', 'Pending', to_date('26-04-2022', 'dd-mm-yyyy'), to_date('01-03-2024', 'dd-mm-yyyy'), 34017820, 29260815, 133);
commit;
prompt 100 records committed...
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (64682469, 'False positives and negatives', 'Escalated', to_date('21-04-2022', 'dd-mm-yyyy'), to_date('28-03-2024', 'dd-mm-yyyy'), 71358712, 48523546, 66839);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (47317184, 'Communication latency', 'Open', to_date('25-09-2022', 'dd-mm-yyyy'), to_date('14-07-2023', 'dd-mm-yyyy'), 91466324, 71399259, 28966);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (91269522, 'Reliability of detection systems', 'Resolved', to_date('29-12-2022', 'dd-mm-yyyy'), to_date('15-10-2023', 'dd-mm-yyyy'), 64207208, 21751206, 8845);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (87582926, 'Reliability of detection systems', 'Open', to_date('31-01-2022', 'dd-mm-yyyy'), to_date('13-09-2023', 'dd-mm-yyyy'), 54103386, 29260815, 86457);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (53593307, 'Supply chain security', 'Resolved', to_date('22-05-2022', 'dd-mm-yyyy'), to_date('07-02-2024', 'dd-mm-yyyy'), 16752796, 54569073, 72691);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (18373426, 'Vulnerability to cyber attacks', 'Escalated', to_date('19-02-2023', 'dd-mm-yyyy'), to_date('22-05-2023', 'dd-mm-yyyy'), 22900368, 99396967, 32430);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (19561496, 'Operator training and human error', 'Resolved', to_date('03-08-2022', 'dd-mm-yyyy'), to_date('24-10-2023', 'dd-mm-yyyy'), 56882009, 57661706, 3596);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (73924675, 'Supply chain security', 'Escalated', to_date('29-03-2022', 'dd-mm-yyyy'), to_date('09-02-2024', 'dd-mm-yyyy'), 61154579, 65252375, 19394);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (25539518, 'Communication latency', 'Resolved', to_date('09-10-2022', 'dd-mm-yyyy'), to_date('13-05-2023', 'dd-mm-yyyy'), 15593866, 86198357, 96883);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (80073705, 'Maintenance and operational costs', 'Pending', to_date('28-04-2023', 'dd-mm-yyyy'), to_date('25-03-2024', 'dd-mm-yyyy'), 90862878, 80099462, 35184);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (59759662, 'Operator training and human error', 'Escalated', to_date('06-02-2022', 'dd-mm-yyyy'), to_date('29-09-2023', 'dd-mm-yyyy'), 96178588, 40981256, 50077);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (33222114, 'Vulnerability to cyber attacks', 'Resolved', to_date('05-01-2022', 'dd-mm-yyyy'), to_date('11-07-2023', 'dd-mm-yyyy'), 31650026, 92639077, 22758);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (36294291, 'Maintenance and operational costs', 'Closed', to_date('01-04-2023', 'dd-mm-yyyy'), to_date('12-01-2024', 'dd-mm-yyyy'), 23720801, 25441111, 69006);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (32947823, 'Communication latency', 'Resolved', to_date('11-01-2022', 'dd-mm-yyyy'), to_date('26-08-2023', 'dd-mm-yyyy'), 16596417, 72012718, 56507);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (61134925, 'Communication latency', 'Closed', to_date('12-06-2022', 'dd-mm-yyyy'), to_date('29-03-2024', 'dd-mm-yyyy'), 54088195, 63342886, 8976);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (69977690, 'Environmental adaptability', 'Pending', to_date('15-08-2022', 'dd-mm-yyyy'), to_date('25-04-2024', 'dd-mm-yyyy'), 41522255, 57661706, 32430);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (41147454, 'Operator training and human error', 'Open', to_date('18-04-2022', 'dd-mm-yyyy'), to_date('21-02-2024', 'dd-mm-yyyy'), 17882271, 85894488, 34146);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (30344986, 'Reliability of detection systems', 'Closed', to_date('08-08-2022', 'dd-mm-yyyy'), to_date('06-04-2024', 'dd-mm-yyyy'), 86514668, 89845799, 88838);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (29574132, 'Supply chain security', 'Pending', to_date('17-07-2022', 'dd-mm-yyyy'), to_date('11-10-2023', 'dd-mm-yyyy'), 99433231, 16551905, 7014);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (70276377, 'Environmental adaptability', 'Pending', to_date('05-02-2022', 'dd-mm-yyyy'), to_date('28-10-2023', 'dd-mm-yyyy'), 85003854, 21006417, 67261);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (48950276, 'Interception accuracy', 'Resolved', to_date('30-01-2023', 'dd-mm-yyyy'), to_date('04-04-2024', 'dd-mm-yyyy'), 89799326, 39457119, 41040);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (57808196, 'Supply chain security', 'Open', to_date('21-04-2023', 'dd-mm-yyyy'), to_date('02-01-2024', 'dd-mm-yyyy'), 67214968, 52948447, 19394);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (29422727, 'Maintenance and operational costs', 'Closed', to_date('16-12-2022', 'dd-mm-yyyy'), to_date('28-09-2023', 'dd-mm-yyyy'), 17634484, 53490786, 35715);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (34446198, 'Integration with existing defense systems', 'Resolved', to_date('27-05-2022', 'dd-mm-yyyy'), to_date('03-04-2024', 'dd-mm-yyyy'), 65702533, 61080008, 75199);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (68123154, 'Integration with existing defense systems', 'Resolved', to_date('07-04-2022', 'dd-mm-yyyy'), to_date('15-04-2024', 'dd-mm-yyyy'), 84657835, 16551905, 48718);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (86481840, 'Maintenance and operational costs', 'Pending', to_date('26-06-2022', 'dd-mm-yyyy'), to_date('16-03-2024', 'dd-mm-yyyy'), 73291243, 11678217, 12110);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (79087165, 'Interception accuracy', 'Closed', to_date('02-01-2022', 'dd-mm-yyyy'), to_date('16-03-2024', 'dd-mm-yyyy'), 34849605, 68840671, 61660);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (78986326, 'Communication latency', 'Closed', to_date('29-09-2022', 'dd-mm-yyyy'), to_date('31-10-2023', 'dd-mm-yyyy'), 31650026, 53490786, 88875);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (73844950, 'Vulnerability to cyber attacks', 'Pending', to_date('08-04-2023', 'dd-mm-yyyy'), to_date('15-05-2023', 'dd-mm-yyyy'), 67214968, 30319594, 68335);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (89146238, 'Reliability of detection systems', 'Open', to_date('31-08-2022', 'dd-mm-yyyy'), to_date('16-09-2023', 'dd-mm-yyyy'), 21509784, 32430536, 84208);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (55865847, 'Vulnerability to cyber attacks', 'Open', to_date('21-03-2022', 'dd-mm-yyyy'), to_date('12-10-2023', 'dd-mm-yyyy'), 84360223, 14758552, 73030);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (27606515, 'Supply chain security', 'Escalated', to_date('03-09-2022', 'dd-mm-yyyy'), to_date('12-07-2023', 'dd-mm-yyyy'), 15593866, 86198357, 69597);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (68142703, 'Vulnerability to cyber attacks', 'Pending', to_date('08-01-2023', 'dd-mm-yyyy'), to_date('29-11-2023', 'dd-mm-yyyy'), 99979592, 16120175, 73581);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (29972894, 'Communication latency', 'Open', to_date('07-01-2022', 'dd-mm-yyyy'), to_date('16-06-2023', 'dd-mm-yyyy'), 85682722, 25441111, 37608);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (97977316, 'Environmental adaptability', 'Pending', to_date('22-12-2022', 'dd-mm-yyyy'), to_date('20-03-2024', 'dd-mm-yyyy'), 82793030, 26386141, 54017);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (63721602, 'Maintenance and operational costs', 'Pending', to_date('22-10-2022', 'dd-mm-yyyy'), to_date('16-01-2024', 'dd-mm-yyyy'), 87552354, 34179616, 34218);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (57100501, 'False positives and negatives', 'Escalated', to_date('21-06-2022', 'dd-mm-yyyy'), to_date('30-01-2024', 'dd-mm-yyyy'), 39403818, 13830308, 35672);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (51594193, 'Environmental adaptability', 'Resolved', to_date('09-03-2023', 'dd-mm-yyyy'), to_date('06-05-2023', 'dd-mm-yyyy'), 61456823, 64848868, 62130);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (34254472, 'Communication latency', 'Escalated', to_date('10-02-2023', 'dd-mm-yyyy'), to_date('18-09-2023', 'dd-mm-yyyy'), 39370182, 80318978, 89259);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (69244847, 'Integration with existing defense systems', 'Pending', to_date('19-02-2022', 'dd-mm-yyyy'), to_date('26-10-2023', 'dd-mm-yyyy'), 31021143, 51793598, 23548);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (61906229, 'Communication latency', 'Resolved', to_date('21-06-2022', 'dd-mm-yyyy'), to_date('03-04-2024', 'dd-mm-yyyy'), 54748279, 64365513, 91215);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (25581313, 'Reliability of detection systems', 'Resolved', to_date('08-04-2023', 'dd-mm-yyyy'), to_date('16-04-2024', 'dd-mm-yyyy'), 31417541, 52928864, 91899);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (84473554, 'Maintenance and operational costs', 'Escalated', to_date('24-03-2023', 'dd-mm-yyyy'), to_date('23-01-2024', 'dd-mm-yyyy'), 59279749, 81026262, 44229);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (67023843, 'Reliability of detection systems', 'Closed', to_date('29-01-2023', 'dd-mm-yyyy'), to_date('12-04-2024', 'dd-mm-yyyy'), 33133087, 74854868, 41535);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (32954964, 'Maintenance and operational costs', 'Pending', to_date('14-10-2022', 'dd-mm-yyyy'), to_date('10-04-2024', 'dd-mm-yyyy'), 50467355, 10670802, 8710);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (84924076, 'Interception accuracy', 'Pending', to_date('17-04-2022', 'dd-mm-yyyy'), to_date('05-10-2023', 'dd-mm-yyyy'), 17634484, 60180068, 55987);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (55786629, 'False positives and negatives', 'Resolved', to_date('13-01-2023', 'dd-mm-yyyy'), to_date('19-01-2024', 'dd-mm-yyyy'), 31650026, 29471845, 2093);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (66762756, 'Operator training and human error', 'Closed', to_date('10-08-2022', 'dd-mm-yyyy'), to_date('07-08-2023', 'dd-mm-yyyy'), 71358712, 54917654, 51259);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (98727756, 'Communication latency', 'Pending', to_date('30-05-2022', 'dd-mm-yyyy'), to_date('07-07-2023', 'dd-mm-yyyy'), 30556154, 40981256, 78548);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (89606516, 'Integration with existing defense systems', 'Open', to_date('17-08-2022', 'dd-mm-yyyy'), to_date('27-03-2024', 'dd-mm-yyyy'), 59743184, 48525494, 74575);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (43226358, 'Integration with existing defense systems', 'Escalated', to_date('31-08-2022', 'dd-mm-yyyy'), to_date('05-11-2023', 'dd-mm-yyyy'), 71061207, 86503833, 96814);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (66774650, 'Environmental adaptability', 'Resolved', to_date('14-07-2022', 'dd-mm-yyyy'), to_date('07-08-2023', 'dd-mm-yyyy'), 99979592, 64848868, 69446);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (73664559, 'Reliability of detection systems', 'Resolved', to_date('17-04-2022', 'dd-mm-yyyy'), to_date('04-02-2024', 'dd-mm-yyyy'), 20834380, 76173383, 93058);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (48871890, 'Communication latency', 'Pending', to_date('20-09-2022', 'dd-mm-yyyy'), to_date('11-05-2023', 'dd-mm-yyyy'), 19137978, 56090177, 49669);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (84751771, 'False positives and negatives', 'Open', to_date('12-08-2022', 'dd-mm-yyyy'), to_date('22-03-2024', 'dd-mm-yyyy'), 34849605, 61080008, 40124);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (86407629, 'Vulnerability to cyber attacks', 'Closed', to_date('01-01-2022', 'dd-mm-yyyy'), to_date('13-09-2023', 'dd-mm-yyyy'), 64103674, 56090177, 96814);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (51750041, 'False positives and negatives', 'Open', to_date('27-08-2022', 'dd-mm-yyyy'), to_date('26-09-2023', 'dd-mm-yyyy'), 17882271, 12270385, 3013);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (36270897, 'Reliability of detection systems', 'Open', to_date('06-03-2022', 'dd-mm-yyyy'), to_date('01-10-2023', 'dd-mm-yyyy'), 36812939, 32336221, 68128);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (23803808, 'Interception accuracy', 'Resolved', to_date('17-08-2022', 'dd-mm-yyyy'), to_date('03-11-2023', 'dd-mm-yyyy'), 31417541, 50974786, 34146);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (36488564, 'Reliability of detection systems', 'Resolved', to_date('19-04-2023', 'dd-mm-yyyy'), to_date('19-12-2023', 'dd-mm-yyyy'), 37207125, 38008634, 19394);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (65031041, 'Supply chain security', 'Pending', to_date('15-01-2022', 'dd-mm-yyyy'), to_date('13-02-2024', 'dd-mm-yyyy'), 94146730, 65968564, 41040);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (46086848, 'Interception accuracy', 'Resolved', to_date('22-04-2022', 'dd-mm-yyyy'), to_date('11-09-2023', 'dd-mm-yyyy'), 71061207, 37100134, 1847);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (44839379, 'Operator training and human error', 'Closed', to_date('09-11-2022', 'dd-mm-yyyy'), to_date('24-12-2023', 'dd-mm-yyyy'), 84360223, 26386141, 54756);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (67628147, 'False positives and negatives', 'Open', to_date('24-08-2022', 'dd-mm-yyyy'), to_date('24-08-2023', 'dd-mm-yyyy'), 36812939, 48696874, 69597);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (48784419, 'Supply chain security', 'Pending', to_date('15-11-2022', 'dd-mm-yyyy'), to_date('26-09-2023', 'dd-mm-yyyy'), 61456823, 40279638, 69774);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (82231541, 'Communication latency', 'Open', to_date('30-06-2022', 'dd-mm-yyyy'), to_date('28-03-2024', 'dd-mm-yyyy'), 28817809, 21561518, 64062);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (29812682, 'Integration with existing defense systems', 'Open', to_date('29-11-2022', 'dd-mm-yyyy'), to_date('27-05-2023', 'dd-mm-yyyy'), 33314613, 34547826, 32155);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (78731023, 'Operator training and human error', 'Escalated', to_date('27-01-2023', 'dd-mm-yyyy'), to_date('16-10-2023', 'dd-mm-yyyy'), 92355989, 53330905, 54756);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (27554040, 'Supply chain security', 'Closed', to_date('02-02-2022', 'dd-mm-yyyy'), to_date('27-07-2023', 'dd-mm-yyyy'), 36373252, 85894488, 2627);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (73205587, 'Environmental adaptability', 'Resolved', to_date('23-06-2022', 'dd-mm-yyyy'), to_date('16-05-2023', 'dd-mm-yyyy'), 87982560, 25441111, 56655);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (46072550, 'Integration with existing defense systems', 'Open', to_date('09-10-2022', 'dd-mm-yyyy'), to_date('18-04-2024', 'dd-mm-yyyy'), 34849605, 21325971, 1546);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (60554752, 'False positives and negatives', 'Pending', to_date('06-02-2023', 'dd-mm-yyyy'), to_date('03-11-2023', 'dd-mm-yyyy'), 23759349, 12125716, 51577);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (98775651, 'Vulnerability to cyber attacks', 'Escalated', to_date('10-11-2022', 'dd-mm-yyyy'), to_date('15-02-2024', 'dd-mm-yyyy'), 51957721, 98674817, 28966);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (39216944, 'Supply chain security', 'Closed', to_date('22-03-2022', 'dd-mm-yyyy'), to_date('05-05-2023', 'dd-mm-yyyy'), 72063537, 58761637, 29403);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (68644548, 'Integration with existing defense systems', 'Resolved', to_date('05-04-2023', 'dd-mm-yyyy'), to_date('31-05-2023', 'dd-mm-yyyy'), 59279749, 15776023, 256);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (91661343, 'Supply chain security', 'Closed', to_date('13-12-2022', 'dd-mm-yyyy'), to_date('30-03-2024', 'dd-mm-yyyy'), 85889675, 74053824, 82080);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (83208405, 'Interception accuracy', 'Escalated', to_date('07-09-2022', 'dd-mm-yyyy'), to_date('12-08-2023', 'dd-mm-yyyy'), 60843836, 74854868, 19286);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (60051393, 'Reliability of detection systems', 'Closed', to_date('11-03-2022', 'dd-mm-yyyy'), to_date('06-04-2024', 'dd-mm-yyyy'), 19792292, 92724719, 77391);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (32366595, 'Maintenance and operational costs', 'Open', to_date('01-09-2022', 'dd-mm-yyyy'), to_date('18-11-2023', 'dd-mm-yyyy'), 86514668, 11449262, 40848);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (86605121, 'Maintenance and operational costs', 'Open', to_date('01-09-2022', 'dd-mm-yyyy'), to_date('15-07-2023', 'dd-mm-yyyy'), 95814419, 46497757, 8976);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (83891763, 'Reliability of detection systems', 'Resolved', to_date('24-07-2022', 'dd-mm-yyyy'), to_date('13-05-2023', 'dd-mm-yyyy'), 62933363, 84153294, 75199);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (64788733, 'Supply chain security', 'Pending', to_date('31-12-2022', 'dd-mm-yyyy'), to_date('30-07-2023', 'dd-mm-yyyy'), 10840739, 30057569, 95056);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (71846855, 'Environmental adaptability', 'Resolved', to_date('15-07-2022', 'dd-mm-yyyy'), to_date('25-04-2024', 'dd-mm-yyyy'), 74742649, 16305031, 36489);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (48700675, 'Supply chain security', 'Escalated', to_date('18-08-2022', 'dd-mm-yyyy'), to_date('26-05-2023', 'dd-mm-yyyy'), 94249883, 75222502, 51713);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (67846549, 'Operator training and human error', 'Pending', to_date('15-06-2022', 'dd-mm-yyyy'), to_date('14-09-2023', 'dd-mm-yyyy'), 83846105, 30319594, 68390);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (26958413, 'Reliability of detection systems', 'Escalated', to_date('03-08-2022', 'dd-mm-yyyy'), to_date('15-01-2024', 'dd-mm-yyyy'), 92535882, 68255934, 75269);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (19712630, 'Environmental adaptability', 'Closed', to_date('28-07-2022', 'dd-mm-yyyy'), to_date('17-03-2024', 'dd-mm-yyyy'), 81525413, 95607525, 55544);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (72214628, 'Vulnerability to cyber attacks', 'Closed', to_date('02-09-2022', 'dd-mm-yyyy'), to_date('25-08-2023', 'dd-mm-yyyy'), 62933363, 63310475, 95858);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (27238890, 'Vulnerability to cyber attacks', 'Open', to_date('26-02-2023', 'dd-mm-yyyy'), to_date('28-11-2023', 'dd-mm-yyyy'), 16354941, 76805170, 62272);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (91228383, 'Vulnerability to cyber attacks', 'Closed', to_date('19-07-2022', 'dd-mm-yyyy'), to_date('05-04-2024', 'dd-mm-yyyy'), 52321215, 40664733, 64062);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (46119033, 'Environmental adaptability', 'Closed', to_date('08-05-2022', 'dd-mm-yyyy'), to_date('08-09-2023', 'dd-mm-yyyy'), 27044249, 83387331, 19470);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (81324986, 'Interception accuracy', 'Pending', to_date('07-02-2023', 'dd-mm-yyyy'), to_date('09-03-2024', 'dd-mm-yyyy'), 28411817, 40279638, 64064);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (49225794, 'Vulnerability to cyber attacks', 'Open', to_date('22-01-2023', 'dd-mm-yyyy'), to_date('29-12-2023', 'dd-mm-yyyy'), 13629800, 50974786, 69446);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (90220880, 'Supply chain security', 'Open', to_date('12-06-2022', 'dd-mm-yyyy'), to_date('04-01-2024', 'dd-mm-yyyy'), 33133087, 21006417, 55446);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (24986168, 'Communication latency', 'Resolved', to_date('30-05-2022', 'dd-mm-yyyy'), to_date('25-02-2024', 'dd-mm-yyyy'), 64207208, 34179616, 59211);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (35691818, 'Maintenance and operational costs', 'Pending', to_date('24-02-2023', 'dd-mm-yyyy'), to_date('04-05-2023', 'dd-mm-yyyy'), 55819347, 37896029, 30084);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (96201124, 'Interception accuracy', 'Escalated', to_date('09-08-2022', 'dd-mm-yyyy'), to_date('22-05-2023', 'dd-mm-yyyy'), 52321215, 92724719, 16048);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (92548936, 'Supply chain security', 'Open', to_date('09-06-2022', 'dd-mm-yyyy'), to_date('06-10-2023', 'dd-mm-yyyy'), 63442847, 39457119, 1546);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (94933581, 'Environmental adaptability', 'Closed', to_date('11-02-2023', 'dd-mm-yyyy'), to_date('22-05-2023', 'dd-mm-yyyy'), 62526376, 25470185, 93493);
insert into SUPPORT_TICKET (ticketid, issuedescription, status, createddate, resolveddate, customerid, accountmanagerid, machine_id)
values (94983015, 'Environmental adaptability', 'Pending', to_date('16-01-2022', 'dd-mm-yyyy'), to_date('22-02-2024', 'dd-mm-yyyy'), 96895448, 85894488, 94041);
commit;
prompt 200 records loaded
prompt Loading SUPPORT_TICKET_TOOL...
insert into SUPPORT_TICKET_TOOL (ticket_id, tool_id)
values (77849654, 39694);
insert into SUPPORT_TICKET_TOOL (ticket_id, tool_id)
values (61282769, 9718);
insert into SUPPORT_TICKET_TOOL (ticket_id, tool_id)
values (78731023, 36368);
insert into SUPPORT_TICKET_TOOL (ticket_id, tool_id)
values (48784419, 12152);
insert into SUPPORT_TICKET_TOOL (ticket_id, tool_id)
values (24969419, 67612);
insert into SUPPORT_TICKET_TOOL (ticket_id, tool_id)
values (29812682, 19324);
insert into SUPPORT_TICKET_TOOL (ticket_id, tool_id)
values (44839379, 2118);
insert into SUPPORT_TICKET_TOOL (ticket_id, tool_id)
values (60554752, 62686);
insert into SUPPORT_TICKET_TOOL (ticket_id, tool_id)
values (91269522, 92520);
insert into SUPPORT_TICKET_TOOL (ticket_id, tool_id)
values (14536211, 94302);
insert into SUPPORT_TICKET_TOOL (ticket_id, tool_id)
values (29196347, 45244);
insert into SUPPORT_TICKET_TOOL (ticket_id, tool_id)
values (18373426, 18210);
insert into SUPPORT_TICKET_TOOL (ticket_id, tool_id)
values (26958413, 85857);
insert into SUPPORT_TICKET_TOOL (ticket_id, tool_id)
values (39089852, 37754);
insert into SUPPORT_TICKET_TOOL (ticket_id, tool_id)
values (55786629, 86417);
insert into SUPPORT_TICKET_TOOL (ticket_id, tool_id)
values (42343903, 60342);
insert into SUPPORT_TICKET_TOOL (ticket_id, tool_id)
values (66762756, 82420);
insert into SUPPORT_TICKET_TOOL (ticket_id, tool_id)
values (33222114, 24492);
insert into SUPPORT_TICKET_TOOL (ticket_id, tool_id)
values (29175739, 63130);
insert into SUPPORT_TICKET_TOOL (ticket_id, tool_id)
values (70276377, 42441);
insert into SUPPORT_TICKET_TOOL (ticket_id, tool_id)
values (40136068, 94302);
insert into SUPPORT_TICKET_TOOL (ticket_id, tool_id)
values (41635474, 38466);
insert into SUPPORT_TICKET_TOOL (ticket_id, tool_id)
values (67628147, 37585);
insert into SUPPORT_TICKET_TOOL (ticket_id, tool_id)
values (34899600, 62121);
insert into SUPPORT_TICKET_TOOL (ticket_id, tool_id)
values (14536211, 59095);
insert into SUPPORT_TICKET_TOOL (ticket_id, tool_id)
values (65031041, 23018);
insert into SUPPORT_TICKET_TOOL (ticket_id, tool_id)
values (73966461, 48215);
insert into SUPPORT_TICKET_TOOL (ticket_id, tool_id)
values (90220880, 68013);
insert into SUPPORT_TICKET_TOOL (ticket_id, tool_id)
values (64141853, 64546);
insert into SUPPORT_TICKET_TOOL (ticket_id, tool_id)
values (53749795, 88387);
insert into SUPPORT_TICKET_TOOL (ticket_id, tool_id)
values (59223712, 18210);
insert into SUPPORT_TICKET_TOOL (ticket_id, tool_id)
values (91661343, 31496);
insert into SUPPORT_TICKET_TOOL (ticket_id, tool_id)
values (77586753, 58151);
insert into SUPPORT_TICKET_TOOL (ticket_id, tool_id)
values (52688957, 93745);
insert into SUPPORT_TICKET_TOOL (ticket_id, tool_id)
values (39216944, 11855);
insert into SUPPORT_TICKET_TOOL (ticket_id, tool_id)
values (14974418, 87087);
insert into SUPPORT_TICKET_TOOL (ticket_id, tool_id)
values (44198239, 72974);
insert into SUPPORT_TICKET_TOOL (ticket_id, tool_id)
values (73844950, 37754);
insert into SUPPORT_TICKET_TOOL (ticket_id, tool_id)
values (26958413, 95719);
insert into SUPPORT_TICKET_TOOL (ticket_id, tool_id)
values (79234640, 91585);
insert into SUPPORT_TICKET_TOOL (ticket_id, tool_id)
values (34899600, 9622);
insert into SUPPORT_TICKET_TOOL (ticket_id, tool_id)
values (68502985, 92546);
insert into SUPPORT_TICKET_TOOL (ticket_id, tool_id)
values (27122135, 78747);
insert into SUPPORT_TICKET_TOOL (ticket_id, tool_id)
values (40484102, 21791);
insert into SUPPORT_TICKET_TOOL (ticket_id, tool_id)
values (98727756, 47342);
insert into SUPPORT_TICKET_TOOL (ticket_id, tool_id)
values (19131770, 59294);
insert into SUPPORT_TICKET_TOOL (ticket_id, tool_id)
values (80073705, 82594);
insert into SUPPORT_TICKET_TOOL (ticket_id, tool_id)
values (64682469, 18769);
insert into SUPPORT_TICKET_TOOL (ticket_id, tool_id)
values (60051393, 22636);
insert into SUPPORT_TICKET_TOOL (ticket_id, tool_id)
values (44574198, 92520);
insert into SUPPORT_TICKET_TOOL (ticket_id, tool_id)
values (25581313, 98507);
insert into SUPPORT_TICKET_TOOL (ticket_id, tool_id)
values (61906229, 71881);
insert into SUPPORT_TICKET_TOOL (ticket_id, tool_id)
values (32366595, 99420);
insert into SUPPORT_TICKET_TOOL (ticket_id, tool_id)
values (73924675, 34928);
insert into SUPPORT_TICKET_TOOL (ticket_id, tool_id)
values (60554752, 47342);
insert into SUPPORT_TICKET_TOOL (ticket_id, tool_id)
values (93066430, 81786);
insert into SUPPORT_TICKET_TOOL (ticket_id, tool_id)
values (46086848, 33510);
insert into SUPPORT_TICKET_TOOL (ticket_id, tool_id)
values (45750835, 84672);
insert into SUPPORT_TICKET_TOOL (ticket_id, tool_id)
values (84924076, 63160);
insert into SUPPORT_TICKET_TOOL (ticket_id, tool_id)
values (75677020, 65297);
commit;
prompt 60 records loaded
prompt Loading WAREHOUSES...
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (726696, 'Evansville', 13511, 5752);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (579426, 'Downey', 13414, 7967);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (781435, 'MN', 12168, 6920);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (525482, 'Arvada', 12443, 5500);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (3888, 'Reno', 10638, 7240);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (25416, 'Huntington Beach', 13374, 9677);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (316728, 'Midland', 14548, 5579);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (680278, 'Pompano Beach', 14444, 9443);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (430533, 'CA', 13637, 7936);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (780387, 'FL', 10671, 9227);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (99644, 'CA', 13742, 7343);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (217444, 'CA', 12875, 9006);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (190519, 'VA', 10336, 6597);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (209133, 'NC', 13247, 7188);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (562600, 'Mobile', 13646, 8798);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (836242, 'MI', 12490, 6307);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (761671, 'Norman', 10309, 5694);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (392265, 'ND', 13522, 6523);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (525713, 'NC', 11619, 8846);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (545510, 'Thornton', 11736, 6946);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (103267, 'Augusta', 13310, 8601);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (313716, 'Boston', 11831, 9767);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (384291, 'Kent', 11918, 5882);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (851152, 'CA', 11195, 7194);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (843523, 'Buffalo', 12707, 6784);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (48238, 'NY', 14863, 6217);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (296339, 'CA', 14139, 9989);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (943642, 'WA', 12021, 6174);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (467108, 'NJ', 13929, 6986);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (948904, 'CA', 14095, 9126);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (370057, 'CT', 11648, 5117);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (885529, 'Salt Lake City', 14376, 8056);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (502628, 'Ann Arbor', 12895, 8418);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (834608, 'Gilbert', 14232, 7876);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (851339, 'TN', 10027, 6282);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (798926, 'Oklahoma City', 10866, 9240);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (710142, 'Rochester', 14457, 9941);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (177565, 'CO', 11645, 5180);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (311279, 'Berkeley', 10506, 6742);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (53021, 'Bend', 14986, 5546);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (268649, 'CA', 10832, 7259);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (290808, 'Arvada', 12808, 9265);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (833660, 'Huntington Beach', 13403, 5192);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (451569, 'OH', 14548, 9402);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (963595, 'Sugar Land', 10046, 5104);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (515690, 'Conroe', 12733, 6052);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (202465, 'Lincoln', 11558, 7949);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (420400, 'IA', 10123, 7025);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (374373, 'Cape Coral', 14368, 9426);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (409387, 'Midland', 13411, 6355);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (89370, 'Visalia', 13775, 6138);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (194909, 'Green Bay', 13482, 5618);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (61818, 'Moreno Valley', 13743, 9573);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (932394, 'KS', 12246, 8062);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (241246, 'OR', 13257, 7883);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (7564, 'Costa Mesa', 11025, 5551);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (755713, 'San Bernardino', 14240, 5488);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (636027, 'MA', 10499, 8323);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (667662, 'VA', 11042, 5490);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (275403, 'Santa Rosa', 12226, 7552);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (542285, 'KS', 11480, 9893);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (849920, 'Reading', 11716, 5737);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (828379, 'CA', 14446, 7641);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (787534, 'Greenville', 13068, 9891);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (51708, 'MN', 14079, 5471);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (869530, 'Paterson', 10173, 7544);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (820857, 'MN', 10494, 6574);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (892637, 'Fairfield', 14480, 5568);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (645599, 'FL', 12082, 7064);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (143634, 'NV', 14313, 6805);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (567747, 'Surprise', 14362, 5275);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (686460, 'Fargo', 10772, 9508);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (604521, 'Augusta', 10404, 8852);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (461826, 'WA', 10176, 9599);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (4400, 'NE', 12812, 9666);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (199322, 'CO', 13080, 5736);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (315483, 'WA', 12265, 6541);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (142025, 'AZ', 14848, 7199);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (266356, 'Elgin', 12630, 5789);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (583612, 'WA', 12795, 9576);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (459440, 'Clearwater', 12628, 9559);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (217968, 'NJ', 14889, 8271);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (876857, 'Clearwater', 14066, 6997);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (301292, 'West Covina', 10006, 9828);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (198790, 'Glendale', 11636, 8230);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (626711, 'Cary', 14774, 6053);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (934337, 'CA', 14268, 6140);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (311390, 'Thornton', 11937, 5965);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (364878, 'DC', 13051, 5975);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (396134, 'Durham', 10331, 5548);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (299926, 'MO', 10719, 7753);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (257507, 'Stockton', 11380, 5317);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (645493, 'Detroit', 12691, 6490);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (832433, 'Indianapolis', 12181, 5706);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (784948, 'CA', 14681, 5240);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (655314, 'Pembroke Pines', 10139, 5255);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (772372, 'NC', 11866, 5938);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (707629, 'FL', 14170, 6619);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (338425, 'Sterling Heights', 14624, 8069);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (80053, 'Aurora', 12462, 5383);
commit;
prompt 100 records committed...
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (708695, 'Seattle', 10818, 5135);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (447058, 'Fairfield', 11806, 6700);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (234571, 'Costa Mesa', 14668, 8951);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (354033, 'NY', 13481, 9725);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (836587, 'Birmingham', 12156, 6737);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (316881, 'CA', 10705, 9878);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (260297, 'San Antonio', 13021, 6035);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (734137, 'Coral Springs', 12651, 8908);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (144621, 'Elk Grove', 14296, 7431);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (611576, 'TX', 10020, 7778);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (902711, 'San Jose', 10416, 5090);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (99319, 'Riverside', 12185, 7356);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (415311, 'Arlington', 14895, 5115);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (841443, 'WA', 10883, 6918);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (536613, 'Chicago', 13547, 6696);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (138098, 'Tyler', 10491, 5473);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (21352, 'NC', 12101, 6566);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (477951, 'IL', 14231, 6799);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (691060, 'CA', 13447, 8285);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (550467, 'CA', 13732, 5304);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (466503, 'AL', 14792, 8059);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (53412, 'Rochester', 13111, 8857);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (257941, 'Ontario', 12403, 5308);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (485020, 'Frisco', 13692, 6677);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (892374, 'Cleveland', 11513, 5828);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (275962, 'CA', 13975, 5442);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (218108, 'West Valley City', 10640, 8410);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (420202, 'Palm Bay', 13498, 8578);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (391853, 'Hialeah', 12478, 9290);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (918354, 'TX', 13258, 8354);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (978345, 'CA', 11349, 9405);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (33549, 'Springfield', 12687, 5795);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (862446, 'Manchester', 12217, 9461);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (359784, 'CA', 13205, 8415);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (973758, 'Omaha', 11262, 7813);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (702791, 'KS', 13319, 5740);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (823731, 'WI', 13022, 6157);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (773391, 'FL', 10301, 7669);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (855271, 'Waterbury', 14089, 8040);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (693356, 'CA', 13415, 5631);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (604854, 'Waco', 13379, 5173);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (313765, 'MO', 13715, 6561);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (677130, 'IN', 13953, 6568);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (345866, 'Virginia Beach', 10397, 9686);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (532034, 'AZ', 11409, 5474);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (304436, 'San Bernardino', 13730, 6125);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (84399, 'Buffalo', 13832, 9141);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (263638, 'NC', 14525, 6304);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (116059, 'Westminster', 13306, 6379);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (425382, 'OR', 10188, 5177);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (500463, 'St. Louis', 13993, 7951);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (500184, 'Thousand Oaks', 12329, 5262);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (239786, 'Springfield', 11769, 9754);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (900525, 'MA', 10924, 7496);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (314530, 'Dallas', 10428, 8832);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (746712, 'TN', 10055, 9891);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (345644, 'IL', 14447, 7193);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (685235, 'CA', 10201, 9014);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (69125, 'Hayward', 13301, 8440);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (519627, 'Frisco', 12098, 9272);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (623131, 'TX', 12369, 7212);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (653823, 'Eugene', 12154, 5006);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (647594, 'Fresno', 10371, 6445);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (348025, 'Peoria', 14438, 5417);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (196320, 'Buffalo', 13389, 7433);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (787050, 'Kent', 14220, 7276);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (461605, 'Clearwater', 10441, 7717);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (961200, 'Modesto', 13081, 5466);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (311346, 'CA', 10618, 6771);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (359618, 'Clearwater', 10581, 6339);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (638644, 'SC', 11790, 9514);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (476144, 'Clovis', 12494, 8866);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (523921, 'CA', 10864, 7623);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (127678, 'North Charleston', 10599, 8619);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (209521, 'MO', 10613, 8668);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (585038, 'Allentown', 14044, 9557);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (886825, 'TX', 13067, 8054);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (516323, 'TX', 12256, 8626);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (295861, 'Tucson', 14459, 8775);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (742764, 'Denton', 14435, 8169);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (137409, 'Jacksonville', 11740, 8986);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (807093, 'OR', 10587, 6151);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (297613, 'TN', 10662, 7380);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (354396, 'Temecula', 14144, 9202);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (885092, 'MS', 10405, 6386);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (325475, 'Sparks', 11122, 8453);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (80546, 'Mesa', 14789, 8168);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (962704, 'NC', 10862, 8214);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (798866, 'Meridian', 10029, 8451);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (628397, 'Columbus', 13321, 7439);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (163748, 'Escondido', 14070, 8146);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (435656, 'Abilene', 12930, 9014);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (794794, 'TX', 12464, 7798);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (691737, 'Columbia', 14013, 6860);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (907128, 'Coral Springs', 10835, 9837);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (153911, 'Chesapeake', 12771, 5842);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (223506, 'SC', 13882, 8649);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (97816, 'TN', 10829, 9496);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (698917, 'AL', 10959, 8460);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (198325, 'Fargo', 10338, 5561);
commit;
prompt 200 records committed...
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (57704, 'Sunnyvale', 13215, 9022);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (222899, 'TX', 10649, 9340);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (143163, 'Costa Mesa', 12291, 9126);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (537450, 'Fresno', 11543, 9846);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (79661, 'Berkeley', 10590, 7914);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (424699, 'NC', 13030, 8791);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (247237, 'Durham', 13097, 9018);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (215035, 'IL', 11699, 7364);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (68719, 'TX', 10769, 7494);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (229873, 'Boulder', 13647, 5837);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (609328, 'Little Rock', 10492, 9585);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (537519, 'Toledo', 13955, 5972);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (988790, 'Cambridge', 11586, 5284);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (521523, 'IL', 12733, 6247);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (605947, 'Birmingham', 13886, 8723);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (261542, 'WA', 12732, 9896);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (175861, 'Cleveland', 12381, 6353);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (412620, 'CA', 14292, 6095);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (920103, 'Spokane', 14841, 5888);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (612001, 'MO', 13507, 8429);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (536069, 'Boulder', 10612, 6835);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (69456, 'FL', 13946, 7267);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (351996, 'TX', 12289, 7542);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (841567, 'TX', 14225, 7048);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (163394, 'PA', 13664, 5369);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (675169, 'CA', 14868, 8302);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (419882, 'OR', 10919, 6182);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (388199, 'Victorville', 10907, 5687);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (262306, 'CO', 12268, 7551);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (63060, 'San Antonio', 11063, 8841);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (372342, 'Lexington', 14148, 9751);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (52479, 'WI', 13470, 6040);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (634609, 'Irving', 13993, 9585);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (797869, 'IA', 12971, 5676);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (611277, 'Clinton', 14555, 7013);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (460186, 'Lincoln', 14979, 5544);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (829177, 'Glendale', 14793, 9596);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (363286, 'IA', 10893, 9941);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (879409, 'El Paso', 12325, 9749);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (249792, 'AZ', 10086, 9575);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (329455, 'VA', 12441, 9814);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (349445, 'Columbia', 13443, 9296);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (447781, 'NY', 13682, 9938);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (259968, 'CA', 13472, 8628);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (740955, 'NC', 14973, 8765);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (640423, 'Portland', 10973, 5119);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (303253, 'TX', 14328, 6946);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (717076, 'Aurora', 13273, 5508);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (978764, 'CA', 14115, 8454);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (601747, 'MO', 14017, 9693);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (336009, 'Fargo', 12878, 9717);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (422677, 'TX', 14528, 7520);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (455038, 'WI', 13731, 6557);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (267885, 'CA', 11727, 8387);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (527051, 'Costa Mesa', 14303, 8954);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (941025, 'CA', 12614, 8650);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (266500, 'Durham', 13256, 8605);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (529751, 'PA', 10312, 6852);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (135703, 'Columbia', 13361, 9313);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (786570, 'Fairfield', 11680, 6757);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (381947, 'Los Angeles', 11133, 5173);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (322207, 'AK', 11474, 8204);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (887106, 'TX', 13039, 6586);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (611459, 'TX', 13088, 5761);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (829745, 'Green Bay', 13253, 9070);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (811558, 'MD', 10843, 5210);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (159728, 'ME', 12989, 9893);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (393030, 'Wichita Falls', 13850, 7828);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (885330, 'Allentown', 11387, 7519);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (583054, 'Glendale', 11421, 7484);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (172850, 'VA', 12965, 8862);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (621321, 'MN', 10062, 5557);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (258710, 'Pearland', 11630, 9354);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (828393, 'Palmdale', 12013, 8661);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (174077, 'Cedar Rapids', 11260, 5825);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (486563, 'TX', 10350, 9174);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (281961, 'Austin', 12837, 7201);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (533215, 'CA', 10667, 8596);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (626833, 'Carlsbad', 13149, 8002);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (66682, 'Fontana', 14298, 8708);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (96730, 'CA', 10055, 9668);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (664607, 'PA', 13114, 5545);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (397864, 'Glendale', 14316, 9685);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (514800, 'Greenville', 10887, 6189);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (841735, 'CA', 12971, 8531);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (358601, 'Des Moines', 11201, 8359);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (944735, 'Newport News', 14301, 9431);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (246736, 'FL', 11940, 7832);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (840264, 'AZ', 14337, 5923);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (107676, 'High Point', 11332, 8663);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (503333, 'Killeen', 14935, 7245);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (128500, 'FL', 10553, 6222);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (787675, 'CA', 13417, 6522);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (948251, 'Fort Lauderdale', 12903, 8049);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (275361, 'CA', 13773, 6774);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (663801, 'CA', 14533, 7506);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (938898, 'FL', 14421, 9737);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (648199, 'Lowell', 11741, 5262);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (615847, 'FL', 12538, 7487);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (181542, 'MS', 14835, 8575);
commit;
prompt 300 records committed...
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (295931, 'CA', 14943, 6893);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (894329, 'CA', 13543, 8391);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (220639, 'New Haven', 10554, 6865);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (23323, 'Wichita Falls', 14004, 9257);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (795342, 'CO', 14398, 8426);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (479903, 'Akron', 12309, 7048);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (313901, 'Santa Clarita', 13187, 7591);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (730935, 'Columbus', 14608, 9502);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (495772, 'CO', 12458, 6062);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (492123, 'Escondido', 13783, 9566);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (835621, 'St. Petersburg', 10277, 9735);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (233870, 'Seattle', 12676, 6566);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (765430, 'CA', 12496, 5012);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (499638, 'CA', 13889, 5176);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (629107, 'CA', 14583, 7942);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (36810, 'UT', 11138, 7208);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (469597, 'IL', 10012, 6154);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (740044, 'Odessa', 12172, 6206);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (628488, 'Gilbert', 10214, 8621);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (407136, 'College Station', 13260, 9868);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (158123, 'Jackson', 11085, 8223);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (307380, 'Columbus', 10230, 5258);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (46210, 'NE', 11070, 7130);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (562424, 'CA', 11082, 6856);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (252929, 'FL', 10796, 9996);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (339632, 'Abilene', 10155, 7400);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (560542, 'Arvada', 14279, 9964);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (857942, 'IL', 13859, 6547);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (235506, 'Shreveport', 11677, 7484);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (206230, 'Columbus', 12970, 7354);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (503074, 'MO', 13631, 6945);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (974158, 'Fargo', 11490, 5559);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (834414, 'IL', 12141, 6116);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (695549, 'CA', 12064, 6685);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (46214, 'CT', 13023, 8406);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (104233, 'Lafayette', 12965, 5946);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (212787, 'Beaumont', 14923, 7928);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (202412, 'Downey', 11635, 5982);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (390690, 'FL', 14890, 7381);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (141521, 'AZ', 14798, 7385);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (155826, 'KS', 10516, 8748);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (915584, 'Detroit', 10122, 7054);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (953054, 'Saint Paul', 13643, 6793);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (867075, 'CO', 14463, 9359);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (258304, 'OK', 10613, 5387);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (5278, 'Chula Vista', 13647, 5110);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (553176, 'Chattanooga', 14110, 6637);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (137143, 'WA', 13836, 8351);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (112062, 'CO', 11536, 7827);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (810649, 'FL', 14445, 5953);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (601745, 'Corona', 14972, 6174);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (70666, 'NY', 12627, 5029);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (493514, 'Lubbock', 12682, 6402);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (27303, 'Boston', 14313, 8162);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (287772, 'CA', 12198, 6114);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (236781, 'TN', 11822, 6432);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (551144, 'Sioux City', 14954, 8993);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (894784, 'New York', 13036, 5281);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (766087, 'Springfield', 12486, 5803);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (842322, 'TX', 12121, 8159);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (993004, 'Bakersfield', 14202, 8211);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (384088, 'AZ', 11832, 8011);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (344844, 'CA', 11698, 5414);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (919317, 'WA', 12369, 6555);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (274220, 'FL', 14660, 8587);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (385151, 'Kansas City', 11789, 6389);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (673012, 'West Valley City', 13301, 8134);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (512490, 'Gresham', 13001, 5900);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (784483, 'Clearwater', 12385, 8759);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (894357, 'Spokane', 12298, 6986);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (927883, 'Irvine', 11799, 7346);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (866758, 'Knoxville', 14476, 5597);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (35562, 'Fresno', 13691, 8656);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (202037, 'Mesa', 14494, 5083);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (2572, 'MI', 11174, 8825);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (614737, 'Antioch', 10713, 7358);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (848787, 'Pompano Beach', 13589, 6691);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (79964, 'CA', 14691, 6870);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (693507, 'NV', 13326, 7919);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (964236, 'CA', 12534, 7392);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (542567, 'AZ', 14222, 6946);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (968856, 'CA', 12824, 6622);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (887944, 'Newark', 11503, 6739);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (885760, 'FL', 11095, 8593);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (119875, 'Clinton', 13306, 6359);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (165881, 'McKinney', 10882, 8897);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (751456, 'Palmdale', 13747, 6346);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (300008, 'CA', 11327, 7725);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (455758, 'UT', 12566, 6911);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (12147, 'Irving', 11348, 5715);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (915435, 'NC', 11325, 8941);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (265377, 'SC', 10373, 7615);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (484832, 'San Diego', 11172, 7816);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (80211, 'Westminster', 10634, 8754);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (664596, 'Aurora', 12170, 5044);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (165456, 'Norman', 11026, 9335);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (388783, 'CA', 14181, 7705);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (361572, 'IL', 12524, 6528);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (124472, 'Concord', 14319, 5696);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (896531, 'TN', 10165, 9391);
commit;
prompt 400 records loaded
prompt Enabling foreign key constraints for CUSTOMERS...
alter table CUSTOMERS enable constraint FK_CUSTOMER;
prompt Enabling foreign key constraints for AIR_ORDER...
alter table AIR_ORDER enable constraint FK_ORDER_;
prompt Enabling foreign key constraints for CUSTOMER_RAW_MATERIALS...
alter table CUSTOMER_RAW_MATERIALS enable constraint SYS_C0010561;
alter table CUSTOMER_RAW_MATERIALS enable constraint SYS_C0010562;
prompt Enabling foreign key constraints for MACHINES...
alter table MACHINES enable constraint FK_CUSTOMER_ID;
alter table MACHINES enable constraint SYS_C0010518;
prompt Enabling foreign key constraints for ORDER_MACHINE...
alter table ORDER_MACHINE enable constraint SYS_C0010551;
alter table ORDER_MACHINE enable constraint SYS_C0010552;
prompt Enabling foreign key constraints for ORDER_TOOL...
alter table ORDER_TOOL enable constraint SYS_C0010556;
alter table ORDER_TOOL enable constraint SYS_C0010557;
prompt Enabling foreign key constraints for PART_OF...
alter table PART_OF enable constraint FK_PART_OF;
alter table PART_OF enable constraint FK_PART_OF2;
prompt Enabling foreign key constraints for PAYMENT...
alter table PAYMENT enable constraint FK_PAYMENT;
prompt Enabling foreign key constraints for PRODUCTION_ORDERS...
alter table PRODUCTION_ORDERS enable constraint FK_ACCOUNT_MANAGER_ID;
alter table PRODUCTION_ORDERS enable constraint SYS_C0010532;
prompt Enabling foreign key constraints for SUPPORT_TICKET...
alter table SUPPORT_TICKET enable constraint FK_MACHINE_ID;
alter table SUPPORT_TICKET enable constraint FK_SUPPORT_TICKET;
alter table SUPPORT_TICKET enable constraint FK_SUPPORT_TICKET2;
prompt Enabling foreign key constraints for SUPPORT_TICKET_TOOL...
alter table SUPPORT_TICKET_TOOL enable constraint SYS_C0010566;
alter table SUPPORT_TICKET_TOOL enable constraint SYS_C0010567;
prompt Enabling triggers for ACCOUNT_MANAGER...
alter table ACCOUNT_MANAGER enable all triggers;
prompt Enabling triggers for CUSTOMERS...
alter table CUSTOMERS enable all triggers;
prompt Enabling triggers for AIR_ORDER...
alter table AIR_ORDER enable all triggers;
prompt Enabling triggers for RAW_MATERIALS...
alter table RAW_MATERIALS enable all triggers;
prompt Enabling triggers for CUSTOMER_RAW_MATERIALS...
alter table CUSTOMER_RAW_MATERIALS enable all triggers;
prompt Enabling triggers for MACHINE_MAINTENANCE...
alter table MACHINE_MAINTENANCE enable all triggers;
prompt Enabling triggers for MACHINES...
alter table MACHINES enable all triggers;
prompt Enabling triggers for ORDER_MACHINE...
alter table ORDER_MACHINE enable all triggers;
prompt Enabling triggers for TOOLS...
alter table TOOLS enable all triggers;
prompt Enabling triggers for ORDER_TOOL...
alter table ORDER_TOOL enable all triggers;
prompt Enabling triggers for PRODUCT...
alter table PRODUCT enable all triggers;
prompt Enabling triggers for PART_OF...
alter table PART_OF enable all triggers;
prompt Enabling triggers for PAYMENT...
alter table PAYMENT enable all triggers;
prompt Enabling triggers for PRODUCTION_ORDERS...
alter table PRODUCTION_ORDERS enable all triggers;
prompt Enabling triggers for SUPPORT_TICKET...
alter table SUPPORT_TICKET enable all triggers;
prompt Enabling triggers for SUPPORT_TICKET_TOOL...
alter table SUPPORT_TICKET_TOOL enable all triggers;
prompt Enabling triggers for WAREHOUSES...
alter table WAREHOUSES enable all triggers;

set feedback on
set define on
prompt Done
