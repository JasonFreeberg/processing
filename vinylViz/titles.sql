

SELECT DISTINCT
    #tr.checkOut,
    o.title,
    o.bibNumber,
    o.deweyClass
FROM spl_2016.transactions as tr
JOIN spl_2016.outraw as o
	ON tr.bibNumber = o.bibNumber
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
    AND ROUND(o.deweyClass) IN(781, 782)
    AND year(tr.checkOut) >= 2009
    AND year(tr.checkOut) <= 2011