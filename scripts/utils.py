import cx_Oracle, os

# Ensure Oracle Instant Client is found (if needed on macOS)
os.environ["DYLD_LIBRARY_PATH"] = "/Users/kushagraverma/insta_client"

def connect_db():
    # Mirror get_db_connection in app.py if needed
    dsn = cx_Oracle.makedsn("localhost", 1521, service_name="XEPDB1")
    return cx_Oracle.connect("SYSTEM", "tiger", dsn)
