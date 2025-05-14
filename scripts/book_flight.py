from scripts.utils import connect_db
import uuid
import random

# Modified version of book_flight function
def book_flight(passenger_name, flight_id):
    pnr = str(uuid.uuid4())[:8]
    baggage_id = f"BAG{random.randint(1000,9999)}"
    belt_number = f"{random.choice(['1', '2', '3'])}"

    conn = connect_db()
    cursor = conn.cursor()
    cursor.execute("""
        INSERT INTO Bookings (pnr, passenger_name, flight_id, baggage_id, belt_number)
        VALUES (?, ?, ?, ?, ?)
    """, (pnr, passenger_name, flight_id, baggage_id, belt_number))
    conn.commit()
    conn.close()

    return pnr


def view_flights():
    conn = connect_db()
    cursor = conn.cursor()
    cursor.execute("""
        SELECT Flights.flight_id, Airlines.name, Destinations.city, flight_date, departure_time, arrival_time, gate_number
        FROM Flights
        JOIN Airlines ON Flights.airline_id = Airlines.airline_id
        JOIN Destinations ON Flights.destination_id = Destinations.destination_id
    """)
    rows = cursor.fetchall()

    print("\nAvailable Flights:")
    for row in rows:
        print(f"ID: {row[0]}, Airline: {row[1]}, Destination: {row[2]}, Date: {row[3]}, Time: {row[4]}-{row[5]}, Gate: {row[6]}")
    conn.close()
