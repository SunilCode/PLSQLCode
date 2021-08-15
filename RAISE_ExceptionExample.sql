SET SERVEROUTPUT ON
DECLARE
  l_user_id   all_users.username%TYPE := 1;
  l_username  all_users.username%TYPE;
  
  ex_forbidden_users  EXCEPTION;
BEGIN
  SELECT username
  INTO   l_username
  FROM   all_users
  WHERE  user_id = l_user_id;
  
  -- Signal an error is the SYS or SYSTEM users are queried.
  IF l_username IN ('SYS', 'SYSTEM') THEN
    RAISE ex_forbidden_users;
  END IF;
  
  DBMS_OUTPUT.put_line('l_username=' || l_username);
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.put_line('No users have a user_id=' || l_user_id);
  WHEN ex_forbidden_users THEN
    DBMS_OUTPUT.put_line('Don''t mess with the ' || l_username || ' user, it is forbidden!');
END;
/