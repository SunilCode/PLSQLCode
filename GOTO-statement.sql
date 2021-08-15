SET SERVEROUTPUT ON
DECLARE
  i  NUMBER := 1;
BEGIN
  LOOP
    IF i > 5 THEN
      GOTO exit_from_loop;
    END IF;
    DBMS_OUTPUT.put_line(i);
    i := i + 1;
  END LOOP;
  
  << exit_from_loop >>
  dbms_output.put_line('Outside For Loop');
  NULL;
END;
/