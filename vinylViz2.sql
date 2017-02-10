



SELECT 
	unix_timestamp(tr.checkOut) as checkOut,
    unix_timestamp(tr.checkIn) as checkIn,
    IFNULL(tr.checkIn - tr.checkOut, 0) as timeOut,
    o.title,
    o.itemType
FROM
	spl_2016.transactions as tr
JOIN spl_2016.outraw as o
	ON tr.bibNumber = o.bibNumber
WHERE
	#i.cin is not null AND
	year(tr.checkOut) > 2006 AND
	o.itemtype REGEXP "(cas|cd|rec)" AND
    NOT o.itemtype REGEXP "dvd"
LIMIT 150
	


/*
SELECT
	unix_timestamp(o.cout) as checkOut,
    unix_timestamp(i.cin) as checkIn,
    o.cout,
    i.cin,
	i.cin - o.cout as timeOut,
    o.title,
    o.itemtype,
    o.callNumber
FROM
	spl_2016.outraw as o
JOIN spl_2016.inraw as i
	ON i.barcode = o.barcode
WHERE
	#i.cin is not null AND
	year(o.cout) > 2008 AND
	o.itemtype REGEXP "(cas|cd|rec)" AND
    NOT o.itemtype REGEXP "dvd"
#ORDER BY
#	checkOut ASC
LIMIT 800
*/