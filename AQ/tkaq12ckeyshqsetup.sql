Rem
Rem $Header: tkmain_8/tkaq/sql/tkaq12ckeyshqsetup.sql /main/1 2018/03/05 23:55:52 ichokshi Exp $
Rem
Rem tkaq12ckeyshqsetup.sql
Rem
Rem Copyright (c) 2018, Oracle and/or its affiliates. All rights reserved.
Rem
Rem    NAME
Rem      tkaq12ckeyshqsetup.sql - Sharded Queue Key Based Queue Setup 
Rem
Rem    DESCRIPTION
Rem      Pass two arguments : Queue Name and Init Shards.
Rem      This will create a multi consumer sharded queue and set
Rem      KEY_BASED_ENQUEUE and STICKY_DEQUEUE parameter
Rem
Rem    NOTES
Rem      Should be used by all Key Based Sharded Queue test cases for setup 
Rem
Rem    BEGIN SQL_FILE_METADATA
Rem    SQL_SOURCE_FILE: tkmain_8/tkaq/sql/tkaq12ckeyshqsetup.sql
Rem    SQL_SHIPPED_FILE:
Rem    SQL_PHASE:
Rem    SQL_STARTUP_MODE: NORMAL
Rem    SQL_IGNORABLE_ERRORS: NONE
Rem    SQL_CALLING_FILE:
Rem    END SQL_FILE_METADATA
Rem
Rem    MODIFIED   (MM/DD/YY)
Rem    ichokshi    02/19/18 - Created
Rem

SET ECHO ON
SET FEEDBACK 1
SET NUMWIDTH 10
SET LINESIZE 80
SET TRIMSPOOL ON
SET TAB OFF
SET PAGESIZE 100

define qname='&1'
define sname='&2'

set echo on; 
set serveroutput on; 
connect sys/knl_test7 as sysdba;

alter system set "_aq_init_shards"=1;
set echo on; 
set serveroutput on; 
drop user aq cascade;

create user aq identified by aq; 
grant resource , connect, unlimited tablespace to aq; 
grant execute on dbms_aq to aq; 
grant execute on dbms_aqadm to aq; 
grant execute on dbms_aqin to aq; 
grant execute on dbms_aqjms_internal to aq; 

connect aq/aq;

create or replace procedure createTopic(tName in varchar2)
as
begin
sys.dbms_aqadm.create_sharded_queue(queue_name=>tName,multiple_consumers=>TRUE);
sys.dbms_aqadm.start_queue(queue_name=>tName);
end;
/


create or replace procedure purgeQueue(qName in varchar2)
as
pCon varchar2(20);
pOp  dbms_aqadm.aq$_purge_options_t;
begin
pCon :='';
dbms_aqadm.purge_queue_table(queue_table=>qName,purge_condition=>pCon,purge_options=>pOp);
end;
/

create or replace procedure addSubscriber(qName in varchar2 , subName in varchar2)
as
begin
  dbms_aqadm.add_subscriber(qName,subscriber => sys.aq$_agent(subName,null,null));
end;
/


begin
 createTopic('&qname');
 addSubscriber('&qname','&sname');
end;
/

 
