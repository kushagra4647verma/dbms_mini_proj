CREATE SEQUENCE airline_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE destination_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE flight_seq START WITH 1 INCREMENT BY 1;

CREATE TABLE Airlines (
  airline_id   NUMBER PRIMARY KEY,
  name         VARCHAR2(100) NOT NULL
);

CREATE TABLE Destinations (
  destination_id NUMBER PRIMARY KEY,
  city           VARCHAR2(100) NOT NULL
);

CREATE TABLE Flights (
  flight_id      NUMBER PRIMARY KEY,
  airline_id     NUMBER REFERENCES Airlines(airline_id) ON DELETE CASCADE,
  destination_id NUMBER REFERENCES Destinations(destination_id) ON DELETE CASCADE,
  flight_date    DATE,
  departure_time TIMESTAMP,
  arrival_time   TIMESTAMP,
  gate_number    VARCHAR2(10)
);

CREATE TABLE Bookings (
  pnr            VARCHAR2(20) PRIMARY KEY,
  passenger_name VARCHAR2(100),
  flight_id      NUMBER REFERENCES Flights(flight_id) ON DELETE CASCADE,
  baggage_id     VARCHAR2(20),
  belt_number    VARCHAR2(10)
);

-- Triggers for auto increment, views, and procedures omitted for brevity but use your original script

-- 2. Triggers for Auto-Increment -----------------------------------
CREATE OR REPLACE TRIGGER trg_airline_id
  BEFORE INSERT ON Airlines
  FOR EACH ROW
BEGIN
  :new.airline_id := airline_seq.NEXTVAL;
END;
/

CREATE OR REPLACE TRIGGER trg_destination_id
  BEFORE INSERT ON Destinations
  FOR EACH ROW
BEGIN
  :new.destination_id := destination_seq.NEXTVAL;
END;
/

CREATE OR REPLACE TRIGGER trg_flight_id
  BEFORE INSERT ON Flights
  FOR EACH ROW
BEGIN
  :new.flight_id := flight_seq.NEXTVAL;
END;
/

-- 3. Views for Common Queries --------------------------------------
-- Upcoming flights view
CREATE OR REPLACE VIEW vw_upcoming_flights AS
SELECT 
  f.flight_id,
  a.name   AS airline,
  d.city   AS destination,
  f.flight_date,
  f.departure_time,
  f.arrival_time,
  f.gate_number
FROM Flights f
JOIN Airlines a   ON f.airline_id = a.airline_id
JOIN Destinations d ON f.destination_id = d.destination_id
WHERE f.flight_date >= TRUNC(SYSDATE);

-- Booking summary per city
CREATE OR REPLACE VIEW vw_booking_summary AS
SELECT
  d.city,
  COUNT(b.pnr)           AS total_bookings,
  MIN(f.flight_date)     AS first_flight,
  MAX(f.flight_date)     AS last_flight
FROM Bookings b
JOIN Flights f     ON b.flight_id = f.flight_id
JOIN Destinations d ON f.destination_id = d.destination_id
GROUP BY d.city;

-- 4. PL/SQL Procedure Using a Cursor --------------------------------
CREATE OR REPLACE PROCEDURE list_bookings_by_city (
  p_city   IN  VARCHAR2,
  p_refcur OUT SYS_REFCURSOR
) AS
BEGIN
  OPEN p_refcur FOR
    SELECT b.pnr, b.passenger_name, f.flight_date
    FROM Bookings b
    JOIN Flights f     ON b.flight_id      = f.flight_id
    JOIN Destinations d ON f.destination_id = d.destination_id
    WHERE d.city = p_city;
END;
/
