#Lesson 1c Business Analytics

#Get the date of an order, and arrange in order of data
SELECT DATE(ordered_at) FROM ORDERS
ORDER BY 1
LIMIT 100;

#Lets say you've done the above and got the dates of all the orders, now you
#want to know how many orders there were on each date and order them as such

SELECT DATE(ordered_at) AS order_date, 
COUNT(1) AS n_orders
FROM orders
GROUP BY 1
ORDER BY 1; #the 1 in both of these refers to the column number that you want to order by

#if you wanted to order by number of orders this could be done by:

ORDER BY 2;
#or
ORDER BY n_orders; #I gave the alias n_orders

#if you want to group by date this could be done by:

GROUP BY 1;
#or
GROUP BY order_date;


#Lets say that you have one table, t1, with the food item ordered, the amount paid and the 
#order ID
#You also have another table, t2, with the order ID, and the delivery time and date
#You want to know how much money was made on each day.
#You need to join the two tables together.
#Then add up the data

SELECT DATE(ordered_at),
			 ROUND(SUM(amount_paid), 2)
FROM orders
JOIN order_items on
			 orders.id = order_items.order_id #indicate the unique identifiers to match the data between the two tables
GROUP BY 1
ORDER BY 1;

#Same as above, by now we're only interested in the money made from kale smoothies.
#For this we need to add a WHERE clause.

SELECT DATE(ordered_at),
			 ROUND(SUM(amount_paid), 2)
FROM orders
JOIN order_items on
			 orders.id = order_items.order_id
       WHERE order_items.name = 'kale-smoothie'
GROUP BY 1
ORDER BY 1;


# want to know how much each items has generated in revenue?

SELECT name, round( sum(amount_paid), 2) AS  'Total revenue'
FROM order_items
GROUP BY name
ORDER BY 2 desc; #this is how you do descending order


#now lets get the %revenue generated by each item
#for this we need the amount paid for each order item divided by the amount
#paid in total
#the synatx is a bit weird as it looks like you do the same thing twice, the 
#thing to appreciate is that the first SUM(amount_paid) is being grouped by 
#name, whereas the second one is not (i.e. it's just the total).

#effctively 'select sum(amount_paid) from order_items' acts as a number - the total
#revenue of all items put together.

SELECT name, 
	   round( SUM(amount_paid) /
       		(SELECT SUM(amount_paid) FROM order_items) 
       		* 100, 2) AS 'pct'
FROM order_items
GROUP BY name
ORDER BY 2 desc;

#Create a new column where you classify all of the items accoring to a few different
#categories
SELECT * CASE name
				when 'kale-smoothie'    then 'smoothie'
    			when 'banana-smoothie'  then 'smoothie'
    			when 'orange-juice'     then 'drink'
    			when 'soda'             then 'drink'
    			when 'blt'              then 'sandwich'
    			when 'grilled-cheese'   then 'sandwich'
    			when 'tikka-masala'     then 'dinner'
    			when 'chicken-parm'     then 'dinner'
     			else 'other'
FROM order_items
ORDER by id
LIMIT 100;

#now lets say that we want to know the percentage of revenue coming from each category
#of food item. The first column is the one we create, which we call category - this
#is what we later group by, which allows the percentage to be calculated

select
  case name
    when 'kale-smoothie'    then 'smoothie'
    when 'banana-smoothie'  then 'smoothie'
    when 'orange-juice'     then 'drink'
    when 'soda'             then 'drink'
    when 'blt'              then 'sandwich'
    when 'grilled-cheese'   then 'sandwich'
    when 'tikka-masala'     then 'dinner'
    when 'chicken-parm'     then 'dinner'
    else 'other'
  end as category, round(sum(amount_paid) /
    (select sum(amount_paid) from order_items) * 100, 2) as pct
from order_items
group by category
order by pct desc;

#Finish off by finding how many orders are repeat orders?
#The reorder rate  is the ratio of the total number of orders to the number of 
#people making orders. It uses the location where the orders are delivered as a
#way of identifying repeat customers.

select name, round(1.0 * count(distinct order_id) /
  count(distinct orders.delivered_to), 2) as reorder_rate
from order_items
  join orders on
    orders.id = order_items.order_id
group by 1
order by 2 desc;

