# drop example database
DROP DATABASE record_company;

# create new database for exercises
CREATE DATABASE record_company;
USE record_company;

CREATE TABLE bands (
  id INT NOT NULL AUTO_INCREMENT,
  name VARCHAR(255) NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE albums (
  id INT NOT NULL AUTO_INCREMENT,
  name VARCHAR(255) NOT NULL,
  release_year INT,
  band_id INT NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (band_id) REFERENCES bands(id)
);

# 1. Create a Songs Table
CREATE TABLE songs (
	id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    length FLOAT NOT NULL,
    album_id INT NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (album_id) REFERENCES albums(id)
);

# 2. Select only the Names of all the bands
SELECT bands.name AS 'Band Name'
FROM bands;

# 3. Select the Oldest Album
SELECT * FROM albums
WHERE release_years IS NOT NULL
ORDER BY release_year
LIMIT 1;

# 4. Get all Bands that have Albums
/* Assuming all bands have unique name */
SELECT DISTINCT bands.name AS 'Band Name'
FROM bands
JOIN albums ON bands.id = albums.band_id;

/* If bands don't have a unique name:

SELECT bands.name AS 'Band Name'
FROM bands
JOIN albums ON bands.id = albums.band_id
GROUP BY albums.band_id
HAVING COUNT (albums.id) > 0;
*/

# 5. Get all Bands that have No Albums
SELECT bands.name AS 'Band Name'
FROM bands
LEFT JOIN albums ON bands.id = albums.band_id
GROUP BY albums.band_id
HAVING COUNT(albums.id) = 0;

# 6. Get the Longest Album
SELECT
	albums.name as Name,
    albums.release_year as 'Release Year',
    SUM(songs.length) as 'Duration'
FROM albums
JOIN songs on albums.id = songs.album_id
GROUP BY songs.album_id
ORDER BY Duration DESC
LIMIT 1;

# 7. Update the Release Year of the Album with no Release Year
UPDATE albums
SET release_year = 1986
WHERE id = 4;

# 8. Insert a record for your favorite Band and one of their Albums
INSERT INTO bands(name)
VALUES ('Favorite Band Name');

INSERT INTO albums (name, release_year, band_id)
VALUES('Favorite Album Name', 2000, 8);

# 9. Delete the Band and Album you added in #8
DELETE FROM albums
WHERE id = 19;

DELETE FROM bands
WHERE id = 8;

# 10. Get the Average Length of all Songs
SELECT AVG(length) as 'Average Song Duration'
FROM songs;

# 11. Select the longest Song off each Album
SELECT
	albums.name AS 'Album'
    albums.release_year AS 'Release Year'
    MAX(songs.length) AS 'Duration'
FROM albums
JOIN songs ON albums.id = songs.album_id
GROUP BY songs.album_id;

# 12. Get the number of Songs for each Band 
SELECT
	bands.name as 'Band'
    COUNT(songs.id) AS 'Number of Songs'
FROM bands
JOIN albums ON bands.id = albums.band_id
JOIN songs ON albums.id = songs.album_id
GROUP BY albums.band_id;



















