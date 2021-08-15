
DECLARE
    l_name customers.NAME%TYPE;
    l_customer_id customers.customer_id%TYPE := &customer_id;
BEGIN
    -- get the customer
    SELECT NAME INTO l_name
    FROM customers
    WHERE customer_id = l_customer_id;
    
    -- show the customer name   
    dbms_output.put_line('customer name is ' || l_name);

    EXCEPTION 
        WHEN NO_DATA_FOUND THEN
            dbms_output.put_line('Customer ' || l_customer_id ||  ' does not exist');
END;
/
