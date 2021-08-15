Oracle - 19c
Password = admin
-----------------------------------------------------------------------------------
PL/SQL stands for “Procedural Language extensions to the Structured Query Language.
PL/SQL is an embedded language.
PL/SQL engine is in charge of compiling PL/SQL code into byte-code and executes the executable code.
PL/SQL block consists of three sections: declaration(optional), executable(mandatory), and exception-handling sections(optional).
PL/SQL block has a name, e.g. Functions , Procedures .
A named block is stored into the Oracle Database server and can be reused later.
A block without a name is an anonymous block. An anonymous block is not saved in the Oracle Database server, so it is just for one-time use.
Declaration Section(where you declare variables, allocate memory for cursors, and define data types)
Begin 
 Execution Section(The executable section must have a least one executable statement, even if it is the NULL statement which does nothing)
 Exception Section(where you catch and handle exceptions raised by the code in the execution section) 
End;
SET SERVEROUTPUT ON command so that the DBMS_OUTPUT.PUT_LINE procedure will display text on the screen.
forward slash ( /) to instruct SQL*Plus to execute the block.
DECLARE  ---declaration
      v_result NUMBER;
BEGIN  ---executable 
   v_result := 1 / 0;
   EXCEPTION -- exception
      WHEN ZERO_DIVIDE THEN
         DBMS_OUTPUT.PUT_LINE( SQLERRM );
END;
-----------------------------------------------------------------
PL/SQL Data Types -
1.Scalar - store single values such as 
Number - real numbers, integers, and floating-point numbers,BINARY_FLOAT,BINARY_DOUBLE,PLS_INTEGER datatype is specific to 
PL/SQL(Faster and Less Storage),BINARY_INTEGER.
Boolean - three data values: TRUE, FALSE, and NULL
Character - CHAR, VARCHAR2, LONG, RAW, LONG RAW, ROWID, and UROWID
Datetime - DATE, TIMESTAMP, TIMESTAMP WITH TIME ZONE, TIMESTAMP WITH LOCAL TIME ZONE, INTERVAL YEAR TO MONTH, and INTERVAL DAY TO SECOND.
2.Composite - store multiple values, for example, record and collection.
-------------------------------------------------------------------
PL/SQL Variables - 
In PL/SQL, a variable is named storage location that stores a value of a particular data type.
Before using a variable, you must declare it in the declaration section of a block.
DECLARE
  l_product_name VARCHAR2( 100 ) := 'Laptop'; --Variable assignments
  l_product_dname VARCHAR2(100) DEFAULT 'Mobile'; --Default values
  l_shipping_status VARCHAR2( 25 ) NOT NULL := 'Shipped'; --NOT NULL constraint
  l_customer_name customers.name%TYPE; -- Anchored declarations
BEGIN
  NULL;
END;
--------------------------------------------------------------------
PL/SQL Comments -
single-line comments (--)
multi-line comments(/* */)
--------------------------------------------------------------------
PL/SQL constants - 
constant holds a value that does not change throughout the execution of the program.
DECLARE
    co_payment_term   CONSTANT NUMBER   := 45; -- days 
    co_payment_status CONSTANT BOOLEAN  := FALSE; 
BEGIN
    NULL;
END;
---------------------------------------------------------------------
IF THEN/IF THEN ELSE/IF THEN ELSIF/Nested IF Statement - 
statement allows you to either execute or skip a sequence of statements, depending on a condition.
DECLARE
  n_sales NUMBER := 300000;
  n_commission NUMBER( 10, 2 ) := 0;
BEGIN
  IF n_sales > 200000 THEN
    n_commission := n_sales * 0.1;
  ELSIF n_sales <= 200000 AND n_sales > 100000 THEN 
    n_commission := n_sales * 0.05;
  ELSIF n_sales <= 100000 AND n_sales > 50000 THEN 
    n_commission := n_sales * 0.03;
  ELSE
    n_commission := n_sales * 0.02;
  END IF;
END;
-----------------------------------------------------------------------
CASE Statement -
The CASE statement has two types: simple CASE statement and searched CASE statement -
ELSE clause is optional, you can skip.
DECLARE
  n_sales      NUMBER;
  n_commission NUMBER;
BEGIN
  n_sales := 150000;
  CASE
  WHEN n_sales    > 200000 THEN
    n_commission := 0.2;
  WHEN n_sales   >= 100000 AND n_sales < 200000 THEN
    n_commission := 0.15;
  WHEN n_sales   >= 50000 AND n_sales < 100000 THEN
    n_commission := 0.1;
  WHEN n_sales    > 30000 THEN
    n_commission := 0.05;
  ELSE
    n_commission := 0;
  END CASE;

  DBMS_OUTPUT.PUT_LINE( 'Commission is ' || n_commission * 100 || '%'
  );
END;
---------------------------------------------------------------------------------
GOTO statement - 
The GOTO statement allows you to transfer control to a labeled block or statement.
Cannot use a GOTO statement to transfer control into an IF, CASE or LOOP statement, the same for sub-block.
BEGIN
  GOTO second_message;

  <<first_message>>
  DBMS_OUTPUT.PUT_LINE( 'Hello' );
  GOTO the_end;

  <<second_message>>
  DBMS_OUTPUT.PUT_LINE( 'PL/SQL GOTO Demo' );
  GOTO first_message;

  <<the_end>>
  DBMS_OUTPUT.PUT_LINE( 'and good bye...' );

END;
-----------------------------------------------------------------------------------
NULL statement - 
The NULL statement does nothing except that it passes control to the next statement.
IF job_title = 'Sales Representative' THEN
    send_email;
ELSE
    NULL;
END IF;
----------------------------------------------------------------------------------
LOOP statement -
The LOOP statement executes the statements in its body and returns control to the top of the loop.
the loop contains at least one EXIT or EXIT WHEN statement for terminating the loop. Otherwise, the loop becomes an infinite loop.
DECLARE
  l_counter NUMBER := 0;
BEGIN
  LOOP
    l_counter := l_counter + 1;
    IF l_counter > 3 THEN
      EXIT;
    END IF;
    dbms_output.put_line( 'Inside loop: ' || l_counter )  ;
  END LOOP;
  -- control resumes here after EXIT
  dbms_output.put_line( 'After loop: ' || l_counter );
END;
-----------------------------------------------------------------------------------
FOR LOOP statement - 
FOR LOOP executes a sequence of statements a specified number of times.
DECLARE
  l_counter PLS_INTEGER := 10;
BEGIN
  FOR l_counter IN 1.. 5 loop
    DBMS_OUTPUT.PUT_LINE (l_counter);
  end loop;
  -- after the loop
  DBMS_OUTPUT.PUT_LINE (l_counter);
