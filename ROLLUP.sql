SELECT
   salesman_id,
   customer_id,
   SUM(quantity * unit_price) amount
FROM
   orders
INNER JOIN order_items USING (order_id)
WHERE
   status      = 'Shipped' AND 
   salesman_id IS NOT NULL AND 
   EXTRACT(YEAR FROM order_date) = 2017
GROUP BY
   ROLLUP(salesman_id,customer_id);
