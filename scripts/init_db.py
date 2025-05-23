import cx_Oracle
import os

os.environ["DYLD_LIBRARY_PATH"] = "/Users/kushagraverma/insta_client"

dsn = cx_Oracle.makedsn("localhost", 1521, service_name="XEPDB1")
conn = cx_Oracle.connect("SYSTEM", "tiger", dsn)
cursor = conn.cursor()

def run_sql_file(filename):
    with open(filename, 'r') as f:
        sql_script = f.read()

    # Split script into commands using "/" on its own line as delimiter (typical for PL/SQL)
    commands = []
    statement = []
    for line in sql_script.splitlines():
        stripped = line.strip()
        if stripped == "/":  # delimiter between PL/SQL blocks
            if statement:
                commands.append("\n".join(statement))
                statement = []
        else:
            statement.append(line)
    # Add last statement if any
    if statement:
        commands.append("\n".join(statement))

    for cmd in commands:
        # skip empty or comment lines
        if not cmd.strip() or cmd.strip().startswith("--"):
            continue
        try:
            print(f"Running command:\n{cmd[:50]}...")
            cursor.execute(cmd)
        except cx_Oracle.DatabaseError as e:
            print(f"Error executing SQL command:\n{e}")

# Run schema.sql
run_sql_file("db/schema.sql")

# Run sample_data.sql
run_sql_file("db/sample_data.sql")

conn.commit()
cursor.close()
conn.close()

print("✅ Oracle schema and sample data initialized.")
