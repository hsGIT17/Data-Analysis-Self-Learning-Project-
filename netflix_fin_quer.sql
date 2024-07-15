-- To set dynamically (requires SUPER privilege):
SET GLOBAL wait_timeout = 600;
SET GLOBAL interactive_timeout = 600;

CREATE DATABASE IF NOT EXISTS HEMENDRA; -- Created a Database HEMENDRA
USE HEMENDRA;

SHOW TABLES;
SHOW VARIABLES LIKE 'secure_file_priv';

DROP TABLE netflix_data;
CREATE TABLE netflix_data (
    show_id VARCHAR(20),
    type VARCHAR(20),
    title VARCHAR(255),
    director TEXT,
    cast TEXT,
    country VARCHAR(100),
    date_added DATE,
    release_year INT,
    rating VARCHAR(20),
    duration VARCHAR(20),
    listed_in VARCHAR(100),
    description TEXT
);

LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\netflix_data.csv'
INTO TABLE netflix_data
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(show_id, type, title, director, cast, country, @date_added, release_year, rating, duration, listed_in, description)
SET date_added = STR_TO_DATE(@date_added, '%M %d, %Y');

-- Verify the data
SELECT * FROM netflix_data;

SELECT DISTINCT country FROM netflix_data;


CREATE TABLE country_to_continent (
    country VARCHAR(100),
    continent VARCHAR(20)
);

INSERT INTO country_to_continent (country, continent) VALUES
-- Add your country-to-continent mappings here
('Canada', 'North America'),
('India', 'Asia'),
('United States', 'North America'),
('United Kingdom', 'Europe'),
('France', 'Europe'),
('Spain', 'Europe'),
('Italy', 'Europe'),
('Japan', 'Asia'),
('China', 'Asia'),
('Denmark', 'Europe'),
('Czech Republic', 'Europe'),
('Netherlands', 'Europe'),
('Ireland', 'Europe'),
('Germany', 'Europe'),
('Australia', 'Australia'),
('Belgium', 'Europe'),
('Chile', 'South America'),
('Argentina', 'South America'),
('Mexico', 'North America'),
('Sweden', 'Europe'),
('New Zealand', 'Australia'),
('Portugal', 'Europe'),
('Brazil', 'South America'),
('Switzerland', 'Europe'),
('Iran', 'Asia'),
('South Africa', 'Africa'),
('Egypt', 'Africa'),
('United Arab Emirates', 'Asia'),
('Luxembourg', 'Europe'),
('Monaco', 'Europe'),
('Afghanistan', 'Asia'),
('Colombia', 'South America'),
('Norway', 'Europe'),
('Kosovo', 'Europe'),
('Albania', 'Europe'),
('Kazakhstan', 'Asia'),
('Malaysia', 'Asia'),
('Poland', 'Europe'),
('Georgia', 'Europe'),
('South Korea', 'Asia')
-- Add more mappings as needed
;



-- 1st Query
WITH country_expansion AS (
    SELECT
        show_id,
        title,
        listed_in,
        TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(country, ',', numbers.n), ',', -1)) AS country
    FROM
        netflix_data
        CROSS JOIN (
            SELECT 1 AS n UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5
            UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9 UNION ALL SELECT 10
        ) numbers
    WHERE
        numbers.n <= 1 + LENGTH(country) - LENGTH(REPLACE(country, ',', ''))
),
genre_expansion AS (
    SELECT
        show_id,
        TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(listed_in, ',', numbers.n), ',', -1)) AS genre,
        country
    FROM
        country_expansion
        CROSS JOIN (
            SELECT 1 AS n UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5
            UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9 UNION ALL SELECT 10
        ) numbers
    WHERE
        numbers.n <= 1 + LENGTH(listed_in) - LENGTH(REPLACE(listed_in, ',', ''))
)
SELECT
    g.genre,
    c.continent,
    COUNT(*) AS movie_count
FROM
    genre_expansion g
    INNER JOIN country_to_continent c ON g.country = c.country
GROUP BY
    g.genre,
    c.continent
ORDER BY
    c.continent,
    g.genre;


-- 2nd Query
WITH genre_expansion AS (
    SELECT
        show_id,
        TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(listed_in, ',', numbers.n), ',', -1)) AS genre
    FROM
        netflix_data
        CROSS JOIN (
            SELECT 1 AS n UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5
            UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9 UNION ALL SELECT 10
        ) numbers
    WHERE
        numbers.n <= 1 + LENGTH(listed_in) - LENGTH(REPLACE(listed_in, ',', ''))
)
SELECT
    genre,
    COUNT(*) AS record_count
FROM
    genre_expansion
GROUP BY
    genre
ORDER BY
    record_count DESC;

-- 3rd Query
SELECT
    release_year,
    COUNT(*) AS release_count
FROM
    netflix_data
WHERE
    release_year BETWEEN 2000 AND 2020
GROUP BY
    release_year
ORDER BY
    release_year;


-- 4th Query
SELECT
    type,
    COUNT(*) AS count,
    ROUND(COUNT() / (SELECT COUNT() FROM netflix_data) * 100, 2) AS percentage
FROM
    netflix_data
GROUP BY
    type;


-- 5th Query
SELECT
    rating,
    COUNT(*) AS title_count
FROM
    netflix_data
GROUP BY
    rating;