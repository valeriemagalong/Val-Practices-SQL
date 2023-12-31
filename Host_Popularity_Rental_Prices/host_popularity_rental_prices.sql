/*
Question sourced from StrataScratch.com
https://platform.stratascratch.com/coding/9632-host-popularity-rental-prices

Database: MySQL
*/

-- You’re given a table of rental property searches by users. The table consists of search results and
-- outputs host information for searchers. Find the minimum, average, maximum rental prices for each host’s
-- popularity rating. The host’s popularity rating is defined as below:
    -- 0 reviews: New
    -- 1 to 5 reviews: Rising
    -- 6 to 15 reviews: Trending Up
    -- 16 to 40 reviews: Popular
    -- more than 40 reviews: Hot

-- My strategy: Since each row of the the airbnb_host_searches table represents a single search, it may be
-- the case that there are duplicated rental properties in this table. First, create a CTE where price,
-- room_type, host_since, and zip_code are concatenated to produce a host_rental_id column. Keep only the
-- distinct host_rental_ids, so that one row in this CTE represents a unique rental property. Since there
-- is no popularity rating column in the original table, this column needs to be derived based on the
-- number_of_reviews column using conditional logic (i.e. CASE statement). Lastly, use the CTE to group by
-- popularity rating, getting the minimum, average, and maximum rental prices for each group.

WITH host_rentals AS (
    SELECT
        DISTINCT CONCAT(price, room_type, host_since, zipcode) AS host_rental_id,
        price,
        number_of_reviews,
        CASE WHEN number_of_reviews = 0 THEN 'New'
            WHEN number_of_reviews < 6 THEN 'Rising'
            WHEN number_of_reviews < 16 THEN 'Trending Up'
            WHEN number_of_reviews < 41 THEN 'Popular'
            ELSE 'Hot'
        END AS popularity_rating
    FROM airbnb_host_searches
)
SELECT popularity_rating,
    MIN(price) AS min_price,
    AVG(price) AS avg_price,
    MAX(price) AS max_price
FROM host_rentals
GROUP BY popularity_rating;
