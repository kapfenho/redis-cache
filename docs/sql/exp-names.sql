set pagesize 0
set linesize 10000
set trimspool on
set heading off
set feedback off
set flush off
set TERMOUT off
set pause on
spool out.txt
select '"' || trim(' ' from a.LAST_NAME_SRCH) || 
  '","' || trim(' ' from a.first_name_srch) ||
  '","' || c.RBTACCTNO || 
  '"' || CHR(13)
-- select trim(' ' from a.LAST_NAME_SRCH) || ',' trim(' ' from a.FIRST_NAME_SRCH), c.RBTACCTNO 
from PS_BO_NAME a, PS_RD_PERSON b, PS_RBT_ACCOUNT c 
where	a.BO_ID = b.BO_ID 
and c.RBTCUST_BO_ID = a.BO_ID 
and a.LAST_NAME_SRCH <> ' ' 
and a.LAST_NAME_SRCH <> 'UNBEKANNT'
and c.RBTACCTNO <> ' ';
set spool off