END; 
-------------------------------------------------------------------------------------
WHILE Loop - 
WHILE loop statement to execute a sequence of statements as long as a specified condition is TRUE .
DECLARE
   n_counter NUMBER := 1;
BEGIN
   WHILE n_counter <= 5
      LOOP
        DBMS_OUTPUT.PUT_LINE( 'Counter : ' || n_counter );
        n_counter := n_counter + 1;
        EXIT WHEN n_counter = 3;
      END LOOP;
   END;
------------------------------------------------------------------------------------
CONTINUE Statement - 
CONTINUE or CONTINUE WHEN statement to exit the current loop iteration unconditionally or conditionally.
BEGIN
  FOR n_index IN 1 .. 10
  LOOP
    -- skip odd numbers
    IF MOD( n_index, 2 ) = 1 THEN
      CONTINUE;
    END IF;
    DBMS_OUTPUT.PUT_LINE( n_index );
  END LOOP;
END;
--------------------------------------------------------------------------------------
SELECT INTO statement -
the simplest and fastest way to fetch a single row from a table into variables.
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
Errors - 
ORA-00947: not enough values The INTO list contains fewer variables than the SELECT list.
ORA-00913: too many values The INTO list contains more variables than the SELECT list.
ORA-06502: PL/SQL: numeric or value error
---------------------------------------------------------------------------------------
Exceptions Block
PL/SQL treats all errors that occur in an anonymous block, procedure, or function as exceptions.
It is not possible to anticipate all potential exceptions, however, you can write code to handle 
exceptions to enable the program to continue running as normal.
A PL/SQL block can have an exception-handling section, which can have one or more exception handlers.
Exception categories - 
1.Internally defined exceptions are errors which arise from the Oracle Database environment. 
The runtime system raises the internally defined exceptions automatically. 
Internally defined exceptions do not have names, but an error code. - ORA-27102 (out of memory)
2.Predefined exceptions are errors which occur during the execution of the program. 
The predefined exceptions are internally defined exceptions that PL/SQL has given names e.g., NO_DATA_FOUND, TOO_MANY_ROWS.
3.User-defined exceptions are custom exception defined by users like you. User-defined exceptions must be raised explicitly.
DECLARE
    l_name customers.NAME%TYPE;
    l_customer_id customers.customer_id%TYPE := &customer_id;
BEGIN
    -- get the customer
    SELECT NAME INTO l_name
    FROM customers
    WHERE customer_id > l_customer_id;
    
    -- show the customer name   
    dbms_output.put_line('Customer name is ' || l_name);
    EXCEPTION 
        WHEN NO_DATA_FOUND THEN
            dbms_output.put_line('Customer ' || l_customer_id ||  ' does not exist');
        WHEN TOO_MANY_ROWS THEN
            dbms_output.put_line('The database returns more than one customer');    
END;
/
--------------------------------------------------------------------------------------
RAISE EXCEPTIONS - 
RAISE statement to raise a user-defined exception, internally defined exception, and reraising an exception.
1.Raise a user-defined exception(A user-defined exception is defined by users like you or other developers 
in the declaration section of a block or subprogram).
DECLARE
    e_credit_too_high EXCEPTION;
    PRAGMA exception_init( e_credit_too_high, -20001 );
    l_max_credit customers.credit_limit%TYPE;
    l_customer_id customers.customer_id%TYPE := &customer_id;
    l_credit customers.credit_limit%TYPE := &credit_limit;
BEGIN
    -- get the meax credit limit
    SELECT MAX(credit_limit) 
    INTO l_max_credit
    FROM customers;
    
    -- check if input credit is greater than the max credit
    IF l_credit > l_max_credit THEN 
        RAISE e_credit_too_high;
    END IF;
    
    -- if not, update credit limit
    UPDATE customers 
    SET credit_limit = l_credit
    WHERE customer_id = l_customer_id;
    
    COMMIT;
END;
/
2.Raise an internally defined exception.
Typically, the runtime system raises internally defined exceptions implicitly when they occur. Besides, 
you can explicitly raise an internally defined exception with the RAISE statement if the exception has a name:
DECLARE
    l_customer_id customers.customer_id%TYPE := &customer_id;
BEGIN
    -- get the meax credit limit
    IF l_customer_id < 0 THEN
        RAISE invalid_number;
    END IF;
END;
/
3.Reraising the current exception.
Reraising an exception passes it to the enclosing block, which later can be handled further. To reraise an exception, 
you don’t need to specify the exception name.
DECLARE
    e_credit_too_high EXCEPTION;
    PRAGMA exception_init( e_credit_too_high, -20001 );
    l_max_credit customers.credit_limit%TYPE;
    l_customer_id customers.customer_id%TYPE := &customer_id;
    l_credit customers.credit_limit%TYPE     := &credit_limit;
BEGIN
    BEGIN
        -- get the max credit limit
        SELECT MAX(credit_limit) 
        INTO l_max_credit
        FROM customers;
        
        -- check if input credit is greater than the max credit
        IF l_credit > l_max_credit THEN 
            RAISE e_credit_too_high;
        END IF;
        EXCEPTION
            WHEN e_credit_too_high THEN
                dbms_output.put_line('The credit is too high' || l_credit);
                RAISE; -- reraise the exception
    END;
EXCEPTION
    WHEN e_credit_too_high THEN
        -- get average credit limit
        SELECT avg(credit_limit) 
        into l_credit
        from customers;
        
        -- adjust the credit limit to the average
        dbms_output.put_line('Adjusted credit to ' || l_credit);
    
        --  update credit limit
        UPDATE customers 
        SET credit_limit = l_credit
        WHERE customer_id = l_customer_id;
   
        COMMIT;
END;
/
------------------------------------------------------------------------------------------
RAISE_APPLICATION_ERROR -
The procedure raise_application_error allows you to issue an user-defined error from a code block or stored program.
belongs to the package DBMS_STANDARD
Note that the changes made to the global data structure such as packaged variables, and database objects like tables 
will not be rolled back. Therefore, you must explicitly execute the ROLLBACK statement to reverse the effect of the DML.
DECLARE
    credit_limit_exceed EXCEPTION;
    PRAGMA exception_init(credit_limit_exceed, -20111);

    l_customer_id     customers.customer_id%TYPE := &customer_id;
    l_credit_limit    customers.credit_limit%TYPE := &credit_limit;

    l_customer_credit customers.credit_limit%TYPE;
    
