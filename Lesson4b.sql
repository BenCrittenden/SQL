#Lesson4b

#some of these functions are specific to the flavour of SQL. These are for
#SQLlite

#get the date and time from a column in the baked_goods database
SELECT DATETIME(delivery_time) FROM baked_goods;

#Lets say I'm only interested in the date, not the time and want to know
#how many cakes were delivered on a certain day

SELECT DATE(delivery_time),
		COUNT(*) AS count_baked_goods
FROM baked_goods
GROUP BY DATE(delivery_time);

#if you want to add time to a datetime, that's possible.
#lets say that your goods a packaged 2 days, 5 hours 20 mins after delivery:
#create this new datetime in a column called package_time

SELECT DATETIME(delivery_time, '+5 hours', '20 minutes', '2 days') AS package_time
FROM baked_goods;

#Lets say that you want to change how many numbers that one of your columns is 
#rounded to:

SELECT ROUND(distance, 2) AS distance_from_market
FROM bakeries;

#CAST is another similar function that coverts an integer into a real number, which
#can be useful for math

CAST(number1 AS REAL)


#Say that you want to know the max value comparing two columns (cooking time and
#cooling time):

SELECT id, MAX(cook_time, cool_down_time) FROM baked_goods;

#concatenating strings from two speparate columns and putting them in a new column


SELECT first_name || ' ' || last_name AS full_name
FROM bakeries;


#If you want to replace a string with another string:
#Say you want to replace the string 'enriched_flour' with 'flour', in the column
#named ingredients:

SELECT REPLACE(ingredients,'enriched_','')
FROM baked_goods;

#or

SELECT REPLACE(ingredients,'enriched_flour','flour')
FROM baked_goods;
