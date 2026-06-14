-- create user table
CREATE TABLE IF NOT EXISTS Users (
    user_id SERIAL PRIMARY KEY,
    full_name VARCHAR(50) NOT NULL,
    email VARCHAR(50) NOT NULL UNIQUE,
    role VARCHAR(25) NOT NULL DEFAULT 'Football Fan' CHECK (role IN('Ticket Manager','Football Fan')),
    phone_number VARCHAR(15)
);

-- create match table
CREATE TABLE IF NOT EXISTS Matches (
    match_id SERIAL PRIMARY KEY,
    fixture VARCHAR(100) NOT NULL,
    tournament_category VARCHAR(50) NOT NULL,
    base_ticket_price DECIMAL(10,2) NOT NULL,
    match_status VARCHAR(25) DEFAULT 'Available' CHECK (match_status IN('Available', 'Selling Fast', 'Sold Out', 'Postponed'))
);

-- create booking table
CREATE TABLE Bookings (
    booking_id SERIAL PRIMARY KEY,
    user_id INT NOT NULL,
    FOREIGN KEY(user_id) REFERENCES Users(user_id),
    match_id INT NOT NULL,
    FOREIGN KEY(match_id) REFERENCES Matches(match_id),
    seat_number VARCHAR(25),
    payment_status VARCHAR(25) CHECK (payment_status IN('Pending', 'Confirmed', 'Cancelled', 'Refunded')),
    total_cost DECIMAL(10,2) NOT NULL,
    
);



INSERT INTO Users (user_id, full_name, email, role, phone_number) VALUES
(1, 'Tanvir Rahman', 'tanvir@mail.com', 'Football Fan', '+8801711111111'),
(2, 'Asif Haque', 'asif@mail.com', 'Football Fan', '+8801722222222'),
(3, 'Sajjad Rahman', 'sajjad@mail.com', 'Ticket Manager', '+8801733333333'),
(4, 'Jannat Ara', 'jannat@mail.com', 'Football Fan', NULL),
(5,'Tanvir Islam','tanvir@gmail.com','Football Fan','+8801712321463')


INSERT INTO Matches (match_id, fixture, tournament_category, base_ticket_price, match_status) VALUES
(101, 'Real Madrid vs Barcelona', 'Champions League', 150.00, 'Available'),
(102, 'Man City vs Liverpool', 'Premier League', 120.00, 'Selling Fast'),
(103, 'Bayern Munich vs PSG', 'Champions League', 130.00, 'Available'),
(104, 'AC Milan vs Inter Milan', 'Serie A', 90.00, 'Sold Out'),
(105, 'Juventus vs Roma', 'Serie A', 80.00, 'Available');


INSERT INTO Bookings (booking_id, user_id, match_id, seat_number, payment_status, total_cost) VALUES
(501, 1, 101, 'A-12', 'Confirmed', 150.00),
(502, 1, 102, 'B-04', 'Confirmed', 120.00),
(503, 2, 101, 'A-13', 'Confirmed', 150.00),
(504, 2, 101, NULL, NULL, 150.00),
(505, 3, 102, 'C-20', 'Pending', 120.00),
(506,5,105,'A-10','Pending',130.00);


-- quey 1
SELECT match_id, fixture, base_ticket_price 
FROM Matches 
WHERE tournament_category='Champions League' AND match_status='Available'

-- query 2
SELECT user_id,full_name,email
FROM Users
WHERE full_name ILIKE 'tanvir%' OR full_name ILIKE '%Haque%'

-- query 3
SELECT booking_id, user_id, match_id, COALESCE (payment_status, 'Action Required') AS systematic_status
FROM Bookings WHERE payment_status IS NULL

-- query 4
SELECT booking_id, full_name, fixture, total_cost 
FROM Bookings AS b 
INNER JOIN Users AS u 
ON u.user_id = b.user_id 
INNER JOIN Matches AS m 
ON m.match_id = b.match_id

-- query 5
SELECT u.user_id, u.full_name, b.booking_id
FROM Users AS u LEFT JOIN Bookings AS b
ON u.user_id = b.user_id