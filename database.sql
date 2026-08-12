
drop user HMTC_CHRS cascade;

DROP TABLESPACE DATA_CHRS INCLUDING CONTENTS AND DATAFILES;

create user HMTC_CHRS identified by devdb default tablespace DATA_CHRS;
grant create session to ZKNET;
grant connect,resource,dba,exp_full_database,imp_full_database to HMTC_CHRS;

grant execute on dbms_crypto to HMTC_CHRS;

ID: hrinform_sap    p@ssw0rd
ID: hrinform_vaatz   p@ssw0rd

select sid,serial# from v$session where username='test';


create tablespace DATA_CHRS
datafile 'E:\app\R5Z4731\oradata\orcl\DATA_CHRS.dbf'   
size 6000M
autoextend on next 200M maxsize 10000M;

select * from HR_EMP_HISTORY_STATUS as of timestamp to_timestamp('2017-1-9 12:01:00','YYYY-MM-DD HH24:MI:SS') WHERE STATUS_CODE IS NULL;

set NLS_LANG=AMERICAN_AMERICA.AL32UTF8

alter user kocenter quota unlimited on KO_CENTER_SPACE;

select 'alter table '||table_name||' allocate extent;' from user_tables where num_rows=0;

exp HMTC_CHRS/devdb@HMTC    BUFFER=64000 FILE=E:\HMTC20170630.dmp OWNER=HMTC_CHRS

IMP HMTC_CHRS/devdb    BUFFER=64000 FILE=E:\HMTC20170623.dmp FROMUSER=HMTC_CHRS TOUSER=HMTC_CHRS

IMP HMTC_CHRS/devdb BUFFER=64000 FILE=D:\SPC\db\spc_20170119.dmp FULL=Y 

expdp HMTC_CHRS/devdb@HMTC directory=DATA_PUMP_DIR dumpfile=HMTC20170503.dmp
impdp HMTC_CHRS/devdb@orcl directory=DATA_PUMP_DIR dumpfile=HMTC20170413.DMP remap_tablespace=SPC_CHRS:DATA_CHRS remap_schema=SPC_CHRS:HMTC_CHRS

create tablespace DATA_CHRS   
datafile 'E:/DATA_CHRS.dbf'
size 3000M   
autoextend on next 5M maxsize 10000M;

create user SPC_CHRS identified by devdb default tablespace DATA_CHRS;

grant connect,resource,dba,exp_full_database,imp_full_database to SPC_CHRS;

SELECT a.tablespace_name "表空间名",total 表空间大小,free 表空间剩余大小,
(total-free) 表空间使用大小,
ROUND((total-free)/total,4)*100 "使用率 %"
FROM  (SELECT tablespace_name,SUM(bytes) free FROM DBA_FREE_SPACE
GROUP BY tablespace_name ) a,
(SELECT tablespace_name,SUM(bytes) total FROM DBA_DATA_FILES
GROUP BY tablespace_name) b
WHERE a.tablespace_name=b.tablespace_name;

ALTER DATABASE DATAFILE 'D:\app\Administrator\oradata\orcl\DATA_CHRS.DBF' AUTOEXTEND ON NEXT 200M MAXSIZE 30000M;


select tablespace_name from sys.dba_tablespaces;



alter system checkpoint;
alter system switch logfile;


shutdown immediate;
siartup mount exclusive;

alter system enable res
alter database open;
alter dattabase national character set internal_use utf8;
shutdown immediate;
startup;


alter database character set internal_convert/internal_use utf8;
