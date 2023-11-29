/*
Question sourced from StrataScratch.com
https://platform.stratascratch.com/coding/9633-city-with-most-amenities

Database: MySQL
*/

-- You're given a dataset of searches for properties on Airbnb. For simplicity, let's say that each
-- search result (i.e., each row) represents a unique host. Find the city with the most amenities
-- across all their host's properties. Output the name of the city.

-- My strategy: Since one record in the amenities column is a comma-separated list of amenities, the
-- total number of amenities per list needs to be quantified. Using the LENGTH function, get the total
-- number of characters in the list, and subtract the length of the list with all commas removed, plus
-- one. (A comma follows a single amenity; adding one accounts for the last amenity in the list that
-- isn't followed by a comma.) After deriving the total amenities for each host, group by city and get
-- the sum of the amenities across host properties in that city. Wrap this result set in a CTE, then
-- filter by the city with the max number of amenities.

WITH amenities_summary AS (
    SELECT city,
        SUM(
            LENGTH(amenities) -
            LENGTH(REPLACE(amenities, ',', '')) + 1
            ) AS total_amenities
    FROM airbnb_search_details
    GROUP BY city
)
SELECT city
FROM amenities_summary
WHERE total_amenities = (SELECT MAX(total_amenities) FROM amenities_summary);
