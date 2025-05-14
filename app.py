from flask import Flask, render_template, request, redirect, url_for
from scripts.book_flight import book_flight
from scripts.check_pnr import check_pnr
from scripts.view_schedule import view_schedule
from scripts.cancel_flight import cancel_flight

app = Flask(__name__)

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/book', methods=['GET', 'POST'])
def book():
    if request.method == 'POST':
        passenger_name = request.form['name']
        flight_id = request.form['flight_id']
        pnr = book_flight(passenger_name, flight_id)
        return render_template('booking_success.html', pnr=pnr)
    return render_template('book_flight.html')

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
