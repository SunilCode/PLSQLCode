DECLARE
  l_customer_name customers.name%TYPE;
  l_contact_first_name contacts.first_name%TYPE;
  l_contact_last_name contacts.last_name%TYPE;
BEGIN
  -- get customer and contact names
  SELECT
    name, 
    first_name, 
    last_name
  INTO
    l_customer_name, 
    l_contact_first_name, 
    l_contact_last_name
  FROM
    customers
  INNER JOIN contacts USING( customer_id )
  WHERE
    customer_id = 100;
  -- show the information  
  dbms_output.put_line( 
    l_customer_name || ', Contact Person: ' ||
    l_contact_first_name || ' ' || l_contact_last_name );
END;