SET SERVEROUTPUT ON
DECLARE
  l_description  VARCHAR2(10);
  
  CURSOR c_data (p_id  IN  NUMBER) IS
    SELECT description
    FROM   sql_test
    WHERE  id = p_id;
BEGIN
  OPEN c_data (p_id => 2);
  FETCH c_data
  INTO  l_description;
  CLOSE c_data;

  DBMS_OUTPUT.put_line('l_description=' || l_description);
END;
/