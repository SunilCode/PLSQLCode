SELECT 
    customer, 
    category,
    GROUPING(customer) customer_grouping,
    GROUPING(category) category_grouping,
    SUM(sales_amount) 
FROM customer_category_sales
GROUP BY 
    GROUPING SETS(
        (customer,category),
        (customer),
        (category),
        ()
    )
ORDER BY 
    customer, 
    category;
