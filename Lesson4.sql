#Lesson4

#indexing multiple tables

#a good database will have a unique identifier (ID) for each input, e.g. subject
#this id number should be unique and allows you to reference data stored across
#multiple tables effortlessly.
#You should designate one of the columns as a primary key, which ensures that no two
#values within that column are the same and that no values are NULL
#Only one column within a table can be designated as the primary key.

#Create a table, and designate the id column as the primary key
CREATE TABLE artists(id INTEGER PRIMARY KEY, 
	name TEXT);

#A foreign key is an id, which is the primary key for a different table, but not the
#primary key for this table.
#e.g. there may be table with musicians, where each musician has their own primary key
#and a different table with albums, where each album has it's own primary key
#and a column within the album table that also identifies which musician it is by
#their primary key - this would be a foreign key in the album table.

#Select all the album names and years from the album table and also the names from
#the artist table.
#this process is known as cross joining
#This example isn't particularly useful as it makes a database with every possible
#combination of album, year and artist - so nothing is correctly referenced
SELECT albums.name, albums.year, artists.name 
FROM albums, artists;

#A much more useful (and intuitive cross join would be)
SELECT *
FROM albums
JOIN artists ON albums.artist_id = artists.id;

#The * selection means that we want every column from both tables.
#We are querying the table albums
#We are doing an 'inner' join of artists to albums
#albums.artist_id = artists.id specifies how the two tables are related

#By default, the above code will only select the albums where a matching artist is
#found.
#If we want to include albums without matching artists we use LEFT JOIN, instead of
#just using JOIN
#This is an example of an outer join
#Left refers to the first table (albums), RIGHT would refer to the second table, artists.
#FULL OUTER will do both left and right joins
SELECT *
FROM albums
LEFT JOIN artists ON albums.artist_id = artists.id;


#When combining tables, you may end up with columns with the same header
#e.g. in this data set, in the albums database 'name' refers to album name, and in 
# the artist database 'name' refers to the artist's name.
#It is a good idea to rename column headers so that all headers are unique
#you can do this using the AS keyword, and then asign an alias (alternative col header)
SELECT
albums.name AS 'Album',
albums.year,
artists.name AS 'Artist'
FROM albums
JOIN artists ON 
albums.artist_id = artists.id
WHERE albums.year > 1980;


