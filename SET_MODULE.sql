BEGIN
  DBMS_APPLICATION_INFO.set_module(module_name => 'add_order',
                                   action_name => 'insert into orders');
  
  -- Do insert into ORDERS table.
END;
/