BEGIN
    -- get customer credit limit
    SELECT credit_limit INTO l_customer_credit
    FROM customers
    WHERE customer_id = l_customer_id;
    
    -- raise an exception if the credit limit is exceeded
    IF l_customer_credit > l_credit_limit THEN
        raise_application_error(-20111,'Credit Limit Exceeded');
    END IF;
    
    dbms_output.put_line('Credit Limit is checked and passed');
    
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            dbms_output.put_line('Customer with id ' || l_customer_id || ' does not exist.');
END;
/
--------------------------------------------------------------------------------------------
Exception Propagation - 
When an exception occurs, PL/SQL looks for an exception handler in the current block 
e.g., anonymous block, procedure, or function of the exception. If it does not find a match, 
PL/SQL propagates the exception to the enclosing block of the current block.
PL/SQL then attempts to handle the exception by raising it once more in the enclosing block. 
This process continues in each successive enclosing block until there is no remaining block in which to raise the exception.
Note that an unhandled exception stops the execution of the block.
DECLARE
    e1 EXCEPTION;
    PRAGMA exception_init (e1, -20001);
    e2 EXCEPTION;
    PRAGMA exception_init (e2, -20002);
    e3 EXCEPTION;
    PRAGMA exception_init (e2, -20003);
    l_input NUMBER := &input_number;
BEGIN
    -- inner block
    BEGIN
        IF l_input = 1 THEN
            raise_application_error(-20001,'Exception: the input number is 1');
        ELSIF l_input = 2 THEN
            raise_application_error(-20002,'Exception: the input number is 2');
        ELSE
            raise_application_error(-20003,'Exception: the input number is not 1 or 2');
        END IF;
    -- exception handling of the inner block
    EXCEPTION
        WHEN e1 THEN 
            dbms_output.put_line('Handle exception when the input number is 1');
    END;
    -- exception handling of the outer block
    EXCEPTION 
        WHEN e2 THEN
            dbms_output.put_line('Handle exception when the input number is 2');
END;
/
-------------------------------------------------------------------------------------------
Handling Other Unhandled Exceptions - 
To handle other non-specific exceptions in the WHEN OTHERS clause, you will need to take advantages of 
the built-in error functions such as SQLCODE and SQLERRM.
1.SQLCODE - 
The SQLCODE function accepts no argument and returns a number code of the most recent exception.
The SQLCODE is only usable in the exception-handling section. If you use the SQLCODE function outside an exception handler, it always returns zero.
2.SQLERRM - 
In this syntax, the error_number can be any valid Oracle error number.
Note that you cannot use SQLCODE or SQLERRM function directly in an SQL statement. 
Instead, you must first assign their returned values to variables, and then use the variables in the SQL statement.
DECLARE
    l_first_name  contacts.first_name%TYPE := 'Flor';
    l_last_name   contacts.last_name%TYPE := 'Stone';
    l_email       contacts.email%TYPE := 'flor.stone@raytheon.com';
    l_phone       contacts.phone%TYPE := '+1 317 123 4105';
    l_customer_id contacts.customer_id%TYPE := -1;
BEGIN
    -- insert a new contact
    INSERT INTO contacts(first_name, last_name, email, phone, customer_id)
    VALUES(l_first_name, l_last_name, l_email, l_phone, l_customer_id);
    
    EXCEPTION 
        WHEN OTHERS THEN
            DECLARE
                l_error PLS_INTEGER := SQLCODE;
                l_msg VARCHAR2(255) := sqlerrm;
            BEGIN
                CASE l_error 
                WHEN -1 THEN
                    -- duplicate email
                    dbms_output.put_line('duplicate email found ' || l_email);
                    dbms_output.put_line(l_msg);
                    
                WHEN -2291 THEN
                    -- parent key not found
                    dbms_output.put_line('Invalid customer id ' || l_customer_id);
                    dbms_output.put_line(l_msg);
                END CASE;
                -- reraise the current exception
                RAISE;
            END;
            
END;
/
----------------------------------------------------------------------------------------------
Record - 
A PL/SQL record is a composite data structure which consists of multiple fields; each has its own value.
PL/SQL has three types of records: table-based, cursor-based, programmer-defined. Before using a record, you must declare it.
Records can be used to mimic the row structures of tables and cursors, or as a convenient was to pass data between subprograms 
without listing large number of parameters.
1.Table-based record - 
DECLARE
   r_contact contacts%ROWTYPE;
2.Cursor-based record - 
DECLARE
    CURSOR c_contacts IS
        SELECT first_name, last_name, phone
        FROM contacts;
    r_contact c_contacts%ROWTYPE;
3.Programmer-defined record - 
If you want to create a record whose structure is not based on the existing ones.
DECLARE
  -- define a record type
TYPE r_customer_contact_t
IS
  RECORD
  (
    customer_name customers.name%TYPE,
    first_name    contacts.first_name%TYPE,
    last_name     contacts.last_name%TYPE );
  -- declare a record
  r_customer_contacts r_customer_contact_t;
BEGIN
  NULL;
END;
Referencing a record’s field - r_contact.first_name
Assigning records - r_contact1 := r_contact2;
You can use SELECT INTO a whole record (or individual fields):
You can FETCH INTO a whole record or individual fields:
---------------------------------------------------------------------------------------------
Cursor -
A cursor is a pointer that points to a result of a query.
1.Implicit cursors - 
Whenever Oracle executes an SQL statement such as SELECT INTO, INSERT, UPDATE, and DELETE, it automatically creates an implicit cursor.
Oracle internally manages the whole execution cycle of implicit cursors and reveals only the cursor’s information and 
statuses such as SQL%ROWCOUNT, SQL%ISOPEN, SQL%FOUND, and SQL%NOTFOUND.
The implicit cursor is not elegant when the query returns zero or multiple rows which cause NO_DATA_FOUND or TOO_MANY_ROWS exception respectively.

2.Explicit cursors - 
An explicit cursor is an SELECT statement declared explicitly in the declaration section of the current block or a package specification.
For an explicit cursor, you have control over its execution cycle from OPEN, FETCH, and CLOSE.
Explicit Cursor Attributes- cursor_name%attribute
1.%ISOPEN - This attribute is TRUE if the cursor is open or FALSE if it is not.
2.%FOUND - NULL before the first fetch , TRUE if a record was fetched successfully ,FALSE if no row returned, INVALID_CURSOR if the cursor is not opened
3.%NOTFOUND - NULL before the first fetch ,FALSE if a record was fetched successfully ,TRUE if no row returned ,INVALID_CURSOR if the cursor is not opened
4.%ROWCOUNT - The %ROWCOUNT attribute returns the number of rows fetched from the cursor. If the cursor is not opened, this attribute returns INVALID_CURSOR.
If you declare a cursor in an anonymous block, procedure, or function, the cursor will automatically be closed when the execution of these objects end.
CREATE VIEW sales AS
SELECT customer_id,
       SUM(unit_price * quantity) total,
       ROUND(SUM(unit_price * quantity) * 0.05) credit
FROM order_items
INNER JOIN orders USING (order_id)
WHERE status = 'Shipped'
GROUP BY customer_id;

