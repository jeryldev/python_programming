-- Musical Track Database plus Artists Many-to-Many Relationship Exercise
DROP TABLE album CASCADE;

CREATE TABLE album (
  id SERIAL,
  title VARCHAR(128) UNIQUE,
  PRIMARY KEY (id)
);

DROP TABLE track CASCADE;

CREATE TABLE track (
  id SERIAL,
  title TEXT,
  artist TEXT,
  album TEXT,
  album_id INTEGER REFERENCES album (id) ON DELETE CASCADE,
  count INTEGER,
  rating INTEGER,
  len INTEGER,
  PRIMARY KEY (id)
);

DROP TABLE artist CASCADE;

CREATE TABLE artist (
  id SERIAL,
  name VARCHAR(128) UNIQUE,
  PRIMARY KEY (id)
);

DROP TABLE tracktoartist CASCADE;

CREATE TABLE tracktoartist (
  id SERIAL,
  track VARCHAR(128),
  track_id INTEGER REFERENCES track (id) ON DELETE CASCADE,
  artist VARCHAR(128),
  artist_id INTEGER REFERENCES artist (id) ON DELETE CASCADE,
  PRIMARY KEY (id)
);

-- Copy the CSV contents to track
-- \copy track(title,artist,album,count,rating,len) FROM PROGRAM 'curl -s "https://www.pg4e.com/tools/sql/library.csv"' WITH DELIMITER ',' CSV;
-- Populate album table
INSERT INTO
  album (title)
SELECT DISTINCT
  album
FROM
  track;

-- Update the track album_id after populating the album table
UPDATE track
SET
  album_id = (
    SELECT
      album.id
    FROM
      album
    WHERE
      album.title = track.album
  );

-- Populate artist table
INSERT INTO
  artist (name)
SELECT DISTINCT
  artist
FROM
  track;

-- Populate the tracktoartist table
INSERT INTO
  tracktoartist (track, artist, track_id, artist_id)
SELECT DISTINCT
  t.title,
  a.name,
  t.id,
  a.id
FROM
  track t
  LEFT JOIN artist a ON t.artist = a.name;

-- Delete the text fields from track and tracktoartist tables
ALTER TABLE track
DROP COLUMN album;

ALTER TABLE track
DROP COLUMN artist;

ALTER TABLE tracktoartist
DROP COLUMN track;

ALTER TABLE tracktoartist
DROP COLUMN artist;
