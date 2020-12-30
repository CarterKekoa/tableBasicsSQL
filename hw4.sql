-- Carter Mooring
-- CPSC321 Databases
-- HW4
-- Description:

-- Start using emacs: emacs -nw hw4.sql  
-- TO Save: hold 'control' and type 'xs'
-- TO SEARCH: 'control s' to 'control g' to quit
-- end of line: 'control e'
-- recenter: 'conrtol l'

-- default engine is innodb
SET sql_mode = STRICT_ALL_TABLES;

DROP TABLE IF EXISTS consistsOf;
DROP TABLE IF EXISTS producers;
DROP TABLE IF EXISTS writtenBy;
DROP TABLE IF EXISTS members;
DROP TABLE IF EXISTS influenced;
DROP TABLE IF EXISTS associated;
DROP TABLE IF EXISTS musicGroup;
DROP TABLE IF EXISTS musicArtist;
DROP TABLE IF EXISTS musicTrack;
DROP TABLE IF EXISTS song;
DROP TABLE IF EXISTS album;
DROP TABLE IF EXISTS recordLabel;

CREATE TABLE recordLabel(
	label_name VARCHAR (40),
	year_founded YEAR,
	type VARCHAR (20),
	PRIMARY KEY (label_name)
);

CREATE TABLE album(
	title VARCHAR (30),
	group_name VARCHAR (30),
	year_founded YEAR,
	label_name VARCHAR (40),
	PRIMARY KEY (title, group_name),
	FOREIGN KEY (label_name) REFERENCES recordLabel (label_name)
);

CREATE TABLE song(
	title VARCHAR (20),
	year_written YEAR,
	PRIMARY KEY (title)
);

CREATE TABLE musicTrack(
	date_recorded DATE,
	track_name VARCHAR (30),
	PRIMARY KEY (track_name),
	FOREIGN KEY (track_name) REFERENCES song (title)
);

CREATE TABLE musicArtist(
	artist_name VARCHAR (40),
	birth_year YEAR,
	PRIMARY KEY (artist_name)
);

CREATE TABLE musicGroup(
	group_name VARCHAR (30),
	year_formed YEAR,
	PRIMARY KEY (group_name)
);

CREATE TABLE associated(
	genre_type VARCHAR (20),
	music_group VARCHAR (30),
	PRIMARY KEY (genre_type, music_group),
	FOREIGN KEY (music_group) REFERENCES musicGroup (group_name)
);

CREATE TABLE influenced(
	group_influencing VARCHAR (30),
	group_influenced_by VARCHAR (30),
	PRIMARY KEY (group_influencing, group_influenced_by),
	FOREIGN KEY (group_influencing) REFERENCES musicGroup (group_name),
	FOREIGN KEY (group_influenced_by) REFERENCES musicGroup (group_name)
);

CREATE TABLE members(
	member_name VARCHAR (40),
	group_name VARCHAR (30),
	range_start DATE,
	range_end DATE,
	PRIMARY KEY (member_name, group_name),
	FOREIGN KEY (member_name) REFERENCES musicArtist (artist_name),
	FOREIGN KEY (group_name) REFERENCES musicGroup (group_name)
);

CREATE TABLE writtenBy(
	song_name VARCHAR (20),
	artist_name VARCHAR (40),
	PRIMARY KEY (song_name, artist_name),
	FOREIGN KEY (song_name) REFERENCES song (title),
	FOREIGN KEY (artist_name) REFERENCES musicArtist (artist_name)
);

CREATE TABLE producers(
	artist_name VARCHAR (40),
	track_name VARCHAR (30),
	PRIMARY KEY (artist_name, track_name),
	FOREIGN KEY (artist_name) REFERENCES musicArtist (artist_name),
	FOREIGN KEY (track_name) REFERENCES musicTrack (track_name)
);

CREATE TABLE consistsOf(
	album_name VARCHAR (30),
	track_name VARCHAR (30),
	PRIMARY KEY (album_name, track_name),
	FOREIGN KEY (album_name) REFERENCES album (title),
	FOREIGN KEY (track_name) REFERENCES musicTrack (track_name)
);

-- To View Tables: select * from recordLabel;
INSERT INTO recordLabel VALUES
       ("Sony Music Entertainment", 1929, "Various"),
       ("Universal Music Publishing Group", 1934, "Various"),
       ("Warner Music Group", 1958, "Various"),
       ("Island Records", 1959, "Pop/Rock"),
       ("BMG Rights Management", 2008, "Various");

INSERT INTO album VALUES
       ("Error in the System", "Peter Schilling", 1983, "Warner Music Group"),
       ("California", "Blink-182", 2016, "BMG Rights Management"),
       ("Unbreakable", "Janet Jackson", 2015, "BMG Rights Management"),
       ("Burnin", "The Wailers", 1973, "Island Records"),
       ("Legends Never Die", "Juice WRLD", 2020, "Universal Music Publishing Group"),
       ("As I Am", "Alicia Keys", 2007, "Sony Music Entertainment"),
       ("Stankonia", "OutKast", 2000, "Sony Music Entertainment");

INSERT INTO song VALUES
       ("Hello World", 1983),
       ("No More", 2000),
       ("Research", 2005),
       ("Took 2 Long", 1996),
       ("Sorry Mrs Jackson", 2000);

INSERT INTO musicTrack VALUES
       ('1983-9-3', "Hello World"),
       ('2000-10-13', "No More"),
       ('2005-7-24', "Research"),
       ('1996-4-9', "Took 2 Long"),
       ('2000-5-7', "Sorry Mrs Jackson");

INSERT INTO musicArtist VALUES
       ("Kanye West", 1977),
       ("Janet Jackson", 1966),
       ("Andre 3000", 1975),
       ("Big Boi", 1975);

INSERT INTO musicGroup VALUES
       ("OutKast", 1991),
       ("The Wailers", 1963),
       ("Blink-182", 1992);

INSERT INTO associated VALUES
       ("Hip-Hop", "OutKast"),
       ("Punk Rock", "Blink-182"),
       ("Pop-Punk", "Blink-182"),
       ("Reggae", "The Wailers"),
       ("Rocksteady", "The Wailers"),
       ("Ska", "The Wailers");

INSERT INTO influenced VALUES
       ("The Wailers", "OutKast"),
       ("The Wailers", "Blink-182");

INSERT INTO members VALUES
       ("Andre 3000", "OutKast", '1991-4-13', '2006-7-3'),
       ("Big Boi", "OutKast", '1991-4-13', '2006-7-4');
       
INSERT INTO writtenBy VALUES
       ("Sorry Mrs Jackson", "Andre 3000"),
       ("Sorry Mrs Jackson", "Big Boi");

INSERT INTO producers VALUES
       ("Andre 3000", "Sorry Mrs Jackson");

INSERT INTO consistsOf VALUES
       ("Stankonia", "Sorry Mrs Jackson");
