/*
Question sourced from StrataScratch.com
https://platform.stratascratch.com/coding/10159-ranking-most-active-guests

Database: MySQL
*/

-- Rank guests based on the number of messages they've exchanged with the hosts. Guests with the same
-- number of messages as other guests should have the same rank. Do not skip rankings if the preceding
-- rankings are identical.

-- My strategy: Since the question explicitly states to NOT skip rankings in case of ties, use the
-- DENSE_RANK() window function over the window of total messages by guest (i.e. the sum of all messages
-- sent by each guest.)

SELECT DENSE_RANK() OVER(ORDER BY SUM(n_messages) DESC) AS guest_rank,
    id_guest, SUM(n_messages) AS total_messages
FROM airbnb_contacts
GROUP BY id_guest;
