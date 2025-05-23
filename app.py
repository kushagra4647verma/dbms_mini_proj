import cx_Oracle
from flask import Flask, render_template, request, g, redirect, url_for

# ─── Oracle Connection Config ───────────────────────────────────────
DB_USER    = "SYSTEM"
DB_PASS    = "tiger"
DB_HOST    = "localhost"
DB_PORT    = 1521
DB_SERVICE = "XEPDB1"

app = Flask(__name__)  # <- Moved this here before using @app

def get_db_connection():
    if 'db_conn' not in g:
        dsn = cx_Oracle.makedsn(DB_HOST, DB_PORT, service_name=DB_SERVICE)
        g.db_conn = cx_Oracle.connect(DB_USER, DB_PASS, dsn)
    return g.db_conn

@app.teardown_appcontext
def close_db_connection(exception):
    conn = g.pop('db_conn', None)
    if conn:
        conn.close()

# ─── Helper scripts ─────────────────────────────────────────────────
from scripts.book_flight    import book_flight
from scripts.check_pnr      import check_pnr
from scripts.view_schedule  import view_schedule
from scripts.cancel_flight  import cancel_flight

# ─── Routes ─────────────────────────────────────────────────────────

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/book', methods=['GET', 'POST'])
def book():
    flights = None
    name = destination = ""
    if request.method == 'POST':
        name        = request.form['name']
        destination = request.form['destination']

        if 'flight_id' in request.form:
            # final booking step
            flight_id = request.form['flight_id']
            pnr, bag, belt = book_flight(name, flight_id)
            return render_template('booking_success.html',
                                   name=name, pnr=pnr,
                                   baggage_id=bag, belt_number=belt)

        # search flights
        flights = view_schedule(destination)
    return render_template('book_flights.html',
                           name=name, destination=destination,
                           flights=flights)

@app.route('/check_pnr', methods=['GET','POST'])
def pnr():
    details = None
    if request.method == 'POST':
        pnr = request.form['pnr']
        details = check_pnr(pnr)
    return render_template('check_pnr.html', details=details)

@app.route('/view_schedule', methods=['GET','POST'])
def schedule():
    flights = None
    city    = None
    if request.method == 'POST':
        city    = request.form['city']
        flights = view_schedule(city)
    return render_template('schedule.html', flights=flights, city=city)

@app.route('/cancel', methods=['GET','POST'])
def cancel():
    success = None
    if request.method == 'POST':
        pnr     = request.form['pnr']
        success = cancel_flight(pnr)
    return render_template('cancel_flight.html', success=success)

if __name__ == "__main__":
    app.run(debug=True)
