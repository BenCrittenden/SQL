#Codecademy on SQL

#In SQL everything before a semicolon is treated as the same line, even if they
#appear on different lines, such as the CREATE TABLE command below

#Comment using the hash

#

#to select/load data
SELECT * FROM dbname #* is a wildcard, not a multiplication

#to create a table
CREATE TABLE celebs (id INTEGER,
                    name TEXT,
                    age INGEGER); #it's important to finish lines with semicolon

#to add data to a table
INSERT INTO celebs (id, name, age) VALUES (1, 'Justin Bieber', 21);

INSERT INTO celebs (id, name, age) VALUES (2, 'Beyonce Knowles', 33); 
INSERT INTO celebs (id, name, age) VALUES (3, 'Jeremy Lin', 26); 
INSERT INTO celebs (id, name, age) VALUES (4, 'Taylor Swift', 26);

#to look at the data in a particular column
SELECT name FROM celebs;

#to change the data within a table
UPDATE celebs
SET age = 22
WHERE id = 1;

SELECT * FROM celebs; #you do this to get a printout on screen - not necessary

#to add a new column to an existing table
ALTER TABLE celebs ADD COLUMN twitter_handle TEXT;

#another example of update
UPDATE celebs 
SET twitter_handle = 
'@taylorswift13'
WHERE id = 4;

#By default, if no data is entered, data is NULL

#To delete data, e.g. are the rows where there is a NULL value for twitter_handle

DELETE FROM celebs 
WHERE twitter_handle IS NULL;


