-- Airlines
INSERT INTO Airlines (name) VALUES ('Air India');
INSERT INTO Airlines (name) VALUES ('IndiGo');
INSERT INTO Airlines (name) VALUES ('SpiceJet');
INSERT INTO Airlines (name) VALUES ('Vistara');
INSERT INTO Airlines (name) VALUES ('GoAir');

-- Destinations (excluding Bengaluru)
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

-- Flights: 3 flights per destination

-- Delhi
INSERT INTO Flights (airline_id, destination_id, flight_date, departure_time, arrival_time, gate_number)
VALUES ((SELECT airline_id FROM Airlines WHERE name='Air India'), (SELECT destination_id FROM Destinations WHERE city='Delhi'), TO_DATE('2025-06-01', 'YYYY-MM-DD'), TO_TIMESTAMP('2025-06-01 06:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2025-06-01 08:30:00', 'YYYY-MM-DD HH24:MI:SS'), 'D1');
INSERT INTO Flights (airline_id, destination_id, flight_date, departure_time, arrival_time, gate_number)
VALUES ((SELECT airline_id FROM Airlines WHERE name='IndiGo'), (SELECT destination_id FROM Destinations WHERE city='Delhi'), TO_DATE('2025-06-02', 'YYYY-MM-DD'), TO_TIMESTAMP('2025-06-02 14:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2025-06-02 16:30:00', 'YYYY-MM-DD HH24:MI:SS'), 'D2');
INSERT INTO Flights (airline_id, destination_id, flight_date, departure_time, arrival_time, gate_number)
VALUES ((SELECT airline_id FROM Airlines WHERE name='SpiceJet'), (SELECT destination_id FROM Destinations WHERE city='Delhi'), TO_DATE('2025-06-03', 'YYYY-MM-DD'), TO_TIMESTAMP('2025-06-03 20:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2025-06-03 22:30:00', 'YYYY-MM-DD HH24:MI:SS'), 'D3');

-- Mumbai
INSERT INTO Flights (airline_id, destination_id, flight_date, departure_time, arrival_time, gate_number)
VALUES ((SELECT airline_id FROM Airlines WHERE name='Vistara'), (SELECT destination_id FROM Destinations WHERE city='Mumbai'), TO_DATE('2025-06-01', 'YYYY-MM-DD'), TO_TIMESTAMP('2025-06-01 07:30:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2025-06-01 09:45:00', 'YYYY-MM-DD HH24:MI:SS'), 'M1');
INSERT INTO Flights (airline_id, destination_id, flight_date, departure_time, arrival_time, gate_number)
VALUES ((SELECT airline_id FROM Airlines WHERE name='GoAir'), (SELECT destination_id FROM Destinations WHERE city='Mumbai'), TO_DATE('2025-06-02', 'YYYY-MM-DD'), TO_TIMESTAMP('2025-06-02 12:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2025-06-02 14:15:00', 'YYYY-MM-DD HH24:MI:SS'), 'M2');
INSERT INTO Flights (airline_id, destination_id, flight_date, departure_time, arrival_time, gate_number)
VALUES ((SELECT airline_id FROM Airlines WHERE name='Air India'), (SELECT destination_id FROM Destinations WHERE city='Mumbai'), TO_DATE('2025-06-03', 'YYYY-MM-DD'), TO_TIMESTAMP('2025-06-03 18:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2025-06-03 20:15:00', 'YYYY-MM-DD HH24:MI:SS'), 'M3');

