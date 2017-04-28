#SQL Lesson2 - selecting data

#Lets get the names and ratings of different movies from the movies database
SELECT name, imdb_rating 
FROM movies;

#If you want to know which distinct values a parameter/column has:
SELECT DISTINCT genre FROM movies;

#Lets say you only want the movies where the rating is greater than 8
SELECT * FROM movies 
WHERE imdb_rating > 8;

#How do you select strings that are similar to eachother?
#wildcard character. The _ means you can substitute any 
#individual character here without breaking the pattern
SELECT * FROM movies 
WHERE name LIKE 'Se_en';

#How do you select strings that begin with a certain letter/string?
#Use the % wildcard character
SELECT * FROM movies
WHERE name LIKE 'a%';

#How do you use wildcards before and after a string?
#also using the % wildcard
SELECT * FROM movies
WHERE name LIKE '%man%';

#Similarly, if you want all the movies that end with 2
SELECT * FROM movies
WHERE name LIKE '%2';

#Select all the movies that start with a letter between A and J (including A and J)
#or between two dates
SELECT * FROM movies
WHERE name BETWEEN 'A' AND 'J';

SELECT * FROM movies
WHERE year BETWEEN 1990 AND 2000;

#Joint selection criteria
SELECT * FROM movies
WHERE year BETWEEN 1990 AND 2000
AND genre = 'comedy';

SELECT * FROM movies
WHERE genre = 'comedy'
OR year < 1980;

#select data and reorder accoring to rating
SELECT * FROM movies
ORDER BY imdb_rating DESC;

#select data and reorder, but limit to only the first 3
SELECT * FROM movies
ORDER BY imdb_rating ASC
LIMIT 3;
