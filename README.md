# Flight Management System

A comprehensive web-based flight management system vibe coded using Cursor V0 built with Flask and Oracle Database as a Database Managment Systems project

## 🚀 Features

- ✈️ Flight booking with automatic PNR generation
- 🔍 PNR status checking and booking details
- 📅 Real-time flight schedule viewing
- ❌ Booking cancellation system
- 🎫 Baggage tracking with belt assignments


## 📋 Prerequisites

- Python 3.8 or higher
- Docker Desktop
- Git
- 4GB+ RAM available for Oracle Database


## 🛠️ Installation Guide

### Step 1: Clone the Repository

```shellscript
git clone https://github.com/your-username/flight-management-system.git
cd flight-management-system
```

### Step 2: Set Up Oracle Database with Docker

#### Install Docker Desktop

**Windows:**

1. Download Docker Desktop from [docker.com](https://www.docker.com/products/docker-desktop/)
2. Install and restart your computer
3. Start Docker Desktop


**macOS:**

1. Download Docker Desktop from [docker.com](https://www.docker.com/products/docker-desktop/)
2. Install the .dmg file
3. Start Docker Desktop from Applications


#### Run Oracle Database Container

```shellscript
# Pull and run Oracle Database XE
docker run -d \
  --name oracle-db \
  -p 1521:1521 \
  -e ORACLE_PASSWORD=tiger \
  -e ORACLE_DATABASE=XEPDB1 \
  gvenzl/oracle-xe:21-slim

# Wait for database to start (2-3 minutes)
docker logs -f oracle-db
```

Wait until you see: `DATABASE IS READY TO USE!`

### Step 3: Install Oracle Instant Client

#### Windows

1. **Download Oracle Instant Client:**

1. Go to [Oracle Instant Client Downloads](https://www.oracle.com/database/technologies/instant-client/winx64-64-downloads.html)
2. Download "Basic Package" (instantclient-basic-windows.x64-21.13.0.0.0dbru.zip)
3. Create Oracle account if needed (free)



2. **Extract and Configure:**

```powershell
# Create directory
mkdir C:\instantclient_21_13

# Extract downloaded ZIP to C:\instantclient_21_13
# Add to PATH environment variable
$env:PATH += ";C:\instantclient_21_13"
[Environment]::SetEnvironmentVariable("PATH", $env:PATH, [EnvironmentVariableTarget]::User)
```


3. **Install Visual C++ Redistributable:**

```powershell
# Download and install
Invoke-WebRequest -Uri "https://aka.ms/vs/17/release/vc_redist.x64.exe" -OutFile "vc_redist.x64.exe"
.\vc_redist.x64.exe /install /quiet /norestart
```




#### macOS

```shellscript
# Install using Homebrew (recommended)
brew install instantclient-basic

# Or download manually from Oracle website
# Extract to /usr/local/instantclient_21_13
# Add to PATH in ~/.zshrc or ~/.bash_profile
echo 'export PATH=$PATH:/usr/local/instantclient_21_13' >> ~/.zshrc
source ~/.zshrc
```

### Step 4: Set Up Python Environment

```shellscript
# Create virtual environment
python3 -m venv flight_env

# Activate virtual environment
# Windows:
flight_env\Scripts\activate
# macOS/Linux:
source flight_env/bin/activate

# Install dependencies
pip install -r requirements.txt
```

### Step 5: Verify Setup

```shellscript
# Test Oracle client installation
python -c "import cx_Oracle; print('✅ Oracle client works!')"

# Test database connection
python -c "
import cx_Oracle
try:
    dsn = cx_Oracle.makedsn('localhost', 1521, service_name='XEPDB1')
    conn = cx_Oracle.connect('SYSTEM', 'tiger', dsn)
    print('✅ Database connection successful!')
    conn.close()
except Exception as e:
    print(f'❌ Connection failed: {e}')
"
```

### Step 6: Initialize Database

```shellscript
# Create database schema and insert sample data
python scripts/init_db.py
```

You should see:

```plaintext
Connecting to Oracle database...
Connected successfully!
Creating database schema...
Schema created successfully!
Inserting sample data...
Sample data inserted successfully!
Database initialization completed successfully!
```

### Step 7: Run the Application

```shellscript
# Start the Flask application
python app.py
```

You should see:

```plaintext
* Running on http://127.0.0.1:5000
* Debug mode: on
```

### Step 8: Access the Application

Open your web browser and navigate to:

```plaintext
http://localhost:5000
```

## 🧪 Testing the System

### Test Flight Booking

1. Click "Book a Flight"
2. Enter passenger name: "John Doe"
3. Enter destination: "Delhi"
4. Select a flight and complete booking


### Test PNR Check

1. Click "Check PNR"
2. Enter a PNR from your booking (e.g., "PNR001")
3. View booking details


### Test Flight Schedule

1. Click "View Flight Schedule"
2. Enter destination: "Mumbai"
3. View available flights


## 🔧 Troubleshooting

### Oracle Client Issues

**Error: "DPI-1047: Cannot locate a 64-bit Oracle Client library"**

**Windows:**

```powershell
# Verify Oracle client files exist
ls C:\instantclient_21_13
# Should show oci.dll, oraociei21.dll, etc.

# Check PATH
echo $env:PATH | Select-String "instantclient"
```

**macOS:**

```shellscript
# Check installation
brew list | grep instantclient

# Verify PATH
echo $PATH | grep instantclient
```

### Database Connection Issues

**Error: "TNS:no listener" or "Connection refused"**

```shellscript
# Check if Oracle container is running
docker ps

# Restart Oracle container if needed
docker restart oracle-db

# Check Oracle logs
docker logs oracle-db
```

### Python Module Issues

```shellscript
# Reinstall dependencies
pip uninstall cx_Oracle Flask
pip install cx_Oracle Flask

# Or try alternative Oracle driver
pip install oracledb
```

### Port Conflicts

If port 1521 is already in use:

```shellscript
# Use different port
docker run -d \
  --name oracle-db \
  -p 1522:1521 \
  -e ORACLE_PASSWORD=tiger \
  gvenzl/oracle-xe:21-slim

# Update connection in scripts/utils.py
# Change port from 1521 to 1522
```

## 📁 Project Structure

```plaintext
flight_management_system/
├── app.py                 # Main Flask application
├── config.py             # Database configuration
├── requirements.txt      # Python dependencies
├── scripts/
│   ├── init_db.py        # Database initialization
│   ├── utils.py          # Database utilities
│   ├── book_flight.py    # Booking logic
│   ├── check_pnr.py      # PNR checking
│   ├── view_schedule.py  # Schedule viewing
│   └── cancel_flight.py  # Cancellation logic
├── db/
│   ├── schema.sql        # Database schema
│   └── sample_data.sql   # Sample data
└── templates/
    ├── index.html        # Homepage
    ├── book_flights.html # Booking page
    ├── check_pnr.html    # PNR check page
    └── ...               # Other templates
```

## 🛑 Stopping the System

```shellscript
# Stop Flask application
# Press Ctrl+C in terminal

# Stop Oracle container
docker stop oracle-db

# Remove Oracle container (optional)
docker rm oracle-db

# Deactivate Python environment
deactivate
```

## 🔄 Restarting the System

```shellscript
# Start Oracle container
docker start oracle-db

# Activate Python environment
source flight_env/bin/activate  # macOS/Linux
# OR
flight_env\Scripts\activate     # Windows

# Run application
python app.py
```

## 📞 Support

If you encounter issues:

1. **Check Docker**: Ensure Docker Desktop is running
2. **Check Oracle**: Verify Oracle container is healthy
3. **Check Python**: Ensure virtual environment is activated
4. **Check Logs**: Look at terminal output for error messages


## 🎯 Available Destinations

The system includes flights to these cities:

- Delhi
- Mumbai
- Chennai
- Hyderabad
- Kolkata
- Pune
- Ahmedabad
- Jaipur
- Goa
- Lucknow


## 📝 Sample Data

The system comes with:

- 5 Airlines (Air India, IndiGo, SpiceJet, Vistara, GoAir)
- 10 Destinations
- 30 Flights (3 per destination)
- 3 Sample bookings (PNR001, PNR002, PNR003)
