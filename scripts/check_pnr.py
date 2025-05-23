from scripts.utils import connect_db

def check_pnr(pnr):
    """Check PNR status and return booking details"""
    if not pnr:
        return None
        
    conn = connect_db()
    cursor = conn.cursor()
    try:
        cursor.execute("""
            SELECT b.passenger_name, b.baggage_id, b.belt_number,
                a.name, d.city, 
                TO_CHAR(f.flight_date, 'YYYY-MM-DD') as flight_date,
                TO_CHAR(f.departure_time, 'HH24:MI') as departure_time,
                TO_CHAR(f.arrival_time, 'HH24:MI') as arrival_time,
                f.gate_number
            FROM Bookings b
            JOIN Flights f ON b.flight_id = f.flight_id
            JOIN Airlines a ON f.airline_id = a.airline_id
            JOIN Destinations d ON f.destination_id = d.destination_id
            WHERE b.pnr = :pnr
        """, {"pnr": pnr})
        row = cursor.fetchone()
        
        if not row:
            return None

        return {
            "pnr": pnr,
            "passenger": row[0],
            "baggage_id": row[1],
            "belt": row[2],
            "airline": row[3],
            "destination": row[4],
            "date": row[5],
            "time": f"{row[6]} - {row[7]}",
            "gate": row[8]
        }
    except Exception as e:
        print(f"Error in check_pnr: {e}")
        raise
    finally:
        cursor.close()
        conn.close()
