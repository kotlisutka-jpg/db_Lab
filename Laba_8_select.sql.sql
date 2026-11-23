SELECT Number_track, Capacity, review
FROM Track
WHERE Operational_status = 'рабочая' AND Crib_bumpers = TRUE
ORDER BY Capacity DESC, Number_track ASC;

SELECT Fname, Lname, phone_number, bonus_balance
FROM Client
ORDER BY bonus_balance DESC
LIMIT 3;

SELECT 
    type_footwear,
    COUNT(ID) AS games_count,
    SUM(total_order) AS total_revenue,
    ROUND(AVG(total_order), 2) AS avg_check,
    MIN(total_order) AS min_check,
    MAX(total_order) AS max_check
FROM Game
GROUP BY type_footwear;

SELECT Client_id, COUNT(ID) AS reservations_count
FROM Reservation
GROUP BY Client_id
HAVING COUNT(ID) > 1;

SELECT Shoe_size, Total_quantity, Available_quantity
FROM Footwear
WHERE Available_quantity < 10
ORDER BY Available_quantity ASC;
