import cx_Oracle
from flask import Flask, render_template, request, g, redirect, url_for, flash
import traceback

DB_USER    = "SYSTEM"
DB_PASS    = "tiger"
DB_HOST    = "localhost"
DB_PORT    = 1521
DB_SERVICE = "XEPDB1"

app = Flask(__name__)
app.secret_key = 'flight_management_secret_key' 

def get_db_connection():
    """Get database connection from Flask g object or create a new one"""
    if 'db_conn' not in g:
        try:
            dsn = cx_Oracle.makedsn(DB_HOST, DB_PORT, service_name=DB_SERVICE)
            g.db_conn = cx_Oracle.connect(DB_USER, DB_PASS, dsn)
        except cx_Oracle.DatabaseError as e:
            print(f"Database connection error: {e}")
            return None
    return g.db_conn

@app.teardown_appcontext
def close_db_connection(exception):
    """Close database connection when the request ends"""
    conn = g.pop('db_conn', None)
    if conn:
        conn.close()

from scripts.book_flight    import book_flight
from scripts.check_pnr      import check_pnr
from scripts.view_schedule  import view_schedule
from scripts.cancel_flight  import cancel_flight


@app.route('/')
def index():
    return render_template('index.html')

@app.route('/book', methods=['GET', 'POST'])
def book():
    flights = None
    name = ""
    destination = ""
    
    try:
        if request.method == 'POST':
            name = request.form.get('name', '')
            destination = request.form.get('destination', '')

            if 'flight_id' in request.form:
                # Final booking step
                flight_id = request.form['flight_id']
                pnr, bag, belt = book_flight(name, flight_id)
                return render_template('booking_success.html',
                                    name=name, pnr=pnr,
                                    baggage_id=bag, belt_number=belt)

            # Search flights
            if destination:
                flights = view_schedule(destination)
    except Exception as e:
        print(f"Error in book route: {e}")
        traceback.print_exc()
        return render_template('error.html', error=str(e))
        
    return render_template('book_flights.html',
                        name=name, destination=destination,
                        flights=flights)

@app.route('/check_pnr', methods=['GET', 'POST'])
def pnr():
    details = None
    try:
        if request.method == 'POST':
            pnr = request.form.get('pnr', '')
            if pnr:
                details = check_pnr(pnr)
                if details:
                    return render_template('pnr_details.html', details=details)
    except Exception as e:
        print(f"Error in check_pnr route: {e}")
        traceback.print_exc()
        return render_template('error.html', error=str(e))
        
    return render_template('check_pnr.html', details=details)

@app.route('/view_schedule', methods=['GET', 'POST'])
def schedule():
    flights = None
    city = None
    try:
        if request.method == 'POST':
            city = request.form.get('city', '')
            if city:
                flights = view_schedule(city)
    except Exception as e:
        print(f"Error in view_schedule route: {e}")
        traceback.print_exc()
        return render_template('error.html', error=str(e))
        
    return render_template('view_schedule.html', flights=flights, city=city)

@app.route('/cancel', methods=['GET', 'POST'])
def cancel():
    success = None
    try:
        if request.method == 'POST':
            pnr = request.form.get('pnr', '')
            if pnr:
                success = cancel_flight(pnr)
                if success:
                    return render_template('cancel_success.html')
    except Exception as e:
        print(f"Error in cancel route: {e}")
        traceback.print_exc()
        return render_template('error.html', error=str(e))
        
    return render_template('cancel_flight.html', success=success)

if __name__ == "__main__":
    app.run(debug=True)
