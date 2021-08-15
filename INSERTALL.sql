INSERT ALL
   WHEN amount < 10000 THEN
      INTO small_orders
   WHEN amount >= 10000 AND amount <= 30000 THEN
      INTO medium_orders
   ELSE
      INTO big_orders
  SELECT order_id,
         customer_id,
         (quantity * unit_price) amount
  FROM orders
  INNER JOIN order_items USING(order_id);
