import cx_Oracle
import os

# Set Oracle client library path if needed
# Uncomment and modify this if you're having Oracle client issues
# os.environ["DYLD_LIBRARY_PATH"] = "/path/to/instantclient"

def connect_db():
    """Create and return a database connection"""
    try:
        dsn = cx_Oracle.makedsn("localhost", 1521, service_name="XEPDB1")
        conn = cx_Oracle.connect("SYSTEM", "tiger", dsn)
        return conn
    except cx_Oracle.DatabaseError as e:
        print(f"Database connection error: {e}")
        # Return None or raise exception based on your error handling strategy
        raise
