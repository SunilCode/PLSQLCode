SET SERVEROUTPUT ON
DECLARE
  l_description  VARCHAR2(10);
BEGIN
  SELECT description
  INTO   l_description
  FROM   sql_test
  WHERE  id = 1;
  
  DBMS_OUTPUT.put_line('l_description=' || l_description);
END;
/