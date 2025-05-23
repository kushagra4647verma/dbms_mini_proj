from scripts.utils import connect_db

def cancel_flight(pnr):
    conn   = connect_db()
    cursor = conn.cursor()
    cursor.execute("DELETE FROM Bookings WHERE pnr = :1", (pnr,))
    conn.commit()
    deleted = cursor.rowcount
    cursor.close()
    conn.close()
    return deleted > 0
