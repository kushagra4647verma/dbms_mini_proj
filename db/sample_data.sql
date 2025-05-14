-- Airlines
INSERT INTO Airlines (name) VALUES ('IndiGo'), ('Air India'), ('SpiceJet');

-- Destinations
INSERT INTO Destinations (city) VALUES ('Delhi'), ('Mumbai'), ('Bangalore');

-- Flights
INSERT INTO Flights (airline_id, destination_id, flight_date, departure_time, arrival_time, gate_number)
VALUES
(1, 1, '2025-05-14', '09:00', '11:00', 'A1'),
(2, 2, '2025-05-14', '12:00', '14:00', 'B2'),
(3, 3, '2025-05-15', '15:00', '17:00', 'C3');
