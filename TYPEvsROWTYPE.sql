SET SERVEROUTPUT ON;

DECLARE
  -- Specific column from table.
  l_username  all_users.username%TYPE;
  
  -- Whole record from table.
  l_all_users_row  all_users%ROWTYPE;
  
  CURSOR c_user_data IS
    SELECT username,
           created
    FROM   all_users
    WHERE  username = 'SYS';
    
  -- Record that matches cursor definition. 
  l_all_users_cursor_row  c_user_data%ROWTYPE;
BEGIN
  -- Specific column from table.
  SELECT username
  INTO   l_username
  FROM   all_users
  WHERE  username = 'SYS';
  
  DBMS_OUTPUT.put_line('l_username=' || l_username);
  
  -- Whole record from table.
  SELECT *
  INTO   l_all_users_row
  FROM   all_users
  WHERE  username = 'SYS';

  DBMS_OUTPUT.put_line('l_all_users_row.username=' ||
                        l_all_users_row.username);
  DBMS_OUTPUT.put_line('l_all_users_row.user_id=' ||
                        l_all_users_row.user_id);
  DBMS_OUTPUT.put_line('l_all_users_row.created=' ||
                        l_all_users_row.created);
  
  -- Record that matches cursor definition. 
  OPEN  c_user_data;
  FETCH c_user_data
  INTO  l_all_users_cursor_row;
  CLOSE c_user_data;

  DBMS_OUTPUT.put_line('l_all_users_cursor_row.username=' ||
                        l_all_users_cursor_row.username);
  DBMS_OUTPUT.put_line('l_all_users_cursor_row.created=' ||
                        l_all_users_cursor_row.created);
END;
/