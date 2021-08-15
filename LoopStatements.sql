SET SERVEROUTPUT ON
DECLARE
  i  NUMBER := 1;
BEGIN
  LOOP
    --EXIT WHEN i > 5;    --- WHILE DO Loop 
    DBMS_OUTPUT.put_line(i);
    i := i + 1;
    EXIT WHEN i > 5; --- DO WHILE Loop 
  END LOOP;
END;
/