-- Airlines
CREATE TABLE IF NOT EXISTS Airlines (
    airline_id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL
);

-- Destinations
CREATE TABLE IF NOT EXISTS Destinations (
    destination_id INTEGER PRIMARY KEY AUTOINCREMENT,
    city TEXT NOT NULL
);

-- Flights
CREATE TABLE IF NOT EXISTS Flights (
    flight_id INTEGER PRIMARY KEY AUTOINCREMENT,
    airline_id INTEGER,
    destination_id INTEGER,
    flight_date TEXT,
    departure_time TEXT,
    arrival_time TEXT,
    gate_number TEXT,
    FOREIGN KEY (airline_id) REFERENCES Airlines(airline_id),
    FOREIGN KEY (destination_id) REFERENCES Destinations(destination_id)
);

-- Bookings
CREATE TABLE IF NOT EXISTS Bookings (
    pnr TEXT PRIMARY KEY,
    passenger_name TEXT,
    flight_id INTEGER,
    baggage_id TEXT,
    belt_number TEXT,
    FOREIGN KEY (flight_id) REFERENCES Flights(flight_id)
);
