set pagesize 0
set linesize 10000
set trimspool on
set heading off
set feedback off
set flush off
set TERMOUT off
set pause on
spool msisdn.txt
select trim(' ' from at_f_primsisdn) || 
  ',' || trim(' ' from rbtacctno) ||
  CHR(13)
from PS_RBT_ACCOUNT 
where at_f_primsisdn <> ' '
and rbtacctno <> ' ';
set spool off

