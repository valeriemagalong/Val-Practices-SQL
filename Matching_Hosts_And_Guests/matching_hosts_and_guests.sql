/*
Question sourced from StrataScratch.com
https://platform.stratascratch.com/coding/10078-find-matching-hosts-and-guests-in-a-way-that-they-are-both-of-the-same-gender-and-nationality

Database: MySQL
*/

-- Find matching hosts and guests pairs in a way that they are both of the same gender and nationality.
-- Output the host id and the guest id of matched pair.

-- My strategy: Use a cross join to create a result set of all possible row combinations of the
-- airbnb_hosts and airbnb_guests table, filtering by the rows where there is a match in gender and
-- nationality between the host and guest.  Since there are repeated hosts and guests in each table,
-- select only the distinct host/guest pairs with matching gender and nationality.

SELECT DISTINCT h.host_id, g.guest_id
FROM airbnb_hosts h
CROSS JOIN airbnb_guests g
WHERE h.gender = g.gender
    AND h.nationality = g.nationality;

-- Alternative solution using an inner join on two matching columns:

SELECT DISTINCT h.host_id, g.guest_id
FROM airbnb_hosts h
JOIN airbnb_guests g ON h.gender = g.gender
    AND h.nationality = g.nationality;
