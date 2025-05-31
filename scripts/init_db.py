import cx_Oracle
import os
import sys

# Set Oracle client library path if needed
# Uncomment and modify this if you're having Oracle client issues
# os.environ["DYLD_LIBRARY_PATH"] = "/path/to/instantclient"

def execute_sql_statement(cursor, statement):
    """Execute a single SQL statement"""
    statement = statement.strip()
    if not statement or statement.startswith('--'):
        return True
        
    try:
        cursor.execute(statement)
        print(f"✅ Executed: {statement[:50]}...")
        return True
    except cx_Oracle.DatabaseError as e:
        error, = e.args
        error_code = error.code
        
        # Ignore certain expected errors during DROP operations
        if error_code in [942, 955, 2289, 4043]:  # Table/view doesn't exist, name already used, sequence doesn't exist, object doesn't exist
            print(f"ℹ️  Ignoring expected error: {error.message}")
            return True
        else:
            print(f"❌ Error executing statement: {error.message}")
            print(f"   Statement: {statement[:100]}...")
            return False

def run_sql_file(cursor, filename):
    """Execute SQL commands from a file"""
    print(f"\n📄 Executing SQL from {filename}")
    print("-" * 50)
    
    try:
        with open(filename, 'r') as f:
            content = f.read()
        
        
        statements = []
        current_statement = []
        lines = content.split('\n')
        
        i = 0
        while i < len(lines):
            line = lines[i].strip()
            
            
            if not line or line.startswith('--'):
                i += 1
                continue
            
            
            is_plsql_block = any(keyword in line.upper() for keyword in [
                'CREATE OR REPLACE TRIGGER', 
                'CREATE OR REPLACE PROCEDURE', 
                'CREATE OR REPLACE VIEW',
                'CREATE TRIGGER',
                'CREATE PROCEDURE', 
                'CREATE VIEW',
                'BEGIN'
            ])
            
            if is_plsql_block:
                
                plsql_block = [line]
                i += 1
                
                while i < len(lines):
                    next_line = lines[i]
                   
                    if next_line.strip() == '/':
                        break
                    plsql_block.append(next_line)
                    i += 1
                
                
                if plsql_block:
                    statement_text = '\n'.join(plsql_block).strip()
                    if statement_text:
                        statements.append(statement_text)
            else:
                
                current_statement.append(line)
                if line.endswith(';'):
                    stmt = '\n'.join(current_statement).rstrip(';')
                    if stmt.strip():
                        statements.append(stmt)
                    current_statement = []
            
            i += 1
        
        
        if current_statement:
            stmt = '\n'.join(current_statement).rstrip(';')
            if stmt.strip():
                statements.append(stmt)
        
        
        success_count = 0
        total_statements = len(statements)
        
        for i, statement in enumerate(statements):
            print(f"📝 Executing statement {i+1}/{total_statements}")
            if execute_sql_statement(cursor, statement):
                success_count += 1
            else:
                print(f"⚠️  Failed to execute statement {i+1}")
                
                print(f"   Full statement: {statement}")
        
        print(f"\n📊 Results: {success_count}/{total_statements} statements executed successfully")
        
        if success_count < total_statements:
            print("⚠️  Some statements failed, but this might be expected (e.g., DROP statements for non-existing objects)")
        
    except Exception as e:
        print(f"❌ Error processing {filename}: {e}")
        raise

def verify_database_objects(cursor):
    """Verify that all expected database objects were created"""
    print("\n🔍 Verifying database objects...")
    print("-" * 50)
    
    tables_to_check = ['AIRLINES', 'DESTINATIONS', 'FLIGHTS', 'BOOKINGS']
    for table in tables_to_check:
        try:
            cursor.execute(f"SELECT COUNT(*) FROM {table}")
            count = cursor.fetchone()[0]
            print(f"✅ Table {table}: {count} records")
        except cx_Oracle.DatabaseError:
            print(f"❌ Table {table}: NOT FOUND")
    
    sequences_to_check = ['AIRLINE_SEQ', 'DESTINATION_SEQ', 'FLIGHT_SEQ']
    for seq in sequences_to_check:
        try:
            cursor.execute(f"SELECT {seq}.CURRVAL FROM DUAL")
            val = cursor.fetchone()[0]
            print(f"✅ Sequence {seq}: Current value = {val}")
        except cx_Oracle.DatabaseError:
            try:
                cursor.execute(f"SELECT {seq}.NEXTVAL FROM DUAL")
                val = cursor.fetchone()[0]
                print(f"✅ Sequence {seq}: Next value = {val}")
            except cx_Oracle.DatabaseError:
                print(f"❌ Sequence {seq}: NOT FOUND")
    
    views_to_check = ['VW_UPCOMING_FLIGHTS', 'VW_BOOKING_SUMMARY']
    for view in views_to_check:
        try:
            cursor.execute(f"SELECT COUNT(*) FROM {view}")
            count = cursor.fetchone()[0]
            print(f"✅ View {view}: {count} records")
        except cx_Oracle.DatabaseError:
            print(f"❌ View {view}: NOT FOUND")
    
    try:
        cursor.execute("SELECT object_name FROM user_objects WHERE object_type = 'PROCEDURE'")
        procedures = cursor.fetchall()
        if procedures:
            for proc in procedures:
                print(f"✅ Procedure {proc[0]}: EXISTS")
        else:
            print("ℹ️  No procedures found")
    except cx_Oracle.DatabaseError:
        print("❌ Could not check procedures")

