INSERT INTO Client (Fname, Lname, phone_number, bonus_balance) VALUES
('Август', 'ВандерХольт', '+375291112233', 15.50),
('Олег', 'Волков', '+375292223344', 40.00),
('Сергей', 'Разумовский', '+375333334242', 0.00),
('Дмитрий', 'Дубин', '+375444445566', 120.00),
('Игорь', 'Гром', '+375295556677', 5.00);

INSERT INTO Track (Number_track, review, Operational_status, Capacity, Crib_bumpers) VALUES
(1, 'Новая дорожка, отличное покрытие', 'рабочая', 6, TRUE),
(2, 'Идеально для детских праздников', 'рабочая', 6, TRUE),
(3, 'Стандартная дорожка', 'рабочая', 8, FALSE),
(4, 'Замена механизма возврата шаров', 'на ремонте', 6, FALSE),
(5, 'Стандартная дорожка', 'рабочая', 8, TRUE);

INSERT INTO Discount (Type_Discount, Magnitude, Condition_for_obtaining) VALUES
('льготная', 20.00, 'Студентам и школьникам при предъявлении документа'),
('по дню недели', 15.00, 'Скидка по понедельникам и вторникам до 17:00'),
('накопительная бонусная', 10.00, 'При накоплении более 100 бонусных баллов');

INSERT INTO Workers (Job_title) VALUES
('Администратор зала'),
('Механик дорожек'),
('Старший администратор');

INSERT INTO Footwear (Shoe_size, Total_quantity, Available_quantity) VALUES
(32.0, 6, 4),
(38.5, 10, 7),
(39.0, 12, 10),
(41.0, 15, 11),
(42.0, 15, 13);

INSERT INTO Reservation (Client_id, Track_number, Booking_status, Booking_duration, Time_type, Prepayment) VALUES
(1, 1, 'оплачено полностью', 2, '2026-11-20 18:00:00', 50.00),
(2, 2, 'внесена предоплата', 1, '2026-11-20 19:00:00', 25.00),
(4, 5, 'завершено', 2, '2026-11-15 20:00:00', 80.00),
(1, 3, 'ожидает предоплаты', 1, '2026-11-22 16:00:00', 0.00),
(5, 1, 'аннулировано', 2, '2026-11-14 15:00:00', 0.00);

INSERT INTO Game (Team_name, Client_id, Reservation_id, Discount_id, Track_number, type_footwear, Text, total_order) VALUES
('Чумной доктор', 4, 3, 3, 5, 'аренда', 'День рождения, заказали дополнительно напитки', 145.00),
('Лисы', 3, NULL, 1, 3, 'аренда', 'Пришли без брони по студенческим билетам', 64.00),
('Троянцы', 1, 1, NULL, 1, 'своя обувь', 'Постоянные игроки со своими шарами и обувью', 110.00),
('Семейка Адамс', 2, NULL, 2, 2, 'аренда', 'Игра с детьми, включены детские бортики', 51.00);

INSERT INTO Game_Footwear (Game_id, Footwear_id, Quantity_rented) VALUES
(1, 5, 2), (1, 2, 3), (2, 4, 4), (4, 1, 2), (4, 3, 2);

INSERT INTO Oversees_G (Worker_id, Game_id) VALUES
(1, 1), (2, 1), (1, 2), (2, 3), (4, 4);

INSERT INTO Oversees_R (Worker_id, Reservation_id) VALUES
(1, 1), (4, 2), (1, 3), (4, 4);
