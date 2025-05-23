from scripts.utils import connect_db

def check_pnr(pnr):
    conn   = connect_db()
    cursor = conn.cursor()
    cursor.execute("""
        SELECT b.passenger_name, b.baggage_id, b.belt_number,
               a.name, d.city, f.flight_date, f.departure_time, f.arrival_time, f.gate_number
        FROM Bookings b
        JOIN Flights     f ON b.flight_id      = f.flight_id
        JOIN Airlines    a ON f.airline_id     = a.airline_id
        JOIN Destinations d ON f.destination_id = d.destination_id
        WHERE b.pnr = :pnr
    """, {"pnr": pnr})
    row = cursor.fetchone()
    cursor.close()
    conn.close()

    if not row:
        return None

    return {
        "pnr":          pnr,
        "passenger":    row[0],
        "baggage_id":   row[1],
        "belt":         row[2],
        "airline":      row[3],
        "destination":  row[4],
        "date":         row[5].strftime("%Y-%m-%d"),
        "time":         f"{row[6].strftime('%H:%M')} - {row[7].strftime('%H:%M')}",
        "gate":         row[8]
    }
