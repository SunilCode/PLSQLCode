CREATE OR REPLACE PROCEDURE get_my_results (p_id IN NUMBER DEFAULT NULL)
AS
  l_cursor_1 SYS_REFCURSOR;
  l_cursor_2 SYS_REFCURSOR;
BEGIN
  IF p_id IS NOT NULL THEN
    OPEN l_cursor_1 FOR
      SELECT description, created_date
      FROM   t1
      WHERE  id = p_id;

    DBMS_SQL.RETURN_RESULT(l_cursor_1);
  END IF;
  OPEN l_cursor_2 FOR
    SELECT COUNT(*)
    FROM   t1;

  DBMS_SQL.RETURN_RESULT(l_cursor_2);
END;
/

EXEC get_my_results(1);
EXEC get_my_results;