

SELECT
    CASE
		WHEN ti.title LIKE "bourne identity" THEN 0
        WHEN ti.title LIKE "bourne supremacy" THEN 1
        WHEN ti.title LIKE "bourne ultimatum" THEN 2
        WHEN ti.title LIKE "bourne legacy" THEN 3
        WHEN ti.title LIKE "jason bourne" THEN 4 END
	AS title,
    # Unix timestamps
	unix_timestamp(tr.checkOut) as checkOut,
    unix_timestamp(tr.checkIn) AS checkIn,
	round(abs(unix_timestamp(tr.checkIn)- unix_timestamp(tr.checkOut))/60/60/24, 4) AS daysOut,
	meanTimes.meanDaysOut,
    # day, month, year of checkout
    day(tr.checkOut) as dayOut,
    month(tr.checkOut) as monthOut,
    year(tr.checkOut) as yearOut,
    # day, month, year of checkin
    day(tr.checkIn) as dayIn,
    month(tr.checkIn) as monthIn,
    year(tr.checkIn) as yearIn
FROM spl_2016.transactions as tr
JOIN spl_2016.title as ti
	ON tr.bibNumber = ti.bibNumber
JOIN
	(SELECT
		ti.title as title,
		unix_timestamp(tr.checkOut) as dayOut,
		round(avg(abs(unix_timestamp(tr.checkIn) - unix_timestamp(tr.checkOut))/60/60/24),4) AS meanDaysOut
	FROM spl_2016.transactions as tr
	JOIN spl_2016.title as ti
		ON tr.bibNumber = ti.bibNumber
	WHERE 
		year(tr.checkOut) >= 2005 AND
        tr.Checkin is not NULL AND
		(ti.title LIKE "bourne identity" OR
		ti.title LIKE "bourne supremacy" OR
		ti.title LIKE "bourne ultimatum" OR
		ti.title LIKE "bourne legacy" OR
		ti.title LIKE "jason bourne")
	GROUP BY
		title
	) as meanTimes
    ON meanTimes.title = ti.title
WHERE 
	year(tr.checkOut) >= 2005 AND
    tr.checkIn is not NULL AND
    (ti.title LIKE "bourne identity" OR
	ti.title LIKE "bourne supremacy" OR
    ti.title LIKE "bourne ultimatum" OR
    ti.title LIKE "bourne legacy" OR
    ti.title LIKE "jason bourne")
ORDER BY
	title asc,
    dayOut asc
