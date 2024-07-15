CREATE TABLE netflix_data (
    show_id TEXT,
    type TEXT,
    title TEXT,
    director TEXT,
    cast TEXT,
    country TEXT,
    date_added TEXT,
    release_year INTEGER,
    rating TEXT,
    duration TEXT,
    listed_in TEXT,
    description TEXT
);
INSERT INTO netflix_data (show_id, type, title, director, cast, country, date_added, release_year, rating, duration, listed_in, description) VALUES 
('81145628', 'Movie', 'Norm of the North: King Sized Adventure', 'Richard Finn, Tim Maltby', 'Alan Marriott, Andrew Toth, Brian Dobson, Cole Howard', 'United States, India, South Korea, China', 'September 9, 2019', 2019, 'TV-PG', '90 min', 'Children & Family Movies, Comedies', 'Before planning an awesome wedding for his grandfather, a polar bear king must take back a stolen artifact from an evil archaeologist first.');

SELECT country, COUNT(show_id) as total_shows
FROM netflix_data
GROUP BY country
ORDER BY total_shows DESC;


SELECT type, COUNT(show_id) as total
FROM netflix_data
GROUP BY type;


SELECT rating, COUNT(show_id) as total
FROM netflix_data
GROUP BY rating;


SELECT listed_in, COUNT(show_id) as total
FROM netflix_data
GROUP BY listed_in
ORDER BY total DESC
LIMIT 10;

SELECT release_year, type, COUNT(show_id) as total
FROM netflix_data
GROUP BY release_year, type
ORDER BY release_year;


SELECT description, duration, release_year, date_added, rating
FROM netflix_data
WHERE show_id = '81145628';

