from scripts.utils import connect_db

def view_schedule(city):
    """View flight schedule for a given city"""
    if not city or not city.strip():
        print("No city provided")
        return []
        
    conn = connect_db()
    cursor = conn.cursor()
    try:
        sql = """
            SELECT f.flight_id, a.name, d.city,
                TO_CHAR(f.flight_date, 'YYYY-MM-DD') as flight_date,
                TO_CHAR(f.departure_time, 'HH24:MI') as departure_time,
                TO_CHAR(f.arrival_time, 'HH24:MI') as arrival_time,
                f.gate_number
            FROM Flights f
            JOIN Airlines a ON f.airline_id = a.airline_id
            JOIN Destinations d ON f.destination_id = d.destination_id
            WHERE LOWER(d.city) = LOWER(:city)
            ORDER BY f.flight_date, f.departure_time
        """
        
        print(f"Searching for flights to: {city}")
        cursor.execute(sql, {"city": city.strip()})
        rows = cursor.fetchall()
        print(f"Found {len(rows)} flights")
        
        # Debug: print the first few results
        for i, row in enumerate(rows[:3]):
            print(f"Flight {i+1}: {row}")
            
        return rows
    except Exception as e:
        print(f"Error in view_schedule: {e}")
        import traceback
        traceback.print_exc()
        raise
    finally:
        cursor.close()
        conn.close()
