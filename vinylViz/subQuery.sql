# Jason Freeberg
# MAT 259 Winter 2017
# Join is very slow, so I will join them using Python

SELECT
    year(tr.checkOut) as yearOut,
    month(tr.checkOut) as monthOut,
    weekOfYear(tr.checkOut) as weekOut,
    if(o.bibnumber = 2149593, 1, 0) as thrillerCount
FROM
	spl_2016.transactions as tr
JOIN spl_2016.outraw as o
	ON tr.itemNumber = o.itemNumber
WHERE
	year(tr.checkOut) >= 2009 AND 
    year(tr.checkOut) <= 2011 AND
	(o.itemType REGEXP "cd" AND NOT o.itemtype REGEXP "(cas|bccd|acdisk|dvd|rec)") AND # Only CDs
    ROUND(o.deweyClass) = 782 # 782 is "vocal music"
GROUP BY
	yearOut, monthOut, dayOut