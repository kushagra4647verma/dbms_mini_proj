from scripts.utils import connect_db

def check_pnr(pnr):
    conn = connect_db()
    cursor = conn.cursor()
    cursor.execute("""
        SELECT passenger_name, baggage_id, belt_number,
               Airlines.name, Destinations.city, flight_date, departure_time, arrival_time, gate_number
        FROM Bookings
        JOIN Flights ON Bookings.flight_id = Flights.flight_id
        JOIN Airlines ON Flights.airline_id = Airlines.airline_id
        JOIN Destinations ON Flights.destination_id = Destinations.destination_id
        WHERE pnr = ?
    """, (pnr,))
    row = cursor.fetchone()
    conn.close()

    if row:
        return {
            "pnr": pnr,
            "passenger": row[0],
            "airline": row[3],
            "destination": row[4],
            "date": row[5],
            "time": f"{row[6]} - {row[7]}",
            "gate": row[8],
            "baggage_id": row[1],
            "belt": row[2]
        }
    else:
        return None
