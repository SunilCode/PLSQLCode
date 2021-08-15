CREATE OR REPLACE PACKAGE my_package AS

PROCEDURE display_numbers (
  p_lower  IN   NUMBER,
  p_upper  IN   NUMBER);
  
FUNCTION difference (
  p_lower  IN   NUMBER,
  p_upper  IN   NUMBER)
  RETURN NUMBER;

END;
/