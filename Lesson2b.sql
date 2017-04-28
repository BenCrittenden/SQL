#Lesson 2b

#select the top 10 rows of the data
SELECT * FROM flights LIMIT 10;

#Merging

#When merging row, this is called a JOIN
#When merging columns, this is called a UNION

#When merging columns, the data must have the same number of columns on both sides
#of the merge and also similar data types

#Here, merge the brand column from legacy_products database and the brand column from
#the new_products database

SELECT brand FROM legacy_products
UNION
SELECT brand FROM new_products;

#Here's an example where you combine multiple columns and allow duplicates with ALL

SELECT id, sale_price FROM order_items
UNION ALL
SELECT id, sale_price FROM order_items_historic;

#Now lets say that you want the average sales price from data from 2 databases merged
#into one column, keeping the id information
#you need to use an alias here and also GROUP BY to make sure that the average isn't 
#done over everything.

SELECT id, avg(a.sale_price) FROM (
  SELECT id, sale_price FROM order_items
  UNION ALL
  SELECT id, sale_price FROM order_items_historic) 
AS a
GROUP BY 1;


#Lets say you want to select all the rows from two tables with matching info
#e.g. all the categories of items in two databases
#For this you use INTERSECT, which finds the rows in db2 that match db1

SELECT category FROM new_products
INTERSECT
SELECT category FROM legacy_products;


#Similarly, if we want to know what rows are specific to one db we use EXCEPT
#e.g. what rows in legacy products are NOT in new_products

SELECT category FROM legacy_products
EXCEPT
SELECT category FROM new_products;

