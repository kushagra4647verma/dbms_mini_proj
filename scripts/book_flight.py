from scripts.utils import connect_db
import uuid, random

def book_flight(passenger_name, flight_id):
    pnr        = str(uuid.uuid4())[:8]
    baggage_id = f"BAG{random.randint(1000,9999)}"
    belt       = str(random.randint(1,10))

    conn   = connect_db()
    cursor = conn.cursor()
    cursor.execute("""
        INSERT INTO Bookings (pnr, passenger_name, flight_id, baggage_id, belt_number)
        VALUES (:1, :2, :3, :4, :5)
    """, (pnr, passenger_name, flight_id, baggage_id, belt))
    conn.commit()
    cursor.close()
    conn.close()

    return pnr, baggage_id, belt