-- Chennai
INSERT INTO Flights (airline_id, destination_id, flight_date, departure_time, arrival_time, gate_number)
VALUES ((SELECT airline_id FROM Airlines WHERE name='IndiGo'), (SELECT destination_id FROM Destinations WHERE city='Chennai'), TO_DATE('2025-06-04', 'YYYY-MM-DD'), TO_TIMESTAMP('2025-06-04 05:45:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2025-06-04 08:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'C1');
INSERT INTO Flights (airline_id, destination_id, flight_date, departure_time, arrival_time, gate_number)
VALUES ((SELECT airline_id FROM Airlines WHERE name='SpiceJet'), (SELECT destination_id FROM Destinations WHERE city='Chennai'), TO_DATE('2025-06-05', 'YYYY-MM-DD'), TO_TIMESTAMP('2025-06-05 13:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2025-06-05 15:15:00', 'YYYY-MM-DD HH24:MI:SS'), 'C2');
INSERT INTO Flights (airline_id, destination_id, flight_date, departure_time, arrival_time, gate_number)
VALUES ((SELECT airline_id FROM Airlines WHERE name='Vistara'), (SELECT destination_id FROM Destinations WHERE city='Chennai'), TO_DATE('2025-06-06', 'YYYY-MM-DD'), TO_TIMESTAMP('2025-06-06 19:30:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2025-06-06 21:45:00', 'YYYY-MM-DD HH24:MI:SS'), 'C3');

-- Hyderabad
INSERT INTO Flights (airline_id, destination_id, flight_date, departure_time, arrival_time, gate_number)
VALUES ((SELECT airline_id FROM Airlines WHERE name='GoAir'), (SELECT destination_id FROM Destinations WHERE city='Hyderabad'), TO_DATE('2025-06-01', 'YYYY-MM-DD'), TO_TIMESTAMP('2025-06-01 06:30:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2025-06-01 08:40:00', 'YYYY-MM-DD HH24:MI:SS'), 'H1');
INSERT INTO Flights (airline_id, destination_id, flight_date, departure_time, arrival_time, gate_number)
VALUES ((SELECT airline_id FROM Airlines WHERE name='Air India'), (SELECT destination_id FROM Destinations WHERE city='Hyderabad'), TO_DATE('2025-06-02', 'YYYY-MM-DD'), TO_TIMESTAMP('2025-06-02 11:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2025-06-02 13:10:00', 'YYYY-MM-DD HH24:MI:SS'), 'H2');
INSERT INTO Flights (airline_id, destination_id, flight_date, departure_time, arrival_time, gate_number)
VALUES ((SELECT airline_id FROM Airlines WHERE name='IndiGo'), (SELECT destination_id FROM Destinations WHERE city='Hyderabad'), TO_DATE('2025-06-03', 'YYYY-MM-DD'), TO_TIMESTAMP('2025-06-03 17:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2025-06-03 19:10:00', 'YYYY-MM-DD HH24:MI:SS'), 'H3');

-- Kolkata
INSERT INTO Flights (airline_id, destination_id, flight_date, departure_time, arrival_time, gate_number)
VALUES ((SELECT airline_id FROM Airlines WHERE name='SpiceJet'), (SELECT destination_id FROM Destinations WHERE city='Kolkata'), TO_DATE('2025-06-04', 'YYYY-MM-DD'), TO_TIMESTAMP('2025-06-04 07:15:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2025-06-04 09:45:00', 'YYYY-MM-DD HH24:MI:SS'), 'K1');
INSERT INTO Flights (airline_id, destination_id, flight_date, departure_time, arrival_time, gate_number)
VALUES ((SELECT airline_id FROM Airlines WHERE name='Vistara'), (SELECT destination_id FROM Destinations WHERE city='Kolkata'), TO_DATE('2025-06-05', 'YYYY-MM-DD'), TO_TIMESTAMP('2025-06-05 13:30:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2025-06-05 16:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'K2');
INSERT INTO Flights (airline_id, destination_id, flight_date, departure_time, arrival_time, gate_number)
VALUES ((SELECT airline_id FROM Airlines WHERE name='GoAir'), (SELECT destination_id FROM Destinations WHERE city='Kolkata'), TO_DATE('2025-06-06', 'YYYY-MM-DD'), TO_TIMESTAMP('2025-06-06 18:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2025-06-06 20:30:00', 'YYYY-MM-DD HH24:MI:SS'), 'K3');

-- Pune
INSERT INTO Flights (airline_id, destination_id, flight_date, departure_time, arrival_time, gate_number)
VALUES ((SELECT airline_id FROM Airlines WHERE name='Air India'), (SELECT destination_id FROM Destinations WHERE city='Pune'), TO_DATE('2025-06-01', 'YYYY-MM-DD'), TO_TIMESTAMP('2025-06-01 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2025-06-01 11:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'P1');
INSERT INTO Flights (airline_id, destination_id, flight_date, departure_time, arrival_time, gate_number)
VALUES ((SELECT airline_id FROM Airlines WHERE name='IndiGo'), (SELECT destination_id FROM Destinations WHERE city='Pune'), TO_DATE('2025-06-02', 'YYYY-MM-DD'), TO_TIMESTAMP('2025-06-02 15:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2025-06-02 17:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'P2');
INSERT INTO Flights (airline_id, destination_id, flight_date, departure_time, arrival_time, gate_number)
VALUES ((SELECT airline_id FROM Airlines WHERE name='SpiceJet'), (SELECT destination_id FROM Destinations WHERE city='Pune'), TO_DATE('2025-06-03', 'YYYY-MM-DD'), TO_TIMESTAMP('2025-06-03 20:30:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2025-06-03 22:30:00', 'YYYY-MM-DD HH24:MI:SS'), 'P3');

-- Ahmedabad
INSERT INTO Flights (airline_id, destination_id, flight_date, departure_time, arrival_time, gate_number)
VALUES ((SELECT airline_id FROM Airlines WHERE name='Vistara'), (SELECT destination_id FROM Destinations WHERE city='Ahmedabad'), TO_DATE('2025-06-04', 'YYYY-MM-DD'), TO_TIMESTAMP('2025-06-04 06:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2025-06-04 08:10:00', 'YYYY-MM-DD HH24:MI:SS'), 'A1');
INSERT INTO Flights (airline_id, destination_id, flight_date, departure_time, arrival_time, gate_number)
VALUES ((SELECT airline_id FROM Airlines WHERE name='GoAir'), (SELECT destination_id FROM Destinations WHERE city='Ahmedabad'), TO_DATE('2025-06-05', 'YYYY-MM-DD'), TO_TIMESTAMP('2025-06-05 12:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2025-06-05 14:10:00', 'YYYY-MM-DD HH24:MI:SS'), 'A2');
INSERT INTO Flights (airline_id, destination_id, flight_date, departure_time, arrival_time, gate_number)
VALUES ((SELECT airline_id FROM Airlines WHERE name='Air India'), (SELECT destination_id FROM Destinations WHERE city='Ahmedabad'), TO_DATE('2025-06-06', 'YYYY-MM-DD'), TO_TIMESTAMP('2025-06-06 18:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2025-06-06 20:10:00', 'YYYY-MM-DD HH24:MI:SS'), 'A3');

-- Jaipur
INSERT INTO Flights (airline_id, destination_id, flight_date, departure_time, arrival_time, gate_number)
VALUES ((SELECT airline_id FROM Airlines WHERE name='IndiGo'), (SELECT destination_id FROM Destinations WHERE city='Jaipur'), TO_DATE('2025-06-01', 'YYYY-MM-DD'), TO_TIMESTAMP('2025-06-01 07:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2025-06-01 09:15:00', 'YYYY-MM-DD HH24:MI:SS'), 'J1');
INSERT INTO Flights (airline_id, destination_id, flight_date, departure_time, arrival_time, gate_number)
VALUES ((SELECT airline_id FROM Airlines WHERE name='SpiceJet'), (SELECT destination_id FROM Destinations WHERE city='Jaipur'), TO_DATE('2025-06-02', 'YYYY-MM-DD'), TO_TIMESTAMP('2025-06-02 13:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2025-06-02 15:15:00', 'YYYY-MM-DD HH24:MI:SS'), 'J2');
INSERT INTO Flights (airline_id, destination_id, flight_date, departure_time, arrival_time, gate_number)
VALUES ((SELECT airline_id FROM Airlines WHERE name='Vistara'), (SELECT destination_id FROM Destinations WHERE city='Jaipur'), TO_DATE('2025-06-03', 'YYYY-MM-DD'), TO_TIMESTAMP('2025-06-03 19:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2025-06-03 21:15:00', 'YYYY-MM-DD HH24:MI:SS'), 'J3');

-- Goa
INSERT INTO Flights (airline_id, destination_id, flight_date, departure_time, arrival_time, gate_number)
VALUES ((SELECT airline_id FROM Airlines WHERE name='GoAir'), (SELECT destination_id FROM Destinations WHERE city='Goa'), TO_DATE('2025-06-01', 'YYYY-MM-DD'), TO_TIMESTAMP('2025-06-01 06:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2025-06-01 08:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'G1');
INSERT INTO Flights (airline_id, destination_id, flight_date, departure_time, arrival_time, gate_number)
VALUES ((SELECT airline_id FROM Airlines WHERE name='Air India'), (SELECT destination_id FROM Destinations WHERE city='Goa'), TO_DATE('2025-06-02', 'YYYY-MM-DD'), TO_TIMESTAMP('2025-06-02 14:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2025-06-02 16:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'G2');
INSERT INTO Flights (airline_id, destination_id, flight_date, departure_time, arrival_time, gate_number)
VALUES ((SELECT airline_id FROM Airlines WHERE name='IndiGo'), (SELECT destination_id FROM Destinations WHERE city='Goa'), TO_DATE('2025-06-03', 'YYYY-MM-DD'), TO_TIMESTAMP('2025-06-03 20:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2025-06-03 22:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'G3');

-- Lucknow
INSERT INTO Flights (airline_id, destination_id, flight_date, departure_time, arrival_time, gate_number)
VALUES ((SELECT airline_id FROM Airlines WHERE name='SpiceJet'), (SELECT destination_id FROM Destinations WHERE city='Lucknow'), TO_DATE('2025-06-04', 'YYYY-MM-DD'), TO_TIMESTAMP('2025-06-04 07:30:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2025-06-04 09:45:00', 'YYYY-MM-DD HH24:MI:SS'), 'L1');
INSERT INTO Flights (airline_id, destination_id, flight_date, departure_time, arrival_time, gate_number)
VALUES ((SELECT airline_id FROM Airlines WHERE name='Vistara'), (SELECT destination_id FROM Destinations WHERE city='Lucknow'), TO_DATE('2025-06-05', 'YYYY-MM-DD'), TO_TIMESTAMP('2025-06-05 13:30:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2025-06-05 15:45:00', 'YYYY-MM-DD HH24:MI:SS'), 'L2');
INSERT INTO Flights (airline_id, destination_id, flight_date, departure_time, arrival_time, gate_number)
VALUES ((SELECT airline_id FROM Airlines WHERE name='GoAir'), (SELECT destination_id FROM Destinations WHERE city='Lucknow'), TO_DATE('2025-06-06', 'YYYY-MM-DD'), TO_TIMESTAMP('2025-06-06 18:30:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2025-06-06 20:45:00', 'YYYY-MM-DD HH24:MI:SS'), 'L3');

-- Example Bookings (for a few flights)
INSERT INTO Bookings (pnr, airline_id, flight_id, baggage_id, passenger_name, seat_number)
VALUES ('PNR001', (SELECT airline_id FROM Airlines WHERE name='Air India'), 1, 'BAG001', 'Kush', '12A');
INSERT INTO Bookings (pnr, airline_id, flight_id, baggage_id, passenger_name, seat_number)
VALUES ('PNR002', (SELECT airline_id FROM Airlines WHERE name='IndiGo'), 2, 'BAG002', 'Anita', '14B');
INSERT INTO Bookings (pnr, airline_id, flight_id, baggage_id, passenger_name, seat_number)
VALUES ('PNR003', (SELECT airline_id FROM Airlines WHERE name='SpiceJet'), 3, 'BAG003', 'Rahul', '15C');
