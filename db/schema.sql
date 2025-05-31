-- Drop existing tables if they exist (ignore errors if they don't exist)
DROP TABLE Bookings CASCADE CONSTRAINTS;
DROP TABLE Flights CASCADE CONSTRAINTS;
DROP TABLE Destinations CASCADE CONSTRAINTS;
DROP TABLE Airlines CASCADE CONSTRAINTS;

-- Drop sequences if they exist
DROP SEQUENCE airline_seq;
DROP SEQUENCE destination_seq;
DROP SEQUENCE flight_seq;

-- Drop views if they exist
DROP VIEW VW_BOOKING_SUMMARY;
DROP VIEW VW_UPCOMING_FLIGHTS;

-- Create sequences
CREATE SEQUENCE airline_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE destination_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE flight_seq START WITH 1 INCREMENT BY 1;

-- Create Airlines table
CREATE TABLE Airlines (
  airline_id   NUMBER PRIMARY KEY,
  name         VARCHAR2(100) NOT NULL
);

-- Create Destinations table
CREATE TABLE Destinations (
  destination_id NUMBER PRIMARY KEY,
  city           VARCHAR2(100) NOT NULL
);

-- Create Flights table
CREATE TABLE Flights (
  flight_id      NUMBER PRIMARY KEY,
  airline_id     NUMBER REFERENCES Airlines(airline_id) ON DELETE CASCADE,
  destination_id NUMBER REFERENCES Destinations(destination_id) ON DELETE CASCADE,
  flight_date    DATE,
  departure_time TIMESTAMP,
  arrival_time   TIMESTAMP,
  gate_number    VARCHAR2(10)
);

-- Create Bookings table
CREATE TABLE Bookings (
  pnr            VARCHAR2(20) PRIMARY KEY,
  passenger_name VARCHAR2(100) NOT NULL,
  flight_id      NUMBER REFERENCES Flights(flight_id) ON DELETE CASCADE,
  baggage_id     VARCHAR2(20),
  belt_number    VARCHAR2(10)
);

-- Create triggers for auto-increment
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

-- Create upcoming flights view (fixed syntax)
CREATE OR REPLACE VIEW VW_UPCOMING_FLIGHTS AS
SELECT 
  f.flight_id,
  a.name AS airline,
  d.city AS destination,
  f.flight_date,
  f.departure_time,
  f.arrival_time,
  f.gate_number
FROM Flights f
JOIN Airlines a ON f.airline_id = a.airline_id
JOIN Destinations d ON f.destination_id = d.destination_id
WHERE f.flight_date >= TRUNC(SYSDATE);
/

-- Create booking summary view (fixed syntax)
CREATE OR REPLACE VIEW VW_BOOKING_SUMMARY AS
SELECT
  d.city,
  COUNT(b.pnr) AS total_bookings,
  MIN(f.flight_date) AS first_flight,
  MAX(f.flight_date) AS last_flight
FROM Bookings b
JOIN Flights f ON b.flight_id = f.flight_id
JOIN Destinations d ON f.destination_id = d.destination_id
GROUP BY d.city;
/

-- Create procedure for listing bookings by city
CREATE OR REPLACE PROCEDURE list_bookings_by_city (
  p_city IN VARCHAR2,
  p_refcur OUT SYS_REFCURSOR
) AS
BEGIN
  OPEN p_refcur FOR
    SELECT b.pnr, b.passenger_name, f.flight_date
    FROM Bookings b
    JOIN Flights f ON b.flight_id = f.flight_id
    JOIN Destinations d ON f.destination_id = d.destination_id
    WHERE d.city = p_city;
END;
/
