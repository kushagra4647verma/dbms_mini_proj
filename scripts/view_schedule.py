from scripts.utils import connect_db

def view_schedule(city):
    conn = connect_db()
    cursor = conn.cursor()
    cursor.execute("""
        SELECT Airlines.name, flight_date, departure_time, arrival_time, gate_number
        FROM Flights
        JOIN Airlines ON Flights.airline_id = Airlines.airline_id
        JOIN Destinations ON Flights.destination_id = Destinations.destination_id
        WHERE Destinations.city = ?
    """, (city,))
    rows = cursor.fetchall()
    conn.close()

    return rows
