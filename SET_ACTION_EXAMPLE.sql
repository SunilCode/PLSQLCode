BEGIN
  DBMS_APPLICATION_INFO.set_action(action_name => 'insert into order_lines');
  
  -- Do insert into ORDER_LINES table.
END;
/