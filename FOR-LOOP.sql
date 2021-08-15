SET SERVEROUTPUT ON
BEGIN
  FOR cur_rec IN (SELECT description
                  FROM   sql_test)
  LOOP
    DBMS_OUTPUT.put_line('cur_rec.description=' || cur_rec.description);
  END LOOP;
END;
/