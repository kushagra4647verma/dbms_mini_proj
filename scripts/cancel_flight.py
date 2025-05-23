from scripts.utils import connect_db

def cancel_flight(pnr):
    """Cancel a flight booking by PNR"""
    if not pnr:
        return False
        
    conn = connect_db()
    cursor = conn.cursor()
    try:
        cursor.execute("DELETE FROM Bookings WHERE pnr = :1", (pnr,))
        conn.commit()
        deleted = cursor.rowcount
        return deleted > 0
    except Exception as e:
        conn.rollback()
        print(f"Error in cancel_flight: {e}")
        raise
    finally:
        cursor.close()
        conn.close()