DECLARE
  l_budget NUMBER := 1000000;
   -- cursor
  CURSOR c_sales IS
  SELECT  *  FROM sales  
  ORDER BY total DESC;
   -- record    
   r_sales c_sales%ROWTYPE;
BEGIN

  -- reset credit limit of all customers
  UPDATE customers SET credit_limit = 0;

  OPEN c_sales;

  LOOP
    FETCH  c_sales  INTO r_sales;
    EXIT WHEN c_sales%NOTFOUND;

    -- update credit for the current customer
    UPDATE 
        customers
    SET  
        credit_limit = 
            CASE WHEN l_budget > r_sales.credit 
                        THEN r_sales.credit 
                            ELSE l_budget
            END
    WHERE 
        customer_id = r_sales.customer_id;

    --  reduce the budget for credit limit
    l_budget := l_budget - r_sales.credit;

    DBMS_OUTPUT.PUT_LINE( 'Customer id: ' ||r_sales.customer_id || 
' Credit: ' || r_sales.credit || ' Remaining Budget: ' || l_budget );

    -- check the budget
    EXIT WHEN l_budget <= 0;
  END LOOP;

  CLOSE c_sales;
END;
--------------------------------------------------------------------------------
Cursor FOR LOOP statement -
The numeric FOR LOOP executes the body of a loop once for every integer value in a specified range.  
Similarly, the cursor FOR LOOP executes the body of the loop once for each row returned by the query associated with the cursor.
DECLARE
  CURSOR c_product
  IS
    SELECT 
        product_name, list_price
    FROM 
        products 
    ORDER BY 
        list_price DESC;
BEGIN
  FOR r_product IN c_product
  LOOP
    dbms_output.put_line( r_product.product_name || ': $' ||  r_product.list_price );
  END LOOP;
END;
--------------------------------------------------------------------------------
Cursor with Parameters -
An explicit cursor may accept a list of parameters. Each time you open the cursor, 
you can pass different arguments to the cursor, which results in different result sets.
DECLARE
    r_product products%rowtype;
    CURSOR c_product (low_price NUMBER, high_price NUMBER)
    IS
        SELECT *
        FROM products
        WHERE list_price BETWEEN low_price AND high_price;
BEGIN
    -- show mass products
    dbms_output.put_line('Mass products: ');
    OPEN c_product(50,100);
    LOOP
        FETCH c_product INTO r_product;
        EXIT WHEN c_product%notfound;
        dbms_output.put_line(r_product.product_name || ': ' ||r_product.list_price);
    END LOOP;
    CLOSE c_product;

    -- show luxury products
    dbms_output.put_line('Luxury products: ');
    OPEN c_product(800,1000);
    LOOP
        FETCH c_product INTO r_product;
        EXIT WHEN c_product%notfound;
        dbms_output.put_line(r_product.product_name || ': ' ||r_product.list_price);
    END LOOP;
    CLOSE c_product;

END;
/
------------------------------------------------------------------------------------
Cursor Variables with REF CURSOR -
A cursor variable is a variable that references to a cursor.
The most important benefit of a cursor variable is that it enables passing the result of a query between PL/SQL programs. 
Without a cursor variable, you have to fetch all data from a cursor, store it in a variable 
e.g., a collection, and pass this variable as an argument. With a cursor variable, you simply pass the reference to that cursor.
To declare a cursor variable, you use the REF CURSOR is the data type.
CREATE OR REPLACE FUNCTION get_direct_reports(
      in_manager_id IN employees.manager_id%TYPE)
   RETURN SYS_REFCURSOR
AS
   c_direct_reports SYS_REFCURSOR;
BEGIN

   OPEN c_direct_reports FOR 
   SELECT 
      employee_id, 
      first_name, 
      last_name, 
      email
   FROM 
      employees 
   WHERE 
      manager_id = in_manager_id 
   ORDER BY 
         first_name,   
         last_name;

   RETURN c_direct_reports;
END;
--------------------------------------------------------------------------------
CURSOR FOR UPDATE - 
Sometimes, you want to lock a set of rows before you can update them in your program. 
Oracle provides the FOR UPDATE clause of the SELECT statement in an updatable cursor to perform this kind of locking mechanism.
DECLARE
    -- customer cursor
    CURSOR c_customers IS 
        SELECT 
            customer_id, 
            name, 
            credit_limit
        FROM 
            customers
        WHERE 
            credit_limit > 0 
        FOR UPDATE OF credit_limit;
    -- local variables
    l_order_count PLS_INTEGER := 0;
    l_increment   PLS_INTEGER := 0;
    
BEGIN
    FOR r_customer IN c_customers
    LOOP
        -- get the number of orders of the customer
        SELECT COUNT(*)
        INTO l_order_count
        FROM orders
        WHERE customer_id = r_customer.customer_id;
        -- 
        IF l_order_count >= 5 THEN
            l_increment := 5;
        ELSIF l_order_count < 5 AND l_order_count >=2 THEN
            l_increment := 2;
        ELSIF l_increment = 1 THEN
            l_increment := 1;
        ELSE 
            l_increment := 0;
        END IF;
        
        IF l_increment > 0 THEN
            -- update the credit limit
            UPDATE 
                customers
            SET 
                credit_limit = credit_limit * ( 1 +  l_increment/ 100)
            WHERE 
                customer_id = r_customer.customer_id;
            
            -- show the customers whose credits are increased
            dbms_output.put_line('Increase credit for customer ' 
                || r_customer.NAME || ' by ' 
                || l_increment || '%' );
        END IF;
    END LOOP;
    
    EXCEPTION
        WHEN OTHERS THEN
            dbms_output.put_line('Error code:' || SQLCODE);
            dbms_output.put_line('Error message:' || sqlerrm);
            RAISE;
            
END;
/
----------------------------------------------------------------------------------
Procedure - 
A PL/SQL procedure is a reusable unit that encapsulates specific business logic of the application.
PL/SQL procedure is a named block stored as a schema object in the Oracle Database.
Procedure header - A procedure begins with a header that specifies its name and an optional parameter list.
Each parameter can be in either IN, OUT, or INOUT mode.
An IN parameter is read-only. You can reference an IN parameter inside a procedure, but you cannot change its value.
An OUT parameter is writable. Typically, you set a returned value for the OUT parameter and return it to the calling program. 
An INOUT parameter is both readable and writable. The procedure can read and modify it.
procedure body -  	
Similar to an anonymous block, the procedure body has three parts. 
The executable part is mandatory whereas the declarative and exception-handling parts are optional. 
The executable part must contain at least one executable statement.
CREATE OR REPLACE PROCEDURE print_contact(
    in_customer_id NUMBER 
)
IS
  r_contact contacts%ROWTYPE;
