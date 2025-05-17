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

    if request.method == "POST":
        name = request.form.get("name", "").strip()
        destination = request.form.get("destination", "").strip()
        flight_id = request.form.get("flight_id")

        if flight_id:
            # User selected flight, so book it
            pnr = ''.join(random.choices(string.ascii_uppercase + string.digits, k=6))
            baggage_id = "BG" + ''.join(random.choices(string.digits, k=4))
            belt_number = random.randint(1, 10)

            cur.execute("""
                INSERT INTO bookings (pnr, passenger_name, flight_id, baggage_id, belt_number)
                VALUES (?, ?, ?, ?, ?)""",
                (pnr, name, flight_id, baggage_id, belt_number)
            )
            conn.commit()
            conn.close()

            return render_template("booking_success.html", pnr=pnr, name=name, baggage_id=baggage_id, belt_number=belt_number)

        elif destination:
            # User submitted destination, so fetch matching flights
            cur.execute("""
                SELECT Flights.flight_id, Airlines.name, Destinations.city, flight_date, departure_time, arrival_time, gate_number
                FROM Flights
                JOIN Airlines ON Flights.airline_id = Airlines.airline_id
                JOIN Destinations ON Flights.destination_id = Destinations.destination_id
                WHERE lower(Destinations.city) = lower(?)
            """, (destination,))
            flights = cur.fetchall()
            conn.close()
            return render_template("book_flights.html", name=name, destination=destination, flights=flights)

    # Initial GET request or no data submitted yet
    conn.close()
    return render_template("book_flights.html", flights=None)




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
