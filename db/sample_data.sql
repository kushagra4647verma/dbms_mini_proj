-- Insert Airlines
INSERT INTO Airlines (name) VALUES ('Air India');
INSERT INTO Airlines (name) VALUES ('IndiGo');
INSERT INTO Airlines (name) VALUES ('SpiceJet');
INSERT INTO Airlines (name) VALUES ('Vistara');
INSERT INTO Airlines (name) VALUES ('GoAir');

-- Insert Destinations (excluding Bengaluru)
INSERT INTO Destinations (city) VALUES ('Delhi');
INSERT INTO Destinations (city) VALUES ('Mumbai');
INSERT INTO Destinations (city) VALUES ('Chennai');
INSERT INTO Destinations (city) VALUES ('Hyderabad');
INSERT INTO Destinations (city) VALUES ('Kolkata');
INSERT INTO Destinations (city) VALUES ('Pune');
INSERT INTO Destinations (city) VALUES ('Ahmedabad');
INSERT INTO Destinations (city) VALUES ('Jaipur');
INSERT INTO Destinations (city) VALUES ('Goa');
INSERT INTO Destinations (city) VALUES ('Lucknow');

-- Insert Flights for Delhi
INSERT INTO Flights (airline_id, destination_id, flight_date, departure_time, arrival_time, gate_number)
VALUES (1, 1, DATE '2025-06-01', TIMESTAMP '2025-06-01 06:00:00', TIMESTAMP '2025-06-01 08:30:00', 'D1');

INSERT INTO Flights (airline_id, destination_id, flight_date, departure_time, arrival_time, gate_number)
VALUES (2, 1, DATE '2025-06-02', TIMESTAMP '2025-06-02 14:00:00', TIMESTAMP '2025-06-02 16:30:00', 'D2');

INSERT INTO Flights (airline_id, destination_id, flight_date, departure_time, arrival_time, gate_number)
VALUES (3, 1, DATE '2025-06-03', TIMESTAMP '2025-06-03 20:00:00', TIMESTAMP '2025-06-03 22:30:00', 'D3');

-- Insert Flights for Mumbai
INSERT INTO Flights (airline_id, destination_id, flight_date, departure_time, arrival_time, gate_number)
VALUES (4, 2, DATE '2025-06-01', TIMESTAMP '2025-06-01 07:30:00', TIMESTAMP '2025-06-01 09:45:00', 'M1');

INSERT INTO Flights (airline_id, destination_id, flight_date, departure_time, arrival_time, gate_number)
VALUES (5, 2, DATE '2025-06-02', TIMESTAMP '2025-06-02 12:00:00', TIMESTAMP '2025-06-02 14:15:00', 'M2');

INSERT INTO Flights (airline_id, destination_id, flight_date, departure_time, arrival_time, gate_number)
VALUES (1, 2, DATE '2025-06-03', TIMESTAMP '2025-06-03 18:00:00', TIMESTAMP '2025-06-03 20:15:00', 'M3');

-- Insert Flights for Chennai
INSERT INTO Flights (airline_id, destination_id, flight_date, departure_time, arrival_time, gate_number)
VALUES (2, 3, DATE '2025-06-04', TIMESTAMP '2025-06-04 05:45:00', TIMESTAMP '2025-06-04 08:00:00', 'C1');

INSERT INTO Flights (airline_id, destination_id, flight_date, departure_time, arrival_time, gate_number)
VALUES (3, 3, DATE '2025-06-05', TIMESTAMP '2025-06-05 13:00:00', TIMESTAMP '2025-06-05 15:15:00', 'C2');

INSERT INTO Flights (airline_id, destination_id, flight_date, departure_time, arrival_time, gate_number)
VALUES (4, 3, DATE '2025-06-06', TIMESTAMP '2025-06-06 19:30:00', TIMESTAMP '2025-06-06 21:45:00', 'C3');

-- Insert Flights for Hyderabad
INSERT INTO Flights (airline_id, destination_id, flight_date, departure_time, arrival_time, gate_number)
VALUES (5, 4, DATE '2025-06-01', TIMESTAMP '2025-06-01 06:30:00', TIMESTAMP '2025-06-01 08:40:00', 'H1');

INSERT INTO Flights (airline_id, destination_id, flight_date, departure_time, arrival_time, gate_number)
VALUES (1, 4, DATE '2025-06-02', TIMESTAMP '2025-06-02 11:00:00', TIMESTAMP '2025-06-02 13:10:00', 'H2');

INSERT INTO Flights (airline_id, destination_id, flight_date, departure_time, arrival_time, gate_number)
VALUES (2, 4, DATE '2025-06-03', TIMESTAMP '2025-06-03 17:00:00', TIMESTAMP '2025-06-03 19:10:00', 'H3');

-- Insert Flights for Kolkata
INSERT INTO Flights (airline_id, destination_id, flight_date, departure_time, arrival_time, gate_number)
VALUES (3, 5, DATE '2025-06-04', TIMESTAMP '2025-06-04 07:15:00', TIMESTAMP '2025-06-04 09:45:00', 'K1');

INSERT INTO Flights (airline_id, destination_id, flight_date, departure_time, arrival_time, gate_number)
VALUES (4, 5, DATE '2025-06-05', TIMESTAMP '2025-06-05 13:30:00', TIMESTAMP '2025-06-05 16:00:00', 'K2');

