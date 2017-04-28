#Lesson3b

#Aggregate functions

#count the number of rows in a database (count is an aggregate function)
SELECT COUNT(*) FROM flights;

#Let's say that you only want to count the rows

SELECT COUNT(*) FROM flights 
WHERE arr_time IS NOT NULL 
AND destination = 'ATL';

#IF ELSE...

#In SQL they use SELECT CASE

#Here we create a new column called elevation_tier, using the data in the elevation
#column of the airports database

SELECT
    CASE
        WHEN elevation < 500 
        	THEN 'Low'
        WHEN elevation BETWEEN 500 AND 1999 
        	THEN 'Medium'
        WHEN elevation >= 2000 
        	THEN 'High'
        ELSE 
        	'Unknown' #if else is not included, they default is NULL
    END AS elevation_tier
    , COUNT(*)
FROM airports
GROUP BY 1;


#Lets say that you want to know how many airports there are below a certain elevation
#in each state. (the airports database only has US airports)

#specify that the first column will be state, the second one the count of airports
#that meet your criteria

#then you have your codintional statement that says when an aiport is less than 1000ft
#of elevation give it a 1, otherwise a NULL. The count function then counts the 
#number of airports (i.e. the number of 1's) that meet this criteria.

#Finally, indicate which database you're getting this data from
#and indicate that you want the sum to be done over each state using group by.

SELECT state,
		COUNT(CASE
         WHEN elevation < 1000
         THEN 1
         ELSE NULL
         END)
    as count_low_elevation_airports
FROM airports
GROUP BY state;

#Lets say you want to know the distances flown by all planes and just delta airlines
#specifically, for each airport origin.
#create three columns, taking one directly and creating the other two
#sum over distances for all airlines
#then do case where you only count distances when the carrier is DL (delta)
#specify the database where the info is coming from
#don't forget to group by the airport of origin

SELECT origin, 
			 sum(distance) AS total_flight_distance, 						 
			 sum(CASE 
           			WHEN carrier = 'DL' 
		   			THEN distance 
           			ELSE 0
           			END) AS total_delta_flight_distance 
FROM flights 
GROUP BY origin;

#IF you wanted to know percentages:

SELECT origin, 
			100.0 * (SUM(CASE 
                   	WHEN carrier = 'DL'
                   	THEN distance 
                   	ELSE 0
                   	END)
               		/sum(distance)) AS percentage_flight_distance_from_delta 
FROM flights
GROUP BY origin;

#Another example

SELECT state, 
			100 * SUM(CASE 
                   	WHEN elevation >= 2000 
                   	THEN 1 
                   	ELSE 0 
                   	END)
               / COUNT(*) AS percentage_high_elevation_airports 
FROM airports
GROUP BY state;

