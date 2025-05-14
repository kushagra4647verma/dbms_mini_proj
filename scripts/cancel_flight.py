from scripts.utils import connect_db

def cancel_flight(pnr):
    conn = connect_db()
    cursor = conn.cursor()
    cursor.execute("DELETE FROM Bookings WHERE pnr = ?", (pnr,))
    conn.commit()
    conn.close()

    return cursor.rowcount > 0
