#Lesson3

#using the fictional database fake_apps

#How many rows are in the data?
SELECT COUNT(*) FROM fake_apps;

#How many of those apps are free?
SELECT COUNT(*) FROM fake_apps
WHERE price = 0;

#A little more complex now
#How many apps are there at each price?
#In this example, GROUP BY is a clause and is only used by aggregate functions
SELECT price, COUNT(*) FROM fake_apps
GROUP BY price;

#Now lets count the number of apps at each price, but only those that have been
#downloaded more than 20 thousand times
SELECT price, COUNT(*) FROM fake_apps
WHERE downloads > 20000
GROUP BY price;

#What is the total number of downloads of all apps
SELECT SUM(downloads) FROM fake_apps;

#and doing the same but grouping by price:
SELECT price, SUM(downloads) 
FROM fake_apps
GROUP BY price;

#How many downloads does the most popular app have?
SELECT MAX(downloads) FROM fake_apps;

#How do you get the names of the most downloaded apps in each category?
#Selection criteria are name, category and max(downloads)

SELECT name, category, MAX(downloads)
FROM fake_apps
GROUP BY category;

#do the same for the least downloaded in each category
SELECT name, category, MIN(downloads) 
FROM fake_apps
GROUP BY category;

#what's the average number of downloads for apps at each price, rounding to 2dp
#for no d.p. i.e. integer, just don't give an argument to ROUND
SELECT price, ROUND(AVG(downloads), 2) 
FROM fake_apps
GROUP BY price;
