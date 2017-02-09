


SELECT 
	*,
    COUNT(bibNumber) as popularity
FROM spl_2016.transactions as tr
GROUP BY
	bibNumber
WHERE
	checkOut > 3