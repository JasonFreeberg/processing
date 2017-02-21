/*
 Jason Freeberg
 MAT 259A -- Winter 2017
 Checkouts of audio CDs in the SPL database. Narrowed down to only
 music CDs. Since the query can take a long time, I se
*/

SELECT 
	unix_timestamp(tr.checkOut) as checkOut,
    unix_timestamp(tr.checkIn) as checkIn,
    IFNULL(tr.checkIn - tr.checkOut, 0) as timeOut,
    o.title,
    o.itemType,
    o.bibNumber,
    o.deweyClass
FROM
	spl_2016.transactions as tr
JOIN spl_2016.outraw as o
	ON tr.itemNumber = o.itemNumber
WHERE
	year(tr.checkOut) > 2015 AND 
    year(tr.checkOut) < 2017 AND
	(o.itemType REGEXP "cd" AND NOT o.itemtype REGEXP "(cas|bccd|acdisk|dvd|rec)") AND # Only CDs
    ROUND(o.deweyClass) = 782 # 782 is "vocal music"
limit
	1000000