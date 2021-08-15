CREATE OR REPLACE PROCEDURE display_numbers (
  p_lower  IN   NUMBER,
  p_upper  IN   NUMBER)
AS
BEGIN
  FOR i IN p_lower .. p_upper LOOP
    DBMS_OUTPUT.put_line(i);
  END LOOP;
END;
/
 
SET SERVEROUTPUT ON
EXECUTE display_numbers(2, 6);