set pagesize 0
set linesize 10000
set trimspool on
set heading off
set feedback off
set flush off
set TERMOUT off
set pause on
spool consumer.csv
SELECT TRIM(' ' FROM IP.AT_F_SUBR_ID) || ';' ||
       TRIM(' ' FROM IP.ASSETTAG) || ';' ||
       TRIM(' ' FROM C.RBTACCTNO) || ';' || 
       TRIM(' ' FROM A.FIRST_NAME) || ';' ||
       TRIM(' ' FROM A.LAST_NAME) || ';' ||
       TRIM(' ' FROM CM.POSTAL)
FROM   PS_RF_INST_PROD IP,
       PS_RBT_ACCOUNT C,
       PS_BO_NAME A,
       PS_RD_PERSON B,
       PS_CM CM,
       PS_BO_CM BC
WHERE  A.BO_ID = B.BO_ID 
AND    C.RBTCUST_BO_ID = A.BO_ID 
AND    A.LAST_NAME_SRCH <> ' ' 
AND    A.LAST_NAME_SRCH <> 'UNBEKANNT'
AND    C.RBTACCTNO <> ' '
AND    IP.RBTACCTID = C.RBTACCTID
AND    IP.INST_PROD_STATUS IN ('INS','SUS')
AND    IP.ASSETTAG <> ' '
AND    CM.CM_TYPE_ID = 1
AND    BC.CM_ID = CM.CM_ID
AND    BC.BO_ID = B.BO_ID;
set spool off
