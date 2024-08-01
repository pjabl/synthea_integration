import os
import psycopg2
from sqlalchemy import create_engine, text
import yaml
from datetime import datetime
import csv

# Load credentials from a dbt profile YAML file
def get_db_credentials(yaml_file_path, profile_name, target_name):
    with open(yaml_file_path, 'r') as file:
        profiles = yaml.safe_load(file)
        profile = profiles[profile_name]['outputs'][target_name]
        user = profile['user']
        password = profile['pass']
        host = profile['host']
        db_name = profile['dbname']
    return user, password, host, db_name

# Create the database engine
def create_db_engine(user, password, host, db_name):
    connection_string = f"postgresql+psycopg2://{user}:{password}@{host}/{db_name}"
    return create_engine(connection_string)

# Create schema
def create_schema(engine, schema_name):
    with engine.connect() as conn:
        conn.execute(text(f"CREATE SCHEMA IF NOT EXISTS {schema_name};"))

# Execute DDL statements from file
def execute_ddl(engine, ddl_file_path):
    with engine.connect() as conn:
        try:
            with open(ddl_file_path, 'r') as ddl_file:
                ddl_statements = ddl_file.read()
                conn.execute(text(ddl_statements))
                conn.commit()  # Ensure the transaction is committed
        except Exception as e:
            print(f"An error occurred: {e}")

# Truncate table
def truncate_table(conn, schema, table_name):
    try:
        cursor = conn.cursor()
        cursor.execute(f"TRUNCATE TABLE {schema}.{table_name};")
        conn.commit()
    except Exception as e:
        conn.rollback()
        print(f"An error occurred while truncating {schema}.{table_name}: {e}")
    finally:
        cursor.close()

# Split CSV file into chunks of 500 MB if it exceeds 800 MB
def split_csv(file_path, chunk_size_mb=500, threshold_mb=800):
    file_size = os.path.getsize(file_path) / (1024 * 1024)  # Convert to MB
    chunk_size = chunk_size_mb * 1024 * 1024  # Convert to bytes
    if file_size <= threshold_mb:
        print(f"File {file_path} is {file_size:.2f} MB and does not need splitting.")
        return [file_path]

    print(f"File {file_path} is {file_size:.2f} MB and will be split into 500 MB chunks.")
    base_filename = os.path.splitext(file_path)[0]
    file_extension = os.path.splitext(file_path)[1]
    chunk_files = []
    with open(file_path, 'r') as file:
        reader = csv.reader(file)
        header = next(reader)
        chunk_number = 1
        chunk_file_path = f"{base_filename}_chunk{chunk_number}{file_extension}"
        chunk_files.append(chunk_file_path)
        with open(chunk_file_path, 'w', newline='') as chunk_file:
            writer = csv.writer(chunk_file)
            writer.writerow(header)
            for row in reader:
                if chunk_file.tell() > chunk_size:
                    print(f"Created chunk file: {chunk_file_path}")
                    chunk_number += 1
                    chunk_file_path = f"{base_filename}_chunk{chunk_number}{file_extension}"
                    chunk_files.append(chunk_file_path)
                    chunk_file = open(chunk_file_path, 'w', newline='')
                    writer = csv.writer(chunk_file)
                    writer.writerow(header)
                writer.writerow(row)
            print(f"Created chunk file: {chunk_file_path}")
    return chunk_files

# Load CSV data into the database using COPY
def load_csv_to_db(user, password, host, db_name, csv_file_path, table_name, schema):
    conn_string = f"host={host} dbname={db_name} user={user} password={password}"
    conn = psycopg2.connect(conn_string)
    try:
        truncate_table(conn, schema, table_name)
        cursor = conn.cursor()
        chunk_files = split_csv(csv_file_path)
        for chunk_file in chunk_files:
            with open(chunk_file, 'r') as f:
                # Skip the header row for all but the first chunk
                if chunk_file != chunk_files[0]:
                    next(f)
                start_time = datetime.now()
                print(f"Starting to load {chunk_file} into {table_name} at {start_time}")
                cursor.copy_expert(f"COPY {schema}.{table_name} FROM STDIN WITH CSV HEADER", f)
                conn.commit()
                finish_time = datetime.now()
                print(f"Finished loading {chunk_file} into {table_name} at {finish_time}")
                print(f"Duration: {finish_time - start_time}")
    except Exception as e:
        conn.rollback()
        print(f"An error occurred while loading {csv_file_path} into {schema}.{table_name}: {e}")
    finally:
        cursor.close()
        conn.close()

def main():
    script_dir = os.path.dirname(os.path.abspath(__file__))
    yaml_file_path = os.path.expanduser('~/.dbt/profiles.yml')
    profile_name = 'sanofi'
    target_name = 'stage'  # other options dev
    schema = 'patients_data'
    ddl_file_path = os.path.join(script_dir, 'config', 'synthea_tables_ddl.sql')
    csv_dir = 'C:\\a\\data\\Synthea\\output\\csv\\2024_07_24T04_23_25Z'
    start_with = 'observations'
    skip_files = ['claims_transactions.csv']
    csv_files = [os.path.join(csv_dir, f) for f in os.listdir(csv_dir) if f.endswith('.csv') and f >= start_with and f not in skip_files]

    # Get database credentials
    user, password, host, db_name = get_db_credentials(yaml_file_path, profile_name, target_name)

    # Create database engine
    engine = create_db_engine(user, password, host, db_name)

    # Create new schema
    create_schema(engine, schema)

    # Execute DDL statements to create tables
    execute_ddl(engine, ddl_file_path)

    # Load each CSV file into the corresponding table
    for csv_file in csv_files:
        table_name = os.path.splitext(os.path.basename(csv_file))[0]  # Assume table name matches file name
        load_csv_to_db(user, password, host, db_name, csv_file, table_name, schema)

if __name__ == "__main__":
    main()
