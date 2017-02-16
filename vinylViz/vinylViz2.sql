


SELECT 
	unix_timestamp(tr.checkOut) as checkOut,
    unix_timestamp(tr.checkIn) as checkIn,
    IFNULL(tr.checkIn - tr.checkOut, 0) as timeOut,
    o.title,
    o.itemType,
    o.collCode,
    o.bibNumber
FROM
	spl_2016.transactions as tr
JOIN spl_2016.outraw as o
	ON tr.itemNumber = o.itemNumber
/* 
# Just gonna do this in Python... I FUCKING GUESS
JOIN (
	SELECT 
		bibnumber,
		COUNT(bibNumber) as popularity
	FROM spl_2016.transactions as tr
	GROUP BY
		bibnumber
	 ) as p
     ON p.bibnumber = tr.bibnumber
*/
WHERE
	#i.cin is not null AND
	year(tr.checkOut) > 2012 AND 
    year(tr.checkOut) < 2014 AND
	o.itemtype REGEXP "(cas|cd|rec)" AND
    NOT o.itemtype REGEXP "dvd"
LIMIT 100000