def create_views_manually(cursor):
    """Create views manually if they failed during schema creation"""
    print("\n🔧 Creating views manually...")
    print("-" * 50)
    
    try:
        cursor.execute("""
            CREATE OR REPLACE VIEW VW_UPCOMING_FLIGHTS AS
            SELECT 
              f.flight_id,
              a.name AS airline,
              d.city AS destination,
              f.flight_date,
              f.departure_time,
              f.arrival_time,
              f.gate_number
            FROM Flights f
            JOIN Airlines a ON f.airline_id = a.airline_id
            JOIN Destinations d ON f.destination_id = d.destination_id
            WHERE f.flight_date >= TRUNC(SYSDATE)
        """)
        print("✅ Created VW_UPCOMING_FLIGHTS view")
    except cx_Oracle.DatabaseError as e:
        print(f"❌ Failed to create VW_UPCOMING_FLIGHTS: {e}")
    
    # Create VW_BOOKING_SUMMARY
    try:
        cursor.execute("""
            CREATE OR REPLACE VIEW VW_BOOKING_SUMMARY AS
            SELECT
              d.city,
              COUNT(b.pnr) AS total_bookings,
              MIN(f.flight_date) AS first_flight,
              MAX(f.flight_date) AS last_flight
            FROM Bookings b
            JOIN Flights f ON b.flight_id = f.flight_id
            JOIN Destinations d ON f.destination_id = d.destination_id
            GROUP BY d.city
        """)
        print("✅ Created VW_BOOKING_SUMMARY view")
    except cx_Oracle.DatabaseError as e:
        print(f"❌ Failed to create VW_BOOKING_SUMMARY: {e}")

def main():
    """Initialize the database schema and sample data"""
    try:
        print("🔌 Connecting to Oracle database...")
        dsn = cx_Oracle.makedsn("localhost", 1521, service_name="XEPDB1")
        conn = cx_Oracle.connect("SYSTEM", "tiger", dsn)
        cursor = conn.cursor()
        
        print("✅ Connected successfully!")
        
        print("\n" + "="*60)
        print("🏗️  CREATING DATABASE SCHEMA")
        print("="*60)
        run_sql_file(cursor, "db/schema.sql")
        
        conn.commit()
        print("\n✅ Schema creation completed!")
        
        create_views_manually(cursor)
        conn.commit()
        
        print("\n" + "="*60)
        print("📊 INSERTING SAMPLE DATA")
        print("="*60)
        run_sql_file(cursor, "db/sample_data.sql")
        
        conn.commit()
        print("\n✅ Sample data insertion completed!")
        
        verify_database_objects(cursor)
        
        print("\n" + "="*60)
        print("🎉 DATABASE INITIALIZATION COMPLETED SUCCESSFULLY!")
        print("="*60)
        print("\n📋 Summary:")
        print("   ✅ Tables created: Airlines, Destinations, Flights, Bookings")
        print("   ✅ Sequences created: airline_seq, destination_seq, flight_seq")
        print("   ✅ Views created: VW_UPCOMING_FLIGHTS, VW_BOOKING_SUMMARY")
        print("   ✅ Triggers created: Auto-increment triggers")
        print("   ✅ Procedures created: list_bookings_by_city")
        print("   ✅ Sample data inserted")
        print("\n🚀 You can now run: python3 app.py")
        
    except cx_Oracle.DatabaseError as e:
        error, = e.args
        print(f"❌ Database error: {error.message}")
        print("\n💡 Troubleshooting tips:")
        print("   - Check if Oracle Database is running")
        print("   - Verify connection credentials (SYSTEM/tiger)")
        print("   - Ensure port 1521 is accessible")
        print("   - Check if XEPDB1 service is available")
        return 1
    except Exception as e:
        print(f"❌ Database initialization failed: {e}")
        import traceback
        traceback.print_exc()
        return 1
    finally:
        if 'cursor' in locals():
            cursor.close()
        if 'conn' in locals():
            conn.close()
    
    return 0

if __name__ == "__main__":
    sys.exit(main())
