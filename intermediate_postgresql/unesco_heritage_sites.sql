-- Unesco Heritage Sites Many-to-One
DROP TABLE IF EXISTS unesco_raw;

CREATE TABLE unesco_raw (
  name TEXT,
  description TEXT,
  justification TEXT,
  year INTEGER,
  longitude FLOAT,
  latitude FLOAT,
  area_hectares FLOAT,
  category TEXT,
  category_id INTEGER,
  state TEXT,
  state_id INTEGER,
  region TEXT,
  region_id INTEGER,
  iso TEXT,
  iso_id INTEGER
);

CREATE TABLE category (
  id SERIAL,
  name VARCHAR(128) UNIQUE,
  PRIMARY KEY (id)
);

-- Create additional tables
CREATE TABLE iso (
  id SERIAL,
  name VARCHAR(128) UNIQUE,
  PRIMARY KEY (id)
);

CREATE TABLE state (
  id SERIAL,
  name VARCHAR(128) UNIQUE,
  PRIMARY KEY (id)
);

CREATE TABLE region (
  id SERIAL,
  name VARCHAR(128) UNIQUE,
  PRIMARY KEY (id)
);

CREATE TABLE unesco (
  id SERIAL,
  name VARCHAR(255) NOT NULL,
  description TEXT,
  justification TEXT,
  year INTEGER,
  longitude FLOAT,
  latitude FLOAT,
  area_hectares FLOAT,
  category_id INTEGER REFERENCES category (id),
  iso_id INTEGER REFERENCES iso (id),
  state_id INTEGER REFERENCES state (id),
  region_id INTEGER REFERENCES region (id),
  PRIMARY KEY (id)
);

-- Copy the CSV contents to unesco_raw
-- \copy unesco_raw(name, description, justification, year, longitude, latitude, area_hectares, category, state, region, iso) FROM PROGRAM 'curl -s "https://www.pg4e.com/tools/sql/whc-sites-2018-small.csv"' WITH (FORMAT CSV, HEADER true, DELIMITER ',');
-- Populate the category, iso, state, region, and unesco tables
INSERT INTO
  category (name)
SELECT DISTINCT
  category
FROM
  unesco_raw
WHERE
  category IS NOT NULL;

INSERT INTO
  iso (name)
SELECT DISTINCT
  iso
FROM
  unesco_raw
WHERE
  iso IS NOT NULL;

INSERT INTO
  state (name)
SELECT DISTINCT
  state
FROM
  unesco_raw
WHERE
  state IS NOT NULL;

INSERT INTO
  region (name)
SELECT DISTINCT
  region
FROM
  unesco_raw
WHERE
  region IS NOT NULL;

INSERT INTO
  unesco (
    name,
    description,
    justification,
    year,
    longitude,
    latitude,
    area_hectares,
    category_id,
    iso_id,
    state_id,
    region_id
  )
SELECT
  ur.name,
  ur.description,
  ur.justification,
  -- Option 1: With checks
  -- CASE 
  --   WHEN ur.year ~ '^[0-9]+$' THEN ur.year::INTEGER
  --   ELSE NULL
  -- END,
  -- ur.longitude::FLOAT,
  -- ur.latitude::FLOAT,
  -- CASE 
  --   WHEN ur.area_hectares ~ '^[0-9]+(\.[0-9]+)?$' THEN ur.area_hectares::FLOAT
  --   ELSE NULL
  -- END,
  -- Option 2: With casting
  -- ur.year::INTEGER, 
  -- ur.longitude::FLOAT, 
  -- ur.latitude::FLOAT, 
  -- ur.area_hectares::FLOAT, 
  ur.year,
  ur.longitude,
  ur.latitude,
  ur.area_hectares,
  c.id,
  i.id,
  s.id,
  r.id
FROM
  unesco_raw ur
  LEFT JOIN category c ON ur.category = c.name
  LEFT JOIN iso i ON ur.iso = i.name
  LEFT JOIN state s ON ur.state = s.name
  LEFT JOIN region r ON ur.region = r.name;