BEGIN
  -- get contact based on customer id
  SELECT *
  INTO r_contact
  FROM contacts
  WHERE customer_id = p_customer_id;

  -- print out contact's information
  dbms_output.put_line( r_contact.first_name || ' ' ||
  r_contact.last_name || '<' || r_contact.email ||'>' );

EXCEPTION
   WHEN OTHERS THEN
      dbms_output.put_line( SQLERRM );
END;
To compile the procedure, you click the Run Statement button 
Executing a procedure - 
EXECUTE procedure_name( arguments);
EXEC procedure_name( arguments);
DROP PROCEDURE procedure_name; 
------------------------------------------------------------------------------------
IMPLICIT STATEMENT RESULTS - (DBMS_SQL.RETURN_RESULT and DBMS_SQL.GET_NEXT_RESULT)
Prior Oracle Database 12c, you can return a result set from a stored procedure using the OUT REF CURSOR parameters.
CREATE OR REPLACE PROCEDURE get_customer_by_credit(
    min_credit NUMBER
)
AS 
    c_customers SYS_REFCURSOR;
BEGIN
    -- open the cursor
    OPEN c_customers FOR
        SELECT customer_id, credit_limit, name
        FROM customers
        WHERE credit_limit > min_credit
        ORDER BY credit_limit;
    -- return the result set
    dbms_sql.return_result(c_customers);
END;

Oracle Database 12c Release 1 added a new feature called implicit statement result that allows you to return one or more 
result sets from a stored procedure by using the dbms_sql package.
CREATE OR REPLACE PROCEDURE get_customers(
    page_no NUMBER, 
    page_size NUMBER
)
AS
    c_customers SYS_REFCURSOR;
    c_total_row SYS_REFCURSOR;
BEGIN
    -- return the total of customers
    OPEN c_total_row FOR
        SELECT COUNT(*)
        FROM customers;
    
    dbms_sql.return_result(c_total_row);
    
    -- return the customers 
    OPEN c_customers FOR
        SELECT customer_id, name
        FROM customers
        ORDER BY name
        OFFSET page_size * (page_no - 1) ROWS
        FETCH NEXT page_size ROWS ONLY;
        
    dbms_sql.return_result(c_customers);    
END;

Using the get_next_result() procedure - 
if you want to process result sets using PL/SQL, you can use the get_next_resultset() procedure in the DBMS_SQL package.
SET SERVEROUTPUT ON

DECLARE
l_sql_cursor    PLS_INTEGER;
c_cursor        SYS_REFCURSOR;
l_return        PLS_INTEGER;

l_column_count  PLS_INTEGER;
l_desc_tab      dbms_sql.desc_tab;

l_total_rows    NUMBER;
l_customer_id   customers.customer_id%TYPE;
l_name          customers.NAME%TYPE;
BEGIN
-- Execute the function.
l_sql_cursor := dbms_sql.open_cursor(treat_as_client_for_results => TRUE);

dbms_sql.parse(C             => l_sql_cursor,
                STATEMENT     => 'BEGIN get_customers(1,10); END;',
                language_flag => dbms_sql.NATIVE);

l_return := dbms_sql.EXECUTE(l_sql_cursor);

-- Loop over the result sets.
LOOP
    -- Get the next resultset.
    BEGIN
    dbms_sql.get_next_result(l_sql_cursor, c_cursor);
    EXCEPTION
    WHEN no_data_found THEN
        EXIT;
    END;

    -- Get the number of columns in each result set.
    l_return := dbms_sql.to_cursor_number(c_cursor);
    dbms_sql.describe_columns (l_return, l_column_count, l_desc_tab);
    c_cursor := dbms_sql.to_refcursor(l_return);

    -- Handle the result set based on the number of columns.
    CASE l_column_count
    WHEN 1 THEN
        dbms_output.put_line('The total number of customers:');
        FETCH c_cursor
        INTO  l_total_rows;

        dbms_output.put_line(l_total_rows);
        CLOSE c_cursor;
    WHEN 2 THEN
        dbms_output.put_line('The customer list:');
        LOOP
        FETCH c_cursor
        INTO  l_customer_id, l_name;

        EXIT WHEN c_cursor%notfound;

        dbms_output.put_line(l_customer_id || ' ' || l_name);
        END LOOP;
        CLOSE c_cursor;
    ELSE
        dbms_output.put_line('An error occurred!');
    END CASE;
END LOOP;
END;
/
----------------------------------------------------------------------------------------
Function -
Procedures and functions still retain the block format, but the DECLARE keyword is replaced by PROCEDURE or FUNCTION definitions, 
which are similar except for the additional return type definition for a function.
The function header has the function name and a RETURN clause that specifies the datatype of the returned value. 
Each parameter of the function can be either in the IN, OUT, or INOUT mode.
Bdy which has three sections: declarative section, executable section, and exception-handling section.
The declarative section is between the IS and BEGIN keywords. It is where you declare variables, constants, cursors, and user-defined types.
The executable section is between the BEGIN and END keywords. It is where you place the executable statements. Unlike a procedure, 
you must have at least one RETURN statement in the executable statement.
The exception-handling section is where you put the exception handler code.
CREATE OR REPLACE FUNCTION get_total_sales(
    in_year PLS_INTEGER
) 
RETURN NUMBER
IS
    l_total_sales NUMBER := 0;
BEGIN
    -- get total sales
    SELECT SUM(unit_price * quantity)
    INTO l_total_sales
    FROM order_items
    INNER JOIN orders USING (order_id)
    WHERE status = 'Shipped'
    GROUP BY EXTRACT(YEAR FROM order_date)
    HAVING EXTRACT(YEAR FROM order_date) = in_year;
    
    -- return the total sales
    RETURN l_total_sales;
END;
Calling a PL/SQL function -
1) in an assignment statement:
DECLARE
    l_sales_2017 NUMBER := 0;
BEGIN
    l_sales_2017 := get_total_sales (2017);
    DBMS_OUTPUT.PUT_LINE('Sales 2017: ' || l_sales_2017);
END;
2) in a Boolean expression
BEGIN
    IF get_total_sales (2017) > 10000000 THEN
        DBMS_OUTPUT.PUT_LINE('Sales 2017 is above target');
    END IF;
END;
3) in an SQL statement
SELECT
    get_total_sales(2017)
FROM
    dual;
