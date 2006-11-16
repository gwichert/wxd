(Tests were done with PostgreSQL)

Create a dabatbase named test

Create table testtable:

CREATE TABLE testtable(
	id	VARCHAR(19),
	name VARCHAR(200),
	street VARCHAR(200),
	city VARCHAR(200)
);

Fill the table with some test-data: 
INSERT INTO testtable (id, name, street, city) VALUES ('1', 'John Doe', 'Bakerstreet', 'Chicago');
....

Don't forget to change the settings in
dbcon.ConnectionString ="DSN=test;UID=alex;DATABASE=test";
to the settings that you need.

Alexander Olk
