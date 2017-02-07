# Jason Freeberg
# MAT 259A
# 3D Data Viz Project

# Query Explanation:
# Investigates the usage of audio materials over time. The query measures
# each item's number of checkouts, 
/*
SELECT
	tr.checkOut,
    tr.checkIn,
    ti.title,
    it.itemType,
    ca.callNumber
FROM spl_2016.transactions as tr
JOIN spl_2016.title as ti			# Title
	ON ti.bibNumber = tr.bibNumber
JOIN spl_2016.itemType as it		# Item type
	ON it.itemNumber = tr.itemNumber
JOIN spl_2016.callNumber as ca		# callNumber
	ON ca.itemNumber = it.itemNumber
WHERE
	it.itemType REGEXP "(cas|cd|rec)" AND
    NOT it.itemtype REGEXP "dvd"
LIMIT 500;
*/

SELECT *
from spl_2016.outraw
limit 1000;