DROP FUNCTION function_name;
---------------------------------------------------------------------------------
What is a PL/SQL package -
In PL/SQL, a package is a schema object that contains definitions for a group of related functionalities. 
A package includes variables, constants, cursors, exceptions, procedures, functions, and subprograms. 
Packages allow related code, along with supporting types, variables and cursors, to be grouped together. 
The package is made up of a specification that defines the external interface of the package, and a body that contains all the implementation code.
It is compiled and stored in the Oracle Database.
Typically, a package has a specification and a body. A package specification is mandatory while the package body
can be required or optional, depending on the package specification.
Package specification-
The package specification declares the public objects that are accessible from outside the package.
If a package specification whose public objects include cursors and subprograms, 
then it must have a body which defines queries for the cursors and code for the subprograms.
Package body -
A package body contains the implementation of the cursors or subprograms declared in the package specification. 
In the package body, you can declare or define private variables, cursors, etc., used only by package body itself.
Avantages of the package:
Make code more modular
Hide implementation details
Improve application performance
Minimize unnecessary recompiling code
Manage authorization easily
package specification - 
you can access items declared in a package specification from anywhere in the schema 
e.g., you can access items in a package specification from other packages.
A package specification does not contain any implementations of the public items.
A package specification can exist independently if their items do not require implementations.
Typically, a package specification contains the following items:
Procedures
Functions
Cursors
Types, variables, and constants
Records
Collections
Between the  AS and END keywords, you declare the public items of the package specification.
CREATE OR REPLACE PACKAGE order_mgmt
AS
  gc_shipped_status  CONSTANT VARCHAR(10) := 'Shipped';
  gc_pending_status CONSTANT VARCHAR(10) := 'Pending';
  gc_canceled_status CONSTANT VARCHAR(10) := 'Canceled';

  -- cursor that returns the order detail
  CURSOR g_cur_order(p_order_id NUMBER)
  IS
    SELECT
      customer_id,
      status,
      salesman_id,
      order_date,
      item_id,
      product_name,
      quantity,
      unit_price
    FROM
      order_items
    INNER JOIN orders USING (order_id)
    INNER JOIN products USING (product_id)
    WHERE
      order_id = p_order_id;

  -- get net value of a order
  FUNCTION get_net_value(
      p_order_id NUMBER)
    RETURN NUMBER;

  -- Get net value by customer
  FUNCTION get_net_value_by_customer(
      p_customer_id NUMBER,
      p_year        NUMBER)
    RETURN NUMBER;

END order_mgmt;
------------------------------------------------------------------------------------
package body -
If the package specification has cursors or subprograms, then the package body is mandatory.
Both the package body and package specification must be in the same schema.
A package body can have an initialization part which consists of statements that initialize public variables and do other one-time setup tasks.
It can also include an exception handler.
CREATE OR REPLACE PACKAGE BODY order_mgmt
AS
  -- get net value of a order
  FUNCTION get_net_value(
      p_order_id NUMBER)
    RETURN NUMBER
  IS
    ln_net_value NUMBER 
  BEGIN
    SELECT
      SUM(unit_price * quantity)
    INTO
      ln_net_value
    FROM
      order_items
    WHERE
      order_id = p_order_id;

    RETURN p_order_id;

  EXCEPTION
  WHEN no_data_found THEN
    DBMS_OUTPUT.PUT_LINE( SQLERRM );
  END get_net_value;

-- Get net value by customer
  FUNCTION get_net_value_by_customer(
      p_customer_id NUMBER,
      p_year        NUMBER)
    RETURN NUMBER
  IS
    ln_net_value NUMBER 
  BEGIN
    SELECT
      SUM(quantity * unit_price)
    INTO
      ln_net_value
    FROM
      order_items
    INNER JOIN orders USING (order_id)
    WHERE
      extract(YEAR FROM order_date) = p_year
    AND customer_id                 = p_customer_id
    AND status                      = gc_shipped_status;
    RETURN ln_net_value;
  EXCEPTION
  WHEN no_data_found THEN
    DBMS_OUTPUT.PUT_LINE( SQLERRM );
  END get_net_value_by_customer;

END order_mgmt;
Calling functions from a package -
SELECT
  order_mgmt.get_net_value_by_customer(1,2017) sales
FROM
  dual;
DROP PACKAGE statement -
DROP PACKAGE [BODY] schema_name.package_name;
-----------------------------------------------------------------------------------
TRIGGER :-
Database triggers are stored programs associated with a specific table, view or system events, 
such that when the specific event occurs the associated code is executed. 
A trigger is a named PL/SQL block stored in the Oracle Database and executed automatically when a triggering event takes place.
The event can be any of the following:
1.A data manipulation language  (DML) statement executed against a table e.g., INSERT, UPDATE, or DELETE. For example, 
if you define a trigger that fires before an INSERT statement on the customers table, the trigger will fire once before 
a new row is inserted into the customers table.
2.A data definition language (DDL) statement executes e.g., CREATE or ALTER statement. These triggers are often used for auditing 
purposes to record changes of the schema.
3.A system event such as startup or shutdown of the Oracle Database.
4.A user event such as login or logout.
Trigger usages -
1.Enforcing complex business rules that cannot be established using integrity constraint such as UNIQUE, NOT NULL, and CHECK.
2.Preventing invalid transactions.
3.Gathering statistical information on table accesses.
4.Generating value automatically for derived columns.
5.Auditing sensitive data.
CREATE TABLE audits (
      audit_id         NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
      table_name       VARCHAR2(255),
      transaction_name VARCHAR2(10),
      by_user          VARCHAR2(30),
      transaction_date DATE
);

CREATE OR REPLACE TRIGGER customers_audit_trg
    AFTER 
    UPDATE OR DELETE 
    ON customers
    FOR EACH ROW    
DECLARE
   l_transaction VARCHAR2(10);
BEGIN
   -- determine the transaction type
   l_transaction := CASE  
         WHEN UPDATING THEN 'UPDATE'
         WHEN DELETING THEN 'DELETE'
   END;

   -- insert a row into the audit table   
   INSERT INTO audits (table_name, transaction_name, by_user, transaction_date)
   VALUES('CUSTOMERS', l_transaction, USER, SYSDATE);
END;
/
----------------------------------------------------------------------------
Statement-level triggers -
statement-level trigger executes once for each transaction
For example, if you update 1000 rows in a table, then a statement-level trigger on that table would only be executed once.
CREATE OR REPLACE TRIGGER customers_credit_trg
    BEFORE UPDATE OF credit_limit  
    ON customers
DECLARE
    l_day_of_month NUMBER;
BEGIN
    -- determine the transaction type
    l_day_of_month := EXTRACT(DAY FROM sysdate);

    IF l_day_of_month BETWEEN 28 AND 31 THEN
        raise_application_error(-20100,'Cannot update customer credit from 28th to 31st');
    END IF;
END;

---------------------------------------------------------------------------
Row-level triggers -
Row-level triggers fires once for each row affected by the triggering event such as INSERT, UPDATE, or DELETE.
CREATE OR REPLACE TRIGGER customers_update_credit_trg 
    BEFORE UPDATE OF credit_limit
    ON customers
    FOR EACH ROW
    WHEN (NEW.credit_limit > 0)
