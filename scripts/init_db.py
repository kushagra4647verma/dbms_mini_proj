import cx_Oracle
import os
import sys

# Set Oracle client library path if needed
# Uncomment and modify this if you're having Oracle client issues
os.environ["DYLD_LIBRARY_PATH"] = "/path/to/instantclient"

def execute_sql_statement(cursor, statement):
    """Execute a single SQL statement"""
    statement = statement.strip()
    if not statement or statement.startswith('--'):
        return True
        
    try:
        cursor.execute(statement)
        return True
    except cx_Oracle.DatabaseError as e:
        error, = e.args
        error_code = error.code
        
        # Ignore certain expected errors
        if error_code in [942, 955, 2289]:  # Table/view doesn't exist, name already used, sequence doesn't exist
            print(f"Ignoring expected error: {error.message}")
            return True
        else:
            print(f"Error executing statement: {error.message}")
            print(f"Statement: {statement[:100]}...")
            return False

def run_sql_file(cursor, filename):
    """Execute SQL commands from a file"""
    print(f"Executing SQL from {filename}")
    
    try:
        with open(filename, 'r') as f:
            content = f.read()
        
        # Split by semicolon and slash delimiters
        statements = []
        current_statement = []
        lines = content.split('\n')
        
        i = 0
        while i < len(lines):
            line = lines[i].strip()
            
            # Skip empty lines and comments
            if not line or line.startswith('--'):
                i += 1
                continue
            
            # Handle PL/SQL blocks (procedures, triggers, etc.)
            if any(keyword in line.upper() for keyword in ['CREATE OR REPLACE TRIGGER', 'CREATE OR REPLACE PROCEDURE', 'CREATE OR REPLACE VIEW']):
                # This is a PL/SQL block, read until we find the terminating /
                plsql_block = [line]
                i += 1
                while i < len(lines):
                    next_line = lines[i]
                    if next_line.strip() == '/':
                        break
                    plsql_block.append(next_line)
                    i += 1
                
                if plsql_block:
                    statements.append('\n'.join(plsql_block))
            else:
                # Regular SQL statement
                current_statement.append(line)
                if line.endswith(';'):
                    stmt = '\n'.join(current_statement).rstrip(';')
                    if stmt.strip():
                        statements.append(stmt)
                    current_statement = []
            
            i += 1
        
        # Add any remaining statement
        if current_statement:
            stmt = '\n'.join(current_statement).rstrip(';')
            if stmt.strip():
                statements.append(stmt)
        
        # Execute each statement
        success_count = 0
        for i, statement in enumerate(statements):
            print(f"Executing statement {i+1}/{len(statements)}")
            if execute_sql_statement(cursor, statement):
                success_count += 1
        
        print(f"Successfully executed {success_count}/{len(statements)} statements")
        
    except Exception as e:
        print(f"Error processing {filename}: {e}")
        raise

def main():
    """Initialize the database schema and sample data"""
    try:
        # Connect to Oracle
        print("Connecting to Oracle database...")
        dsn = cx_Oracle.makedsn("localhost", 1521, service_name="XEPDB1")
        conn = cx_Oracle.connect("SYSTEM", "tiger", dsn)
        cursor = conn.cursor()
        
        print("Connected successfully!")
        
        # Run schema.sql
        print("\n" + "="*50)
        print("Creating database schema...")
        print("="*50)
        run_sql_file(cursor, "db/schema.sql")
        
        # Commit schema changes
        conn.commit()
        print("Schema created successfully!")
        
        # Run sample_data.sql
        print("\n" + "="*50)
        print("Inserting sample data...")
        print("="*50)
        run_sql_file(cursor, "db/sample_data.sql")
        
        # Commit data changes
        conn.commit()
        print("Sample data inserted successfully!")
        
        print("\n" + "="*50)
        print("Database initialization completed successfully!")
        print("="*50)
        
    except cx_Oracle.DatabaseError as e:
        error, = e.args
        print(f"Database error: {error.message}")
        return 1
    except Exception as e:
        print(f"Database initialization failed: {e}")
        return 1
    finally:
        if 'cursor' in locals():
            cursor.close()
        if 'conn' in locals():
            conn.close()
    
    return 0

if __name__ == "__main__":
    sys.exit(main())
