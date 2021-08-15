-- Create a trigger to log price changes of items.
CREATE OR REPLACE TRIGGER items_aru_trg
  AFTER UPDATE OF price ON items
  FOR EACH ROW
BEGIN
   INSERT INTO items_audit_log (id, item_id, description, old_price, new_price, log_date)
   VALUES (items_audit_log_seq.NEXTVAL, :new.id, :new.description, :old.price, :new.price, SYSDATE);
END;
/