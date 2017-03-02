/*
 Jason Freeberg
 MAT 259A -- Winter 2017
 Checkouts of audio CDs in the SPL database. Narrowed down to only
 music CDs. Since the query can take a long time, I se

*/



SELECT DISTINCT # lots of duplicate transactions in this table
	unix_timestamp(tr.checkOut) as checkOut,
    IFNULL(unix_timestamp(tr.checkIn), 0) as checkIn,
    o.title,
    year(tr.checkOut) as yearOut,
    month(tr.checkOut) as monthOut,
    weekOfYear(tr.checkOut) as weekOut
FROM
	spl_2016.transactions as tr
JOIN spl_2016.outraw as o
	ON tr.itemNumber = o.itemNumber
WHERE
	 lower(o.title) IN(
        "number ones",
		"off the wall",
		"thriller",
		"bad",
		"dangerous",
		"history past present and future book 1",
		"invincible",
        "michael",
		"escape"
        )    
     AND (IFNULL( 
		PERIOD_DIFF( date_format(tr.checkIn, "%YYYY%MM"), date_format(tr.checkOut, "%YYYY%MM") ) +
            (year(tr.checkIn) - year(tr.checkOut)) * 12, 0) <= 1) 
	AND year(tr.checkOut) >= 2007 
    AND year(tr.checkOut) <= 2011 
    AND (o.itemType REGEXP "cd" AND NOT o.itemtype REGEXP "(cas|bccd|acdisk|dvd|rec)") # Only CDs
    AND ROUND(o.deweyClass) IN(781, 782) # 782 is "vocal music"
