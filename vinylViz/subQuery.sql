# Jason Freeberg
# MAT 259 Winter 2017
# Join is very slow, so I will join them using Python

SELECT 
	bibnumber,
    COUNT(bibNumber) as popularity
FROM spl_2016.transactions as tr
GROUP BY
	bibNumber