BEGIN
    -- check the credit limit
    IF :NEW.credit_limit >= 2 * :OLD.credit_limit THEN
        raise_application_error(-20101,'The new credit ' || :NEW.credit_limit || 
            ' cannot increase to more than double, the current credit ' || :OLD.credit_limit);
    END IF;
END;
---------------------------------------------------------------
Instead of trigger -
An INSTEAD OF trigger is a trigger that allows you to update data in tables via their view which cannot be modified directly through DML statements.
If the view has an INSTEAD OF trigger, it will automatically skip the DML statement and execute other DML statements instead.
In Oracle, you can create an INSTEAD OF trigger for a view only. You cannot create an INSTEAD OF trigger for a table.
CREATE OR REPLACE TRIGGER new_customer_trg
    INSTEAD OF INSERT ON vw_customers
    FOR EACH ROW
DECLARE
    l_customer_id NUMBER;
BEGIN
    -- insert a new customer first
    INSERT INTO customers(name, address, website, credit_limit)
    VALUES(:NEW.NAME, :NEW.address, :NEW.website, :NEW.credit_limit)
    RETURNING customer_id INTO l_customer_id;
    
    -- insert the contact
    INSERT INTO contacts(first_name, last_name, email, phone, customer_id)
    VALUES(:NEW.first_name, :NEW.last_name, :NEW.email, :NEW.phone, l_customer_id);
END;

-------------------------------------------------------------------
Disable Triggers -
Disable a single trigger - ALTER TRIGGER trigger_name DISABLE;
Disable all triggers of a table - ALTER TABLE table_name DISABLE ALL TRIGGERS;
Enable Triggers - 
Enable Triggers - ALTER TRIGGER trigger_name ENABLE;
Enable all triggers of a table - ALTER TABLE table_name ENABLE ALL TRIGGERS;
DROP TRIGGER - DROP TRIGGER [schema_name.]trigger_name;
---------------------------------------------------------------------
Mutating Table Error - 
When a table is mutating, it is changing. If the changing is taking place and you try to make another 
change in the middle of the first change, Oracle will issue a mutating table error with the error code ORA-04091.
------------------------------------------------------------------
COLLECTIONS - (Use collections in PL/SQL to perform array processing.)
Associative Array -
Associative arrays are single-dimensional, unbounded, sparse collections of homogeneous elements.
First, an associative array is single-dimensional. It means that an associative array has a single column of data in each row, 
which is similar to a one-dimension array.
Second, an associative array is unbounded, meaning that it has a predetermined limits number of elements.
Third, an associative array is sparse because its elements are not sequential. In other words, an associative array may have gaps between elements.
Finally, an associative array has elements which have the same data type, or we call them homogenous elements.
DECLARE
    -- declare an associative array type
    TYPE t_capital_type IS TABLE OF VARCHAR2(100) 
    INDEX BY VARCHAR2(50);
    -- declare a variable of the t_capital_type
    t_capital t_capital_type;
    -- local variable
    l_country VARCHAR2(50);
BEGIN
    
    t_capital('USA')            := 'Washington, D.C.';
    t_capital('United Kingdom') := 'London';
    t_capital('Japan')          := 'Tokyo';
    
    l_country := t_capital.FIRST;
    
    WHILE l_country IS NOT NULL LOOP
        dbms_output.put_line('The capital of ' || 
            l_country || 
            ' is ' || 
            t_capital(l_country));
        l_country := t_capital.NEXT(l_country);
    END LOOP;
END;
/
-------------------------------------------------------------------------
Nested tables -
Nested tables are single-dimensional, unbounded collections of homogeneous elements.
First, a nested table is single-dimensional, meaning that each row has a single column of data like a one-dimension array.
Second, a nested table is unbounded. It means that the number of elements of a nested table is predetermined.
Third, homogeneous elements mean that all elements of a nested table have the same data type.
DECLARE
    -- declare a cursor that return customer name
    CURSOR c_customer IS 
        SELECT name 
        FROM customers
        ORDER BY name 
        FETCH FIRST 10 ROWS ONLY;
    -- declare a nested table type   
    TYPE t_customer_name_type 
        IS TABLE OF customers.name%TYPE;
    
    -- declare and initialize a nested table variable
    t_customer_names t_customer_name_type := t_customer_name_type(); 
    
BEGIN
    -- populate customer names from a cursor
    FOR r_customer IN c_customer 
    LOOP
        t_customer_names.EXTEND;
        t_customer_names(t_customer_names.LAST) := r_customer.name;
    END LOOP;
    
    -- display customer names
    FOR l_index IN t_customer_names.FIRST..t_customer_names.LAST 
    LOOP
        dbms_output.put_line(t_customer_names(l_index));
    END LOOP;
END;
--------------------------------------------------------------------------
VARRAY - 
VARRAY stands for the variable-sized array.
A VARRAY is single-dimensional collections of elements with the same data type. Unlike an associative array and nested table, 
a VARRAY always has a fixed number of elements(bounded) and never has gaps between the elements (not sparse).
DECLARE
    TYPE r_customer_type IS RECORD(
        customer_name customers.name%TYPE,
        credit_limit customers.credit_limit%TYPE
    ); 

    TYPE t_customer_type IS VARRAY(5) 
        OF r_customer_type;
    
    t_customers t_customer_type := t_customer_type();

    CURSOR c_customer IS 
        SELECT NAME, credit_limit 
        FROM customers 
        ORDER BY credit_limit DESC 
        FETCH FIRST 5 ROWS ONLY;
BEGIN
    -- fetch data from a cursor
    FOR r_customer IN c_customer LOOP
        t_customers.EXTEND;
        t_customers(t_customers.LAST).customer_name := r_customer.name;
        t_customers(t_customers.LAST).credit_limit  := r_customer.credit_limit;
    END LOOP;

    -- show all customers
    FOR l_index IN t_customers .FIRST..t_customers.LAST 
    LOOP
        dbms_output.put_line(
            'The customer ' ||
            t_customers(l_index).customer_name ||
            ' has a credit of ' ||
            t_customers(l_index).credit_limit
        );
    END LOOP;

