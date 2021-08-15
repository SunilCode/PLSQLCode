DECLARE
  l_date  DATE;
BEGIN
  SELECT SYSDATE
  INTO   l_date
  FROM   dual
  WHERE  1=2; -- For zero rows
EXCEPTION
  WHEN NO_DATA_FOUND THEN   -- to handle ORA-01403: no data found
    NULL;
END;
/