from scripts.utils import connect_db

def view_schedule(city):
    conn = connect_db()
    cursor = conn.cursor()
    sql = """
        SELECT f.flight_id, a.name, d.city,
               f.flight_date, f.departure_time, f.arrival_time, f.gate_number
        FROM Flights f
        JOIN Airlines a ON f.airline_id = a.airline_id
        JOIN Destinations d ON f.destination_id = d.destination_id
        WHERE LOWER(d.city) = LOWER(:city)
        ORDER BY f.flight_date, f.departure_time
    """
    cursor.execute(sql, {"city": city.strip()})
    rows = cursor.fetchall()
    cursor.close()
    conn.close()
    return rows

