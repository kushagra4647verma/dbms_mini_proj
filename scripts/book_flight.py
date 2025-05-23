from scripts.utils import connect_db
import uuid
import random

def book_flight(passenger_name, flight_id):
    """Book a flight and return booking details"""
    if not passenger_name or not flight_id:
        raise ValueError("Passenger name and flight ID are required")
        
    # Generate booking details
    pnr = str(uuid.uuid4())[:8].upper()
    baggage_id = f"BAG{random.randint(1000,9999)}"
    belt = str(random.randint(1,10))

    conn = connect_db()
    cursor = conn.cursor()
    try:
        cursor.execute("""
            INSERT INTO Bookings (pnr, passenger_name, flight_id, baggage_id, belt_number)
            VALUES (:1, :2, :3, :4, :5)
        """, (pnr, passenger_name, flight_id, baggage_id, belt))
        conn.commit()
        return pnr, baggage_id, belt
    except Exception as e:
        conn.rollback()
        print(f"Error in book_flight: {e}")
        raise
    finally:
        cursor.close()
        conn.close()
