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

