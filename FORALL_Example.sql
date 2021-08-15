DECLARE
  TYPE id_type          IS TABLE OF test1.id%TYPE;
  TYPE description_type IS TABLE OF test1.description%TYPE;
  
  t_id           id_type          := id_type();
  t_description  description_type := description_type();
BEGIN
  FOR i IN 1 .. 10000 LOOP
    t_id.extend;
    t_description.extend;
    
    t_id(t_id.last)                   := i;
    t_description(t_description.last) := 'Description: ' || To_Char(i);
  END LOOP;
  
  FORALL i IN t_id.first .. t_id.last
    INSERT INTO test1 (id, description)
    VALUES (t_id(i), t_description(i));
    
  FORALL i IN t_id.first .. t_id.last
    UPDATE test1
    SET    description = t_description(i)
    WHERE  id = t_id(i);
    
  FORALL i IN t_id.first .. t_id.last
    DELETE test1
    WHERE  id = t_id(i);
  
  COMMIT;
END;
/