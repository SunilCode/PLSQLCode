SET SERVEROUTPUT ON
DECLARE
  l_description  VARCHAR2(10);
  
  CURSOR c_data IS
    SELECT description
    FROM   sql_test;
BEGIN
  OPEN c_data;
  LOOP
    FETCH c_data
    INTO  l_description;
    EXIT WHEN c_data%NOTFOUND;

    DBMS_OUTPUT.put_line('l_description=' || l_description);
  END LOOP;
  CLOSE c_data;
END;
/