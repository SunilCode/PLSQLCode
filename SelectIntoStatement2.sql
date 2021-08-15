DECLARE
  r_customer customers%ROWTYPE;
BEGIN
  -- get the information of the customer 100
  SELECT * INTO r_customer
  FROM customers
  WHERE customer_id = 10;
  -- show the customer info
  dbms_output.put_line( r_customer.name || ', website: ' || r_customer.website || ', Address:-'||r_customer.address );
END;