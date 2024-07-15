
SELECT
  country,
  COUNT(*) AS total_shows
FROM netflix_data
GROUP BY country
ORDER BY total_shows DESC;

SELECT
  type,
  COUNT(*) AS total_shows,
  ROUND((COUNT(*) * 100.0) / (SELECT COUNT(*) FROM netflix_data), 2) AS percentage
FROM netflix_data
GROUP BY type;


SELECT
  rating,
  COUNT(*) AS total_shows
FROM netflix_data
GROUP BY rating
ORDER BY total_shows DESC;

SELECT
  release_year,
  SUM(CASE WHEN type = 'Movie' THEN 1 ELSE 0 END) AS total_movies,
  SUM(CASE WHEN type = 'TV Show' THEN 1 ELSE 0 END) AS total_tv_shows
FROM netflix_data
GROUP BY release_year
ORDER BY release_year;

SELECT
  genre,
  COUNT(*) AS total_shows
FROM netflix_data
WHERE genre IS NOT NULL
GROUP BY genre
ORDER BY total_shows DESC
LIMIT 10;