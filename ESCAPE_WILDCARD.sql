SELECT
	product_id,
	discount_message
FROM
	discounts
WHERE
	discount_message LIKE '%25!%%' ESCAPE '!';