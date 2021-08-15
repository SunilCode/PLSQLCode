SET SERVEROUTPUT ON
DECLARE
  l_day  VARCHAR2(10);
BEGIN
  l_day := TRIM(TO_CHAR(SYSDATE, 'DAY'));
  
  IF l_day IN ('SATURDAY', 'SUNDAY') THEN
    DBMS_OUTPUT.put_line('It''s the weekend!');
  ELSE
    DBMS_OUTPUT.put_line('It''s not the weekend yet!');
  END IF;
END;
/