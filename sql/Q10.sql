SELECT 
    LEAST(a.genre, a.sub_genre) AS genre_1,
    GREATEST(a.genre, a.sub_genre) AS genre_2,
    COUNT(*) AS pair_count
FROM Artist a
JOIN Performance p ON a.artist_id = p.artist_id
WHERE a.genre IS NOT NULL 
  AND a.sub_genre IS NOT NULL 
  AND a.genre != a.sub_genre
GROUP BY genre_1, genre_2
ORDER BY pair_count DESC
LIMIT 3;
