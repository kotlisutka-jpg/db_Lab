CREATE TABLE Client (
    ID SERIAL PRIMARY KEY,
    Fname VARCHAR(100) NOT NULL,
    Lname VARCHAR(100) NOT NULL,
    phone_number VARCHAR(20) NOT NULL UNIQUE,
    bonus_balance NUMERIC(10, 2) DEFAULT 0.00 CHECK (bonus_balance >= 0)
);

CREATE TABLE Track (
    Number_track INTEGER PRIMARY KEY CHECK (Number_track > 0),
    review TEXT,
    Operational_status VARCHAR(50) NOT NULL DEFAULT 'рабочая'  	
        CHECK (Operational_status IN ('рабочая', 'нерабочая', 'на ремонте')),
    Capacity INTEGER NOT NULL CHECK (Capacity > 0),
    Crib_bumpers BOOLEAN NOT NULL DEFAULT FALSE
);

CREATE TABLE Discount (
    ID SERIAL PRIMARY KEY,
    Type_Discount VARCHAR(50) NOT NULL 
        CHECK (Type_Discount IN ('льготная', 'по дню недели', 'накопительная бонусная')),
    Magnitude NUMERIC(5, 2) NOT NULL CHECK (Magnitude >= 0 AND Magnitude <= 100),
    Condition_for_obtaining TEXT NOT NULL
);

CREATE TABLE Workers (
    ID SERIAL PRIMARY KEY,
    Job_title VARCHAR(100) NOT NULL
);

CREATE TABLE Reservation (
    ID SERIAL PRIMARY KEY,
    Client_id INTEGER NOT NULL REFERENCES Client(ID) ON DELETE CASCADE,
    Track_number INTEGER NOT NULL REFERENCES Track(Number_track) ON DELETE RESTRICT,
    Registration_Date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    Booking_status VARCHAR(50) NOT NULL DEFAULT 'ожидает предоплаты'
        CHECK (Booking_status IN ('ожидает предоплаты', 'внесена предоплата', 'оплачено полностью', 'завершено', 'аннулировано')),
        Booking_duration INTEGER NOT NULL CHECK (Booking_duration IN (1, 2)),
    Time_type TIMESTAMP NOT NULL,
    Prepayment NUMERIC(10, 2) NOT NULL DEFAULT 0.00 CHECK (Prepayment >= 0)

);

CREATE TABLE Game (
    ID SERIAL PRIMARY KEY,
    Name_Comands VARCHAR(150) NOT NULL,
    Client_id INTEGER NOT NULL REFERENCES Client(ID) ON DELETE CASCADE,
    Reservation_id INTEGER UNIQUE REFERENCES Reservation(ID) ON DELETE SET NULL,
    Discount_id INTEGER REFERENCES Discount(ID) ON DELETE SET NULL,
    Track_number INTEGER NOT NULL REFERENCES Track(Number_track) ON DELETE RESTRICT,
    type_footwear VARCHAR(50) NOT NULL CHECK (type_footwear IN ('своя обувь', 'аренда')),
    Specialized_footwear VARCHAR(100),
    Text TEXT,
    total_order NUMERIC(10, 2) NOT NULL DEFAULT 0.00 CHECK (total_order >= 0)
);

CREATE TABLE Oversees_G (
    Worker_id INTEGER NOT NULL REFERENCES Workers(ID) ON DELETE CASCADE,
    Game_id INTEGER NOT NULL REFERENCES Game(ID) ON DELETE CASCADE,
    PRIMARY KEY (Worker_id, Game_id)
);

CREATE TABLE Oversees_R (
    Worker_id INTEGER NOT NULL REFERENCES Workers(ID) ON DELETE CASCADE,
    Reservation_id INTEGER NOT NULL REFERENCES Reservation(ID) ON DELETE CASCADE,
    PRIMARY KEY (Worker_id, Reservation_id)
);

CREATE INDEX idx_reservation_client ON Reservation(Client_id);
CREATE INDEX idx_reservation_track_time ON Reservation(Track_number, Time_type);
CREATE INDEX idx_game_client ON Game(Client_id);
 
