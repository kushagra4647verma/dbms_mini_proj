import random
import sqlite3
import string
from flask import Flask, render_template, request, redirect, url_for
from scripts.book_flight import book_flight
from scripts.check_pnr import check_pnr
from scripts.view_schedule import view_schedule
from scripts.cancel_flight import cancel_flight

app = Flask(__name__)

@app.route('/')
def index():
    return render_template('index.html')

@app.route("/book", methods=["GET", "POST"])
def book():
    conn = sqlite3.connect("db/flight.db")
    cur = conn.cursor()

    # Ensure the Flights table exists
    cur.execute("""
        CREATE TABLE IF NOT EXISTS Flights (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            flight_number TEXT NOT NULL,
            departure_city TEXT NOT NULL,
            arrival_city TEXT NOT NULL,
            departure_time TEXT NOT NULL,
            arrival_time TEXT NOT NULL
        )
    """)
    conn.commit()

    if request.method == "POST":
        name = request.form["name"]
        flight_id = request.form["flight_id"]

        # Generate values
        pnr = ''.join(random.choices(string.ascii_uppercase + string.digits, k=6))
        baggage_id = "BG" + ''.join(random.choices(string.digits, k=4))
        belt_number = random.randint(1, 10)

        # Insert into bookings table
        cur.execute("""
            INSERT INTO bookings (pnr, passenger_name, flight_id, baggage_id, belt_number)
            VALUES (?, ?, ?, ?, ?)""",
            (pnr, name, flight_id, baggage_id, belt_number)
        )

        conn.commit()
        conn.close()

        return render_template("booking_success.html", pnr=pnr, name=name, baggage_id=baggage_id, belt_number=belt_number)

    # GET method – show available flights
    cur.execute("SELECT * FROM Flights")
    flights = cur.fetchall()
    conn.close()
    return render_template("book_flights.html", flights=flights)



@app.route('/check_pnr', methods=['GET', 'POST'])
def pnr():
    if request.method == 'POST':
        pnr = request.form['pnr']
        details = check_pnr(pnr)
        return render_template('pnr_details.html', details=details)
    return render_template('check_pnr.html')

@app.route('/view_schedule', methods=['GET', 'POST'])
def schedule():
    if request.method == 'POST':
        city = request.form['city']
        flights = view_schedule(city)
        return render_template('schedule.html', flights=flights)
    return render_template('view_schedule.html')

@app.route('/cancel', methods=['GET', 'POST'])
def cancel():
    if request.method == 'POST':
        pnr = request.form['pnr']
        cancel_flight(pnr)
        return render_template('cancel_success.html')
    return render_template('cancel_flight.html')

if __name__ == "__main__":
    app.run(debug=True)
