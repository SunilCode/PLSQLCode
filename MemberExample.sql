SET SERVEROUTPUT ON
DECLARE
  TYPE t_tab IS TABLE OF NUMBER;
  l_tab1 t_tab := t_tab(1,2,3,4,5);
BEGIN
  DBMS_OUTPUT.put('Is 3 MEMBER OF l_tab1? ');
  IF 3 MEMBER OF l_tab1 THEN
    DBMS_OUTPUT.put_line('TRUE');
  ELSE
    DBMS_OUTPUT.put_line('FALSE');  
  END IF;
END;
/