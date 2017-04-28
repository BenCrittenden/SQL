#Lesson1b

#subqueries

#select the top 10 rows of the data
SELECT * FROM flights LIMIT 10;

#In our airplanes database, you'd like to know which flights had an origin airport 
#with an elevation greater than 2000 feet. We can do this with a subquery. 
#This is a non-correlated subquery
#This uses two databases: airports and flights
SELECT *
FROM flights
WHERE origin in (
	SELECT code
	FROM airports
	WHERE elevation < 2000);

#From the flights database, find the airports that come from a particular faa region
#called ASO.
#This also uses the two databases.
SELECT * 
FROM flights 
WHERE origin in (
    SELECT code 
    FROM airports
    WHERE faa_region = 'ASO');


#Lets say that you want to get the average distance flown by planes, for each day of 
#the week for each month. i.e. aveage over the mondays in january...

SELECT a.dep_month, #later we create a table with the name a here we index the month column
       a.dep_day_of_week, #here we index the day column of a
       AVG(a.flight_distance) AS average_distance #we average the distances and rename that column using AS
  FROM ( #now we select from a subselection of the flights table
        SELECT dep_month,
               dep_day_of_week,
               dep_date,
               sum(distance) AS flight_distance #sum up all the distances and rename that column
          FROM flights
    			GROUP BY 1,2,3 #this makes sure that you keep the month week and date columns
       ) a #create the variable a
 GROUP BY 1,2 #this makes sure that you 
 ORDER BY 1,2;

 #Now lets say that you want to know how many flights left for each day of the week
 #for each month

 SELECT a.dep_month,
       a.dep_day_of_week,
       AVG(a.flight_count) AS average_flights
  FROM (
        SELECT dep_month,
              dep_day_of_week,
               dep_date,
               COUNT(*) AS flight_count
          FROM flights
         GROUP BY 1,2,3
       ) a
 GROUP BY 1,2
 ORDER BY 1,2;


 #Find the id of the flights whose distance is below the average for their carrier
 #the code is kind of backwards, as the bit that you need to do first is at the end.

SELECT id #this is the column we ultimately want (to create)
FROM flights AS f
WHERE distance < (
  SELECT AVG(distance)
  FROM flights
  WHERE carrier = f.carrier);

# let's say that we want a table that has the origin, id number and the flight sequence
#number - i.e. where in the order of flights it flew out of the airport.

#first we need to select the columns we want (origin and id) as well as make a new
#column for that flights position that we are going to create.
#next we say where we getting the data from

#f is the alias of flights, so id and origin must be columns in the flights table.

#(this assumes that flight id is assigned in order of departure)

SELECT origin, id,
    (SELECT COUNT(*)
	FROM flights f
	WHERE f.id < flights.id
	AND f.origin=flights.origin) + 1
AS flight_sequence_number
FROM flights;
