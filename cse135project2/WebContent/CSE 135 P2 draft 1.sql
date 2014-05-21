SELECT users.state, products.name ,sum(sales.quantity*sales.price)
FROM users JOIN sales on sales.uid=users.id
JOIN products on sales.pid=products.id
WHERE products.id>=1
AND products.id<=10
AND 'Floyd'<users.name
GROUP BY users.state,products.id, products.name
ORDER BY users.state,products.id,products.name ASC
LIMIT 6


