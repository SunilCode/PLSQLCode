CREATE OR REPLACE PACKAGE BODY my_package AS

PROCEDURE display_numbers (
  p_lower  IN   NUMBER,
  p_upper  IN   NUMBER)
AS
BEGIN
  FOR i IN p_lower .. p_upper LOOP
    DBMS_OUTPUT.put_line(i);
  END LOOP;
END;
  
FUNCTION difference (
  p_lower  IN   NUMBER,
  p_upper  IN   NUMBER)
  RETURN NUMBER
AS
BEGIN
  RETURN p_upper - p_lower;
END;

END;
/