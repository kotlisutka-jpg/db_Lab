SELECT 
    g.Team_name,
    c.Fname || ' ' || c.Lname AS client_name,
    g.Track_number,
    d.Type_Discount,
    g.total_order
FROM Game g
INNER JOIN Client c ON g.Client_id = c.ID
LEFT JOIN Discount d ON g.Discount_id = d.ID;

SELECT 
    g.Team_name,
    f.Shoe_size,
    gf.Quantity_rented,
    f.Available_quantity AS left_in_wardrobe
FROM Game_Footwear gf
INNER JOIN Game g ON gf.Game_id = g.ID
INNER JOIN Footwear f ON gf.Footwear_id = f.ID
ORDER BY g.Team_name, f.Shoe_size;

SELECT c.ID, c.Fname, c.Lname, c.phone_number
FROM Client c
LEFT JOIN Game g ON c.ID = g.Client_id
WHERE g.ID IS NULL;

SELECT d.Type_Discount, d.Magnitude, g.Team_name, g.total_order
FROM Game g
RIGHT JOIN Discount d ON g.Discount_id = d.ID;

SELECT r.ID AS reservation_id, r.Booking_status, g.ID AS game_id, g.Team_name
FROM Reservation r
FULL OUTER JOIN Game g ON r.ID = g.Reservation_id;

SELECT t.Number_track, d.Type_Discount, d.Magnitude
FROM Track t
CROSS JOIN Discount d
WHERE t.Operational_status = 'рабочая';

SELECT 'Бронь #' || ID::text AS event_type, Registration_Date::text AS details
FROM Reservation
UNION
SELECT 'Игра: ' || Team_name, 'Сумма: ' || total_order::text
FROM Game;
