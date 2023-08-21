/*
Question sourced from DataLemur.com
https://datalemur.com/questions/top-fans-rank

Database: PostgreSQL
*/

-- Assume there are three Spotify tables: artists, songs, and global_song_rank,
-- which contain information about the artists, songs, and music charts, respectively.

-- Write a query to find the top 5 artists whose songs appear most frequently
-- in the Top 10 of the global_song_rank table. Display the top 5 artist names
-- in ascending order, along with their song appearance ranking.

-- Assumptions:
    -- If two or more artists have the same number of song appearances, they
    -- should be assigned the same ranking, and the rank numbers should be
    -- continuous (i.e. 1, 2, 2, 3, 4, 5).

    -- For instance, if both Ed Sheeran and Bad Bunny appear in the Top 10 five
    -- times, they should both be ranked 1st and the next artist should be ranked 2nd.

-- My strategy: Join the artists, songs, and global_song_rank tables,
-- filtering by rows with a rank of 1 through 10, grouping by artist,
-- aggregating by song count, and using DENSE_RANK to get the artist rank
-- by song count.  Wrap this query in a CTE, and output the top 5 artists.

WITH top_artists AS (
  SELECT a.artist_name, COUNT(gsr.song_id) AS total_songs,
    DENSE_RANK() OVER(
      ORDER BY COUNT(gsr.song_id) DESC
    ) AS artist_rank
  FROM artists a
  JOIN songs s ON a.artist_id = s.artist_id
  JOIN global_song_rank gsr ON s.song_id = gsr.song_id
  WHERE gsr.rank BETWEEN 1 AND 10
  GROUP BY a.artist_name
)
SELECT artist_name, artist_rank
FROM top_artists
WHERE artist_rank BETWEEN 1 AND 5;
