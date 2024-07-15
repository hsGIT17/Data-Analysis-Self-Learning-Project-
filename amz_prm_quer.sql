
SELECT Genre, COUNT(*) AS TitleCount
FROM amazon_prime_data
GROUP BY Genre
ORDER BY Genre;

SELECT strftime('%Y', ReleaseDate) AS ReleaseYear, COUNT(*) AS TitleCount
FROM amazon_prime_data
WHERE strftime('%Y', ReleaseDate) BETWEEN '2000' AND '2020'
GROUP BY ReleaseYear
ORDER BY ReleaseYear;

SELECT
  CASE WHEN Type = 'Movie' THEN 'Movie' ELSE 'TV Show' END AS TitleType,
  COUNT(*) AS TitleCount
FROM amazon_prime_data
GROUP BY TitleType;

SELECT Rating, COUNT(*) AS TitleCount
FROM amazon_prime_data
GROUP BY Rating
ORDER BY Rating;

SELECT Region, COUNT(*) AS TitleCount
FROM amazon_prime_data
GROUP BY Region
ORDER BY Region;