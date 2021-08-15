SET SERVEROUTPUT ON
DECLARE
  l_user_id   all_users.username%TYPE := 999999;
  l_username  all_users.username%TYPE; 
BEGIN
  SELECT username
  INTO   l_username
  FROM   all_users
  WHERE  user_id = l_user_id;

  DBMS_OUTPUT.put_line('l_username=' || l_username);
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.put_line('No users have a user_id=' || l_user_id);
END;
/