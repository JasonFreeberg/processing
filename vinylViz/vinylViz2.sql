

SELECT 
	unix_timestamp(o.cout) as checkOut,
    unix_timestamp(o.cin) as checkIn,
    o.title,
    
    o.itemtype
FROM
	spl_2016.outraw as o
WHERE
	o.itemtype REGEXP "(cas|cd|rec)" AND
    NOT o.itemtype REGEXP "dvd"
LIMIT 100