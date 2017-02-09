# Jason Freeberg
# MAT 259A
# 3D Data Viz Project

# Query Explanation:
# Investigates the usage of audio materials over time. The query measures
# each item's number of checkouts, 

SELECT
	unix_timestamp(tr.checkOut) as checkOut,
    unix_timestamp(tr.checkIn) as checkIn,
    ti.title,
    #j.popularity,
    it.itemType,
    ca.callNumber
FROM spl_2016.transactions as tr
/*
JOIN 
	(SELECT 
		bibNumber,
        COUNT(bibNumber) as popularity
	FROM
		spl_2016.transactions
	GROUP BY bibNumber
	) as j
    ON j.bibNumber = tr.bibNumber
*/
JOIN spl_2016.title as ti			# Title
	ON ti.bibNumber = tr.bibNumber
JOIN spl_2016.itemType as it		# Item type
	ON it.itemNumber = tr.itemNumber
JOIN spl_2016.callNumber as ca		# callNumber
	ON ca.itemNumber = it.itemNumber
WHERE
	year(tr.checkOut) >= 2005 AND
	it.itemType REGEXP "(cas|cd|rec)" AND
    NOT it.itemtype REGEXP "dvd"
ORDER BY
	unix_timestamp(tr.checkOut)

