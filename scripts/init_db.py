import sqlite3

def init_db():
    conn = sqlite3.connect('db/flight.db')
    cursor = conn.cursor()

    with open('db/schema.sql', 'r') as f:
        cursor.executescript(f.read())

    with open('db/sample_data.sql', 'r') as f:
        cursor.executescript(f.read())

    conn.commit()
    conn.close()
    print("✅ Database initialized.")

if __name__ == "__main__":
    init_db()
