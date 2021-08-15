CREATE OR REPLACE FUNCTION difference (
  p_lower  IN   NUMBER,
  p_upper  IN   NUMBER)
  RETURN NUMBER
AS
BEGIN
  RETURN p_upper - p_lower;
END;
/
SET SERVEROUTPUT ON
VARIABLE l_result NUMBER
BEGIN
  :l_result := difference(2, 6);
END;
/

PRINT l_result;