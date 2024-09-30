-- Musical Tracks Many-to-One Exercise
-- Create the tables
CREATE TABLE album (
  id SERIAL,
  title VARCHAR(128) UNIQUE,
  PRIMARY KEY (id)
);

CREATE TABLE track (
  id SERIAL,
  title VARCHAR(128),
  len INTEGER,
  rating INTEGER,
  count INTEGER,
  album_id INTEGER REFERENCES album (id) ON DELETE CASCADE,
  UNIQUE (title, album_id),
  PRIMARY KEY (id)
);

DROP TABLE IF EXISTS track_raw;

CREATE TABLE track_raw (
  title TEXT,
  artist TEXT,
  album TEXT,
  album_id INTEGER,
  count INTEGER,
  rating INTEGER,
  len INTEGER
);

-- Copy the CSV contents to track_raw table
-- \copy track_raw(title, artist, album, count, rating, len) FROM PROGRAM 'curl -s "https://www.pg4e.com/tools/sql/library.csv"' WITH DELIMITER ','
--  CSV;
-- Select the distinct album names
SELECT DISTINCT
  album
FROM
  track_raw;

-- Insert the distinct album names to the album table
INSERT INTO
  album (title)
SELECT DISTINCT
  album
FROM
  track_raw;

-- Update the album id of each track_raw
UPDATE track_raw
SET
  album_id = (
    SELECT
      album.id
    FROM
      album
    WHERE
      album.title = track_raw.album
  );

-- Select the distinct track names
SELECT DISTINCT
  title
FROM
  track_raw;

-- Insert the distinct track names to the track table
INSERT INTO
  track (title)
SELECT DISTINCT
  title
FROM
  track_raw;

-- Update the len, rating, count, and album id of each track
UPDATE track
SET
  (len, rating, count, album_id) = (
    SELECT
      len,
      rating,
      count,
      album_id
    FROM
      track_raw
    WHERE
      track_raw.title = track.title
  )
WHERE
  EXISTS (
    SELECT
      1
    FROM
      track_raw
    WHERE
      track_raw.title = track.title
  );

-- Select 3 track titles and album titles
SELECT
  track.title,
  album.title
FROM
  track
  JOIN album ON track.album_id = album.id
ORDER BY
  track.title
LIMIT
  3;
