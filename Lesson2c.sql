#Lesson2c

#find out the number of players of a game on a given day, but ignoring multiple plays by the same player, i.e. how many distinct players?


select date(created_at), count(distinct (user_id) ) as dau
from gameplays
group by 1
order by 1;