INSERT INTO Flights (airline_id, destination_id, flight_date, departure_time, arrival_time, gate_number)
VALUES (5, 5, DATE '2025-06-06', TIMESTAMP '2025-06-06 18:00:00', TIMESTAMP '2025-06-06 20:30:00', 'K3');

-- Insert Flights for Pune
INSERT INTO Flights (airline_id, destination_id, flight_date, departure_time, arrival_time, gate_number)
VALUES (1, 6, DATE '2025-06-01', TIMESTAMP '2025-06-01 09:00:00', TIMESTAMP '2025-06-01 11:00:00', 'P1');

INSERT INTO Flights (airline_id, destination_id, flight_date, departure_time, arrival_time, gate_number)
VALUES (2, 6, DATE '2025-06-02', TIMESTAMP '2025-06-02 15:00:00', TIMESTAMP '2025-06-02 17:00:00', 'P2');

INSERT INTO Flights (airline_id, destination_id, flight_date, departure_time, arrival_time, gate_number)
VALUES (3, 6, DATE '2025-06-03', TIMESTAMP '2025-06-03 20:30:00', TIMESTAMP '2025-06-03 22:30:00', 'P3');

-- Insert Flights for Ahmedabad
INSERT INTO Flights (airline_id, destination_id, flight_date, departure_time, arrival_time, gate_number)
VALUES (4, 7, DATE '2025-06-04', TIMESTAMP '2025-06-04 06:00:00', TIMESTAMP '2025-06-04 08:10:00', 'A1');

INSERT INTO Flights (airline_id, destination_id, flight_date, departure_time, arrival_time, gate_number)
VALUES (5, 7, DATE '2025-06-05', TIMESTAMP '2025-06-05 12:00:00', TIMESTAMP '2025-06-05 14:10:00', 'A2');

INSERT INTO Flights (airline_id, destination_id, flight_date, departure_time, arrival_time, gate_number)
VALUES (1, 7, DATE '2025-06-06', TIMESTAMP '2025-06-06 18:00:00', TIMESTAMP '2025-06-06 20:10:00', 'A3');

-- Insert Flights for Jaipur
INSERT INTO Flights (airline_id, destination_id, flight_date, departure_time, arrival_time, gate_number)
VALUES (2, 8, DATE '2025-06-01', TIMESTAMP '2025-06-01 07:00:00', TIMESTAMP '2025-06-01 09:15:00', 'J1');

INSERT INTO Flights (airline_id, destination_id, flight_date, departure_time, arrival_time, gate_number)
VALUES (3, 8, DATE '2025-06-02', TIMESTAMP '2025-06-02 13:00:00', TIMESTAMP '2025-06-02 15:15:00', 'J2');

INSERT INTO Flights (airline_id, destination_id, flight_date, departure_time, arrival_time, gate_number)
VALUES (4, 8, DATE '2025-06-03', TIMESTAMP '2025-06-03 19:00:00', TIMESTAMP '2025-06-03 21:15:00', 'J3');

-- Insert Flights for Goa
INSERT INTO Flights (airline_id, destination_id, flight_date, departure_time, arrival_time, gate_number)
VALUES (5, 9, DATE '2025-06-01', TIMESTAMP '2025-06-01 06:00:00', TIMESTAMP '2025-06-01 08:00:00', 'G1');

INSERT INTO Flights (airline_id, destination_id, flight_date, departure_time, arrival_time, gate_number)
VALUES (1, 9, DATE '2025-06-02', TIMESTAMP '2025-06-02 14:00:00', TIMESTAMP '2025-06-02 16:00:00', 'G2');

INSERT INTO Flights (airline_id, destination_id, flight_date, departure_time, arrival_time, gate_number)
VALUES (2, 9, DATE '2025-06-03', TIMESTAMP '2025-06-03 20:00:00', TIMESTAMP '2025-06-03 22:00:00', 'G3');

-- Insert Flights for Lucknow
INSERT INTO Flights (airline_id, destination_id, flight_date, departure_time, arrival_time, gate_number)
VALUES (3, 10, DATE '2025-06-04', TIMESTAMP '2025-06-04 07:30:00', TIMESTAMP '2025-06-04 09:45:00', 'L1');

INSERT INTO Flights (airline_id, destination_id, flight_date, departure_time, arrival_time, gate_number)
VALUES (4, 10, DATE '2025-06-05', TIMESTAMP '2025-06-05 13:30:00', TIMESTAMP '2025-06-05 15:45:00', 'L2');

INSERT INTO Flights (airline_id, destination_id, flight_date, departure_time, arrival_time, gate_number)
VALUES (5, 10, DATE '2025-06-06', TIMESTAMP '2025-06-06 18:30:00', TIMESTAMP '2025-06-06 20:45:00', 'L3');

-- Insert sample bookings
INSERT INTO Bookings (pnr, passenger_name, flight_id, baggage_id, belt_number)
VALUES ('OBAX45AB', 'Kush', 1, 'BAG001', '1');

INSERT INTO Bookings (pnr, passenger_name, flight_id, baggage_id, belt_number)
VALUES ('XAAB15AC', 'Anita', 2, 'BAG002', '2');

INSERT INTO Bookings (pnr, passenger_name, flight_id, baggage_id, belt_number)
VALUES ('XEDF26AB', 'Rahul', 3, 'BAG003', '3');