END;
/
-------------------------------------------------------------------------------------------------------
COLLECTION METHODS - 
A variety of methods exist for collections, but not all are relevant for every collection type.
EXISTS(n) - Returns TRUE if the specified element exists.
COUNT - Returns the number of elements in the collection.
LIMIT - Returns the maximum number of elements for a VARRAY, or NULL for nested tables.
FIRST - Returns the index of the first element in the collection.
LAST - Returns the index of the last element in the collection.
PRIOR(n) - Returns the index of the element prior to the specified element.
NEXT(n) - Returns the index of the next element after the specified element.
EXTEND - Appends a single null element to the collection.
EXTEND(n) - Appends n null elements to the collection.
EXTEND(n1,n2) - Appends n1 copies of the n2th element to the collection.
TRIM - Removes a single element from the end of the collection.
TRIM(n) - Removes n elements from the end of the collection.
DELETE - Removes all elements from the collection.
DELETE(n) - Removes element n from the collection.
DELETE(n1,n2) - Removes all elements from n1 to n2 from the collection.
----------------------------------------------------------------------------------------------------------------------
OBJECT :- 
Oracle implements Objects through the use of TYPE declarations, defined in a similar way to packages. Unlike packages 
where the instance of the package is limited to the current session, an instance of an object type can be stored in the database for later use. 
The definition of the type contains a comma separated list of attributes/properties, 
defined in the same way as package variables, and member functions/procedures.
--- Object specification 
CREATE OR REPLACE TYPE t_person AS OBJECT (
  first_name     VARCHAR2(30),
  last_name      VARCHAR2(30),
  date_of_birth  DATE,
  MEMBER FUNCTION get_age RETURN NUMBER
);
/
--- Object body 
CREATE OR REPLACE TYPE BODY t_person AS
  MEMBER FUNCTION get_age RETURN NUMBER AS
  BEGIN
    RETURN TRUNC(MONTHS_BETWEEN(SYSDATE, date_of_birth)/12);
  END get_age;
END;
/
---- Use of Object 
CREATE TABLE people (
  id      NUMBER(10) NOT NULL,
  person  t_person
);
---To insert data into the PEOPLE table we must use the t_person() constructor. This can be done as part of a regular DML statement, or using PL/SQL.
INSERT INTO people (id, person)
VALUES (1, t_person('John', 'Doe', TO_DATE('01/01/2000','DD/MM/YYYY')));

DECLARE
  l_person  t_person;
BEGIN
  l_person := t_person('Jane','Doe', TO_DATE('01/01/2001','DD/MM/YYYY'));
  INSERT INTO people (id, person)
  VALUES (2, l_person);
  COMMIT;
END;
/
--- Access Objects parameters
SELECT p.id,
       p.person.first_name,
       p.person.get_age() AS age
FROM   people p;
------------------------------------------------------------
SQL OPTIMIZATION :-
Stop using the wrong data types.
Stop using pass-by-value (NOCOPY).
Stop avoiding bulk binds. 
Stop doing index scans when you can use ROWIDs.
Stop using explicit cursors.
Stop putting your code in the wrong order. Take advantage of performance gains associated with short-circuit evaluation and logic/branch ordering in PL/SQL.
Stop doing intensive processing immediately if it is more appropriate to decouple it.
Stop calling PL/SQL functions in your SQL statements. If you must do it, make sure you use the most efficient manner possible.
Stop avoiding code instrumentation (DBMS_APPLICATION_INFO and DBMS_SESSION). Its a very quick way to identify problems.
Stop avoiding PL/SQL native compilation.
Stop avoiding conditional compilation where it is appropriate. The easiest way to improve the speed of doing something is 
to avoid doing it in the first place.
Stop reinventing the wheel. Oracle has many built-in packages, procedures and functions that will probably do the job much more efficiently 
than you will, so learn them and use them. You can also save time by using other peoples code, like the Alexandria PL/SQL Utility Library.

----------------------------------------------------------------------
BULK BINDS - 
FORALL -  construct to bulk bind the inserts this time is reduced time.
BULK COLLECT INTO -  can also improve the performance when loading collections from a queries

------------------------------------------------------------------------
COMPLEX RECORDSETS -(Build complex recordsets using temporary or PL/SQL tables within stored procedures) -
Temporary Tables -
Using this method we can create a temporary table to hold the data while we process it. Once the processing is complete
we can use a REF CURSOR to pass the recordset out to an application.
CREATE GLOBAL TEMPORARY TABLE my_temp_table
(
  empno         NUMBER(4),
  ename         VARCHAR2(10),
  sal           NUMBER(7,2),
  complex       NUMBER(7,2)
) ON COMMIT PRESERVE ROWS;

PL/SQL Temporary Table - 
CREATE TYPE my_row_type AS OBJECT
(
  empno         NUMBER(4),
  ename         VARCHAR2(10),
  sal           NUMBER(7,2),
  complex       NUMBER(7,2)
);
/
--------------------------------------------------------------------------
DBMS_OBFUSCATION_TOOLKIT - Encrypt and decrypt data using the DBMS_OBFUSCATION_TOOLKIT package.

--------------------------------------------------------------------------
DBMS_APPLICATION_INFO - (Track session and long operation activity more accurately using thes built-in procedures and views)
The DBMS_APPLICATION_INFO package allows programs to add information to the V$SESSION and V$SESSION_LONGOPS views 
to make tracking of session activities more accurate.this information in auditing, SQL tracing and performance tuning.
1.SET_MODULE - Once a program makes a connection to the database it should register itself as a module using the SET_MODULE procedure
BEGIN
  DBMS_APPLICATION_INFO.set_module(module_name => 'add_order',
                                   action_name => 'insert into orders');
  
  -- Do insert into ORDERS table.
END;
/
2.SET_ACTION - Subsequent processing should use the SET_ACTION procedure to reflect the current status or action of the session
BEGIN
  DBMS_APPLICATION_INFO.set_action(action_name => 'insert into order_lines');
  
  -- Do insert into ORDER_LINES table.
END;
/
3.SET_CLIENT_INFO - The SET_CLIENT_INFO procedure can be used if any additional information is needed.
BEGIN
  DBMS_APPLICATION_INFO.set_action(action_name => 'insert into orders');
  DBMS_APPLICATION_INFO.set_client_info(client_info => 'Issued by Web Client');
  
  -- Do insert into ORDERS table.
END;
/
V$SESSION View - The information set by these procedures can be read from the MODULE, ACTION and CLIENT_INFO columns of the V$SESSION view.
-------------------------------------------------------------------------
ANYDATA Type - 
It is a self describing type, containing an instance of a given type along with a description of the type it contains. 
With the exception of BLOB and CLOB types, ANYDATA types can be persisted in database tables.
CREATE TABLE anydata_test (
  id      NUMBER,
  content SYS.ANYDATA
);
INSERT INTO anydata_test (id, content) VALUES (1, SYS.ANYDATA.convertVarchar2('This is some data'));
INSERT INTO anydata_test (id, content) VALUES (2, SYS.ANYDATA.convertNumber(1234567890));
INSERT INTO anydata_test (id, content) VALUES (3, SYS.ANYDATA.convertDate(TO_DATE('01-JAN-2012','DD-MON-YYYY')));
COMMIT;


