SELECT
    category,
    customer,
    SUM(sales_amount) 
FROM 
    customer_category_sales
GROUP BY 
    CUBE(category,customer)
ORDER BY 
    category NULLS LAST, 
    customer NULLS LAST;
