SET SERVEROUTPUT ON
DECLARE
  -- Define a record type manually.
  TYPE t_all_users_record IS RECORD (
    username  VARCHAR2(30),
    user_id   NUMBER,
    created   DATE
  );
  
  -- Declare record variables using the manual and %ROWTYPE methods.
  l_all_users_record_1  t_all_users_record;
  l_all_users_record_2  all_users%ROWTYPE;
BEGIN
  -- Return some data into once record structure.
  SELECT USERNAME,USER_ID,CREATED
  INTO   l_all_users_record_1
  FROM   all_users
  WHERE  username = 'SYS';
  
  -- Display the contents of the first record.
  DBMS_OUTPUT.put_line('l_all_users_record_1.username=' ||
                        l_all_users_record_1.username);
  DBMS_OUTPUT.put_line('l_all_users_record_1.user_id=' ||
                        l_all_users_record_1.user_id);
  DBMS_OUTPUT.put_line('l_all_users_record_1.created=' ||
                        l_all_users_record_1.created);

  -- Assign the values to the second record structure in a single operation.
  l_all_users_record_2:= l_all_users_record_1;
    
  -- Display the contents of the second record.
  DBMS_OUTPUT.put_line('l_all_users_record_2.username=' ||
                        l_all_users_record_2.username);
  DBMS_OUTPUT.put_line('l_all_users_record_2.user_id=' ||
                        l_all_users_record_2.user_id);
  DBMS_OUTPUT.put_line('l_all_users_record_2.created=' ||
                        l_all_users_record_2.created);

  l_all_users_record_1 := NULL;
  
  -- Display the contents of the first record after deletion.
  DBMS_OUTPUT.put_line('l_all_users_record_1.username=' ||
                        l_all_users_record_1.username);
  DBMS_OUTPUT.put_line('l_all_users_record_1.user_id=' ||
                        l_all_users_record_1.user_id);
  DBMS_OUTPUT.put_line('l_all_users_record_1.created=' ||
                        l_all_users_record_1.created);

END;
/
