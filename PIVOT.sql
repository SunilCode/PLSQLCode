SELECT * FROM order_stats
PIVOT(
    COUNT(order_id) 
    FOR category_name
    IN ( 
        'CPU',
        'Video Card',
        'Mother Board',
        'Storage'
    )
)
ORDER BY status;
