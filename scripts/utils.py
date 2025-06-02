import cx_Oracle
import os

def connect_db():
    """Create and return a database connection"""
    try:
        dsn = cx_Oracle.makedsn("localhost", 1521, service_name="XEPDB1")
        conn = cx_Oracle.connect("SYSTEM", "tiger", dsn)
        return conn
    except cx_Oracle.DatabaseError as e:
        print(f"Database connection error: {e}")
        raise
